class StudentsController < ApplicationController
	before_action :set_student, only: [:show]

  def index
  	if params["data"].present?
  		if params["data"]["filter"] != nil
	  		case params["data"]["filter"]
			when "Nombre"
			  @students = Student.where("name LIKE ?", "%#{params["data"]["value"]}%")
			when "Primer Apellido"
			  @students = Student.where("lastname LIKE ?", "%#{params["data"]["value"]}%")
			when "Segundo Apellido"
			  @students = Student.where("second_lastname LIKE ?", "%#{params["data"]["value"]}%")
			when "Identificacion"
			  @students = Student.where("identifier LIKE ?", "%#{params["data"]["value"]}%")
			when "Carrera"
			  @students = Student.where("career LIKE ?", "%#{params["data"]["value"]}%")
			else
			  @students = Student.all	
			end	
		else
			@students = Student.all
		end

		start = false
		finish = false 
		if params["data"]["start(2i)"] != "" && params["data"]["start(3i)"] != "" && params["data"]["start(1i)"] != ""
			start = true
		else
			if params["data"]["start(2i)"] != "" || params["data"]["start(3i)"] != "" || params["data"]["start(1i)"] != ""
				flash.notice = "Valor inicial del rango de fechas incompleto."
			end
		end
		if params["data"]["end(2i)"] != "" && params["data"]["end(3i)"] != "" && params["data"]["end(1i)"] != ""
			finish = true
		else	
			if params["data"]["end(2i)"] != "" || params["data"]["end(3i)"] != "" || params["data"]["end(1i)"] != ""
				if flash.notice != ""
					flash.notice = "Valores del rango de fechas incompletos."
				else
					flash.notice = "Valor final del rango de fechas incompleto."
				end
			end
		end

		if start === true
			if finish === true
				@stud = []
				startDate = Date.parse( {"(1i)"=>params["data"]["start(1i)"], "(2i)"=>params["data"]["start(2i)"], "(3i)"=>params["data"]["start(3i)"]}.to_a.sort.collect{|c| c[1]}.join("-") )
				finishDate = Date.parse( {"(1i)"=>params["data"]["end(1i)"], "(2i)"=>params["data"]["end(2i)"], "(3i)"=>params["data"]["end(3i)"]}.to_a.sort.collect{|c| c[1]}.join("-") )
				@students.each do |student|
					if	startDate <= student.created_at.to_date && student.created_at.to_date <= finishDate
						@stud.push(student)

					end
				end
				@students = []
				@students = @stud
			else
				@stud = []
				startDate = Date.parse( {"(1i)"=>params["data"]["start(1i)"], "(2i)"=>params["data"]["start(2i)"], "(3i)"=>params["data"]["start(3i)"]}.to_a.sort.collect{|c| c[1]}.join("-") )
				@students.each do |student|
					if	startDate <= student.created_at.to_date
						@stud.push(student)
					end
				end
				@students = @stud
			end
		else
			if finish === true
				@stud = []
				finishDate = Date.parse( {"(1i)"=>params["data"]["end(1i)"], "(2i)"=>params["data"]["end(2i)"], "(3i)"=>params["data"]["end(3i)"]}.to_a.sort.collect{|c| c[1]}.join("-") )
				@students.each do |student|
					if	student.created_at.to_date <= finishDate
						@stud.push(student)
					end
				end
				@students = @stud
			end
		end
  	else
  		@students = Student.all	
  	end
  	

  	@students.each do |student|
  		result = []
  		classifications = []
  		ans = {}
  		countTrue = 0
  		countFalse = 0
  		countTotal = 0
  		answers = ActiveSupport::JSON.decode(student.answers.gsub(/:([a-zA-z])/,'\\1').gsub('=>', ' : '))

  		answers.each do |answer|
  			if answer['value'] === true
  				countTrue = countTrue + 1
  			else
  				countFalse = countFalse + 1
  			end
  			countTotal = countTotal + 1

  			classif = {}
  			classif['correct'] = 0
			value = false
			if classifications === []
			    classif['classification'] = answer['class']
			    classif['quantity'] = 1
			    if answer['value'] === true
			    	classif['correct'] = 1
			    end
			    classifications.push(classif)
			else
			  	for  i in 0..classifications.length-1
			    	if classifications[i]['classification'] === answer['class']
			      		classifications[i]['quantity'] = classifications[i]['quantity'] + 1
			      		if answer['value'] === true
			      			if classifications[i]['correct'] === nil
					    		classifications[i]['correct'] = 0
					    		classifications[i]['correct'] = classifications[i]['correct'] + 1
					    	else
					    		classifications[i]['correct'] = classifications[i]['correct'] + 1
					    	end
					    end  
			      		value = true
			      	break
			    	end
				end
				if value === false
				    classif['classification'] = answer['class']
				    classif['quantity'] = 1
				    if answer['value'] === true
				    	classif['correct'] = 1
				    end
				    classifications.push(classif)        
				end
			end
  		end
  		ans['correct'] = countTrue
  		ans['incorrect'] = countFalse
  		ans['total'] = countTotal
  		result.push(ans)
  		student.results = result
  		student.classifications = classifications
  		student.ans = answers
	end
  end

  def show

	result = []
	classifications = []
	ans = {}
	countTrue = 0
	countFalse = 0
	countTotal = 0
	answers = ActiveSupport::JSON.decode(@student.answers.gsub(/:([a-zA-z])/,'\\1').gsub('=>', ' : '))
	answers.each do |answer|
		if answer['value'] === true
			countTrue = countTrue + 1
		else
			countFalse = countFalse + 1
		end
		countTotal = countTotal + 1

		classif = {}
		classif['correct'] = 0
		value = false
		if classifications === []
		    classif['classification'] = answer['class']
		    classif['quantity'] = 1
		    if answer['value'] === true
		    	classif['correct'] = 1
		    end
		    classifications.push(classif)
		else
		  	for  i in 0..classifications.length-1
		    	if classifications[i]['classification'] === answer['class']
		      		classifications[i]['quantity'] = classifications[i]['quantity'] + 1
		      		if answer['value'] === true
		      			if classifications[i]['correct'] === nil
				    		classifications[i]['correct'] = 0
				    		classifications[i]['correct'] = classifications[i]['correct'] + 1
				    	else
				    		classifications[i]['correct'] = classifications[i]['correct'] + 1
				    	end
				    end  
		      		value = true
		      	break
		    	end
			end
			if value === false
			    classif['classification'] = answer['class']
			    classif['quantity'] = 1
			    if answer['value'] === true
			    	classif['correct'] = 1
			    end
			    classifications.push(classif)        
			end
		end
	end
	ans['correct'] = countTrue
	ans['incorrect'] = countFalse
	ans['total'] = countTotal
	result.push(ans)
	@student.results = result
	@student.classifications = classifications
	@student.ans = answers
  end

	private
	def set_student
	  @student = Student.find(params[:id])
	end	
end
