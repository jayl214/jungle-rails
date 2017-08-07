require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'can save successfully' do
      @category = Category.create(name: "testy")
      @product = Product.new(name: "mcTesterson", description: "for testing", image: "testy image", price_cents: 777, quantity: 1, category: @category)
      expect(@product.save).to be_truthy
    end

    it 'should have a name' do
      @category = Category.create(name: "testy")
      @product = Product.new(description: "for testing", image: "testy image", price_cents: 777, quantity: 1, category_id: @category.id)
      expect(@product.save).to be_falsey
      expect(@product.errors.messages[:name]).to eq(["can't be blank"])
    end

    it 'should have a price' do
      @category = Category.create(name: "testy")
      @product = Product.new(name: "mcTesterson", description: "for testing", image: "testy image", quantity: 1, category: @category)
      expect(@product.save).to be_falsey
      expect(@product.errors.messages[:price]).to eq(["is not a number", "can't be blank"])
    end

    it 'should have a quantity' do
      @category = Category.create(name: "testy")
      @product = Product.new(name: "mcTesterson", description: "for testing", image: "testy image", price_cents: 777, category: @category)
      expect(@product.save).to be_falsey
      expect(@product.errors.messages[:quantity]).to eq(["can't be blank"])
    end

    it 'should belong to a category' do
      @category = Category.create(name: "testy")
      @product = Product.new(name: "mcTesterson", description: "for testing", image: "testy image", price_cents: 777, quantity: 1)
      expect(@product.save).to be_falsey
      expect(@product.errors.messages[:category]).to eq(["can't be blank"])
    end

  end
end
