class PagesController < ApplicationController
  # Restrict access so only logged in users can access the secret page:
  before_action :authorize, except: [:new]
  # ----- end of added lines -----
  
  def secret
  end
end
