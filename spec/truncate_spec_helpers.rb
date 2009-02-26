module TruncateSpecHelpers
   
  def login_as(user)
    controller.stub!(:authenticate).and_return(true)
    controller.stub!(:logged_in?).and_return(true)
    controller.stub!(:current_user).and_return(user)
    @current_user = user
  end
  
end