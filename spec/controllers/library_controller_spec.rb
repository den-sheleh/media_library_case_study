require 'rails_helper'

describe LibraryController, type: :controller do
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
        before do
          user.hide!
          get :show, id: user.id
        end

        context 'owner' do
          it { expect(assigns(:media_items)).to include(item) }
          it { expect(response).to render_template('index') }
        end

        context 'stranger' do
          before { sign_in FactoryGirl.create(:user) }

          it { expect(flash[:notice]).to eq(I18n.t('library.forbidden')) }
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
