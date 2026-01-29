require 'nokogiri'
require 'open-uri'
require 'pp'

# Méthode pour récupérer les infos d'un député spécifique
def get_deputy_info(deputy_url)
  page = Nokogiri::HTML(URI.open(deputy_url))
  
  # 1. Récupération du nom complet (c'est dans le titre h1)
  full_name = page.xpath('//h1').text.strip
  
  # 2. Récupération de l'email
  # On cherche le lien qui contient "mailto:"
  email = page.xpath('//a[contains(@href, "mailto:")]').first
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
  
  # --- MODE COMPLET AVEC POURCENTAGE ---
  
  # On définit sur quoi on boucle (ici, on prend tout pour l'exemple)
  # Si tu gardes .first(10) pour tester, change la variable ci-dessous !
  links_to_scrape = links.first(10) # ou links.first(10) pour tester
  
  total = links_to_scrape.length
  puts "Démarrage du scraping pour #{total} députés..."
  
  # Utilisation de each_with_index
  links_to_scrape.each_with_index do |link, index|
    
    # ... (Ta logique de récupération d'URL reste ici) ...
    partial_url = link['href']
    full_url = "https://www.nosdeputes.fr#{partial_url}"
    data = get_deputy_info(full_url)
    deputies_array << data if data
    
    # --- CALCUL DU POURCENTAGE ---
    
    # L'index commence à 0, donc on ajoute 1 pour avoir le nombre courant
    current = index + 1
    
    percentage = (current.to_f / total) * 100
    
    # --- AFFICHAGE ---
    
    # Astuce : 
    # 'print' n'ajoute pas de saut de ligne (contrairement à 'puts')
    # '\r' (Carriage Return) renvoie le curseur au début de la ligne
    # Cela permet d'écraser l'ancien pourcentage par le nouveau !
    
    print "Progression : #{percentage.round(1)}% (#{current}/#{total}) \r"
    
  end

  return deputies_array
end

# Exécution
pp get_deputies_urls