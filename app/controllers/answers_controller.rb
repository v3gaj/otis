class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :set_question
  # GET /answers
  # GET /answers.json
  def index
  end

  # GET /answers/1
  # GET /answers/1.json
  def show

  end

  # GET /answers/new
  def new
    @question.answers = @question.answers.all
    if @question.question_type === "Abierta" && @question.answers.present?
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
      flash[:notice] = "Esta pregunta abierta ya posee una respuesta."
    else
      @answer = Answer.new
    end
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.question = @question
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer.question, notice: 'Respuesta creada exitosamente.' }
        format.json { render :show, status: :created, location: @answer }
        format.js   { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
        format.js   { render :layout => false }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer.question, notice: 'Respuesta actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question_path(@question), notice: 'Respuesta eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:question_id, :description, :image, :content, :message, :value)
    end
end
