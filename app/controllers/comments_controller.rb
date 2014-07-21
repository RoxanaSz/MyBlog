class CommentsController < ApplicationController
  
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end
  def new
    @commentable = find_commentable
    @comment=@commentable.comments.new    
  end
  def create
      @article = Article.find(params[:article_id])
     @commentable = find_commentable  
      @comment = @commentable.comments.build(comment_params)  
      @comment =  @commentable.comments.create(:subject => params[:comment][:subject],:content => params[:comment][:content], :author_name =>  current_user.username, :author_email =>  current_user.email,
      :author_id =>  current_user.id)
      if @comment.save  
        flash[:notice] = "Successfully saved comment."  
        redirect_to article_path(@article)
      else
        render :action => 'new'  
      end
            
  end
  
  #def create
  #@commentable = find_commentable
  #@comment = @commentable.comments.build(params[:comment])
  #if @comment.save
   # flash[:notice] = "Successfully created comment."
   # redirect_to :id => nil
  #else
   # render :action => 'new'
  #end
  #end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
  
  private
    def comment_params
      params.require(:comment).permit(:commentable_id,:commentable_type,:subject,:content,:author_name,:author_email,:author_id)
    end
    
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
       return $1.classify.constantize.find(value)
       end
     end
  nil
  end
  
end
