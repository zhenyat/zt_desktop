require "./app/models/dummy.rb"

class CreateDummies < ActiveRecord::Migration
  def self.up
    create_table :dummies do |t|
      t.string  :name
      t.string  :title
      t.decimal :price
      t.integer :qty
    end

      Dummy.create name: 'tv',      title: 'TV Sony', price:  724.00, qty: 100
      Dummy.create name: 'macbook', title: 'MacBook', price: 1300.99, qty: 45
      Dummy.create name: 'hp',      title: 'HP PC',   price:  500.00, qty: 17
  end

  def self.down
    drop_table :dummies
  end
end