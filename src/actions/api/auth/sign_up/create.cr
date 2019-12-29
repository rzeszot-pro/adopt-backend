class Api::Auth::SignUp::Create < ApiAction
  include Api::Auth::SkipRequireAuthToken

  route do
    user = SignUpUser.create!(params)
    json({token: UserToken.generate(user)})
  end
end
