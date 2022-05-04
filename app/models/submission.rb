class Submission < ApplicationRecord
  belongs_to :survey
  belongs_to :user
  has_many :responses


  def individual_psychological_safety_avg_score
		@score = 0
    (1..3).each do |i|
      @score += self.responses.where(question_number: i).last.score
    end
    return @score.to_d/3
	end

  def individual_dependability_avg_score
		@score = 0
    (4..6).each do |i|
      @score += self.responses.where(question_number: i).last.score
    end
    return @score.to_d/3
	end

  def individual_structure_clarity_avg_score
		@score = 0
    (7..9).each do |i|
      @score += self.responses.where(question_number: i).last.score
    end
    return @score.to_d/3
	end

  def individual_meaning_avg_score
		@score = 0
    (10..12).each do |i|
      @score += self.responses.where(question_number: i).last.score
    end
    return @score.to_d/3
	end

  def individual_impact_avg_score
		@score = 0
    (13..15).each do |i|
      @score += self.responses.where(question_number: i).last.score
    end
    return @score.to_d/3
	end
end
