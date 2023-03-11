# V TikTok

A V library for downloading TikTok videos. Inspired by https://github.com/Sharqo78/VTik

## Install

```sh
v install https://github.com/walkingdevel/v-tiktok
```

## API

```v
fn new_tiktok_video(url_or_video_id string) !TikTokVideo
struct TikTokVideo {
        video_id string
mut:
        video_file_url string
        meta           TikTokVideoMeta
        is_fetched     bool
}

fn (mut t TikTokVideo) get_meta() !TikTokVideoMeta
fn (mut t TikTokVideo) download_file(output_path string) !
fn (mut t TikTokVideo) download_bytes() ![]u8
fn (mut t TikTokVideo) get_file_url() !string

struct TikTokVideoMeta {
        description string
        cover_url   string
        region      string
}

```
