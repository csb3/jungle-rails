require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves a record successfully when all fields are valid' do
      @product = Product.create!({ :name => 'Shiny new product', :price_cents => 112, :quantity => 5, :category => Category.create!({ :name => "Furniture"}) })
    end

    it 'validates name' do
      @product = Product.create({ :name => nil, :price_cents => 112, :quantity => 5, :category => Category.create!({ :name => "Furniture"}) })
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates price' do
      @product = Product.create({ :name => 'Shiny new product', :price_cents => nil, :quantity => 5, :category => Category.create!({ :name => "Furniture"})  })
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates quantity' do
      @product = Product.create({ :name => 'Shiny new product', :price_cents => 112, :quantity => nil, :category => Category.create!({ :name => "Furniture"})  })
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates category' do
      @product = Product.create({ :name => 'Shiny new product', :price_cents => 112, :quantity => 5, :category => nil  })
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
