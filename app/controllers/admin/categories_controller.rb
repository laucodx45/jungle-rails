class Admin::CategoriesController < ApplicationController
  def show
    @categories = Category.pluck(:name)
  end
end