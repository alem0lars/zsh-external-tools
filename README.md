# zsh-external-tools

Customizable external tools support in ZSH.

## Available options

The following options allow you to customize the editor module behaviour:

* `enabled`:

  * Description:

    List of external tools to be supported.

    _By default support for all external tools is enabled._

  * Usage:

    To enable the support for some tools, add their names in the supported list.

    For example to enable support for tools `tool-a`, `tool-b` and `tool-c`
    declare the following zstyle:

    ```
    zstyle ':external-tools' enabled \
      'tool-a' \
      'tool-b' \
      'tool-c'
    ```

## License

Licensed under `Apache License 2.0`. More details [here](./LICENSE).
