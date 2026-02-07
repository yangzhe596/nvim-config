return {
	"sphamba/smear-cursor.nvim",
	opts = {
		-- 在切换 buffer 或窗口时显示轨迹
		smear_between_buffers = true,
		-- 在行内移动或相邻行之间移动时显示轨迹
		smear_between_neighbor_lines = true,
		-- 滚动时在 buffer 空间而非屏幕空间绘制轨迹
		scroll_buffer_space = true,
		-- 如果字体支持传统计算符号，设为 true 会让轨迹更平滑
		legacy_computing_symbols_support = false,
		-- 在插入模式也启用轨迹
		smear_insert_mode = true,
	},
}
