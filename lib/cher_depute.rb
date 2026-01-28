require 'nokogiri'
require 'open-uri'

def get_deputies_data
  # URL suggérée : https://www2.assemblee-nationale.fr/deputes/liste/alphabetique
  # Ou un annuaire public
  
  deputies_array = []
  
  # Logique : 
  # 1. Récupérer la liste des URLs de chaque fiche député
  # 2. Boucler sur chaque URL
  # 3. Sur la page du député, trouver le nom, prénom et l'email
  
  # C'est ton bonus, à toi de jouer avec l'inspecteur d'éléments !
  # N'oublie pas de séparer Prénom et Nom si tu les récupères dans une seule string.
  
  return deputies_array
end