puts "Suppression des Checkpoints existant (et des Project tant qu'ils ne seront pas unique)"

Question.destroy_all
Project.destroy_all
Checkpoint.destroy_all
User.destroy_all

puts "Seeding DB:"
print "\n Création reussie: '.'"
print " - "
print " Déjà existant: '-'"
print " - "
print " Création echouée: 'X'"
puts "\n\n Création de 3 Utilisateurs"

violaine = User.new(email:"violaine@gmail.com", password: "iamcitizen1")
if violaine.save
  print('.')
else
  violaine = User.where(email: "violaine@gmail.com").first
  print('-')
end

julian = User.new(email:"julian@gmail.com", password: "iamcitizen2")
if julian.save
  print('.')
else
  julian = User.where(email: "julian@gmail.com").first
  print('-')
end

patrick = User.new(email:"patrick@gmail.com", password: "iammayor1", admin: true)
if patrick.save
  print('.')
else
  patrick = User.where(email: "patrick@gmail.com").first
  if patrick.admin
    print('-')
  else
    patrick.admin = true
    patrick.save
    print('.')
  end
end

puts "\n Création de 4 projets"

#wagon bdx
projet1 = Project.new(
  title: "Project écologique",
  description: "Aménagement d'un espace vert sur la place dans le cadre d'un project écologique",
  address:"107 Cours Balguerie Stuttenberg, 33300 Bordeaux",
  progress: 2
)
if projet1.save
  projet1.photo.attach(io: open("https://res.cloudinary.com/dbtnehfrf/image/upload/v1606217206/my%20city%20views/luca-herrmann-c3hVKjmw2aU-unsplash_ojroku.jpg"), filename:'projet1')
  print('.')
else
  projet1 = Project.where(title: "Project écologique").first
  print('-')
end

#total
projet2 = Project.new(
  title: "Refaire Chaussée ?",
  description: "Suite à la constatation de nombreux trous présents sur la chaussée",
  address:"17 rue villeneuve 33000 bordeaux",
  progress: 1
)
if projet2.save
  projet2.photo.attach(io: open("https://res.cloudinary.com/dbtnehfrf/image/upload/v1606217209/my%20city%20views/paul-gilmore-jBCSAAcANG8-unsplash_1_ikuiwm.jpg"), filename:'projet2') 
  print ('.')
else
  projet2 = Project.where(title: "Refaire Chaussée ?").first
  print('-')
end

#brasserie du Medoc
projet3 = Project.new(
  title: "Piste cyclable ?",
  description: "Solicitation suite a de multiple demandes d'amenagement d'une piste cyclable",
  address:"53 rue giner de los rios 33800 bordeaux",
  progress: 1
)
if projet3.save
  projet3.photo.attach(io: open("https://res.cloudinary.com/dbtnehfrf/image/upload/v1606217205/my%20city%20views/bruno-martins-GkZvxVsHYWw-unsplash_atn7ga.jpg"), filename:'projet3')
  print('.')
else
  projet3 = Project.where(title: "Piste cyclable ?").first
  print('-')
end

#union sportive
projet4 = Project.new(
  title: "Espace vert au chatron ?",
  description: "Amenagement d'un espace vert dans le cadre d'un project écologique",
  address: " 21 rue des myosotis 33700 merignac",
  progress: 1
)
if projet4.save
  projet4.photo.attach(io: open("https://res.cloudinary.com/dbtnehfrf/image/upload/v1606217203/my%20city%20views/borna-hrzajna-8IPrifbjo-0-unsplash_1_cxd7iz.jpg"), filename:'projet4')
  print('.')
else
  projet4 = Project.where(title: "Espace vert aux Chartrons ?").first
  print('-')
end

puts "\n Création de 4 questions avec deux possibles réponses"

question1 = Question.new(
  title: "Selon vous, de quel coté la piste cyclable doit etre ?",
  first_answer: "Coté Sud",
  second_answer: "Coté Nord",
  project: projet1
)
if question1.save
  print('.')
else
  question1 = Question.where(title: "Selon vous, de quel coté la piste cyclable doit etre ?")
  print('-')
end

question2 = Question.new(
  title: "Préférez vous une chaussé en pavés ou en bitume ?",
  first_answer: "Bitume",
  second_answer: "Pavés",
  project: projet2
)
if question2.save
  print('.')
else
  question2 = Question.where(title: "Préférez vous une chaussé en pavés ou en bitume ?")
  print('-')
end

question3 = Question.new(
  title: "Garder les maronniers place Gambetta ?",
  first_answer: "Oui",
  second_answer: "Non",
  project: projet3
)
if question3.save
  print('.')
else
  question3 = Question.where(title: "Garder les maronniers place Gambetta ?")
  print('-')
end

question4 = Question.new(
  title: "Espace vert au Chartrons ?",
  first_answer: "Oui !",
  second_answer: "Réponse D, la réponse D.",
  project: projet4
)
if question4.save
  print('.')
else
  question4 = Question.where(title: "Espace vert au Chartrons ?")
  print('-')
end

puts "\n Création de Checkpoints pour simuler un mouvement"

checkpoint1 = Checkpoint.new(
  longitude:  -0.5992085742389957,
  latitude: 44.859703639565, 
  user: julian
)
if checkpoint1.save
  print('.')
else
  print('X')
end

checkpoint2 = Checkpoint.new(
  longitude:  -0.5983588937882691,
  latitude: 44.85856359036594, 
  user: julian
)

if checkpoint2.save
  print('.')
else
  print('X')
end

checkpoint3 = Checkpoint.new(
  longitude:  -0.5972057560337115,
  latitude: 44.85703631927222, 
  user: julian
)
if checkpoint3.save
  print('.')
else
  print('X')
end

checkpoint4 = Checkpoint.new(
  longitude:  -0.5961284826051116,
  latitude: 44.855530519381546, 
  user: julian
)
if checkpoint4.save
  print('.')
else
  print('X')
end

checkpoint5 = Checkpoint.new(
  longitude:  -0.5939891086131035,
  latitude: 44.854164509705065, 
  user: julian
)
if checkpoint5.save
  print('.')
else
  print('X')
end

checkpoint6 = Checkpoint.new(
  longitude:  -0.5908634983253563,
  latitude: 44.85289527475242, 
  user: julian
)
if checkpoint6.save
  print('.')
else
  print('X')
end

checkpoint7 = Checkpoint.new(
  longitude:  -0.5884054941643257,
  latitude: 44.853314770731664, 
  user: julian
)
if checkpoint7.save
  print('.')
else
  print('X')
end

checkpoint8 = Checkpoint.new(
  longitude:  -0.5854923040475488,
  latitude: 44.854379631417146, 
  user: julian
)
if checkpoint8.save
  print('.')
else
  print('X')
end

checkpoint9 = Checkpoint.new(
  longitude:  -0.5829432625915942,
  latitude: 44.8550142360191, 
  user: julian
)
if checkpoint9.save
  print('.')
else
  print('X')
end

checkpoint10 = Checkpoint.new(
  longitude:  -0.5800148996096257,
  latitude: 44.85504650386176, 
  user: julian
)
if checkpoint10.save
  print('.')
else
  print('X')
end

checkpoint11 = Checkpoint.new(
  longitude:  -0.5759940901856937,
  latitude: 44.85507877169143, 
  user: julian
)
if checkpoint11.save
  print('.')
else
  print('X')
end

checkpoint12 = Checkpoint.new(
  longitude:  -0.5719884537751253,
  latitude: 44.85510028356444, 
  user: julian
)
if checkpoint12.save
  print('.')
else
  print('X')
end

checkpoint13 = Checkpoint.new(
  longitude:  -0.5698642526483088,
  latitude: 44.85616511123424, 
  user: julian
)
if checkpoint13.save
  print('.')
else
  print('X')
end

checkpoint14 = Checkpoint.new(
  longitude:  -0.5676490143303429,
  latitude: 44.85768164998401, 
  user: julian
)
if checkpoint14.save
  print('.')
else
  print('X')
end

checkpoint15 = Checkpoint.new(
  longitude:  -0.5659799990266258,
  latitude: 44.858853982402636, 
  user: julian
)
if checkpoint15.save
  print('.')
else
  print('X')
end

checkpoint16 = Checkpoint.new(
  longitude:  -0.5691383884174347,
  latitude: 44.86447139010389, 
  user: violaine
)
if checkpoint16.save
  print('.')
else
  print('X')
end

checkpoint17 = Checkpoint.new(
  longitude:  -0.5664259360895968,
  latitude: 44.86377059506184, 
  user: violaine
)
if checkpoint17.save
  print('.')
else
  print('X')
end

checkpoint18 = Checkpoint.new(
  longitude:  -0.5671769545966258,
  latitude: 44.86240938257408, 
  user: violaine
)
if checkpoint18.save
  print('.')
else
  print('X')
end

checkpoint19 = Checkpoint.new(
  longitude:  -0.5679172442794399,
  latitude: 44.86122304822778, 
  user: violaine
)
if checkpoint19.save
  print('.')
else
  print('X')
end

checkpoint20 = Checkpoint.new(
  longitude:  -0.5687487290587449,
  latitude: 44.85985417053263, 
  user: violaine
)
if checkpoint20.save
  print('.')
else
  print('X')
end

checkpoint21 = Checkpoint.new(
  longitude:  -0.5668604539212165,
  latitude: 44.85836738039367, 
  user: violaine
)
if checkpoint21.save
  print('.')
else
  print('X')
end

checkpoint22 = Checkpoint.new(
  longitude:  -0.5659799990266258,
  latitude: 44.858853982402636, 
  user: violaine
)
if checkpoint22.save
  print('.')
else
  print('X')
end

puts "\n Seeding terminé!"
