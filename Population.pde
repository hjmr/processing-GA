class Population {
  Chromosome[] pop;
  Problem problem;

  float mutation_rate;
  Mutation mutation;

  float crossover_rate;
  Crossover crossover;

  int generation;

  Population(int populationSize, int chromosomeLength, Problem prob) {
    pop = new Chromosome[populationSize];
    for ( int i = 0; i < pop.length; i++ ) {
      pop[i] = new Chromosome(chromosomeLength);
    }
    problem = prob;
    mutation_rate = 0.0;
    mutation = null;
    crossover_rate = 0.0;
    crossover = null;
    generation = 0;
  }

  void randomize() {
    for ( int i = 0; i < pop.length; i++ ) {
      pop[i].randomize();
    }
    evaluate();
  }

  void update() {
    reproduce();
    doCrossoverOperation();
    doMutationOperation();
    evaluate();
    generation++;
  }

  void setMutationOperation(Mutation m, float mrate) {
    mutation_rate = mrate;
    mutation = m;
  }

  void setCrossoverOperation(Crossover c, float crate) {
    crossover_rate = crate;
    crossover = c;
  }

  int getGeneration() {
    return generation;
  }

  int getPopulationSize() {
    return pop.length;
  }

  Chromosome getChromosomeAtIndex(int i) {
    return pop[i];
  }

  Chromosome getChromosomeWithMaxFitnessValue() {
    return pop[0];
  }

  float getMaxFitnessValue() {
    return pop[0].getFitnessValue();
  }

  float getAverageFitnessValue() {
    float sum = 0.0;
    for ( int i = 0; i < pop.length; i++ ) {
      sum += pop[i].getFitnessValue();
    }
    return sum / pop.length;
  }

  private void doMutationOperation() {
    if ( mutation != null ) {
      for ( int i = 1; i < pop.length; i++ ) {
        mutation.mutate(pop[i], mutation_rate);
      }
    }
  }

  private void doCrossoverOperation() {
    if ( crossover != null ) {
      int[] idx = new int[pop.length - 1];
      for ( int i = 0; i < idx.length; i++ ) {
        idx[i] = i + 1;
      }

      int num = int(pop.length * crossover_rate);
      int idxlen = idx.length;
      int i = 0;
      while ( i < num ) {
        int a = int(random(0, idxlen    ));
        int b = int(random(0, idxlen - 1));
        if ( a == b ) {
          b = idxlen - 1;
        }
        crossover.crossover(pop[idx[a]], pop[idx[b]]);
        idx[a] = idx[idxlen - 1];
        idx[b] = idx[idxlen - 2];
        idxlen -= 2;
        i += 2;
      }
    }
  }

  private void bubbleSort(Chromosome[] carr) {
    for ( int i = 0; i < carr.length - 1; i++ ) {
      for ( int j = i; j < carr.length - 1; j++ ) {
        if ( carr[j].getFitnessValue() < carr[j+1].getFitnessValue() ) {
          Chromosome tmp = carr[j];
          carr[j] = carr[j+1];
          carr[j+1] = tmp;
        }
      }
    }
  }

  private void evaluate() {
    for ( int i = 0; i < pop.length; i++ ) {
      pop[i].setFitnessValue(problem.evaluate(pop[i]));
    }
    bubbleSort(pop);
  }

  private void reproduce() {
    if (pop[pop.length - 1].getFitnessValue() < pop[0].getFitnessValue()) {
      float min = pop[0].getFitnessValue();
      for ( int i = 1; i < pop.length; i++ ) {
        if ( pop[i].getFitnessValue() < min ) {
          min = pop[i].getFitnessValue();
        }
      }

      float sum = 0.0;
      for ( int i = 0; i < pop.length; i++ ) {
        sum += (pop[i].getFitnessValue() - min);
      }

      Chromosome[] newPop = new Chromosome[pop.length];
      // keep an elitest chromosome
      newPop[0] = new Chromosome(pop[0].getLength());
      newPop[0].setChromosome(pop[0]);
      for (int i = 1; i < newPop.length; i++) {        
        Chromosome c = selectAChromosome(sum, min);
        newPop[i] = new Chromosome(c.getLength());
        newPop[i].setChromosome(c);
      }
      pop = newPop;
    }
  }

  private Chromosome selectAChromosome(float sum, float min) {
    Chromosome ret = pop[0];
    float r = random(0, sum) - (pop[0].getFitnessValue() - min);
    for ( int i = 1; i < pop.length; i++ ) {
      if ( r <= (pop[i].getFitnessValue() - min) ) {
        ret = pop[i];
        break;
      }
      r -= (pop[i].getFitnessValue() - min);
    }
    return ret;
  }

  void drawAll() {
    for ( int i = pop.length - 1; 0 <= i ; i-- ) {
      problem.draw(pop[i]);
    }
  }

  void drawElitest() {
    problem.draw(pop[0]);
  }
}