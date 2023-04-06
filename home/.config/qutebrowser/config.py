# import os
import dracula_theme as ds
# THEME_FILE = 'dracula_theme.py'
# THEME_FILE = os.path.join(os.path.dirname(__file__), THEME_FILE)
# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

c.url.start_pages = ["https://aaron.niskin.org/"]
c.search.ignore_case = 'smart'
c.content.windowed_fullscreen = True
c.content.local_content_can_access_file_urls = False
c.content.pdfjs = True  # False
c.scrolling.bar = 'when-searching'
c.scrolling.smooth = True
c.tabs.tabs_are_windows = False
c.statusbar.hide = True
# c.colors.webpage.preferred_color_scheme = 'dark'

config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
ds.base16(c)
