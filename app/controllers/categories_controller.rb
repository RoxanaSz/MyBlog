class CategoriesController < ApplicationController

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
    #else
     # render :new
    #end
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
