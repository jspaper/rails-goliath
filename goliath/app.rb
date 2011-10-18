require 'goliath'
require 'digest'

class SomeGoliathApp < Goliath::API
  use Goliath::Rack::Params

  def response(env)
    salt = 'supersecretsalt'
    from_signature = env.params.delete('signature')
    valid = Digest::MD5.hexdigest(env.params.to_s+salt) == from_signature
    resp = "Hello from Goliath!<br />Request signature valid? #{valid}.<br />Your user id is #{env.params['user_id']}"

    [200, {}, resp]
  end
end
