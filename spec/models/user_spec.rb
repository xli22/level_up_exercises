require 'spec_helper'

describe User do

  let(:attr) do
    {
      name: "Example User",
      email: "user@example.com",
      password: "changeme",
      password_confirmation: "changeme",
    }
  end

  it "creates a new instance given a valid attribute" do
    User.create!(attr)
  end

  it "requires an email address" do
    no_email_user = User.new(attr.merge(email: ""))
    expect(no_email_user).not_to be_valid
  end

  it "accepts valid email addresses" do
    addresses = %w(user@foo.com THE_USER@foo.bar.org first.last@foo.jp)
    addresses.each do |address|
      valid_email_user = User.new(attr.merge(email: address))
      expect(valid_email_user).to be_valid
    end
  end

  it "rejects invalid email addresses" do
    addresses = %w(user@foo,com user_at_foo.org example.user@foo.)
    addresses.each do |address|
      invalid_email_user = User.new(attr.merge(email: address))
      expect(invalid_email_user).not_to be_valid
    end
  end

  it "rejects duplicate email addresses" do
    User.create!(attr)
    user_with_duplicate_email = User.new(attr)
    expect(user_with_duplicate_email).not_to be_valid
  end

  it "rejects email addresses identical up to case" do
    upcased_email = attr[:email].upcase
    User.create!(attr.merge(email: upcased_email))
    user_with_duplicate_email = User.new(attr)
    expect(user_with_duplicate_email).not_to be_valid
  end

  describe "passwords" do

    let(:user) { User.new(attr) }

    it "has a password attribute" do
      expect(user).to respond_to(:password)
    end

    it "has a password confirmation attribute" do
      expect(user).to respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "requires a password" do
      user = User.new(attr.merge(password: "", password_confirmation: ""))
      expect(user).not_to be_valid
    end

    it "requires a matching password confirmation" do
      user = User.new(attr.merge(password_confirmation: "invalid"))
      expect(user).not_to be_valid
    end

    it "rejects short passwords" do
      short = "a" * 5
      hash = attr.merge(password: short, password_confirmation: short)
      expect(User.new(hash)).not_to be_valid
    end

  end

  describe "password encryption" do
    let(:user) { User.create!(attr) }

    it "has an encrypted password attribute" do
      expect(user).to respond_to(:encrypted_password)
    end

    it "sets the encrypted password attribute" do
      expect(user.encrypted_password).not_to be_blank
    end

  end

  describe "skills" do
    let(:user)      { create(:user) }
    let(:skill)     { create(:skill, category: category) }
    let(:category)  { create(:category) }

    it "finds skills that have been completed" do
      expect(user.skills).to be_empty

      create(:completion, user: user, skill: skill)
      expect(user).to have(1).skills
      expect(user.skills).to include(skill)

      completion = create(:completion, user: user)
      expect(user.reload).to have(2).skills
      expect(user.skills).to include(completion.skill)
    end

    it "finds skills by category" do
      create(:completion, user: user, skill: skill)
      other = create(:completion, user: user)

      # scope down on category
      expect(user.skills.for_category(category)).to have(1).item
      expect(user.skills.for_category(category)).not_to include(other.skill)
    end

    it "checks completion of a skill" do
      expect(user.skills).not_to include(skill)
      create(:completion, user: user, skill: skill)
      expect(user.reload.skills).to include(skill)
    end
  end

  describe "#from_omniauth" do
    let(:attrs) { { email: "tom@test.com", name: "Tom PW" } }
    let(:info) { double("info", email: attrs[:email], name: attrs[:name]) }
    let(:auth) { double("github", provider: "github", uid: "1", info: info) }

    context "with a new user" do
      it "creates the new user with the provided info" do
        expect(User).to receive(:create)
          .with(hash_including(email: attrs[:email], uid: "1"))
          .and_call_original
        User.from_omniauth(auth)
      end

      it "saves the user params" do
        user = User.from_omniauth(auth)
        expect(user).to have_attributes(
          email: attrs[:email],
          name: attrs[:name],
          provider: "github",
          uid: "1",
        )
      end

      it "returns the new user" do
        user = User.from_omniauth(auth)
        expect(user).to be_persisted
      end
    end

    context "when the user registered before" do
      let!(:old_user) { create(:user, email: attrs[:email]) }

      it "finds the old user" do
        user = User.from_omniauth(auth)
        expect(user).to eq(old_user)
      end

      it "doesn't try to create a new user" do
        expect(User).not_to receive(:create)
        User.from_omniauth(auth)
      end
    end

    context "when the user oauth'd before" do
      let!(:old_user) { create(:user, provider: "github", uid: "1") }

      it "finds the old user" do
        user = User.from_omniauth(auth)
        expect(user).to eq(old_user)
      end

      it "doesn't try to create a new user" do
        expect(User).not_to receive(:create)
        User.from_omniauth(auth)
      end
    end
  end
end
