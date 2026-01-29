require_relative '../lib/cher_depute'

describe "Le Scrappeur de Députés" do
  
  it "devrait retourner un array de hashs" do
    result = get_deputies_urls
    expect(result).to be_an(Array)
    expect(result).not_to be_empty
  end

  it "chaque hash doit contenir un prénom, un nom et un email" do
    result = get_deputies_urls
    deputy = result.first
    
    expect(deputy).to have_key("first_name")
    expect(deputy).to have_key("last_name")
    expect(deputy).to have_key("email")
    
    # On vérifie que l'email contient bien un "@"
    expect(deputy["email"]).to include("@")
  end
end