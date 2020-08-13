class PicturesController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])
    unless @event.administrator?(current_user)
      redirect_to @event, flash: { error: "Vous ne pouvez pas modifier un événement dont vous n'êtes pas admin !!" }
    end
  end

  def create
    @event = Event.find(params[:event_id])
    unless @event.administrator?(current_user)
      redirect_to @event, flash: { error: "Vous ne pouvez pas modifier un événement dont vous n'êtes pas admin !!" }
    end
    puts '$' * 100
    puts "-#{params[:picture]}-"
    unless params[:picture]
      @event.errors.add(:picture, 'image non reconnue')
      render :new, flash: { error: 'Image non reconnue !!' }
      return
    end
    @event.picture.attach(params[:picture])
    redirect_to @event, flash: { success: "Merci ! Image ajouté à l'événement" }
  end
end
