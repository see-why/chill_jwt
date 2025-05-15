require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'invalid user' do
      subject(:user) { build(:user, email: "", password: "") }

      it 'is invalid without email' do
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'is invalid without password' do
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
    end

    context 'valid user' do
      subject(:user) { build(:user) }

      it 'email is valid' do
        user.valid?
        expect(user.errors[:email]).to be_empty
      end

      it 'password is valid' do
        user.valid?
        expect(user.errors[:password]).to be_empty
      end
    end
  end
end
