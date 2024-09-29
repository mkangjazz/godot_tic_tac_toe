shader_type spatial;

uniform float width = 0.1;
uniform float height = 0.1;
uniform float gap_x = 0.02;
uniform float gap_y = 0.04;
uniform float sink = -0.5;
uniform sampler2D brick;
uniform sampler2D wall;
uniform sampler2D gap;
uniform float ratio = 0.5;

void fragment() {
	ALBEDO = vec3(0.75);
	ROUGHNESS = 0.5;
	
	float s = 1.0/height;
	float shift = float(int(UV.y*s)) / 2.0*width;
	float x = mod(shift+UV.x, width)/width;
	float y = mod(UV.y, height)/height;
	
	ALBEDO = texture(gap, vec2(UV.x, UV.y)).rgb / 2.5;
	if(x > gap_x && x < 1.0-gap_x && y > gap_y && y < 1.0-gap_y){
		NORMAL = vec3(0.0, 0.0, 0.0);
		ALBEDO = texture(brick, vec2(x, y)).rgb * ratio;
		ALBEDO += texture(wall, vec2(UV.x, UV.y)).rgb * (1.0-ratio);
	}else if(x<y && (1.0-y)>x){
		NORMAL = vec3(x*-sink, 0.0, 0.0);
	}else if(x>y && (1.0-y)<x){
		NORMAL = vec3((1.0-x)*sink, 0.0, 0.0);
	}else if(y<x){
		NORMAL = vec3(0.0, y*-sink, 0.0);
	}else if(y>x){
		NORMAL = vec3(0.0, (1.0-y)*sink, 0.0);
	}
}