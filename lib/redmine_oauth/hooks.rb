# frozen_string_literal: true
#
# Redmine plugin OAuth
#
# Karel Pičman <karel.picman@kontron.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

module RedmineOauth
  # View hooks
  class Hooks < Redmine::Hook::ViewListener
    def view_account_login_bottom(context = {})
      oauth = Setting.plugin_redmine_oauth[:oauth_name]
      return unless oauth.present? && (oauth != 'none')

      context[:controller].send(
        :render_to_string, { partial: 'hooks/view_account_login_bottom', locals: context }
      )
    end

    def view_layouts_base_html_head(context = {})
      return unless /^(AccountController|SettingsController|RedmineOauthController)/.match?(
        context[:controller].class.name
      )

      "\n".html_safe + stylesheet_link_tag('redmine_oauth.css', plugin: :redmine_oauth) +
        "\n".html_safe + stylesheet_link_tag('../vendor/fontawesome/all.min.css', plugin: :redmine_oauth) +
        "\n".html_safe + javascript_include_tag('redmine_oauth.js', plugin: :redmine_oauth)
    end
  end
end
