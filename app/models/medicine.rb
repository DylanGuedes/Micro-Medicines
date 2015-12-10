class Medicine < ActiveRecord::Base
	has_many :shots

	# Validations
	validates :name, presence: true, uniqueness: true, length: { in: 4..20 }
	validates :description, presence: true, length: { in: 4..200 }
	validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :shot, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :max_shot, presence: true, numericality: { greater_than_or_equal_to: 0 }

def next_shot
    now = Time.now.hour

    if self.shots.nil?
      return '-'
    end

    shots = self.sort_shots
		if (shots.last.shot_date.hour > now)
			return shots.last.shot_date.strftime("%H:%M:%S")
		else
			shots.each do |s|
	      if s.shot_date.hour < now
	        return s.shot_date.strftime("%H:%M:%S")
	      end
			end
		end

    return '-'
  end

	def sort_shots
		self.shots.sort_by { |s| s.shot_date }
	end

private
  def format_date time
    time.strftime("%H:%M:%S")
  end
end
