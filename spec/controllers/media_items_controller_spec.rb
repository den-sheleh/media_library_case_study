require 'rails_helper'

describe MediaItemsController, type: :controller do
  context 'authenticated' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe "GET 'index'" do
      let(:own_item) { FactoryGirl.create(:media_item, user: user) }
      let(:strange_item) { FactoryGirl.create(:media_item, user: FactoryGirl.create(:user)) }

      before { get :index }

      it { expect(assigns(:media_items)).to include(own_item) }
      it { expect(assigns(:media_items)).not_to include(strange_item) }
      it { expect(response).to render_template('index') }
    end

    describe "GET 'new'" do
      before { get :new }

      it { expect(response).to render_template('new') }
    end

    describe "POST 'create'" do
      let(:title) { 'test Title' }
      before { post :create, media_item: { title: title } }

      it { expect(assigns(:media_item).title).to eq(title) }
      it { expect(response).to redirect_to(media_item_images_path(assigns(:media_item).id)) }
    end
  end
end
