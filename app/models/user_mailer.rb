class UserMailer < ActionMailer::Base
  # Note remove bcruparel@yahoo.com and change recipients to "recipients user.email" after done testing

  def comment_email_from_us(commented_on_user_model, commenting_user,
                              email_subject, email_text)
    recipients commented_on_user_model.email
    cc APP_CONFIG['admin_email_from']
    from commenting_user.email
    subject email_subject
    sent_on Time.now
    body email_text
  end

  def comment_email_to_us(commented_on_user_model, commenting_user,
                            email_subject, email_text)
    recipients APP_CONFIG['admin_email_to']
    cc commented_on_user_model.email
    from commenting_user.email
    subject email_subject
    sent_on Time.now
    body email_text
  end

end
