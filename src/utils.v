module v_tiktok

import net.urllib

fn get_video_id_from_url(url string) !string {
	parsed := urllib.parse(url)!
	path_parts := parsed.path.split('/')

	if path_parts.len == 0 {
		return error('The video URL is not correct')
	}

	return path_parts.last()
}
