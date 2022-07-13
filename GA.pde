boolean running = false;
Solver solver;

void setup() {
  size(600, 600);
  // size(window.innerWidth, window.innerHeight);
  frameRate(5);
  background(0);

  // SolverEquation(PopSize, ChromLen, MutRate, CxRate)
  // solver = new SolverEquation(5000, 100, 0.1, 0.2);
  // SolverTSP(CityNum, PopSize, MutRate, CxRate)
  solver = new SolverTSP(50, 10000, 0.01, 0.3);
}

void draw() {
  if ( running == true ) {
    fadeToBlack();
    solver.debug();
    solver.update();
    solver.draw();
  }
}

void fadeToBlack() {
  noStroke();
  fill(0, 80);
  rectMode(CORNER);
  rect(0, 0, width, height);
}

void mousePressed() {
  running = (running == true) ? false : true;
}
