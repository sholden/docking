class HelloController < ApplicationController
  def index
    render text: get_text
  end

  def get_text
    text = ''
    text << 'Hello'
    text << ' '
    text << 'World!'
    text
  end
end