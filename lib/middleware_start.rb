module NewRelic
  class MiddlewareStart
    def initialize(app)
      @app = app
    end

    def call(env)
      begin
        now = (Time.now.to_f * 1000000).to_i
        env["HTTP_X_MIDDLEWARE_START"] = "t=#{now}"
    
        # Calculate the queue time
        if env["HTTP_X_SERVER_START"]
          server_time = env["HTTP_X_SERVER_START"][2,16].to_i
          queue_time = now - server_time

          env["HTTP_X_QUEUE_TIME"] = "t=#{queue_time}"
        end
      ensure
        return @app.call(env)
      end
    end
  end
end