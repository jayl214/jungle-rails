class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      puts 'has saved'
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      puts 'failed to save'
      render :new
    end
  end

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
