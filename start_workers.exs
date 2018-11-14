name = System.get_env("HOSTNAME") || "random_#{:rand.uniform()}"

ScaleWorkers.start_worker("#{name}_#{:rand.uniform(100)}")
