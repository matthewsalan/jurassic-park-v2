json.array! @cages do |cage|
  json.id cage.id
  json.capacity cage.capacity
  json.current_capacity cage.current_capacity
  json.status cage.status
  json.species_type cage.species_type
end
