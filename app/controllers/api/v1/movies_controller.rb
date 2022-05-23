class Api::V1::MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :update, :destroy]
  def index
    @movies = Movie.all
    render json: @movies
  end

  def show
    render json: @movie
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render json: @movie
    else
      render error: { error:"Unable to create movie." }
    end
  end

  def update
    if @movie
      @movie.update(movie_params)
      rende json: { message: "Movie successfully updated."}
    else
      render json: { error: "Unable to update movie." }
    end
  end

  def destroy
    if @movie
      @movie.destroy
      render json: { message:"Movie successfully deleted." }
    else
      render json: { error: "Unable to delete movie."}
    end

  end


  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :poster_url, :rating)
  end

  def find_movie
    @movie = Movie.find(params[:id])
  end


end
