module Lita
  module Handlers
    class HelloLita < Handler
      route(/say something/, :complain,
            command: false,
            help: { "say something": "replies with Marvin classic quote" }
      )

      def complain(response)
        response.reply(
          'Life! Dont talk to me about life!'
        )
      end

      Lita.register_handler(self)
    end
  end
end
