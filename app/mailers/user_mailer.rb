class UserMailer < ApplicationMailer
  default from: 'mathieu.vol+thp@gmail.com'

  def welcome_email(user)
    puts "Sending welcome email to #{user.email} - #{user.name}"
    # on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user

    # on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url = 'https://thp-my-eventbrite.herokuapp.com/login'

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def new_attendee_email(attendance)
    @event = attendance.event
    @admin = attendance.event.administrator
    @attendee = attendance.attendee

    puts "Sending new attendee email to #{@admin.email} - #{@admin.name}"
    # on récupère l'instance user pour ensuite pouvoir la passer à la view en @user

    # on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url = 'https://thp-my-eventbrite.herokuapp.com/login'

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @admin.email, subject: 'Nouveau participant !')
  end
end
