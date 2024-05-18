require 'prettyprint'
require 'pry'

class AdminController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  include AdminConcern

  def index
    # render html: helpers.tag.strong('this is home page page')

  end

end