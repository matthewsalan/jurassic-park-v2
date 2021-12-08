# README
**Requirements:**
- [ ] Cages must have a maximum capacity for how many dinosaurs it can hold.
- [ ] Cages know how many dinosaurs are contained.
- [ ] Cages have a power status of ACTIVE or DOWN.
- [ ] Cages cannot be powered off if they contain dinosaurs.
- [ ] Dinosaurs cannot be moved into a cage that is powered down.
- [ ] Each dinosaur must have a name.
- [ ] Each dinosaur must have a species (See enumerated list below, feel free to add others).
- [ ] Each dinosaur is considered an herbivore or a carnivore, depending on its species.
- [ ] Herbivores cannot be in the same cage as carnivores.
- [ ] Carnivores can only be in a cage with other dinosaurs of the same species.
- [ ] Must be able to query a listing of dinosaurs in a specific cage.
- [ ] When querying dinosaurs or cages they should be filterable on their attributes (Cages on their power status and dinosaurs on species).
- [ ] All requests should be respond with the correct HTTP status codes and a response, if necessary, representing either the success or error conditions.

**What additional changes may be needed to make the application run in a concurrent environment?**
* Throw hardware at it, i.e. deploy to multiple regions/availability zones, load balancers, etc.
* Use Typhoeus gem to run HTTP requests in parallel.
