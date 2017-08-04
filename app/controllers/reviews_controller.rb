class ReviewsController < ApplicationController

  def create
    @newReview = Review.new(product_id: params[:product_id], user_id: current_user.id, description: params[:review]["description"], rating: params[:review]["rating"])
    if @newReview.save
      redirect_to :back, notice: 'Review posted!'
    else
      redirect_to :back
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to :back, notice: 'Product deleted!'
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating,
    )
  end
end
