class Api::Pick::Create < ApiAction
  route do
    article = SaveAnimal.create!(params)
    json "animal created", status: 200
  end
end
