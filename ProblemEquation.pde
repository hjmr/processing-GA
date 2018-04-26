float R = 5.0;

float min_v = -10.0;
float max_v =  10.0;

class ProblemEquation implements Problem {
  float evaluate(Chromosome c) {
    float x = decode(c, 0, c.getLength() / 2);
    float y = decode(c, c.getLength() / 2, c.getLength()    );
    return eqn(x, y);
  }

  private float eqn(float x, float y) {
    // float f1 = x * x - 5 * x + 6 + y;
    float f1 = (x * x) + (y * y) - (R * R);
    float f2 = exp(-(f1 * f1));
    return f2;
  }

  float decode(Chromosome c, int from, int to) {
    float v   = 0;
    float max = 0;

    for ( int i = from; i < to; i++ ) {
      v   = v   * 2 + (c.getGeneAtIndex(i) == true ? 1 : 0);
      max = max * 2 + 1;
    }
    v = v / max; // make a value between 0 and 1
    return((max_v - min_v) * v + min_v);
  }

  void draw(Chromosome c) {
    float f = min(1.0, evaluate(c));
    int col = lerpColor(color(0,0,255), color(255,0,0), f);

    float x = decode(c, 0, c.getLength() / 2);
    float y = decode(c, c.getLength() / 2, c.getLength()    );

    float unit_x = width  / (max_v - min_v);
    float unit_y = height / (max_v - min_v);

    float r = f + 1;
    noStroke();
    fill(col, 50);
    ellipse((x - min_v) * unit_x, (y - min_v) * unit_y, r * 2, r * 2);
  }
}