class Animal < BaseModel
  skip_default_columns

  table do
    primary_key id : UUID
    column name : String
    timestamps
  end
end
