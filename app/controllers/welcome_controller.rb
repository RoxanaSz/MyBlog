class WelcomeController < ApplicationController
  skip_before_action :authenticate_user! , only: :root
  
  def index
    @articles=Article.where("published = false")
     #@articles=Article.where(:username => current_user.username)
      
      @number=@articles.count
  end
end
