require './handlers/hello_lita.rb'

describe Lita::Handlers::HelloLita, lita_handler: true do
  it "print quote" do
    send_command("say something")

    expect(replies.last).to eq('Life! Dont talk to me about life!')
  end
end
