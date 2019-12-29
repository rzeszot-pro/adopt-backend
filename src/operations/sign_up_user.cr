class SignUpUser < User::SaveOperation
  param_key :user
  include PasswordValidations

  permit_columns email
  attribute password : String

  before_save do
    validate_uniqueness_of email
    Authentic.copy_and_encrypt password, to: encrypted_password
  end
end
