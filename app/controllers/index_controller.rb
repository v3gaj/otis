class IndexController < ApplicationController

  def home
    session[:test] = nil
    session[:student] = nil
  end

  def info
  	session[:test] = nil
    session[:student] = nil
  	@student = Student.new
  end

  def submit
    if params[:student].present?
      @student = Student.new(student_params)
      session[:student] = @student
      if session[:student] === nil
        redirect_to 'info'      
      end
      respond_to do |format|
        if @student.valid?
          format.html { redirect_to action: 'type', notice: 'Pregunta creada exitosamente.' }
          format.json { render :show, status: :created, location: @question }
        else
          format.html { render :info }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to action: 'info'
    end
  end

  def type

    session[:test] = nil
  	@test = Test.new
    @student = session[:student]
  	student = session[:student]
  	if student === nil || student['name'] === nil
  	  session[:student] = nil
      redirect_to action: 'info'
  	  flash[:alert] = "Complete la informacion requerida."
  	else
  	  if student['career'] != ""
  	  	@tests = Test.joins(:careers).where('tests.indentifier IN (?)',['General']).or(Test.joins(:careers).where('careers.career IN (?)', student['career']))
  	  else
  	  	@tests = Test.where('tests.indentifier IN (?)',['General'])
  	  end
      
  	end
    session[:stud] = @student
  end

  def start

    if session[:stud] === nil
      redirect_to action: 'info'
    else
      session[:test] = params[:id]
      test = Test.find(params[:id])
      student = session[:stud]
      student['test'] = test['indentifier']
      session[:student] = student
      redirect_to action: 'test'
    end
  end



  def test
    id = session[:test]
    student = session[:student]
    if student === nil || id === nil
      session[:test] = nil
      session[:student] = nil
      redirect_to action: 'info'
      flash[:alert] = "Complete la informacion requerida."
    else  
      @test = Test.find(id)
      respond_to do |format|
        format.html
        format.json { render :json => @test }
      end
      @questions = Question.where('id IN (?)', Relation.where("test_id = ?", id).select("question_id")).order("RAND()")
      @total = Question.where('id IN (?)', Relation.where("test_id = ?", id).select("question_id")).order("RAND()").count
    end
  end

  def finish
  end

  

  

  def result
    id = session[:test]
    questions = Question.where('id IN (?)', Relation.where("test_id = ?", id).select("question_id"))
    answers = Answer.where('question_id IN (?)', Relation.where("test_id = ?", id).select("question_id"))
    classifications = Classification.all
    rsts = []
    rst = {}
    questions.each do |question|
      rst = {}
      rst['question'] = question.description

      classifications.each do |classification|
        if classification.id === question.classification_id
          rst['class'] = classification.description
        end
      end

      if params["Preg"+question.id.to_s].present?
        answers.each do |answer|
          if answer.question_id === question.id
            if question.question_type === "Abierta"
              answer_content = params["Preg"+question.id.to_s]
              rst['answer'] = answer_content
              rst['correct'] = answer.content
              if answer.content === answer_content
                rst['value'] = true
              else
                rst['value'] = false
              end
            else
              answer_id = params["Preg"+question.id.to_s]
              if answer.value === true
                rst['correct'] = answer.description
              end  
              if answer_id === answer.id.to_s
                  rst['answer'] = answer.description
                  rst['value'] = answer.value  
              end
            end
          end
        end    
      else
        answers.each do |answer|
          if answer.question_id === question.id
            if question.question_type === "Abierta"
              rst['correct'] = answer.content
            else 
              if answer.value === true
                rst['correct'] = answer.description
              end  
            end 
          end
        end
        rst['answer'] = "No respondio la pregunta"
        rst['value'] = false
      end
      rsts.push(rst)
    end

    @student = session[:student]
    @student['answers'] = rsts

    respond_to do |format|
      if @student.save
        format.html { redirect_to action: 'finish', notice: 'Test Finalizado.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :home }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
    
  end

  private
    def student_params
      params.require(:student).permit(:name, :lastname, :second_lastname, :identifier, :gender, :birth_date, :career, :high_school, :answers)
    end

    def test_params
      params.require(:test).permit(:identifier)
    end
end
