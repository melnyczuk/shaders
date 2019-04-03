precision mediump float;

uniform float u_time;
uniform vec2 u_res;

float rectangle(in vec2 st, in vec2 origin, in vec2 dimensions, in float blur) {
    vec2 bl = smoothstep(origin, origin+blur, st);
    float pct = bl.x * bl.y;
    vec2 tr = smoothstep(1.0-origin-dimensions, 1.0-origin-dimensions+blur, 1.0-st);
    pct *= tr.x * tr.y;

    return pct;
}

float circle(in vec2 _st, in float _radius, in vec3 blur){
  vec2 dist = _st-vec2(0.5);
	return 1.0-smoothstep(
    _radius-(_radius*blur.x), 
    _radius-(_radius*blur.y), 
    dot(dist,dist)*blur.z
  );
}

float rand(float n){return fract(sin(n) * 43758.5453123);}

float noise(float p){
	float fl = floor(p);
  float fc = fract(p);
	return mix(rand(fl), rand(fl + 1.0), fc);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_res;

  vec3 bg = vec3(0.4, 0.1, 0.1);
  vec3 fg = vec3(0.4, 0.5, 0.63);
  float r = noise(rectangle(st, vec2(0.385,0.125), vec2(0.55,10.0), 0.05));

  vec3 colour = mix(bg, fg, r);

  gl_FragColor = vec4(colour + vec3(0.45), 1.0);
}

