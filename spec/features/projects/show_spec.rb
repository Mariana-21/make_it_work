require 'rails_helper'

RSpec.describe "As a visitor" do 
  describe "when I visit projects show page" do 
    it "I see the information about that project" do
      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
      erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000) 

      news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
      lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

      ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
      ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
      ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
      ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

      visit"/projects/#{news_chic.id}"

      within("#project-#{news_chic.id}") do
        expect(page).to have_content(news_chic.name) 
        expect(page).to have_content("Material: #{news_chic.material}") 
        expect(page).to have_content("Challenge Theme: #{recycled_material_challenge.theme}")
        expect(page).to have_content("Number of contestants: #{news_chic.contestants.count}") 
      end

      visit"/projects/#{boardfit.id}"
      within("#project-#{boardfit.id}") do
        expect(page).to have_content(boardfit.name) 
        expect(page).to have_content("Material: #{boardfit.material}") 
        expect(page).to have_content("Challenge Theme: #{recycled_material_challenge.theme}")
        expect(page).to have_content("Number of contestants: #{boardfit.contestants.count}") 
      end

      visit"/projects/#{upholstery_tux.id}"
      within("#project-#{upholstery_tux.id}") do
        expect(page).to have_content(upholstery_tux.name) 
        expect(page).to have_content("Material: #{upholstery_tux.material}") 
        expect(page).to have_content("Challenge Theme: #{furniture_challenge.theme}")
        expect(page).to have_content("Number of contestants: #{upholstery_tux.contestants.count}") 
        expect(page).to have_content("Average Contestant Experience:") 
      end

      visit"/projects/#{lit_fit.id}"
      within("#project-#{lit_fit.id}") do
        expect(page).to have_content(lit_fit.name) 
        expect(page).to have_content("Material: #{lit_fit.material}") 
        expect(page).to have_content("Challenge Theme: #{furniture_challenge.theme}")
        expect(page).to have_content("Number of contestants: #{lit_fit.contestants.count}") 
      end
    end
  end
end  
