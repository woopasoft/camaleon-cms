=begin
  Camaleon CMS is a content management system
  Copyright (C) 2015 by Owen Peredo Diaz
  Email: owenperedo@gmail.com
  This program is free software: you can redistribute it and/or modify   it under the terms of the GNU Affero General Public License as  published by the Free Software Foundation, either version 3 of the  License, or (at your option) any later version.
  This program is distributed in the hope that it will be useful,  but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the  GNU Affero General Public License (GPLv3) for more details.
=end
module CamaleonCms::ThemeHelper
  def theme_init()
    @_front_breadcrumb = []
  end

  # return theme full asset path
  # theme_name: theme name, if nil, then will use current theme
  # asset: asset file name, if asset is present return full path to this asset
  # sample: <script src="<%= theme_asset_path("js/admin.js") %>"></script> => return: /assets/themes/my_theme/assets/css/main-54505620f.css
  def theme_asset_path(asset = nil, theme_name = nil)
    settings = theme_name.present? ? PluginRoutes.theme_info(theme_name) : current_theme.settings
    folder_name = settings["key"]
    if settings["gem_mode"]
      p = "themes/#{folder_name}/#{asset}"
    else
      p = "themes/#{folder_name}/assets/#{asset}"
    end
    p
  end
  alias_method :theme_asset, :theme_asset_path
  alias_method :theme_gem_asset, :theme_asset_path
  alias_method :theme_asset_url, :theme_asset_path

  # return theme view path including the path of current theme
  # view_name: name of the view or template
  # sample: theme_view("index") => "themes/my_theme/index"
  def theme_view(view_name)
    if current_theme.settings["gem_mode"]
      "themes/#{current_theme.slug}/#{view_name}"
    else
      "themes/#{current_theme.slug}/views/#{view_name}"
    end
  end

  # assign the layout for this request
  # asset: asset file name, if asset is present return full path to this asset
  # layout_name: layout name
  def theme_layout(layout_name, theme_name = nil)
    if current_theme.settings["gem_mode"]
      "themes/#{current_theme.slug}/layouts/#{layout_name}"
    else
      "themes/#{current_theme.slug}/views/layouts/#{layout_name}"
    end
  end

  # return theme key for current theme file (helper|controller|view)
  # DEPRECATED, instead use: current_theme
  # index: internal control
  def self_theme_key(index = 0)
    k = "/themes/"
    f = caller[index]
    if f.include?(k)
      f.split(k).last.split("/").first
    end
  end
end