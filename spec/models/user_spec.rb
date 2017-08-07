require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
      @user = User.new(first_name: "testy", last_name: "mcTesterson", email: "testamajigger@TeStY.com", password: "testing123", password_confirmation: "testing123")
  end

  describe 'validations' do

    it 'can save successfully' do
      expect(@user.save).to be_truthy
    end

    it 'must have first name' do
      @user.first_name = nil
      expect(@user.save).to be_falsey
      expect(@user.errors.messages[:first_name]).to eq(["can't be blank"])
    end

    it 'must have last_name' do
      @user.last_name = nil
      expect(@user.save).to be_falsey
      expect(@user.errors.messages[:last_name]).to eq(["can't be blank"])
    end

    it 'must have email' do
      @user.email = nil
      expect(@user.save).to be_falsey
      expect(@user.errors.messages[:email]).to eq(["can't be blank"])
    end

    it 'must store unique emails in a non-case-sensitive manner' do
      expect(@user.save).to be_truthy
      @user2 = User.new(first_name: "testy", last_name: "mcTesterson", email: "TESTAMAJIGGER@testy.com", password: "testing123", password_confirmation: "testing123")
      expect(@user2.save).to be_falsey
      expect(@user2.errors.messages[:email]).to eq(["has already been taken"])
    end

    it 'must have password' do
      @user.password = nil
      expect(@user.save).to be_falsey
      expect(@user.errors.messages[:password]).to eq(["can't be blank"])
    end

    it 'must have password confirmation' do
      @user.password_confirmation = nil
      expect(@user.save).to be_falsey
      expect(@user.errors.messages[:password_confirmation]).to eq(["can't be blank"])
    end

    it 'must have password confirmation equal to password' do
      @user.password_confirmation = "321testing"
      expect(@user.save).to be_falsey
      expect(@user.errors.messages[:password_confirmation]).to eq(["doesn't match Password"])
    end

    it 'must have password longer than 6 characters' do
      @user.password = "t"
      @user.password_confirmation = "t"
      expect(@user.save).to be_falsey
      expect(@user.errors.messages[:password]).to eq(["is too short (minimum is 6 characters)"])
    end

    it 'must have password shorter than 20 characters' do
      @user.password = "testing123testing123testing123testing123testing123testing123"
      @user.password_confirmation = "testing123testing123testing123testing123testing123testing123"
      expect(@user.save).to be_falsey
      expect(@user.errors.messages[:password]).to eq(["is too long (maximum is 20 characters)"])
    end

  end

  describe '.authenticate_with_credentials' do

    before(:each) do
      @user.save!
    end

    it 'can retreive existing user' do
      expect(User.authenticate_with_credentials("testamajigger@testy.com", "testing123")).to be_truthy
    end

    it 'returns nil for wrong password' do
      expect(User.authenticate_with_credentials("testamajigger@testy.com", "testing321")).to be nil
    end

    it 'returns nil for non-existant email' do
      expect(User.authenticate_with_credentials("test@testy.com", "testing123")).to be nil
    end

    it 'cannot accept 0 arguments' do
      expect(User.authenticate_with_credentials(nil,nil)).to be_falsey
    end

    it 'cannot accept only 1 arguments' do
      expect(User.authenticate_with_credentials(nil, "testing123")).to be_falsey
      expect(User.authenticate_with_credentials("testamajigger@testy.com", nil)).to be nil
    end

    it 'is not case-sensitive with regards to email during login' do
      expect(User.authenticate_with_credentials("TeStAmAjIgGeR@testy.com", "testing123")).to be_truthy
    end

    it 'ignore trailing and leading spaces in the email' do
      expect(User.authenticate_with_credentials(" TeStAmAjIgGeR@testy.com", "testing123")).to be_truthy
    end

  end


end
