require 'csv'
class ContributionToPdf
  include Dry::Transaction

  tee :validate
  step :generate_csv_file

  private

  def validate(input)
    @contribution = Contribution.find(input[:contribution_id].to_i)
    # @contributors = @project.contributors
    # if @contributors.empty?
    #   Failure(input.merge(error: 'This project has no contributor'))
    # else
    #   Success(input)
    # end
  end

  def generate_csv_file(input)
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    @file       = Tempfile.new('contributors.csv', 'tmp')
    CSV.open(@file, 'wb', csv_options) do |csv|
      csv << %w[Firstname Lastname Created_at Email Birthday CountryOfResidence Nationality]
      @contributors.each do |user|
        csv << [user.first_name, user.last_name, user.created_at, user.email, user.birthday, user.country_of_residence, user.nationality]
      end
    end
    Success(input.merge(file_path: @file.path))
  end
end