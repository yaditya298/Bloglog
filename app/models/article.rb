class Article < ActiveRecord::Base
	
	has_many :comments, dependent: :destroy
	#accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:article].blank? }, :allow_destroy => true
	validates :title, presence: true, length: { minimum:5 }
	validates :author, presence: true, length: { minimum:5 }

	searchable do
		text :author, :title, :text
	end
end
