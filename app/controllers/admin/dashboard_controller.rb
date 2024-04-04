class Admin::DashboardController < ApplicationController
  def show
    @total_products = Product.count
    @categories_count = Category.count
  end
end
