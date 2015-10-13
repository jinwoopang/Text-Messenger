require 'test_helper'

class TextsControllerTest < ActionController::TestCase
  
  def setup
    @texts_controller = TextsController.new
    @texts_controller.set_from_number("+15005550006")
  end
  
  # Test post_message. Assumes that the Twilio phone number is valid.
  
  def test_post_message
    to_number = "+15005550007"
    msg = "I'm texting to a valid number."
    
    assert_nothing_raised {@texts_controller.post_message(to_number,msg)}
  end
  
  def test_post_message_empty
    to_number = "+15005550007"
    msg = ""

    assert_raise(Twilio::REST::RequestError) {@texts_controller.post_message(to_number,msg)}
  end
  
  def test_post_message_invalid_number
    to_number = "+15005550001"
    msg = "I'm texting to an invalid number."
    
    assert_raise(Twilio::REST::RequestError) {@texts_controller.post_message(to_number,msg)}
  end
end
