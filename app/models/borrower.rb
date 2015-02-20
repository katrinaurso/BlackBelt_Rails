class Borrower < ActiveRecord::Base

  def has_password?(submitted_password)
    self.password == submitted_password
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
end
