class ArticlesController < ApplicationController
   #skip_before_action :authenticate_user! , only: [:index,:show]
   before_action :authenticate_user! , except: [:index,:show]
   
  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all.order('created_at DESC')
      @tags =Tag.all
    end   
    #@categories=Category.find(params[:article][:category_id]) 
    #if params[:category_id] 
     #  @category = Category.find_by(params[:category_id])
    #end
  end

  def new
    @article = Article.new
    @categories = Category.all
    # @tag = Tag.new(tag_params)   # @tags=@article.tags.build     #@tag_list.each do |tag|      #   tag=Tag.new    #end
  end

   
  def create
   @categories = Category.all
   @article = Article.new(article_params)
   @article = Article.new(:title => params[:article][:title], :text => params[:article][:text],
        :category_id => params[:article][:category_id],:username => current_user.username,:tag_list => params[:article][:tag_list])  
   if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    @tags=Tag.all
    # @related_articles = Article.tagged_with(@article.tag_list, any: true)    #authorized! :read ,@article
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
  
  def approve
    @article =Article.find(params[:id])
    @article.update_attribute(:published, true)
    redirect_to articles_path
  end

 private

  def article_params
    params.required(:article).permit(:title,:text,:category_id,:published,:username, :tag_list)
  end
    
  def tag_params
    params.required(:tag).permit(:name)
  end

end
