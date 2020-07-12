class GolfersController < ApplicationController
  def index
    @golfers = Golfer.all
  end
end
