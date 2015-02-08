require 'rails_helper'

describe ImagesController, type: :controller do
  context 'authenticated' do
    let(:user) { FactoryGirl.create(:user) }
    let(:media_item) { FactoryGirl.create(:media_item, user: user) }
    let(:image) { FactoryGirl.create(:image, media_item: media_item) }
    before { sign_in user }

    describe 'GET index' do
      before do
        media_item.reload
        image.reload
        get :index, media_item_id: media_item.id, format: :json
      end

      it { expect(assigns(:media_item)).to eq(media_item) }
      it { expect(assigns(:images)).to include(image.to_jq_upload) }

      context 'HTML format' do
        before { get :index, media_item_id: media_item.id }

        it { expect(response).to render_template('index') }
      end
    end

    describe 'POST create' do
      before { post :create, media_item_id: media_item.id, image: { file: fixture_file_upload(Rails.root.join('spec', 'factories', 'support', 'test.png'), 'image/png') } }

      it { expect(response.body).to eq({files: [Image.last.to_jq_upload]}.to_json) }
    end

    describe 'DELETE destroy' do
      before do
        delete :destroy, media_item_id: media_item.id, id: image.id, format: :json
        media_item.reload
      end

      it { expect(media_item.images).to be_empty }
      it { expect(response.body).to be_blank }
      it { expect(response.status).to eq(204) }
    end
  end
end
