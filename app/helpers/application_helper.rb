module ApplicationHelper
    def nested_dom_id(*args)
      args.map { |arg| ActionView::RecordIdentifier.dom_id(arg) }.join('_')
    end
  end
  