class Api::ResultsController < ApplicationController
  def upload_results
    @files_content = []
    @files_sports_names = []
    params[:results].each do |result|
      file = File.open(result.path, 'r')
      content = file.first.split("\r")
      return results_response('false', 'Wrong format') unless content_validator(content)
    end
    return results_response('false', 'All matches should be from the same sport') unless @files_sports_names.uniq.size == 1

    mvp = Sports.calculate(@files_content)
    # Check if all contents from the same sport or not
    # rescue from exceptions , in case empty param or anything wrong
    # abstract logic into sports calculator
    results_response('true', "MVP of #{@files_content.first.first} tournament is : #{mvp}")
  end

  def content_validator(content)
    if (Sports::SPORTS_NAMES.include? content.first) && sport_format_validator(content)
      @files_content.push(content)
    else
      false
    end
  end

  def results_response(status, message)
    render json: { 'success': status, message: message}
  end

  def sport_format_validator(content)
    @files_sports_names.push(content.first)
    content.drop(1).each do |element|
      # use false instead of break
      break unless element.split(";").size == "Sports::#{content.first}_ELEMENTS".constantize
    end
  end
end
