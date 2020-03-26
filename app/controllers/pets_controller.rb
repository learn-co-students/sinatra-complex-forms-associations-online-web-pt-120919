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
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    else
      @pet.owner = Owner.find(params[:owner_id])
      @pet.save
    end
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
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name], owner: Owner.find(params["owner"]["name"]))
    if !params["owner_name"].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
      @pet.save
    end
    redirect "pets/#{@pet.id}"
  end
end