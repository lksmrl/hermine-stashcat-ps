$base_url = "https://api.thw-messenger.de"
$stashcat_version = "3.19.1"
$device_id = "stashcatiskindofbrokenrandomstr1"
$email = Read-Host
$password = Read-Host

function clientAuthentication {
    $body = [Ordered] @{
        'email' = "$email"
        'password' = "$password"
        'device_id' = "stashcatiskindofbrokenrandomstr1"
        'app_name' = "hermine@thw-Firefox:82.0-browser-4.11.1"
        'encrypted' = "True"
        'callable' = "True"
        'company' = "35428"
    }
    $authUrl = "$base_url/auth/login"
    $t = Invoke-WebRequest -Uri $authUrl -Method Post -Body $body
}

function getSubscribtedChannels {
    $bodyAfterAuth = [Ordered] @{
        'email' = "$email"
        'password' = "$password"
        'device_id' = "stashcatiskindofbrokenrandomstr1"
        'app_name' = "hermine@thw-Firefox:82.0-browser-4.11.1"
        'encrypted' = "True"
        'callable' = "True"
        'client_key' = "$(($t.Content | ConvertFrom-Json).payload.client_key)"
        "company" = "35428"
    }
    $channels = "$base_url/channels/subscripted"
    $channels = Invoke-WebRequest -Uri $channels -Method Post -Body $bodyAfterAuth
}

function getUsersByChannel ($channelID) {
    $bodyAfterAuth = [Ordered] @{
        'email' = "$email"
        'password' = "$password"
        'device_id' = "stashcatiskindofbrokenrandomstr1"
        'app_name' = "hermine@thw-Firefox:82.0-browser-4.11.1"
        'encrypted' = True
        'callable' = True
        'client_key' = "$(($t.Content | ConvertFrom-Json).payload.client_key)"
        "company" = "35428"
        "channel_id" = "$channelID"
    }
    $memberUri = "$base_url/channels/members"
    $member = Invoke-WebRequest -Uri $memberUri -Method Post -Body $bodyAfterAuth
}

function sendMessageToUser ($text, $userID) {
    $bodyforSend = @{
        'email' = "$email"
        'password' = "$password"
        'device_id' = "stashcatiskindofbrokenrandomstr1"
        'app_name' = "hermine@thw-Firefox:82.0-browser-4.11.1"
        'client_key' = "$(($t.Content | ConvertFrom-Json).payload.client_key)"
        "company" = "35428"
        "target" = "conversation"
        "conversation_id" = "$userID"
        "text" = "$text"
        "encrypted" = False

    }
    $sendUrl = "$base_url/message/send"
    Invoke-WebRequest -Uri $sendUrl -Method Post -Body $bodyforSend
}

function sendMessageToChannel($text, $channelID) {
    $bodyforSend = @{
        'email' = "$email"
        'password' = "$password"
        'device_id' = "stashcatiskindofbrokenrandomstr1"
        'app_name' = "hermine@thw-Firefox:82.0-browser-4.11.1"
        'client_key' = "$(($t.Content | ConvertFrom-Json).payload.client_key)"
        "company" = "35428"
        "target" = "channel"
        "channel_id" = "$channelID"
        "text" = "$text"
        "encrypted" = True

    }
    $sendUrl = "$base_url/message/send"
    Invoke-WebRequest -Uri $sendUrl -Method Post -Body $bodyforSend
}