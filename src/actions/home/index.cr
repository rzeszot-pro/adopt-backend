class Home::Index < ApiAction
  include Api::Auth::SkipRequireAuthToken

  get "/" do
    json({hello: "world"})
  end
end
