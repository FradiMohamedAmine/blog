module ApplicationHelper
    def nested_dom_id(*args)
      args.map { |arg| ActionView::RecordIdentifier.dom_id(arg) }.join('_')
    end


    def render_turbo_stream_flash_messages
      turbo_stream.prepend "flash", partial: "layouts/flash"
    end

  end
  