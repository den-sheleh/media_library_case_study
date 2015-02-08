require 'rails_helper'

describe LibrariesController, type: :controller do
  context 'authenticated' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe 'GET show' do
      let(:item) { FactoryGirl.create(:media_item, user: user) }

      context 'public library' do
        before do
          user.share!
          get :show, id: user.id
        end

        context 'owner' do
          it { expect(assigns(:media_items)).to include(item) }
          it { expect(response).to render_template('index') }
        end

        context 'stranger' do
          before { sign_in FactoryGirl.create(:user) }

          it { expect(assigns(:media_items)).to include(item) }
          it { expect(response).to render_template('index') }
        end
      end

      context 'private library' do
        before { user.hide! }

        context 'owner' do
          before { get :show, id: user.id }
          it { expect(assigns(:media_items)).to include(item) }
          it { expect(response).to render_template('index') }
        end

        context 'stranger' do
          before do
            sign_in FactoryGirl.create(:user)
            get :show, id: user.id
          end

          it { expect(flash[:alert]).to eq(I18n.t('library.forbidden')) }
          it { expect(response).to redirect_to root_path }
        end
      end
    end

    describe 'GET share' do
      before { get :share }

      it { user.reload; expect(user.is_public).to be true }
      it { expect(response).to redirect_to root_path }
    end

    describe 'GET hide' do
      before { get :hide }

      it { user.reload; expect(user.is_public).to be false }
      it { expect(response).to redirect_to root_path }
    end
  end
end
