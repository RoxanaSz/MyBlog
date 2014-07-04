class TagsController < ApplicationController

  #GET /articles/1/tags
  def index
    
      @article = Article.find(params[:article_id])
      @tags = @article.tags
      #@tags = Tag.all
  end
 
  #GET /articles/1/tags/new
  def new
    @article = Article.find(params[:article_id])
    @tags=@article.tags.build
    #@tags = Tag.all
    #@tagging= Tagging.new
    #@tagging.article = @article
  end

  #POST
  def create
    @article= Article.find(params[:article_id])
    @tag=@article.tags.build(tag_params)
    @article.tags << @tag
    if @tag.save
      redirect_to article_tags_path(@article, @tag)
    else
      rander :new
    end


    #@tagging = Tagging.new(taggins_params)
    #@tagging.article_id = params[:article_id]
    #@tagging.save!
    #redirect_to article_tags_path
  end
  
  #GET /article/1/tags/2
  def show
    @article = Article.find(params[:article_id])
    @tag = @article.tags.find(params[:id])
    #@tag = Tag.find(params[:id])
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
    #@tag.destroy
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
