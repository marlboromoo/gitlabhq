module EventsHelper
  def link_to_author(event)
    project = event.project
    tm = project.team_member_by_id(event.author_id) if project

    if tm
      link_to event.author_name, project_team_member_path(project, tm)
    else
      event.author_name
    end
  end

  def event_action_name(event)
    target = if event.target_type
               event.target_type.titleize.downcase
             else
               'project'
             end

    [event.action_name, target].join(" ")
  end

  def event_filter_link key, tooltip
    key = key.to_s
    inactive = if @event_filter.active? key
                 nil
               else
                 'inactive'
               end

    content_tag :div, class: "filter_icon #{inactive}" do
      link_to dashboard_path, class: 'has_tooltip event_filter_link', id: "#{key}_event_filter", 'data-original-title' => tooltip do
        image_tag "event_filter_#{key}.png"
      end
    end
  end
end
