
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.new(name: params[:pet_name])
    if params[:owner].nil? && !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
      @pet.owner = owner
    elsif !params[:owner].nil?
      @pet.owner = Owner.find(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    
    pet = Pet.find(params[:id])
    pet.name = params[:pet_name]
    if !params[:owner_name].empty?
      owner = Owner.create(name: params[:owner_name])
      pet.owner = owner
    elsif !params[:owner_id].nil?
      pet.owner = Owner.find(params[:owner_id])
    else
      pet.owner = nil
    end
    pet.save
    redirect to "pets/#{pet.id}"
  end
end