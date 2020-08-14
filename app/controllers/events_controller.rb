class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update]

  def index
    @events = Event.order(created_at: :desc)
  end

  def show
    @event = Event.find(params[:id])
    redirect_to event_attendances_path(@event) if user_signed_in? && @event.administrator?(current_user)
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
    check_current_user_is_admin
  end

  def update
    @event = Event.find(params[:id])
    check_current_user_is_admin
    if @event.update(event_params)
      redirect_to @event, flash: { success: 'Evénement mis à jour !' }
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    check_current_user_is_admin
    if @event.destroy
      redirect_to root_path, flash: { success: 'Evenement bien supprimé' }
    else
      redirect_to @event, flash: { error: 'Erreur dans la suppression' }
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :start_date, :duration, :price, :description)
  end

  def check_current_user_is_admin
    unless @event.administrator?(current_user)
      redirect_to @event, flash: { error: "Impossible, vous n'êtes pas l'administrateur" }
    end
  end
end
