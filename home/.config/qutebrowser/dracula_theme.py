def blood(c, options={}):
    """
        'background': '#282a36',
        'background-alt': '#282a36',
        'background-attention': '#181920',
        'border': '#282a36',
        'current-line': '#44475a',
        'selection': '#44475a',
        'foreground': '#f8f8f2',
        'foreground-alt': '#e0e0e0',
        'foreground-attention': '#ffffff',
        'comment': '#6272a4',
        'cyan': '#8be9fd',
        'green': '#50fa7b',
        'orange': '#ffb86c',
        'pink': '#ff79c6',
        'purple': '#bd93f9',
        'red': '#ff5555',
        'yellow': '#f1fa8c'
    """
    palette = {
        'background': '#181818',
        'background-alt': '#282828',
        'background-attention': '#383838',
        'border': '#282a36',
        'current-line': '#44475a',
        'selection': '#a16946',
        'foreground': '#f8f8f2',
        'foreground-alt': '#e0e0e0',
        'foreground-attention': '#ffffff',
        'comment': '#6272a4',
        'cyan': '#8be9fd',
        'green': '#a1b56c',
        'orange': '#dc9656',
        'pink': '#ff79c6',
        'purple': '#bd93f9',
        'red': '#ab4642',
        'yellow': '#f7ca88'
    }

    spacing = options.get('spacing', {
        'vertical': 5,
        'horizontal': 5
    })

    padding = options.get('padding', {
        'top': spacing['vertical'],
        'right': spacing['horizontal'],
        'bottom': spacing['vertical'],
        'left': spacing['horizontal']
    })

    ## Background color of the completion widget category headers.
    c.colors.completion.category.bg = palette['background']

    ## Bottom border color of the completion widget category headers.
    c.colors.completion.category.border.bottom = palette['border']

    ## Top border color of the completion widget category headers.
    c.colors.completion.category.border.top = palette['border']

    ## Foreground color of completion widget category headers.
    c.colors.completion.category.fg = palette['foreground']

    ## Background color of the completion widget for even rows.
    c.colors.completion.even.bg = palette['background']

    ## Background color of the completion widget for odd rows.
    c.colors.completion.odd.bg = palette['background-alt']

    ## Text color of the completion widget.
    c.colors.completion.fg = palette['foreground']

    ## Background color of the selected completion item.
    c.colors.completion.item.selected.bg = palette['selection']

    ## Bottom border color of the selected completion item.
    c.colors.completion.item.selected.border.bottom = palette['selection']

    ## Top border color of the completion widget category headers.
    c.colors.completion.item.selected.border.top = palette['selection']

    ## Foreground color of the selected completion item.
    c.colors.completion.item.selected.fg = palette['foreground']

    ## Foreground color of the matched text in the completion.
    c.colors.completion.match.fg = palette['orange']

    ## Color of the scrollbar in completion view
    c.colors.completion.scrollbar.bg = palette['background']

    ## Color of the scrollbar handle in completion view.
    c.colors.completion.scrollbar.fg = palette['foreground']

    ## Background color for the download bar.
    c.colors.downloads.bar.bg = palette['background']

    ## Background color for downloads with errors.
    c.colors.downloads.error.bg = palette['background']

    ## Foreground color for downloads with errors.
    c.colors.downloads.error.fg = palette['red']

    ## Color gradient stop for download backgrounds.
    c.colors.downloads.stop.bg = palette['background']

    ## Color gradient interpolation system for download backgrounds.
    ## Type: ColorSystem
    ## Valid values:
    ##   - rgb: Interpolate in the RGB color system.
    ##   - hsv: Interpolate in the HSV color system.
    ##   - hsl: Interpolate in the HSL color system.
    ##   - none: Don't show a gradient.
    c.colors.downloads.system.bg = 'none'

    ## Background color for hints. Note that you can use a `rgba(...)` value
    ## for transparency.
    c.colors.hints.bg = palette['background']

    ## Font color for hints.
    c.colors.hints.fg = palette['purple']

    ## Hints
    c.hints.border = '1px solid ' + palette['background-alt']

    ## Font color for the matched part of hints.
    c.colors.hints.match.fg = palette['foreground-alt']

    ## Background color of the keyhint widget.
    c.colors.keyhint.bg = palette['background']

    ## Text color for the keyhint widget.
    c.colors.keyhint.fg = palette['purple']

    ## Highlight color for keys to complete the current keychain.
    c.colors.keyhint.suffix.fg = palette['selection']

    ## Background color of an error message.
    c.colors.messages.error.bg = palette['background']

    ## Border color of an error message.
    c.colors.messages.error.border = palette['background-alt']

    ## Foreground color of an error message.
    c.colors.messages.error.fg = palette['red']

    ## Background color of an info message.
    c.colors.messages.info.bg = palette['background']

    ## Border color of an info message.
    c.colors.messages.info.border = palette['background-alt']

    ## Foreground color an info message.
    c.colors.messages.info.fg = palette['comment']

    ## Background color of a warning message.
    c.colors.messages.warning.bg = palette['background']

    ## Border color of a warning message.
    c.colors.messages.warning.border = palette['background-alt']

    ## Foreground color a warning message.
    c.colors.messages.warning.fg = palette['red']

    ## Background color for prompts.
    c.colors.prompts.bg = palette['background']

    # ## Border used around UI elements in prompts.
    c.colors.prompts.border = '1px solid ' + palette['background-alt']

    ## Foreground color for prompts.
    c.colors.prompts.fg = palette['cyan']

    ## Background color for the selected item in filename prompts.
    c.colors.prompts.selected.bg = palette['selection']

    ## Background color of the statusbar in caret mode.
    c.colors.statusbar.caret.bg = palette['background']

    ## Foreground color of the statusbar in caret mode.
    c.colors.statusbar.caret.fg = palette['orange']

    ## Background color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.bg = palette['background']

    ## Foreground color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.fg = palette['orange']

    ## Background color of the statusbar in command mode.
    c.colors.statusbar.command.bg = palette['background']

    ## Foreground color of the statusbar in command mode.
    c.colors.statusbar.command.fg = palette['pink']

    ## Background color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.bg = palette['background']

    ## Foreground color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.fg = palette['foreground-alt']

    ## Background color of the statusbar in insert mode.
    c.colors.statusbar.insert.bg = palette['background-attention']

    ## Foreground color of the statusbar in insert mode.
    c.colors.statusbar.insert.fg = palette['foreground-attention']

    ## Background color of the statusbar.
    c.colors.statusbar.normal.bg = palette['background']

    ## Foreground color of the statusbar.
    c.colors.statusbar.normal.fg = palette['foreground']

    ## Background color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.bg = palette['background']

    ## Foreground color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.fg = palette['orange']

    ## Background color of the statusbar in private browsing mode.
    c.colors.statusbar.private.bg = palette['background-alt']

    ## Foreground color of the statusbar in private browsing mode.
    c.colors.statusbar.private.fg = palette['foreground-alt']

    ## Background color of the progress bar.
    c.colors.statusbar.progress.bg = palette['background']

    ## Foreground color of the URL in the statusbar on error.
    c.colors.statusbar.url.error.fg = palette['red']

    ## Default foreground color of the URL in the statusbar.
    c.colors.statusbar.url.fg = palette['foreground']

    ## Foreground color of the URL in the statusbar for hovered links.
    c.colors.statusbar.url.hover.fg = palette['cyan']

    ## Foreground color of the URL in the statusbar on successful load
    c.colors.statusbar.url.success.http.fg = palette['green']

    ## Foreground color of the URL in the statusbar on successful load
    c.colors.statusbar.url.success.https.fg = palette['green']

    ## Foreground color of the URL in the statusbar when there's a warning.
    c.colors.statusbar.url.warn.fg = palette['yellow']

    ## Status bar padding
    c.statusbar.padding = padding

    ## Background color of the tab bar.
    ## Type: QtColor
    c.colors.tabs.bar.bg = palette['selection']

    ## Background color of unselected even tabs.
    ## Type: QtColor
    c.colors.tabs.even.bg = palette['selection']

    ## Foreground color of unselected even tabs.
    ## Type: QtColor
    c.colors.tabs.even.fg = palette['foreground']

    ## Color for the tab indicator on errors.
    ## Type: QtColor
    c.colors.tabs.indicator.error = palette['red']

    ## Color gradient start for the tab indicator.
    ## Type: QtColor
    c.colors.tabs.indicator.start = palette['orange']

    ## Color gradient end for the tab indicator.
    ## Type: QtColor
    c.colors.tabs.indicator.stop = palette['green']

    ## Color gradient interpolation system for the tab indicator.
    ## Type: ColorSystem
    ## Valid values:
    ##   - rgb: Interpolate in the RGB color system.
    ##   - hsv: Interpolate in the HSV color system.
    ##   - hsl: Interpolate in the HSL color system.
    ##   - none: Don't show a gradient.
    c.colors.tabs.indicator.system = 'none'

    ## Background color of unselected odd tabs.
    ## Type: QtColor
    c.colors.tabs.odd.bg = palette['selection']

    ## Foreground color of unselected odd tabs.
    ## Type: QtColor
    c.colors.tabs.odd.fg = palette['foreground']

    # ## Background color of selected even tabs.
    # ## Type: QtColor
    c.colors.tabs.selected.even.bg = palette['background']

    # ## Foreground color of selected even tabs.
    # ## Type: QtColor
    c.colors.tabs.selected.even.fg = palette['foreground']

    # ## Background color of selected odd tabs.
    # ## Type: QtColor
    c.colors.tabs.selected.odd.bg = palette['background']

    # ## Foreground color of selected odd tabs.
    # ## Type: QtColor
    c.colors.tabs.selected.odd.fg = palette['foreground']

    ## Tab padding
    c.tabs.padding = padding
    c.tabs.indicator.width = 1
    c.tabs.favicons.scale = 1
    return c


def base16(c):
    # base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
    # Base16 qutebrowser template by theova
    # Default Dark scheme by Chris Kempson (http://chriskempson.com)

    base00 = "#181818"
    base01 = "#282828"
    base02 = "#383838"
    base03 = "#585858"
    base04 = "#b8b8b8"
    base05 = "#d8d8d8"
    base06 = "#e8e8e8"
    base07 = "#f8f8f8"
    base08 = "#ab4642"
    base09 = "#dc9656"
    base0A = "#f7ca88"
    base0B = "#a1b56c"
    base0C = "#86c1b9"
    base0D = "#7cafc2"
    base0E = "#ba8baf"
    base0F = "#a16946"

    # FIXME
    # c.colors.contextmenu.disabled.bg = base01
    # c.colors.contextmenu.disabled.fg = base04
    c.colors.contextmenu.menu.bg = base00
    c.colors.contextmenu.menu.fg =  base05
    c.colors.contextmenu.selected.bg = base02
    c.colors.contextmenu.selected.fg = base05
    c.colors.completion.item.selected.match.fg = base0B
    c.colors.completion.fg = base05
    c.colors.completion.odd.bg = base01
    c.colors.completion.even.bg = base00
    c.colors.completion.category.fg = base0A
    c.colors.completion.category.bg = base00
    c.colors.completion.category.border.top = base00
    c.colors.completion.category.border.bottom = base00
    c.colors.completion.item.selected.fg = base05
    c.colors.completion.item.selected.bg = base02
    c.colors.completion.item.selected.border.top = base02
    c.colors.completion.item.selected.border.bottom = base02
    c.colors.completion.match.fg = base0B
    c.colors.completion.scrollbar.fg = base05
    c.colors.completion.scrollbar.bg = base00
    c.colors.downloads.bar.bg = base00
    c.colors.downloads.start.fg = base00
    c.colors.downloads.start.bg = base0D
    c.colors.downloads.stop.fg = base00
    c.colors.downloads.stop.bg = base0C
    c.colors.downloads.error.fg = base08
    c.colors.hints.fg = base00
    c.colors.hints.bg = base0A
    c.colors.hints.match.fg = base05
    c.colors.keyhint.fg = base05
    c.colors.keyhint.suffix.fg = base05
    c.colors.keyhint.bg = base00
    c.colors.messages.error.fg = base00
    c.colors.messages.error.bg = base08
    c.colors.messages.error.border = base08
    c.colors.messages.warning.fg = base00
    c.colors.messages.warning.bg = base0E
    c.colors.messages.warning.border = base0E
    c.colors.messages.info.fg = base05
    c.colors.messages.info.bg = base00
    c.colors.messages.info.border = base00
    c.colors.prompts.fg = base05
    c.colors.prompts.border = base00
    c.colors.prompts.bg = base00
    c.colors.prompts.selected.bg = base02
    c.colors.statusbar.normal.fg = base0B
    c.colors.statusbar.normal.bg = base00
    c.colors.statusbar.insert.fg = base00
    c.colors.statusbar.insert.bg = base0D
    c.colors.statusbar.passthrough.fg = base00
    c.colors.statusbar.passthrough.bg = base0C
    c.colors.statusbar.private.fg = base00
    c.colors.statusbar.private.bg = base01
    c.colors.statusbar.command.fg = base05
    c.colors.statusbar.command.bg = base00
    c.colors.statusbar.command.private.fg = base05
    c.colors.statusbar.command.private.bg = base00
    c.colors.statusbar.caret.fg = base00
    c.colors.statusbar.caret.bg = base0E
    c.colors.statusbar.caret.selection.fg = base00
    c.colors.statusbar.caret.selection.bg = base0D
    c.colors.statusbar.progress.bg = base0D
    c.colors.statusbar.url.fg = base05
    c.colors.statusbar.url.error.fg = base08
    c.colors.statusbar.url.hover.fg = base05
    c.colors.statusbar.url.success.http.fg = base0C
    c.colors.statusbar.url.success.https.fg = base0B
    c.colors.statusbar.url.warn.fg = base0E
    c.colors.tabs.pinned.even.bg = base0C
    c.colors.tabs.pinned.even.fg = base07
    c.colors.tabs.pinned.odd.bg = base0B
    c.colors.tabs.pinned.odd.fg = base07
    c.colors.tabs.pinned.selected.even.bg = base02
    c.colors.tabs.pinned.selected.even.fg = base05
    c.colors.tabs.pinned.selected.odd.bg = base02
    c.colors.tabs.pinned.selected.odd.fg = base05
    c.colors.tabs.bar.bg = base00
    c.colors.tabs.indicator.start = base0D
    c.colors.tabs.indicator.stop = base0C
    c.colors.tabs.indicator.error = base08
    c.colors.tabs.odd.fg = base05
    c.colors.tabs.odd.bg = base01
    c.colors.tabs.even.fg = base05
    c.colors.tabs.even.bg = base01
    c.colors.tabs.selected.odd.fg = base0A
    c.colors.tabs.selected.odd.bg = base00
    c.colors.tabs.selected.even.fg = base0A
    c.colors.tabs.selected.even.bg = base00
    # c.colors.webpage.bg = base00
