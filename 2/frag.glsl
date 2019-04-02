precision mediump float;

uniform float u_time;
uniform vec2 u_res;

void main() {
  vec2 st = gl_FragCoord.xy/u_res;

  float r = distance(st,vec2(clamp(abs(cos(u_time + 0.64)), 0.1, 0.7), clamp(abs(atan(u_time + 0.44)), 0.1, 0.7)));
  float g = distance(st,vec2(clamp(abs(sin(u_time + 0.34)), 0.1, 0.7), clamp(abs(cos(u_time + 0.64)), 0.1, 0.7)));
  float b = distance(st,vec2(clamp(abs(tan(u_time + 0.44)), 0.1, 0.9), clamp(abs(sin(u_time + 0.34)), 0.1, 0.9)));

  vec4 rect = vec4(0.325, 0.5, 0.75, 1.0);
  vec2 hv = step(rect.xy, st) * step(st, rect.zw);
  float onOff = hv.x * hv.y;

  float a = (cos(u_time + 0.64) + 1.2) / 1.4;

  gl_FragColor = mix(vec4(r,g,b, 1.0), vec4(g,r,b,a), onOff);
}

