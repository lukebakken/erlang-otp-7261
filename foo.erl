-module(foo).
-compile(export_all).

run() ->
  io:put_chars("START\n"),

  open_port(
    {spawn_executable, os:find_executable("erl")},
    [use_stdio, exit_status, binary, hide,
     {args, ["-eval", "io:setopts(standard_io, [{encoding, utf8}]), io:write(hello), erlang:halt()."]}]
  ),

  loop().

loop() ->
  receive
    {_, {data, Data}} ->
      io:put_chars(Data),
      loop();

    {_, {exit_status, _}} ->
      erlang:halt()
  end.
