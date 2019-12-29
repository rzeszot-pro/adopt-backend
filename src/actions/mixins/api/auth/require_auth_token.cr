module Api::Auth::RequireAuthToken
  macro included
    before require_auth_token
  end

  private def require_auth_token
    if current_user?
      continue
    else
      json auth_error_json, 401
    end
  end

  private def auth_error_json
    ErrorSerializer.new(
      message: "not_authenticated",
      details: auth_error_details
    )
  end

  private def auth_error_details : String
    if auth_token
      "invalid_auth_token"
    else
      "missing_auth_token"
    end
  end

  # Tells the compiler that the current_user is not nil since we have checked
  # that the user is signed in
  private def current_user : User
    current_user?.not_nil!
  end
end
