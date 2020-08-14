class StaticPagesController < ApplicationController
  def home
    @events = Event.order(created_at: :desc)
    render :home, layout: 'layouts/home'
  end
end
