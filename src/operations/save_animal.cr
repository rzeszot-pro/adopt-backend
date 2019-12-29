class SaveAnimal < Animal::SaveOperation
  permit_columns name
end
