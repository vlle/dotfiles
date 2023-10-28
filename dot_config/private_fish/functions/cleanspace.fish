
function cleanspace 
    df | grep '512-blocks'
    df -H | grep 'disk2'
    rm -rf ~/Library/Caches/* 
    rm -rf ~/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/
    rm -rf ~/Library/Application\ Support/Slack/Cache/
    rm -rf ~/Library/Application\ Support/Slack/Code\ Cache/
    rm -rf ~/Library/Application\ Support/Code/Cache
    rm -rf ~/Library/Application\ Support/Code/CachedData
    rm -rf ~/Library/Application\ Support/Code/CachedExtension
    rm -rf ~/Library/Application\ Support/Code/CachedExtensions
    rm -rf ~/Library/Application\ Support/Code/CachedExtensionVSIXs
    rm -rf ~/Library/Application\ Support/Code/Code\ Cache
    rm -rf ~/Library/Application\ Support/Code/Service\ Worker/ScriptCache
    rm -rf ~/Library/Application\ Support/Slack/Service\ Worker/ScriptCache
    rm -rf ~/Library/Application\ Support/Telegram\ Desktop/tdata/user_data
    rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage
    rm -rf ~/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/ScriptCache
    rm -rf ~/Library/Developer/CoreSimulator/Caches
    rm -rf ~/Library/Developer/CoreSimulator/Devices
    rm -rf ~/Library/Developer/Xcode/DerivedData
    rm -rf ~/Library/Application\ Support/Code/Cache
    rm -rf ~/Library/Containers/com. apple. Safari/Data/Library/Caches
    rm -rf ~/.Trash
    df -H | grep 'disk2'
end
