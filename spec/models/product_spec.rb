require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'validates name' do
      @product = Product.create!({ :name => 'Shiny new product', :price_cents => 112, :quantity => 5, :category => Category.create!({ :name => "Furniture"}) })
      expect(@product.name).to be_truthy
    end
    it 'validates price' do
      @product = Product.create!({ :name => 'Shiny new product', :price_cents => 112, :quantity => 5, :category => Category.create!({ :name => "Furniture"})  })
      expect(@product.price).to be_truthy
    end
    it 'validates quantity' do
      @product = Product.create!({ :name => 'Shiny new product', :price_cents => 112, :quantity => 5, :category => Category.create!({ :name => "Furniture"})  })
      expect(@product.quantity).to be_truthy
    end
    it 'validates category' do
      @product = Product.create!({ :name => 'Shiny new product', :price_cents => 112, :quantity => 5, :category => Category.create!({ :name => "Furniture"})  })
      expect(@product.category_id).to be_truthy
    end
    it 'returns an error if a field is nil' do
      @product = Product.create({ :name => nil, :price_cents => 112, :quantity => 5, :category => Category.create!({ :name => "Furniture"})  })
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
  end
end
