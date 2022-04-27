function ps()
  fprintf("Available Groups:\n");
  fprintf("1: Full Time Series\n");
  fprintf("2: 2019-2021\n");
  fprintf("Available Datasets:\n");
  fprintf("1: Level 2 CSR (Temp. Unavailable)\n");
  fprintf("2: Level 2 GFZ (Temp. Unavailable)\n");
  fprintf("3: Level 2 JPL (Temp. Unavailable)\n");
  fprintf("4: Level 3 CSR\n");
  fprintf("5: Level 3 GFZ\n");
  fprintf("6: Level 3 JPL\n");
  fprintf("7: JPL Mascons (Temp. Unavailable)\n");
  fprintf("8: Cumulative Level 3 CSR\n");
  fprintf("9: Cumulative Level 3 GFZ\n");
  fprintf("10: Cumulative Level 3 JPL\n");
  fprintf("11: Cumulative JPL Mascons (Temp. Unavailable)\n");
  error("Error: No dataset specified!\n\n")
end