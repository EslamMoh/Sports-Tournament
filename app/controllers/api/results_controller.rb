class Api::ResultsController < ApplicationController
  def upload_results
    @files_content = []
    @files_sports_names = []
    params[:results].each do |result|
      file = File.open(result.path, 'r')
      content = file.first.split("\r")
      @match_palyers = []

      return results_response('false', 'Wrong format') unless content_validator(content)

      return results_response('false', 'Same player cannot play in different positions in same match') unless @match_palyers.uniq.size == 6 
    end
    return results_response('false', 'All matches should be from the same sport') unless @files_sports_names.uniq.size == 1

    mvp = Sports.calculate(@files_content)

    results_response(mvp[0], mvp[1])
  rescue StandardError => e
    results_response('false', 'Failure')
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
      elements_array = element.split(";")
      break unless elements_array.size == "Sports::#{content.first}_ELEMENTS".constantize

      @match_palyers.push(elements_array[1])
    end
  end
end
