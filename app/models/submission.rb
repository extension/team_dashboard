class Submission < ApplicationRecord
  belongs_to :survey
  has_many :responses


  def psychological_safety_avg_score
		@psychological_safety_avg_score = 0
    (1..3).each do |i|
      @psychological_safety_avg_score += self.responses.where(question_number: i).last.score
    end
    return @psychological_safety_avg_score.to_d/3
	end

  def dependability_avg_score
		@dependability_avg_score = 0
    (4..6).each do |i|
      @dependability_avg_score += self.responses.where(question_number: i).last.score
    end
    return @dependability_avg_score.to_d/3
	end

  def structure_clarity_avg_score
		@structure_clarity_avg_score = 0
    (7..9).each do |i|
      @structure_clarity_avg_score += self.responses.where(question_number: i).last.score
    end
    return @structure_clarity_avg_score.to_d/3
	end

  def meaning_avg_score
		@meaning_avg_score = 0
    (10..12).each do |i|
      @meaning_avg_score += self.responses.where(question_number: i).last.score
    end
    return @meaning_avg_score.to_d/3
	end

  def impact_avg_score
		@impact_avg_score = 0
    (13..15).each do |i|
      @impact_avg_score += self.responses.where(question_number: i).last.score
    end
    return @impact_avg_score.to_d/3
	end
end
