class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]

  # GET /teams or /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1 or /teams/1.json
  def show

    # surveys_hash = {"Initial Baseline Survey"=>5.4, "Second Survey"=>7.8, "Third Survey"=>8.1, "Final Survey"=>8.7}

    @psychological_safety_surveys = Hash.new
    @team.surveys.each do |survey|
      @psychological_safety_surveys[survey.name] = survey.aggregate_psychological_safety_avg_score.to_d.round(2)
    end

    @dependability_surveys = Hash.new
    @team.surveys.each do |survey|
      @dependability_surveys[survey.name] = survey.aggregate_dependability_avg_score.to_d.round(2)
    end

    @structure_clarity_surveys = Hash.new
    @team.surveys.each do |survey|
      @structure_clarity_surveys[survey.name] = survey.aggregate_structure_clarity_avg_score.to_d.round(2)
    end

    @meaning_surveys = Hash.new
    @team.surveys.each do |survey|
      @meaning_surveys[survey.name] = survey.aggregate_meaning_avg_score.to_d.round(2)
    end

    @impact_surveys = Hash.new
    @team.surveys.each do |survey|
      @impact_surveys[survey.name] = survey.aggregate_impact_avg_score.to_d.round(2)
    end

    @total_surveys = Hash.new
    @team.surveys.each do |survey|
      @total_surveys[survey.name] = survey.aggregate_total_score.to_d.round(2)
    end

  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name)
    end
end
