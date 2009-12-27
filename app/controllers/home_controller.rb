# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class HomeController < ApplicationController

  def index
    redirect_to :clients if user_signed_in?    
  end
 
  def insufficient
  end

  def help
  end
  
  def ourclients
  end
  
  def faq
  end
  
  def terms
  end

end
