class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end
  
  def new
    @article = Article.find(params[:id]) 
    @tags = Tag.all
    @tagging = Tagging.new
    #@tag=Tag.new
    @tagging.article = @article
    @tagging.tag = @tag
    @article.tags << Tag.new
    
    #tag=@article.tags.new(params[:tag])
    #tag.save
    #tagging=Tag(article_id: @article_id, tag_id: @tag_id)
    #tagging.save
    
  end

  def create
    @tagging = Tagging.new(tagging_params)
    @tagging.article_id = params[:article_id]
    @tagging.tag_id = params[:tag_id]
    @tagging.save!
    @tag = Tag.new(tag_params)
    @tag.save
    redirect_to  @article #articles_path
  end

  def show
    @tag = Tag.find(params[:id])
  end

  
  private

  def tagging_params
    params.required(:tagging).permit(:article_id,:tag_id)
  end

  def tag_params
    params.required(:tag).permit(:name)
  end

end