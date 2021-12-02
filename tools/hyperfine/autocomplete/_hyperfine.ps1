
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'hyperfine' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'hyperfine'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-')) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'hyperfine' {
            [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'Perform NUM warmup runs before the actual benchmark. This can be used to fill (disk) caches for I/O-heavy programs.')
            [CompletionResult]::new('--warmup', 'warmup', [CompletionResultType]::ParameterName, 'Perform NUM warmup runs before the actual benchmark. This can be used to fill (disk) caches for I/O-heavy programs.')
            [CompletionResult]::new('-m', 'm', [CompletionResultType]::ParameterName, 'Perform at least NUM runs for each command (default: 10).')
            [CompletionResult]::new('--min-runs', 'min-runs', [CompletionResultType]::ParameterName, 'Perform at least NUM runs for each command (default: 10).')
            [CompletionResult]::new('-M', 'M', [CompletionResultType]::ParameterName, 'Perform at most NUM runs for each command. By default, there is no limit.')
            [CompletionResult]::new('--max-runs', 'max-runs', [CompletionResultType]::ParameterName, 'Perform at most NUM runs for each command. By default, there is no limit.')
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'Perform exactly NUM runs for each command. If this option is not specified, hyperfine automatically determines the number of runs.')
            [CompletionResult]::new('--runs', 'runs', [CompletionResultType]::ParameterName, 'Perform exactly NUM runs for each command. If this option is not specified, hyperfine automatically determines the number of runs.')
            [CompletionResult]::new('-p', 'p', [CompletionResultType]::ParameterName, 'Execute CMD before each timing run. This is useful for clearing disk caches, for example.
The --prepare option can be specified once for all commands or multiple times, once for each command. In the latter case, each preparation command will be run prior to the corresponding benchmark command.')
            [CompletionResult]::new('--prepare', 'prepare', [CompletionResultType]::ParameterName, 'Execute CMD before each timing run. This is useful for clearing disk caches, for example.
The --prepare option can be specified once for all commands or multiple times, once for each command. In the latter case, each preparation command will be run prior to the corresponding benchmark command.')
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Execute CMD after the completion of all benchmarking runs for each individual command to be benchmarked. This is useful if the commands to be benchmarked produce artifacts that need to be cleaned up.')
            [CompletionResult]::new('--cleanup', 'cleanup', [CompletionResultType]::ParameterName, 'Execute CMD after the completion of all benchmarking runs for each individual command to be benchmarked. This is useful if the commands to be benchmarked produce artifacts that need to be cleaned up.')
            [CompletionResult]::new('-P', 'P', [CompletionResultType]::ParameterName, 'Perform benchmark runs for each value in the range MIN..MAX. Replaces the string ''{VAR}'' in each command by the current parameter value.

  Example:  hyperfine -P threads 1 8 ''make -j {threads}''

This performs benchmarks for ''make -j 1'', ''make -j 2'', …, ''make -j 8''.

To have the value increase following different patterns, use shell arithmetics.

  Example: hyperfine -P size 0 3 ''sleep $((2**{size}))''

This performs benchmarks with power of 2 increases: ''sleep 1'', ''sleep 2'', ''sleep 4'', …
The exact syntax may vary depending on your shell and OS.')
            [CompletionResult]::new('--parameter-scan', 'parameter-scan', [CompletionResultType]::ParameterName, 'Perform benchmark runs for each value in the range MIN..MAX. Replaces the string ''{VAR}'' in each command by the current parameter value.

  Example:  hyperfine -P threads 1 8 ''make -j {threads}''

This performs benchmarks for ''make -j 1'', ''make -j 2'', …, ''make -j 8''.

To have the value increase following different patterns, use shell arithmetics.

  Example: hyperfine -P size 0 3 ''sleep $((2**{size}))''

This performs benchmarks with power of 2 increases: ''sleep 1'', ''sleep 2'', ''sleep 4'', …
The exact syntax may vary depending on your shell and OS.')
            [CompletionResult]::new('-D', 'D', [CompletionResultType]::ParameterName, 'This argument requires --parameter-scan to be specified as well. Traverse the range MIN..MAX in steps of DELTA.

  Example:  hyperfine -P delay 0.3 0.7 -D 0.2 ''sleep {delay}''

This performs benchmarks for ''sleep 0.3'', ''sleep 0.5'' and ''sleep 0.7''.')
            [CompletionResult]::new('--parameter-step-size', 'parameter-step-size', [CompletionResultType]::ParameterName, 'This argument requires --parameter-scan to be specified as well. Traverse the range MIN..MAX in steps of DELTA.

  Example:  hyperfine -P delay 0.3 0.7 -D 0.2 ''sleep {delay}''

This performs benchmarks for ''sleep 0.3'', ''sleep 0.5'' and ''sleep 0.7''.')
            [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Perform benchmark runs for each value in the comma-separated list VALUES. Replaces the string ''{VAR}'' in each command by the current parameter value.

Example:  hyperfine -L compiler gcc,clang ''{compiler} -O2 main.cpp''

This performs benchmarks for ''gcc -O2 main.cpp'' and ''clang -O2 main.cpp''.

The option can be specified multiple times to run benchmarks for all possible parameter combinations.
')
            [CompletionResult]::new('--parameter-list', 'parameter-list', [CompletionResultType]::ParameterName, 'Perform benchmark runs for each value in the comma-separated list VALUES. Replaces the string ''{VAR}'' in each command by the current parameter value.

Example:  hyperfine -L compiler gcc,clang ''{compiler} -O2 main.cpp''

This performs benchmarks for ''gcc -O2 main.cpp'' and ''clang -O2 main.cpp''.

The option can be specified multiple times to run benchmarks for all possible parameter combinations.
')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Set output style type (default: auto). Set this to ''basic'' to disable output coloring and interactive elements. Set it to ''full'' to enable all effects even if no interactive terminal was detected. Set this to ''nocolor'' to keep the interactive output without any colors. Set this to ''color'' to keep the colors without any interactive output. Set this to ''none'' to disable all the output of the tool.')
            [CompletionResult]::new('--style', 'style', [CompletionResultType]::ParameterName, 'Set output style type (default: auto). Set this to ''basic'' to disable output coloring and interactive elements. Set it to ''full'' to enable all effects even if no interactive terminal was detected. Set this to ''nocolor'' to keep the interactive output without any colors. Set this to ''color'' to keep the colors without any interactive output. Set this to ''none'' to disable all the output of the tool.')
            [CompletionResult]::new('-S', 'S', [CompletionResultType]::ParameterName, 'Set the shell to use for executing benchmarked commands.')
            [CompletionResult]::new('--shell', 'shell', [CompletionResultType]::ParameterName, 'Set the shell to use for executing benchmarked commands.')
            [CompletionResult]::new('-u', 'u', [CompletionResultType]::ParameterName, 'Set the time unit to be used. Possible values: millisecond, second.')
            [CompletionResult]::new('--time-unit', 'time-unit', [CompletionResultType]::ParameterName, 'Set the time unit to be used. Possible values: millisecond, second.')
            [CompletionResult]::new('--export-asciidoc', 'export-asciidoc', [CompletionResultType]::ParameterName, 'Export the timing summary statistics as an AsciiDoc table to the given FILE.')
            [CompletionResult]::new('--export-csv', 'export-csv', [CompletionResultType]::ParameterName, 'Export the timing summary statistics as CSV to the given FILE. If you need the timing results for each individual run, use the JSON export format.')
            [CompletionResult]::new('--export-json', 'export-json', [CompletionResultType]::ParameterName, 'Export the timing summary statistics and timings of individual runs as JSON to the given FILE.')
            [CompletionResult]::new('--export-markdown', 'export-markdown', [CompletionResultType]::ParameterName, 'Export the timing summary statistics as a Markdown table to the given FILE.')
            [CompletionResult]::new('-n', 'n', [CompletionResultType]::ParameterName, 'Give a meaningful name to a command')
            [CompletionResult]::new('--command-name', 'command-name', [CompletionResultType]::ParameterName, 'Give a meaningful name to a command')
            [CompletionResult]::new('-i', 'i', [CompletionResultType]::ParameterName, 'Ignore non-zero exit codes of the benchmarked programs.')
            [CompletionResult]::new('--ignore-failure', 'ignore-failure', [CompletionResultType]::ParameterName, 'Ignore non-zero exit codes of the benchmarked programs.')
            [CompletionResult]::new('--show-output', 'show-output', [CompletionResultType]::ParameterName, 'Print the stdout and stderr of the benchmark instead of suppressing it. This will increase the time it takes for benchmarks to run, so it should only be used for debugging purposes or when trying to benchmark output speed.')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print this help message.')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print this help message.')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Show version information.')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Show version information.')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
