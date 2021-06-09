require "base64"
require "net/http"

def register(params)
    @encoded = params["encoded"]
  end

  def filter(event)
    encoded = event.get(@encoded)
    raw_resp = Base64.decode64(encoded)
    resp_io = StringIO.new(raw_resp)
    buff_io = Net::BufferedIO.new(resp_io)
    response = Net::HTTPResponse.read_new(buff_io)
    response.reading_body(buff_io, true) { res if block_given? }
    event.set("headers",response.each_header.to_h)
    event.set('body',response.body)
    return [event]
 end




