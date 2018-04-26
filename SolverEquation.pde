class SolverEquation implements Solver {
  ProblemEquation problem;
  Population pop;

  SolverEquation(int populationSize, int chromosomeLength, 
    float mutationRate, float crossoverRate) {
    problem = new ProblemEquation();
    pop = new Population(populationSize, chromosomeLength, problem);

    SimpleOperator op = new SimpleOperator();
    pop.setMutationOperation(op, mutationRate);
    pop.setCrossoverOperation(op, crossoverRate);
    pop.randomize();
  }

  void update() {
    pop.update();
  }

  void draw() {
    pop.drawAll();
  }

  void debug() {
    if ( pop.getGeneration() % 100 == 1 ) {
      println("[" + pop.getGeneration() + "]" + 
        " AVG:" + pop.getAverageFitnessValue() +
        " MAX:" + pop.getMaxFitnessValue());
    }
  }
}