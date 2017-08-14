class RelationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_relation, only: [:show, :edit, :update, :destroy]
  before_action :set_test

  # GET /relations
  # GET /relations.json
  def index
  end

  # GET /relations/1
  # GET /relations/1.json
  def show
  end

  # GET /relations/new
  def new
    @relation = Relation.new
    @questions = Question.where('id NOT IN (?)', Relation.where("test_id = ?", @test.id).select("question_id"))
  end

  # GET /relations/1/edit
  def edit
  end

  # POST /relations
  # POST /relations.json
  def create
    @questions = Question.where('id NOT IN (?)', Relation.where("test_id = ?", @test.id).select("question_id"))
    @relation = Relation.new(relation_params)
    @relation.test = @test
    respond_to do |format|
      if @relation.save
        format.html { redirect_to @relation.test, notice: 'Relación creada exitosamente.' }
        format.json { render :show, status: :created, location: @relation }
      else
        format.html { render :new }
        format.json { render json: @relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # No tiene control de errores
  def create_multiple
    params[:question_ids].each do|question_id|
      Relation.create(:test_id => params[:test_id], :question_id => question_id)
    end 
    redirect_to @test, notice: 'Relaciones creadas exitosamente.'
  end

  # PATCH/PUT /relations/1
  # PATCH/PUT /relations/1.json
  def update
    respond_to do |format|
      if @relation.update(relation_params)
        format.html { redirect_to @relation.test, notice: 'Relación actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @relation }
      else
        format.html { render :edit }
        format.json { render json: @relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relations/1
  # DELETE /relations/1.json
  def destroy
    @relation.destroy
    respond_to do |format|
      format.html { redirect_to test_path(@test), notice: 'Relación eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_test
      @test = Test.find(params[:test_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_relation
      @relation = Relation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relation_params
      params.require(:relation).permit(:test_id, :question_id)
    end
end
