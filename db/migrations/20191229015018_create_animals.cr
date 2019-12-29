class CreateAnimals::V20191229015018 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Animal) do
      primary_key id : UUID
      add_timestamps

      add name : String
    end
  end

  def rollback
    drop table_for(Animal)
  end
end
