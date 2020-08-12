class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])

    if @event.administrator?(current_user)
      redirect_to event_path(@event), flash: { alert: "Tu es administrateur, tu ne peux pas t'inscrire comme participant !" }
    end
    if @event.attendee?(current_user)
      redirect_to event_path(@event), flash: { notice: 'Tu es déjà inscrit dans cet événement !' }
    end

    @attendance = Attendance.new
    @amount = @event.price * 100
  end

  def create
    @event = Event.find(params[:event_id])
    # Amount in cents
    @amount = @event.price * 100

    customer = Stripe::Customer.create({
                                         email: params[:stripeEmail],
                                         source: params[:stripeToken]
                                       })

    charge = Stripe::Charge.create({
                                     customer: customer.id,
                                     amount: @amount,
                                     description: 'Rails Stripe customer',
                                     currency: 'eur'
                                   })
    Attendance.create(event: @event, attendee: current_user, stripe_customer_id: customer.id)
    redirect_to event_path(@event), flash: { success: 'Merci pour ton inscription !' }
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_event_attendance_path(@event)
  end

  def index
    @event = Event.find(params[:event_id])
    unless @event.administrator?(current_user)
      redirect_to @event, flash: { error: 'Tu ne peux voir les participants que des événements dont tu es administrateur !' }
    end
  end
end
