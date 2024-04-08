class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['ADMIN_USER_NAME'], password: ENV['ADMIN_PASSWORD'], only: :show

  def show
    @total_products = Product.count
    @categories_count = Category.count
  end
end
