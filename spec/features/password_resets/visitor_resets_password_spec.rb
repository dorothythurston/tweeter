require "rails_helper"
require "support/features/session_helpers"

RSpec.feature "Visitor resets password" do
  before { ActionMailer::Base.deliveries.clear }

  around do |example|
    original_adapter = ActiveJob::Base.queue_adapter
    ActiveJob::Base.queue_adapter = :inline
    example.run
    ActiveJob::Base.queue_adapter = original_adapter
  end

  scenario "by navigating to the page" do
    visit new_session_path

    click_link I18n.t("sessions.reset_password")

    expect(current_path).to eq new_password_reset_path
  end

  scenario "with valid email" do
    user = user_with_reset_password

    expect_page_to_display_change_password_message
    expect_reset_notification_to_be_sent_to user
  end

  scenario "with non-user account" do
    reset_password_for "unknown.email@example.com"

    expect_page_to_display_change_password_message
    expect_mailer_to_have_no_deliveries
  end

  private

  def expect_reset_notification_to_be_sent_to(user)
    expect(user.password_resets).not_to be_blank
    expect_mailer_to_have_delivery(
      user.email,
      "password",
      user.password_resets.first
    )
  end

  def expect_page_to_display_change_password_message
    expect(page).to have_content I18n.t("password_resets.create.confirmation")
  end

  def expect_mailer_to_have_delivery(recipient, subject, body)
    expect(ActionMailer::Base.deliveries).not_to be_empty

    message = ActionMailer::Base.deliveries.any? do |email|
      email.to == [recipient] &&
        email.subject =~ /#{subject}/i
    end

    expect(message).to be
  end

  def expect_mailer_to_have_no_deliveries
    expect(ActionMailer::Base.deliveries).to be_empty
  end
end
