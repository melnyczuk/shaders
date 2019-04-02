precision mediump float;

uniform float u_time;
uniform vec2 u_res;

void main() {
  vec2 st = gl_FragCoord.xy/u_res;

  float r = distance(st,vec2((cos(u_time + 0.64) + 1.0) / 2.0, (tan(u_time + 0.44) + 1.0) / 2.0));
  float g = distance(st,vec2((sin(u_time + 0.34) + 1.0) / 2.0, (cos(u_time + 0.64) + 1.0) / 2.0));
  float b = distance(st,vec2((tan(u_time + 0.44) + 1.0) / 2.0, (sin(u_time + 0.34) + 1.0) / 2.0));

  vec4 rect = vec4(0.2, 0.2, 0.6, 0.6);
  vec2 hv = step(rect.xy, st) * step(st, rect.zw);
  float onOff = hv.x * hv.y;

  gl_FragColor = mix(vec4(r, g, b, 1.0 ), vec4(1.0,1.0,1.0,1.0), onOff);
}

