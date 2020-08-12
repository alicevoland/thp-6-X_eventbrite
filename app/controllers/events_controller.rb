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
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    unless @event.administrator?(current_user)
      redirect_to root_path, flash: { error: "Vous ne pouvez pas supprimer un événement dont vous n'êtes pas admin !!" }
    end
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
end
