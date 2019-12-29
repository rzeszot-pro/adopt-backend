module PasswordValidations
  macro included
    before_save run_password_validations
  end

  private def run_password_validations
    validate_required password
    validate_size_of password, min: 6
  end
end
