class PaymentsController < ApplicationController
    
  def payment_status
    @status = params[:status]
    @payment_id = params[:id]
    @payment = Moyasar::Payment.find(@payment_id)
    @payment_email = @payment.metadata['email']
    
    @user = current_user

    if @payment_email.present? && @payment_email == current_user.email && @status == 'paid'
    
      # Calculate the current_period_end as 1 year from now
      current_period_end = 1.year.from_now

      # Update the user's subscription status and current_period_end
      @user.update(
        subscription_status: @status,
        current_period_end: current_period_end
      )
    end
  end
end
