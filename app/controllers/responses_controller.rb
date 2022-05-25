class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:get_google_form_submission]
  skip_before_action :verify_authenticity_token, only:[:get_google_form_submission]

  # GET /responses or /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1 or /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses or /responses.json
  def create
    @response = Response.new(response_params)

    respond_to do |format|
      if @response.save
        format.html { redirect_to @response, notice: "Response was successfully created." }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1 or /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: "Response was successfully updated." }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: "Response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #import data from csv
  def import
    Response.import(params[:file])
    redirect_to root_url, notice: "Successfully imported data"
  end

  def get_google_form_submission
    bearer_token = request.headers['Authorization'].split(' ').last

    if bearer_token == ENV['BEARER_TOKEN']
      #we don't care about the questions for email, survey and team so just get the responses
      values = params.values
      @email = values[0]
      @survey = values[1]
      @team = values[2]

      #create new hash with questions and responses excluding email, survey and team
      #we need both the question and answer for the responses
      responses = {}
      parameters = params.permit(params.keys).to_h
      Hash[Array(parameters)[3..17]].each_pair do |key, value|
        responses.store(key, value)
      end

      Response.get_google_form_submission(@email, @survey, @team, responses)

      ResponsesMailer.with(email: @email, survey: @survey, team: @team).new_response_email.deliver_now
    else
      puts "bearer_token failed"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.require(:response).permit(:question, :score, :time_entered, :question_number, :submission_id)
    end
end
