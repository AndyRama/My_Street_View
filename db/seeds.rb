puts "clean datbase"

User.destroy_all
Question.destroy_all
Project.destroy_all

puts "Creating 3 new users"

marie = User.new(email:"marie@gmail.com", password: "iamcitizen1")

sophie = User.new(email:"shopie@gmail.com", password: "iamcitizen2")

patrick = User.new(email:"patrick@gmail.com", password: "iammayor1")

marie.save
sophie.save
patrick.save

puts "Creating 4 new projects"

#wagon bdx
voirie1 = Project.new(
  title: "Project ecologique?",
  description: "Amenagement d'un espace vert sur la place dans le cadre d'un project ecologie",
  longitude: 44.85959815077221, 
  latitude:  -0.5659754120653856,
  progress: 2
)

#total
voirie2 = Project.new(
  title: "Refaire Chaussée ?",
  description: "Suite à la constatation de nombreux troues present sur la chaussée",
  longitude: 44.861582981544565,
  latitude: -0.5703369634805979,
  progress: 4
)
  
  
#brasserie du Medoc
voirie3 = Project.new(
  title: "Piste cyclable ?",
  description: "Solicitation suite a de multiple demandes amenagement d'une piste cyclable",
  longitude: 44.85846256846444,
  latitude: -0.5669074204334726,
  progress: 3
)

  
#union sportive
voirie4 = Project.new(
  title: "Espace vert au chatron ?",
  description: "Amenagement d'un espace vert dans le cadre d'un project ecologie",
  longitude: 44.858523409633406,
  latitude: -0.5648152974891937,
  progress: 1
)
voirie1.photo.attach(io: open("https://res.cloudinary.com/dbtnehfrf/image/upload/v1606217206/my%20city%20views/luca-herrmann-c3hVKjmw2aU-unsplash_ojroku.jpg"), filename:'voirie1')
voirie1.save!
voirie2.photo.attach(io: open("https://res.cloudinary.com/dbtnehfrf/image/upload/v1606217209/my%20city%20views/paul-gilmore-jBCSAAcANG8-unsplash_1_ikuiwm.jpg"), filename:'voirie2') 
voirie2.save! 
voirie3.photo.attach(io: open("https://res.cloudinary.com/dbtnehfrf/image/upload/v1606217205/my%20city%20views/bruno-martins-GkZvxVsHYWw-unsplash_atn7ga.jpg"), filename:'voirie3')
voirie3.save!
voirie4.photo.attach(io: open("https://res.cloudinary.com/dbtnehfrf/image/upload/v1606217203/my%20city%20views/borna-hrzajna-8IPrifbjo-0-unsplash_1_cxd7iz.jpg"), filename:'voirie4')
voirie4.save!

puts "Creating questions with answers first and second "

question1 = Question.new(
  title: "Selon vous, de quel coté la piste cyclable doit etre ?",
  first_answer: "Coté Sud",
  second_answer: "Coté Nord",
  project: Project.first
)

question2 = Question.new(
  title: "Préférez vous une chaussé en pavés ou en bitume ?",
  first_answer: "Bitume",
  second_answer: "Pavés",
  project_id: 2
)

question3 = Question.new(
  title: "Garder les maronniers place Gambetta ?",
  first_answer: "Oui",
  second_answer: "Non",
  project_id: 3
)

question4 = Question.new(
  title: "Espace vert au Chartrons ?",
  first_answer: "Oui !",
  second_answer: "Réponse D, la réponse D.",
  project: Project.last
)
question1.save
question2.save
question3.save
question4.save

puts "Created, ready to go!"
