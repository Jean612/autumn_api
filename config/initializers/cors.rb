LOCALHOST_URL = 'http://localhost:3001'.freeze
# PRODUCTION_URL = ENV['RESIDENTS_URL'] || 'https://web.pagacontarjeta.cl'.freeze
# VERCEL_REGEX = %r{^https://non-users-payments-front(-\w+)*(\.|-\w+-comunidad-feliz)\.vercel\.app/?$}

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  # allow do
  #   origins VERCEL_REGEX, PRODUCTION_URL
  #   resource '/', headers: :any, methods: %i[post options]
  # end

  unless Rails.env.production?
    allow do
      origins LOCALHOST_URL
      resource '/', headers: :any, methods: %i[post options]
    end
  end
end
