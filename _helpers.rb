require 'action_view'

module Helpers
  include ActionView::Helpers::TagHelper

  def assets
    "http://assets1.cidtnatal2010.eventos.participe.de,http://assets2.cidtnatal2010.eventos.participe.de,http://assets3.cidtnatal.eventos.participe.de"
  end

  def variable(name)
    begin
      page.send(name)
    rescue
      return nil
    end
  end

  def layout_type
    variable('layout_type') || 'internal_page'
  end

  def css_tag(href, options = {})
    options[:rel] ||= 'stylesheet'
    options[:type] ||= 'text/css'
    options[:href] = static_url("/css/#{href}")
    options[:media] ||= 'screen'
    tag('link', options)
  end

  def script_tag(source, options = {})
    options[:src] = static_url("/js/#{source}")
    options[:type] ||= 'text/javascript'
    content_tag('script', '', options)
  end

  def image_tag(source, options = {})
    options[:src] = static_url("/images/#{source}")
    tag('img', options)
  end

  def juice_css(files, target = :all)
    juice_it :css, files, target
    css_tag "#{target}.min.css"
  end

  def juice_js(files, target = :all)
    juice_it :js, files, target
    script_tag "#{target}.min.js"
  end

  protected

  def static_url(base_url)
    path = File.join("#{File.expand_path(File.dirname(__FILE__))}", base_url)
    if assets
      prefix = assets.split(',')
      base_url = prefix[rand(prefix.size)] + base_url
    end
    if File.exist?(path)
      base_url + '?' + File.new(path).ctime.to_time.to_i.to_s
    else
      base_url
    end
  end

  def juice_it(type, files, target)
    files_with_paths = files.inject('') { |partial, file| partial.concat("#{type}/_#{file}.#{type} ") }
    #puts "juicer merge #{files_with_paths} -o #{type}/#{target}.min.#{type} #{' -h ' + assets if assets} --ignore-problems --force" unless layout_type == 'internal_page'
    `juicer merge #{files_with_paths} -o #{type}/#{target}.min.#{type} #{' -h ' + assets if assets} --ignore-problems --force` unless layout_type == 'internal_page'
  end
end
