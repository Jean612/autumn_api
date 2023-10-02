require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'validate presence of required fields' do
      should validate_presence_of(:email)
      should validate_presence_of(:password)
    end
  end

  describe 'password should be password fields' do
    it 'should have password salt' do
      expect(user.password_salt).not_to be_nil
      expect(user.password_salt).to be_a(String)
    end

    it 'should have password hash' do
      expect(user.password_hash).not_to be_nil
      expect(user.password_hash).to be_a(String)
    end
  end

  describe 'scopes' do
    before do
      create_list(:user, 5)
      create_list(:user, 5, active: false)
      create_list(:user, 5, admin: true)
    end

    describe 'active scope' do
      it 'should returns only active users' do
        expect(User.active.size).to be(10)
        expect(User.active).to all(satisfy { |user| user.active } )
      end
    end

    describe 'admin scope' do
      it 'should returns only admin users' do
        expect(User.admin.size).to be(5)
        expect(User.admin).to all(satisfy { |user| user.active && user.admin } )
      end
    end
  end

  describe 'instance methods' do
    let(:last_name) { Faker::Name.last_name }
    let(:name)      { Faker::Name.first_name }
    let(:password)  { Faker::Internet.password }
    let(:user)      { create(:user, name: name, last_name: last_name, password: password) }

    describe 'valid_password?' do
      it 'should return true when password is valid' do
        expect(user.valid_password?(password)).to be_truthy
      end

      it 'should return false when password is different' do
        expect(user.valid_password?(Faker::Internet.password)).to be_falsy
      end
    end

    describe 'fullname' do
      it 'should return correct full name' do
        expect(user.fullname).to eq("#{name} #{last_name}")
      end
    end

  end
end
