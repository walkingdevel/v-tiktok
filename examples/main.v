import v_tiktok

fn main() {
	mut video1 := v_tiktok.new_tiktok_video('7204144603975634222')!

	println(video1.get_meta()!.description)
	println(video1.get_file_url()!)

	video1.download_file('./output1.mp4')!

	mut video2 := v_tiktok.new_tiktok_video('https://www.tiktok.com/@mrbeast/video/7204144603975634222')!

	println(video2.get_meta()!.description)
	println(video2.get_file_url()!)

	video2.download_file('./output2.mp4')!
}
