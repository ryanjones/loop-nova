class OutageMailer < ApplicationMailer
  default from: Rails.configuration.aws_ses_default_mailer

  def outage_email(site)
    mail(to: Rails.configuration.user_to_notify, subject: "DOWN - #{site.url}", body: "Your site is down.")
  end

end
