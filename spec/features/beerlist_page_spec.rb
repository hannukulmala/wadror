require 'rails_helper'

describe "Beerlist page" do
  before :all do
    browser_options = ::Selenium::WebDriver::Firefox::Options.new()
    browser_options.args << '--headless'
    
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(
        app,
        browser: :firefox,
        options: browser_options
      )
    end
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name: "Zastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", js:true  do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "shows beers in alphabetical order", js:true  do
    visit beerlist_path
    beers = []
    result = page.all('.tablerow')
    result.each do |elem|
      beers.append(elem.text)
    end
    sorted_beers = beers.sort
    expect(beers == sorted_beers).to equal(true)
  end
end
