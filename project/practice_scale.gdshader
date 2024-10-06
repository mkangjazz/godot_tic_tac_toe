shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float blur_amount = 2.0;

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);

	COLOR = vec4(1.0, 0.5, 1.0, input_color.b);
}

//const float scale = 2.0;
//uniform float scale : hint_range(0.1, 10) = 2.0;
//uniform vec4 color: source_color;
//uniform float flashState : hint_range(0, 1) = 0.5;
//uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
//uniform sampler2D noise: filter_nearest, repeat_enable;
//uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

//uniform float brightness = 1.0;
//uniform float contrast = 1.0;
//uniform float saturation = 1.0;

//void fragment() {
    //vec3 c = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;
//
    //c.rgb = mix(vec3(0.0), c.rgb, brightness);
    //c.rgb = mix(vec3(0.5), c.rgb, contrast);
    //c.rgb = mix(vec3(dot(vec3(1.0), c.rgb) * 0.33333), c.rgb, saturation);
//
    //COLOR.rgb = c;
//
	////vec4 pixelColor = texture(TEXTURE, UV);
	////vec4 screenColor = texture(SCREEN_TEXTURE, SCREEN_UV);
	////COLOR = screenColor;
	////vec4 pixelColor = texture(TEXTURE, UV * scale);
	////COLOR = pixelColor;
//
	//COLOR = mix(pixelColor, color, flashState);
	//COLOR.a *= pixelColor.a;

	//COLOR = pixelColor;
	//COLOR.rgb = COLOR.gbr;
	//COLOR.rgb = COLOR.bgb;

	//float brightness = (pixelColor.r + pixelColor.g + pixelColor.b) / 5.0;
	//vec4 grayScale = vec4(brightness, brightness, brightness, pixelColor.a);
	//COLOR = grayScale;
//
	//vec2 distortedUV = UV;
	//distortedUV.x += distortedUV.y - 0.1 * scale;
	//distortedUV.y = distortedUV.y -0.1 * scale;
	//vec4 pixelColor = texture(TEXTURE, distortedUV);
	//COLOR = pixelColor;
//}
