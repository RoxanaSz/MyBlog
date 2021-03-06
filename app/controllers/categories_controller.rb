class CategoriesController < ApplicationController
  
  before_action :authenticate_user! , except: [:index,:show]
  
  def index
    @categories=Category.all
  end

  def new
    @category=Category.new
  end

  def create
    @category=Category.new(category_params)
    @category.save
      redirect_to new_category_path, alert: "Category created!"
  end
  
  def show
    @category = Category.find(params[:id])
    @articles = @category.articles
  end

private

    def category_params
      params.required(:category).permit(:name)
    end
end
