class AnimalSerializer < BaseSerializer
  def initialize(@animal : Animal)
  end

  def render
    { id: @animal.id, name: @animal.name }
  end
end
