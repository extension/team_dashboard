class SurveysController < ApplicationController
  before_action :set_survey, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /surveys or /surveys.json
  def index
    @surveys = Survey.all
  end

  # GET /surveys/1 or /surveys/1.json
  def show

    @psychological_safety_surveys = Hash.new
    @survey.submissions.each do |submission|
      @psychological_safety_surveys[submission.id] = submission.individual_psychological_safety_avg_score.to_d.round(2)
    end

    @dependability_surveys = Hash.new
    @survey.submissions.each do |submission|
      @dependability_surveys[submission.id] = submission.individual_dependability_avg_score.to_d.round(2)
    end

    @structure_clarity_surveys = Hash.new
    @survey.submissions.each do |submission|
      @structure_clarity_surveys[submission.id] = submission.individual_structure_clarity_avg_score.to_d.round(2)
    end

    @meaning_surveys = Hash.new
    @survey.submissions.each do |submission|
      @meaning_surveys[submission.id] = submission.individual_meaning_avg_score.to_d.round(2)
    end

    @impact_surveys = Hash.new
    @survey.submissions.each do |submission|
      @impact_surveys[submission.id] = submission.individual_impact_avg_score.to_d.round(2)
    end

  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys or /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: "Survey was successfully created." }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1 or /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: "Survey was successfully updated." }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1 or /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: "Survey was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def survey_params
      params.require(:survey).permit(:name, :team_id)
    end
end
