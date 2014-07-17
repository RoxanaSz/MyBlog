class ArticlesController < ApplicationController
   #skip_before_action :authenticate_user! , only: [:index,:show]
   before_action :authenticate_user! , except: [:index,:show]
   
  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all.order('created_at DESC')
      @articles2=Article.where("published = false")
      @number=@articles2.count
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
        :category_id => params[:article][:category_id],:username => current_user.username,:tag_list => params[:article][:tag_list],:user_id => current_user.id)  
     if @article.save
       redirect_to articles_path
     else
       render :new
     end
  end

  def show
    @article = Article.find(params[:id])   
    @related_articles = Article.where("category_id =#{@article.category_id}")
    @tags=Tag.all
     #@related_articles = Article.tagged_with(@article.tag_list, any: true)
     #@related_articles =Article.joins(:taggings).where('articles.id != ?', @article.id).where(taggings: { tag_id: @article.tag_ids })
     #@related_articles = Article.tagged_with(@article.tag_list)
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
    params.required(:article).permit(:title,:text,:category_id,:published,:username, :tag_list,:user_id)
  end
    
  def tag_params
    params.required(:tag).permit(:name)
  end

end
