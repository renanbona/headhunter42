require 'rails_helper'

RSpec.describe "Pipeline", type: :feature do
  let!(:user) { create(:user, role: :admin) }
  let!(:pipeline) { create(:pipeline) }
  let!(:step1) { create(:step, pipeline: pipeline, order: 1) }
  let!(:step2) { create(:step, pipeline: pipeline, order: 2) }

  before do
    create(:company)
    sign_in user
  end

  scenario "action show pipeline also show their steps" do
    visit (admin_pipeline_path(pipeline.id))

    expect(page).to have_content(pipeline.name)
    expect(page).to have_content(step1.name)
    expect(page).to have_content(step1.description)
    expect(page).to have_content(step2.name)
    expect(page).to have_content(step2.description)
  end

  scenario "user visit show and click button back" do
    visit (admin_pipeline_path(pipeline.id))

    find('.btn-info').click

    expect(current_path).to eq '/admin/pipelines'
  end

  scenario "user creates a new pipeline" do
    visit (new_admin_pipeline_path)

    fill_in('pipeline_name', with: "Trabson")
    click_button('Salvar')

    expect(page).to have_text("Cargo criado com sucesso!")
  end

  scenario "user does not create a pipeline" do
    visit (new_admin_pipeline_path)

    fill_in('pipeline_name', with: "")
    click_button('Salvar')

    expect(page).to have_text("Nome não pode ficar em branco")
  end

  scenario "user edit the pipeline" do
    visit (edit_admin_pipeline_path(pipeline.id))

    fill_in('pipeline_name', with: "Biribiri")
    click_button('Salvar')

    expect(page).to have_text("Cargo atualizado com sucesso!")
  end

  scenario "user does not edit the pipeline" do
    visit (edit_admin_pipeline_path(pipeline.id))

    fill_in('pipeline_name', with: "")
    click_button('Salvar')

    expect(page).to have_text("Nome não pode ficar em branco")
  end
end
