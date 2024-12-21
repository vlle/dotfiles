starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set POSTING_EDITOR vim
set fish_greeting ""
set -g theme_color_scheme light

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/artemijkulikov/.ghcup/bin $PATH # ghcup-env

set C_INCLUDE_PATH /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/usr/include
set CPLUS_INCLUDE_PATH /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/usr/include

# Fish shell options for an improved experience
set -U fish_color_command yellow bold  # Command color
set -U fish_color_cwd green            # Directory color
set -U fish_color_error red            # Error color

## Add useful abbreviations for Neovim and Git
#abbr -a gco 'git checkout'
#abbr -a gb 'git branch'
#abbr -a gc 'git commit -m'
#abbr -a nv 'nvim'  # Shortcut to open Neovim
#
## Key bindings for improved Fish usage
#function fish_user_key_bindings
#    bind \cr 'commandline -f repaint; echo'  # Refresh prompt
#end
#
## Export paths if necessary
#set -Ux PATH $PATH /usr/local/go/bin
