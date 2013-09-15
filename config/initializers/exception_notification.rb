unless Rails.env.development?
  Raindrop::Application.config.middleware.use(
    ExceptionNotification::Rack,
    email: {
      email_prefix:         "[#{Rails.env}][#{Settings.site_name}] ",
      sender_address:       %{"ExceptionNotifier" <rails.dev0115@gmail.com>},
      exception_recipients: %w{rails.dev0115@gmail.com},
    }
  )
end

