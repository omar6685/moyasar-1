class StaticPublicController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :trems]
  def home
  end

  def user_dash
  end

  def trems
  end


  def pricing
    @products = Product.all
  end
end
