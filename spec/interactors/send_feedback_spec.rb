require 'spec_helper'

describe SendFeedback do
  let(:user) { create(:user) }
  let(:page) { "page" }
  let(:message) { "message" }
  let(:params) { { user: user, page: page, message: message } }
  let(:interactor) { SendFeedback.call(params) }

  context "when the interactor is a success" do
    let(:mail) { double("AdminMailer", deliver!: true) }

    it "sends feedback emails" do
      expect(AdminMailer).to receive(:send_feedback).once
        .with(user, page, message).and_return(mail)

      expect(interactor).to be_success
    end
  end

  context "when emails cannot be sent" do
    let(:mail) { double("AdminMailer") }

    it "fails when emails cannot be sent properly" do
      expect(mail).to receive(:deliver!).once.and_raise

      expect(AdminMailer).to receive(:send_feedback).once
        .with(user, page, message).and_return(mail)

      expect(interactor).not_to be_success
    end
  end

end
