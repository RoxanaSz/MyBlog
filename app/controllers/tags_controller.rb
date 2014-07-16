class TagsController < ApplicationController

  #GET /articles/1/tags
  def index    
    @article = Article.find(params[:article_id])
    @tags = @article.tags
  end
 
  #GET /articles/1/tags/new
  def new
    @article = Article.find(params[:article_id])
    @tags=@article.tags.build
    @tag=Tag.new
  end

  #POST
  def create
    @article= Article.find(params[:article_id])
    @tag=Tag.find_or_create_by(tag_params)
      if !@article.tags.find_by(tag_params)
        @article.tags << @tag
      end
      if @tag.save
        redirect_to article_tags_path(@article, @tag)
      else
      render :new
       end
  end
 
  #GET /article/1/tags/2
  def show
    @tag = Tag.find(params[:id])
  end
  
  def edit 
    @article = Article.find(params[:article_id])
    @tag=@article.tags.find(params[:id])
  end
  
  def update
    @article=Article.find(params[:article_id])
    @tag=Tag.find(params[:id])
    if  @tag.update(tag_params)
      redirect_to article_tags_path(@article)
    else 
      render :edit
    end
  end
  
  def destroy
    @article = Article.find(params[:article_id])
    @tag = Tag.find(params[:id])      
    @article.tags.delete(@tag)
    redirect_to article_tags_path(@article)
  end

  private

  def tagging_params
    params.required(:tagging).permit(:article_id,:tag_id)
  end

  def tag_params
    params.required(:tag).permit(:name)
  end

end
