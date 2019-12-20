class Api::ResultsController < ApplicationController
  def upload_results
    @results = []
    params[:results].each do |result|
      file = File.open(result.path, 'r')
      content = file.first.split("\r")
      return results_response('false', 'Failed') unless content_validator(content)
    end
    results_response('true', 'Success')
  end

  def content_validator(content)
    byebug
    if content.first == 'BASKETBALL' && sport_format_validator(content)
      @results.push(content)
    elsif content.first == 'HANDBALL' && sport_format_validator(content)
      @results.push(content)
    else
      false
    end
  end

  def results_response(status, message)
    render json: { 'success': status, message: message}
  end

  def sport_format_validator(content)
    line_elements = content.first == 'BASKETBALL' ? 8 : 7
    content.drop(1).each do |element|
      break unless element.split(";").size == line_elements
    end
  end
end