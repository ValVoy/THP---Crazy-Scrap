require_relative '../lib/mairie_christmas'

describe "Le Scrappeur de Mairies" do
  
  describe "get_townhall_email" do
    it "devrait retourner un email valide pour une mairie test" do
      # On teste avec Avernes, une ville du 95
      test_url = "http://annuaire-des-mairies.com/95/avernes.html"
      email = get_townhall_email(test_url)
      expect(email).to include("@")
    end
  end

  describe "get_townhall_urls" do
    it "devrait retourner un tableau non vide" do
      # Attention : Ce test peut être long car il lance tout le scraping
      # Pour le test, tu pourrais mocker (simuler) la réponse, mais restons simples.
      list = get_townhall_urls
      expect(list).to be_an(Array)
      expect(list).not_to be_empty
    end
  end
end