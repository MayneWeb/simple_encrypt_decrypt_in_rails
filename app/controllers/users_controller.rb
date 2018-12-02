class UsersController < ApplicationController
  before_action :authenticate_user!
  include CryptConcern

  # GET /
  def index
    @user = current_user
  end

  # PATCH /save
  def save_keys
    user = current_user

    # To see the decrypted value:
    # puts crypt.decrypt_and_verify(user.consumer_key)
    # will print the value in your terminal.

    # If all is saved, return to homepage
    # To use a falsh notice, use the regular if block: if ... end
    user.update_attributes(user_params) and return redirect_to root_path

    # Normally this action would be an :edit
    # Ensure you have an edit method before changing.
    render action: :index
  end

  private
    def user_params
      params.require(:user).permit(:consumer_key, :consumer_secret)
    end
end
