module v_tiktok

import net.http
import x.json2

const tiktokv_download_url = 'https://api.tiktokv.com/aweme/v1/feed/?aweme_id='

[noinit]
pub struct TikTokVideo {
	video_id string
mut:
	video_file_url string
	meta           TikTokVideoMeta
	is_fetched     bool
}

pub struct TikTokVideoMeta {
pub:
	description string
	cover_url   string
	region      string
}

pub fn new_tiktok_video(url_or_video_id string) !TikTokVideo {
	video_id := if url_or_video_id.starts_with('http') {
		get_video_id_from_url(url_or_video_id)!
	} else {
		url_or_video_id
	}

	return TikTokVideo{
		video_id: video_id
	}
}

// get_meta gets incomplete meta-information about the video.
pub fn (mut t TikTokVideo) get_meta() !TikTokVideoMeta {
	t.fetch_video_info()!

	return t.meta
}

// download_file downloads the video and saves it as `output_file_path`.
pub fn (mut t TikTokVideo) download_file(output_file_path string) ! {
	t.fetch_video_info()!

	http.download_file(t.video_file_url, output_file_path)!
}

// download_bytes downloads the video as bytes.
pub fn (mut t TikTokVideo) download_bytes() ![]u8 {
	t.fetch_video_info()!

	response := http.get(t.video_file_url)!

	return response.bytes()
}

// get_file_url gets the direct download file URL.
pub fn (mut t TikTokVideo) get_file_url() !string {
	t.fetch_video_info()!

	return t.video_file_url
}

fn (mut t TikTokVideo) fetch_video_info() ! {
	if t.is_fetched {
		return
	}

	response := http.get('${v_tiktok.tiktokv_download_url}${t.video_id}')!
	raw_json := response.body

	response_json := json2.raw_decode(raw_json)!
	post_info := response_json.as_map()['aweme_list']!.arr()[0]!.as_map()

	t.meta = TikTokVideoMeta{
		description: post_info['desc']!.str()
		cover_url: post_info['video']!.as_map()['cover']!.as_map()['url_list']!.arr()[0]!.str()
		region: post_info['region']!.str()
	}
	t.video_file_url = post_info['video']!.as_map()['play_addr']!.as_map()['url_list']!.arr()[0]!.str()

	t.is_fetched = true
}
