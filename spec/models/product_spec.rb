require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before(:each) do
      @category = Category.create(name: "testy")
      @product = Product.new(name: "mcTesterson", description: "for testing", image: "testy image", price_cents: 777, quantity: 1, category: @category)
    end

    it 'can save successfully' do
      expect(@product.save).to be_truthy
    end

    it 'should have a name' do
      @product.name = nil
      expect(@product.save).to be_falsey
      expect(@product.errors.messages[:name]).to eq(["can't be blank"])
    end

    it 'should have a price' do
      @product.price_cents = nil
      expect(@product.save).to be_falsey
      expect(@product.errors.messages[:price_cents]).to eq(["is not a number"])
    end

    it 'should have a quantity' do
      @product.quantity = nil
      expect(@product.save).to be_falsey
      expect(@product.errors.messages[:quantity]).to eq(["can't be blank"])
    end

    it 'should belong to a category' do
      @product.category = nil
      expect(@product.save).to be_falsey
      expect(@product.errors.messages[:category]).to eq(["can't be blank"])
    end

  end
end
