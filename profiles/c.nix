{
  mkProfile,
  clang-tools,
  gcc
}:

mkProfile {
  name = "c";
  paths = [
    clang-tools
    gcc
  ];
}
