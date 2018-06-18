class PasswordResetMailer < ActionMailer::Base
  default from: "noreply@example.com" # NOTE: You'll want to change this

  def change_password(password_reset)
    @password_reset = password_reset
    @user = password_reset.user

    I18n.with_locale(:en) do # NOTE: We will want to store the locale of the user on the user record for usage here
      mail(
        to: @user.email,
        subject: t('mailers.password_resets.subject')
      )
    end
  end
end
