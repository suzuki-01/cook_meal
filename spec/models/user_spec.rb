
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '有効なユーザー' do
    it '全ての項目が入力されていれば有効' do
      user = User.new(
        name: "hogehoge"
        email: "hogehoge@hoge",
        password: "hogehoge",
        password_confirmation: "hogehoge",
      )
      expect(user).to be_valid
    end
  end

  describe '無効なユーザー' do
    it '名前がなければ無効' do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'パスワードが入力されていなければ無効' do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end
end