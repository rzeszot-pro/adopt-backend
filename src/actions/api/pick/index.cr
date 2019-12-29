class Api::Pick::Index < ApiAction
  route do
    all_animals = AnimalQuery.all
    json AnimalSerializer.for_collection(all_animals)
  end
end
