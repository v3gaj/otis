class TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
    @test.relations = Relation.joins(:question).where("relations.test_id = ?", @test.id).select("relations.id, questions.identifier, questions.description")
    @quantity = Relation.joins(:question).where("relations.test_id = ?", @test.id).select("relations.id, questions.identifier, questions.description").count(:all)
    questions = Question.where("questions.id IN (?)", Relation.where("test_id = ?", @test.id).select("question_id"))
    classificat = Classification.all

    classifications = []
  
    questions.each do |question|
      classif = {}
      value = false
      if classifications === []
        classif['classification'] = question.classification_id
        classif['quantity'] = 1
        classifications.push(classif)
      else
        for  i in 0..classifications.length-1
            if classifications[i]['classification'] === question.classification_id
            classifications[i]['quantity'] = classifications[i]['quantity'] + 1  
            value = true
            break
          end
        end
        if value === false
          classif['classification'] = question.classification_id
          classif['quantity'] = 1
          classifications.push(classif)        
        end
      end
    end

    classificat.each do |classif|
      for  i in 0..classifications.length-1
        if classifications[i]['classification'] === classif.id
          classifications[i]['classification'] = classif.description
          break
        end
      end
    end
    @classifications = classifications
  end  

  # GET /tests/new
  def new
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)

    respond_to do |format|
      if @test.save
        format.html { redirect_to @test, notice: 'Prueba creada exitosamente.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to @test, notice: 'Prueba actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url, notice: 'Prueba eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:indentifier, :description, :time)
    end
end
