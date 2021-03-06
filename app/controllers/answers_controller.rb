class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :mark_best, :destroy]
  before_action :set_answer, only: [:update, :mark_best, :destroy]
  before_action :set_question, only: [:create]

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answer_params) if current_user.author?(@answer)
  end

  def mark_best
    @answer.mark_best if current_user.author?(@answer.question)
  end

  def destroy
    @answer.destroy if current_user.author?(@answer)
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end
end