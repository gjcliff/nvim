return {
  cmd = {
    "clangd",
    "--log=error",
    "--query-driver=/opt/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-g*",
    -- "-I/opt/gcc-arm-none-eabi-10-2020-q4-major/lib/gcc/arm-none-eabi/10.2.1/include",
    -- "-I/opt/gcc-arm-none-eabi-10-2020-q4-major/arm-none-eabi/include",
    "--log=verbose",
  },
}
