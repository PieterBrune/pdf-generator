class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :full_name, :company, :phone_number, :street_address, :city, :state, :postal_code, :country ])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [ :full_name, :company, :phone_number, :street_address, :city, :state, :postal_code, :country ])
  end

  def after_sign_up_path_for(_resource)
    "/invoices"
  end

  def after_sign_in_path_for(_resource)
    "/invoices"
  end
end
