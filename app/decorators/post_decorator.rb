class PostDecorator < Draper::Decorator
  delegate_all

  def created_at
    h.content_tag :span, class: 'time' do
      object.created_at.strftime('%Y %B %d')
    end
  end

  def tags
    tags = model.tags.map do |tag|
      link_to_tag(tag)
    end
    h.raw tags.join(', ')
  end

  private

  def link_to_tag(tag)
    h.link_to tag.name, h.tag_path(tag.name)
  end
end
