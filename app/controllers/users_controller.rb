class UsersController < ApplicationController
  	def new
	  @user = User.new
	end

	def create
	  @user = User.new(user_params)

	  if @user.save
	    flash[:notice] = "Usuario creado exitosamente." 
	    redirect_to action: 'new'
	  else
	    render :action => 'new'
	    flash[:notice] = "Error al crear usuario, contacte al administrador." 
	  end
	end

	private

	  def user_params
	    params.require(:user).permit(:name, :last_name, :second_last_name, :role, :email, :password, :password_confirmation)
	  end

end
