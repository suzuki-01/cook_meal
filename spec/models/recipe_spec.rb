
require 'rails_helper'

RSpec.describe 'Recipeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { recipe.valid? }

    let(:user) { create(:user) }
    let!(:recipe) { build(:recipe, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        recipe.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        recipe.body = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        recipe.body = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        recipe.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end