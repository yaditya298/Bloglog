class Article < ActiveRecord::Base
	#attr_accessible :author, :text, :created_at
	has_many :comments, dependent: :destroy
	#accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:article].blank? }, :allow_destroy => true
	
	validates :author, presence: true, length: { minimum:5 }

	searchable do
		text :author, :text
	end
end
