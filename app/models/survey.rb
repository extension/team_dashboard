class Survey < ApplicationRecord
  belongs_to :team
  has_many :submissions

  def aggregate_psychological_safety_avg_score
    scores = 0
    self.submissions.each do |s|
      scores += s.individual_psychological_safety_avg_score
    end
    return scores.to_d/self.submissions.count
	end

  def aggregate_dependability_avg_score
    scores = 0
    self.submissions.each do |s|
      scores += s.individual_dependability_avg_score
    end
    return scores.to_d/self.submissions.count
	end

  def aggregate_structure_clarity_avg_score
    scores = 0
    self.submissions.each do |s|
      scores += s.individual_structure_clarity_avg_score
    end
    return scores.to_d/self.submissions.count
	end

  def aggregate_meaning_avg_score
    scores = 0
    self.submissions.each do |s|
      scores += s.individual_meaning_avg_score
    end
    return scores.to_d/self.submissions.count
	end

  def aggregate_impact_avg_score
    scores = 0
    self.submissions.each do |s|
      scores += s.individual_impact_avg_score
    end
    return scores.to_d/self.submissions.count
	end

  def aggregate_total_score
    scores = 0
    self.submissions.each do |s|
      scores += s.individual_psychological_safety_avg_score
      scores += s.individual_dependability_avg_score
      scores += s.individual_structure_clarity_avg_score
      scores += s.individual_meaning_avg_score
      scores += s.individual_impact_avg_score
    end
    return scores.to_d/self.submissions.count/5
	end


end
