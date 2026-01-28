require_relative '../lib/dark_trader'

describe "Le Scrappeur de Crypto" do
  it "devrait retourner un tableau, et non nil" do
    expect(crypto_scrapper).not_to be_nil
    expect(crypto_scrapper).to be_an(Array)
  end

  it "devrait retourner au moins 10 cryptomonnaies" do
    expect(crypto_scrapper.length).to be > 10
  end
  
  # Test de cohérence : Vérifier qu'on a bien des Hashs à l'intérieur
  it "devrait contenir des hashs avec clés et valeurs" do
    result = crypto_scrapper
    expect(result[0]).to be_a(Hash)
  end
end