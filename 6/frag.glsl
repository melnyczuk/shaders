precision mediump float;

uniform float u_time;
uniform vec2 u_res;

const float PI = 3.1415926535897932384626433832795;

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

float circle(in vec2 _st, in float _radius){
  vec2 dist = _st-vec2(0.5);
	return 1.0-step(
    _radius,
    dot(dist,dist)
  );
}

float sinc( float x, float k ) {
  float a = PI * (k*x-1.0);
  return sin(a)/a;
}


float parabola( float x, float k ) {
  return pow( 4.0*x*(1.0-x), k );
}

float grain (vec2 st, float offset) {
    return fract(sin(dot(st.xy, vec2(12.9898 + sin(tan(u_time) + offset),78.233 + atan(u_time + offset)))) * 43758.5453123 + atan(u_time + offset));
}

float grain (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898 + sin(u_time),78.233 + atan(u_time)))) * 43758.5453123 + atan(u_time));
}

float rand(float n) {
  return fract(sin(n) * 43758.5453123);
}

float rand(float n, float seed) {
  return fract(sin(n) * seed);
}

float noise(float p) {
	float fl = floor(p);
  float fc = fract(p);
	return mix(rand(fl), rand(fl + 1.0), fc);
}

void main() {
  vec2 st = gl_FragCoord.xy/u_res;

  vec3 bg = vec3(0.4, 0.1, 0.1);
  vec3 fg = vec3(0.4, 0.5, 0.63);

  float k = sinc(st.x, 2.3) * sinc(st.y, 2.3) * grain(st);

  float r = distance(st,vec2(0.6)) * distance(st, vec2(abs(sin(u_time + 0.3432426353242)))) * grain(st, 0.3432426353242);
  float g = distance(st,vec2(0.5)) * distance(st, vec2(abs(sin(u_time + 0.2352315674444)))) * grain(st, 0.2352315674444);
  float b = distance(st,vec2(0.4)) * distance(st, vec2(abs(sin(u_time + 0.8643212523125)))) * grain(st, 0.8643212523125);

  vec3 colour = mix(bg, fg, 0.5);

  gl_FragColor = vec4(1.0-r, 1.0-g, 1.0-b, 1.0);
}
