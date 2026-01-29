require 'nokogiri'
require 'open-uri'
require 'pp'

# Méthode pour récupérer les infos d'un député spécifique
def get_deputy_info(deputy_url)
  page = Nokogiri::HTML(URI.open(deputy_url))
  
  # 1. Récupération du nom complet (c'est dans le titre h1)
  # Ex: "Jean Castex"
  full_name = page.xpath('//h1').text.strip
  
  # 2. Récupération de l'email
  # On cherche le lien qui contient "mailto:"
  # Souvent, il y a plusieurs emails (bureau, perso), on prend le premier
  email = page.xpath('//a[contains(@href, "mailto:")]').first
  # Si l'email existe, on prend le texte, sinon "Pas d'email"
  email = email ? email.text.strip : "Email non trouvé"

  # 3. Séparation Prénom / Nom
  # On coupe la string aux espaces
  names = full_name.split(' ')
  
  # Logique simple : Le premier mot est le prénom, le reste est le nom
  first_name = names[0]
  last_name = names[1..-1].join(' ') 

  # Le tout dans un hash
  return {
    "first_name" => first_name,
    "last_name" => last_name,
    "email" => email
  }

rescue => e
  puts "Erreur sur la fiche : #{e}"
  return nil
end

# Méthode principale
def get_deputies_urls
  index_url = "https://www.nosdeputes.fr/deputes"
  page = Nokogiri::HTML(URI.open(index_url))
  
  deputies_array = []
  
  # Sur ce site, chaque député est dans une div avec la classe "list_table"
  # On cherche le lien <a> à l'intérieur
  links = page.xpath('//div[@class="list_table"]//a')
  
  puts "Il y a #{links.length} députés trouvés. Traitement des 10 premiers..."

  # --- MODE TEST : On ne prend que les 10 premiers ---
  # Il faut retirer le .first(10) pour tout récupérer
  links.first(10).each do |link|
    
    # L'URL est relative (ex: "/jean-castex"), on ajoute le domaine devant
    partial_url = link['href']
    full_url = "https://www.nosdeputes.fr#{partial_url}"
    
    # On va chercher les infos
    data = get_deputy_info(full_url)
    
    # On ajoute au tableau si on a trouvé des données
    deputies_array << data if data
    
    # Petit affichage pour patienter
    puts "Scraping : #{data['first_name']} #{data['last_name']}"
  end
  
  return deputies_array
end

# Exécution
pp get_deputies_urls