require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "valid with valid attributes " do
      category = Category.create(name: "Example Category")
      
      product = Product.create(
        name: "Example Product",
        description: "This is an example product.",
        price_cents: 1000,
        quantity: 10,
        category: category
      )
      
      expect(product).to be_valid
      expect(product.category).to eq(category)
    end

    it 'should validates name when creating a new product' do
      category = Category.create(name: "Example Category")
      product = Product.create(
        description: "This is an example product.",
        price_cents: 1000,
        quantity: 10,
        category: category
      )
      
      expect(product).to be_invalid
    end

    it 'should validates price when creating a new product' do
      category = Category.create(name: "Example Category")
      product = Product.create(
        name: "fern",
        description: "This is an example product.",
        quantity: 10,
        category: category
      )
      
      expect(product).to be_invalid
    end

    it 'should validates quantity when creating a new product' do
      category = Category.create(name: "Example Category")
      
      product = Product.create(
        name: "Example Product",
        description: "This is an example product.",
        price_cents: 1000,
        category: category
      )

      expect(product).to be_invalid
    end

    it 'should validates category when creating a new product' do
      product = Product.create(
        name: "Example Product",
        description: "This is an example product.",
        price_cents: 1000,
        quantity: 10
      )

      expect(product).to be_invalid
    end

  end
end