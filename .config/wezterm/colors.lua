local colors = {}
function colors.apply_to_config(config)
	config.color_scheme_dirs = { "./colors", "./colors/zenbones" }
	config.color_scheme = "Oxocarbon Dark"
end

return colors
