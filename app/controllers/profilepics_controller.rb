class ProfilepicsController < ApplicationController

  def index
     @profilepics = Profilepic.where("user_id =#{current_user.id}")
  end

  def show
    @profilepics= Profilepic.where("user_id =#{current_user.id}")
  end
      
end
