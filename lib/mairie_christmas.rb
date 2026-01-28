require 'nokogiri'
require 'open-uri'
require 'pp' # Permet d'afficher joliment les tableaux

# Méthode 1 : Récupérer l'email d'une ville spécifique
def get_townhall_email(townhall_url)
  # On ouvre la page de la mairie
  page = Nokogiri::HTML(URI.open(townhall_url))
  
  # On cherche le texte qui contient un "@" (c'est souvent l'email)
  email = page.xpath('//td[contains(text(), "@")]').text
  
  # On nettoie l'email (on enlève les espaces vides autour)
  return email.strip
rescue => e
  # Si ça plante (pas d'email trouvé), on retourne une chaine vide
  return ""
end

# Méthode 2 : Récupérer les URLs et construire la liste
def get_townhall_urls
  index_url = "http://annuaire-des-mairies.com/val-d-oise.html"
  page = Nokogiri::HTML(URI.open(index_url))
  
  final_array = []
  
  # On récupère tous les liens qui ont la classe "lientxt" (les villes)
  links = page.xpath('//a[@class="lientxt"]')
  
  # On ne prend que les 10 premiers (.first(10)) pour tester rapidement.
  links.first(10).each do |link|
  # links.each do |link|
    
    city_name = link.text
    
    # L'URL est relative (ex: "./95/avernes.html"), on doit la reconstruire
    suffix = link['href'].delete_prefix(".")
    full_url = "http://annuaire-des-mairies.com#{suffix}"
    
    # On récupère l'email via la méthode précédente
    email = get_townhall_email(full_url)
    
    # On crée le hash et on l'ajoute au tableau
    final_array << { city_name => email }
    
  end
  
  # On retourne le tableau complet
  return final_array
end

# --- EXÉCUTION ---
# puts "Récupération des emails en cours (10 premiers)..."

# On utilise 'pp' (Pretty Print) pour avoir l'affichage exact [ { }, { } ]
# pp get_townhall_urls