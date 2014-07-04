class ArticlesController < ApplicationController

  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all
      @tags =Tag.all
    end
      
     
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
   @categories = Category.all
   @article = Article.new(article_params)
   @article = Article.new(:title => params[:article][:title], :text => params[:article][:text],
        :category_id => params[:article][:category_id])  
    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    @tags=Tag.all
   # @related_articles = Article.tagged_with(@article.tag_list, any: true)
  end

  def category_name
    self.category.name if self.category
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id]) 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
   @article.destroy
    redirect_to category_path(@article.category_id)
  end


 private

    def article_params
      params.required(:article).permit(:title,:text,:category_id)
    end
    
end
