require 'nokogiri'
require 'open-uri'

def crypto_scrapper
  # 1. Ouverture de l'URL
  # On utilise la vue "all" pour tout avoir d'un coup
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  
  crypto_array = []

  # 2. Récupération des lignes (XPath structurel)
  # On cherche toutes les lignes (tr) du corps du tableau (tbody)
  rows = page.xpath('//tbody/tr')

  rows.each do |row|
    begin
      # 3. Extraction Symbole et Prix
      # Astuce : Au lieu de classes compliquées, on prend la position.
      # Sur la page "All", le symbole est souvent dans la colonne 3 et le prix dans la 5.
      # Note : Si ça renvoie vide, change le numéro entre crochets [x].
      
      symbol = row.xpath('td[3]').text 
      price = row.xpath('td[5]').text

      # 4. Nettoyage (enlever le $ et convertir en chiffre)
      clean_price = price.delete("$,").to_f

      # On ne garde que si le symbole n'est pas vide
      unless symbol.empty?
        crypto_array << { symbol => clean_price }
      end
      
    rescue => e
      # Si une ligne plante, on l'ignore et on continue
      # puts "Erreur sur une ligne : #{e}"
    end
  end

  return crypto_array
end

# Décommenter la ligne suivante pour tester l'exécution directe :
puts crypto_scrapper