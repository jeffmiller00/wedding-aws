require 'test_helper'

class RsvpTest < ActiveSupport::TestCase
  def teardown
    un = ENV['G_UN']
    pw = ENV['G_PW']
    session = GoogleDrive.login(un, pw)

    ws = session.spreadsheet_by_title('Krista + Jeff').worksheet_by_title('Online RSVP')

    (1..ws.num_cols).each do |i|
      ws[ws.num_rows, i] = nil
    end
    ws.save
  end

  # test "the truth" do
  #   assert true
  # end
  test 'meals get created correctly' do
    r = Rsvp.create(
      :invited_guest_name => 'Automated Test',
      :plus_one_name      => 'Automated Test Guest',
      :num_beef           => 1,
      :num_chicken        => 2,
      :num_veg            => 3,
      :notes              => 'Test Notes.',
    )
    assert r.plus_one == true
    assert r.declined == false
    assert r.meal == 'b c c v v v'
    assert !r.notes.empty?
  end

  test 'spreadsheet rows get created on save' do
    un = ENV['G_UN']
    pw = ENV['G_PW']
    session = GoogleDrive.login(un, pw)

    ws = session.spreadsheet_by_title('Krista + Jeff').worksheet_by_title('Online RSVP')
    tot_rows = ws.num_rows

    Rsvp.create(
      :invited_guest_name => 'Automated Test',
      :plus_one           => true,
      :plus_one_name      => 'Automated Test Guest',
    )

    ws.reload
    assert ws.num_rows == tot_rows + 1
  end
end
