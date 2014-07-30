class Rsvp < ActiveRecord::Base
  before_validation :cleanup_data
  after_save :send_to_spreadsheet

  validates :invited_guest_name, presence: true
  validates :num_beef, numericality: { greater_than_or_equal_to: 0, less_than: 10 }
  validates :num_chicken, numericality: { only_integer: true, less_than: 10 }
  validates :num_veg, numericality: { only_integer: true, less_than: 10 }

  def plus_one?
    !!self.plus_one
  end

  def cleanup_data
    self.plus_one = (self.plus_one_name && !self.plus_one_name.empty?) ? true : false
    self.num_beef    ||= 0
    self.num_chicken ||= 0
    self.num_veg     ||= 0
    self.declined    ||= false

    self.meal = self.declined ? 'D ' : ''
    self.num_beef.times do
      self.meal += 'b '
    end
    self.num_chicken.times do
      self.meal += 'c '
    end
    self.num_veg.times do
      self.meal += 'v '
    end
    self.meal.strip!
  end

  def send_to_spreadsheet
    #system( "sh .env_secrets") if ENV['G_UN']
    un = ENV['G_UN']
    pw = ENV['G_PW']
    session = GoogleDrive.login(un, pw)

    ws = session.spreadsheet_by_title('Krista + Jeff').worksheet_by_title('Online RSVP')

    new_row = ws.num_rows + 1
    invited_guest_col = 1
    plus_one_col      = 2
    plus_one_name_col = 3
    declined_col      = 4
    meal_col          = 5
    notes_col         = 6

    ws[new_row, invited_guest_col] = self.invited_guest_name
    ws[new_row, plus_one_col]      = self.plus_one?
    ws[new_row, plus_one_name_col] = self.plus_one_name
    ws[new_row, declined_col]      = self.declined
    ws[new_row, meal_col]          = self.meal
    ws[new_row, notes_col]         = self.notes
    ws.save
  end
end
