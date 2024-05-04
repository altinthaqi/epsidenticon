# Epsidenticon

**Epsidenticon** is a service which generate an [identicon](http://en.wikipedia.org/wiki/Identicon) image based on a string.

Here are some examples of generated identicons!

![Example #1](identicons/altin-1713906807.png)&nbsp;&nbsp;
![Example #2](identicons/epsilono-1713906815.png)&nbsp;&nbsp;
![Example #3](identicons/elixir-1713906811.png)&nbsp;&nbsp;

## Usage

Images are generated in PNG format with transparent background.

The string can be an email, an IP address, a username, an ID or something else. Every image is saved under `identicons/` directory.

### Generate an identicon

Clone the repository

```bash
$ git clone https://github.com/altinthaqi/epsidenticon.git
```

Install dependencies ([egd](https://www.erlang.org/docs/18/man/egd.html))

```bash
$ cd epsidenticon/
$ mix deps.get
```

Start IEx

```bash
$ iex -S mix
```

Run main with a string

```bash
function Epsidenticon.main/1
```

Example

```bash
iex(1)> Epsidenticon.main("altinthaqi")
```

That's it - you should now have a newly generated identicon under `identicons/`!

The same string will always generate the same identicon color and pattern.

## License

Epsidenticon is released under the MIT License. See the bundled [LICENSE file](LICENSE.md) for details.
