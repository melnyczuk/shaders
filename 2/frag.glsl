precision mediump float;

uniform float u_time;
uniform vec2 u_res;

void main() {
  vec2 st = gl_FragCoord.xy/u_res;

  float r = distance(st,vec2(clamp(abs(cos(u_time + 0.64)), 0.1, 0.7), clamp(abs(cos(u_time + 0.44)), 0.1, 0.7)));
  float g = distance(st,vec2(clamp(abs(sin(u_time + 0.34)), 0.1, 0.7), clamp(abs(cos(u_time + 0.64)), 0.1, 0.7)));
  float b = distance(st,vec2(clamp(abs(sin(u_time + 0.44)), 0.1, 0.9), clamp(abs(sin(u_time + 0.34)), 0.1, 0.9)));

  float center = 0.39;
  vec4 rect0 = vec4(center, 0.05, 0.683, 1.0);
  vec2 hv = step(rect0.xy, st) * step(st, rect0.zw);
  float onOff = hv.x * hv.y;

  vec4 rect1 = vec4(0.1, 0.05,center, 1.0);
  vec2 hv1 = step(rect1.xy, st) * step(st, rect1.zw);
  float onOff1 = hv1.x * hv1.y;

  float a = (cos(u_time + 0.64) + 1.2) / 1.4;

  vec4 mixa = mix(vec4(0.5*r,g,b,a),vec4(r,0.2*g,b, 1.0), onOff);
  vec4 mixb = mix(vec4(r,0.2*g,b, 1.0), vec4(r,g,0.5*b,a), onOff1);

  gl_FragColor = mix(mixa, mixb, 0.5);
}

