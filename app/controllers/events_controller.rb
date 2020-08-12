class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update]

  def index
    @events = Event.order(created_at: :desc)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    redirect_to new_user_session_path unless user_signed_in?
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.administrator = current_user

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, flash: { success: 'Evénement mis à jour !' }
    else
      redirect_to @event, flash: { error: 'Il y a eu un problème !' }
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :start_date, :duration, :price, :description)
  end
end
