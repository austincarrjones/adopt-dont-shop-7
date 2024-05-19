# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

application = PetApplication.create!(
                                    name: "Cesar Milan",
                                    street: "5 Haytown Rd.",
                                    city: "Lebanon",
                                    state: "NJ",
                                    zip: "08889",
                                    description: "I'd be great",
                                    status: "In Progress"
)
shelter = Shelter.create!(
                        name: "Mystery Building",
                        city: "Irvine CA",
                        foster_program: false,
                        rank: 9
)
pet1 = Pet.create!(
                name: "Scooby",
                age: 2,
                breed: "Great Dane",
                adoptable: true,
                shelter_id: shelter.id
)
pet2 = Pet.create(
                adoptable: true,
                age: 3,
                breed: "doberman",
                name: "Lobster",
                shelter_id: shelter.id
)
PetApplicationPet.create!(pet_application: application, pet: pet1)
PetApplicationPet.create!(pet_application: application, pet: pet2)