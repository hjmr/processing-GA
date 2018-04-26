class SolverTSP implements Solver {
  ProblemTSP problem;
  Population pop;

  SolverTSP(int cityNum, 
    int populationSize, float mutationRate, float crossoverRate) {

    problem = new ProblemTSP(cityNum);
    pop = new Population(populationSize, problem.getChromosomeLength(), problem);

    SimpleOperator op = new SimpleOperator();
    pop.setMutationOperation(op, mutationRate);
    pop.setCrossoverOperation(op, crossoverRate);
    pop.randomize();
  }

  void update() {
    pop.update();
  }

  void draw() {
    pop.drawElitest();
  }

  void debug() {
    if ( pop.getGeneration() % 100 == 1 ) {
      println("[" + pop.getGeneration() + "]" + 
        " AVG:" + pop.getAverageFitnessValue() +
        " MAX:" + pop.getMaxFitnessValue());
    }
  }
}