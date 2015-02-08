require 'rails_helper'

describe MediaItemsController, type: :controller do
  context 'authenticated' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe 'GET index' do
      let(:own_item) { FactoryGirl.create(:media_item, user: user) }
      let(:strange_item) { FactoryGirl.create(:media_item, user: FactoryGirl.create(:user)) }

      before { get :index }

      it { expect(assigns(:media_items)).to include(own_item) }
      it { expect(assigns(:media_items)).not_to include(strange_item) }
      it { expect(response).to render_template('index') }
    end

    describe 'GET new' do
      before { get :new }

      it { expect(response).to render_template('new') }
    end

    describe 'POST create' do
      let(:title) { 'test Title' }
      let(:website_url) { Faker::Internet.url }
      let(:video_url) { Faker::Internet.url }
      before { post :create, media_item: { title: title, website_url: website_url, video_url: video_url } }

      it { expect(assigns(:media_item).title).to eq(title) }
      it { expect(assigns(:media_item).website_url).to eq(website_url) }
      it { expect(assigns(:media_item).video_url).to eq(video_url) }
      it { expect(response).to redirect_to(media_item_images_path(assigns(:media_item).id)) }
    end

    describe 'GET show' do
      let(:item) { FactoryGirl.create(:media_item, user: user) }

      before { get :show, id: item.id }

      it { expect(assigns(:media_item)).to eq(item) }
      it { expect(response).to render_template('show') }
    end

    describe 'GET edit' do
      let(:item) { FactoryGirl.create(:media_item, user: user) }

      before { get :edit, id: item.id }

      it { expect(assigns(:media_item)).to eq(item) }
      it { expect(response).to render_template('edit') }
    end

    describe 'GET edit' do
      let(:item) { FactoryGirl.create(:media_item, user: user) }

      before { get :edit, id: item.id }

      it { expect(assigns(:media_item)).to eq(item) }
      it { expect(response).to render_template('edit') }
    end

    describe 'PUT update' do
      let(:title) { 'test Title' }
      let(:website_url) { Faker::Internet.url }
      let(:video_url) { Faker::Internet.url }
      let(:item) { FactoryGirl.create(:media_item, user: user) }

      before { put :update, id: item.id, media_item: { title: title, website_url: website_url, video_url: video_url } }

      it { expect(assigns(:media_item).title).to eq(title) }
      it { expect(assigns(:media_item).website_url).to eq(website_url) }
      it { expect(assigns(:media_item).video_url).to eq(video_url) }
      it { expect(response).to redirect_to(media_item_path(item.id)) }
    end

    describe 'DELETE destroy' do
      let(:item) { FactoryGirl.create(:media_item, user: user) }

      before { delete :destroy, id: item.id }

      it { expect { MediaItem.find(item.id) }.to raise_exception(ActiveRecord::RecordNotFound) }
      it { expect(response).to redirect_to(root_path) }
    end
  end
end
