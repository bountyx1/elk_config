
require 'json'
require "resolv"


# register accepts the hashmap passed to "script_params"
# it runs once at startup
def register(params)
  @message = params["message"]
end


def filter(event)
   domain = event.get(@message).reverse.chomp(".*").reverse
   file = File.open("./programs.json").read
   targets = JSON.parse(file)
   targets.each do |target|
    if domain.end_with?("."+target)
      event.set("domain",target)
      event.set("subdomain",domain)
      return [event]
   end
end
# Return empty list to indicate event.cancel
return []
end
