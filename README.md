# Proof of concept build compromise while using a package lock file

This is just a simple example of compromising a .NET project build
process for projects that use a package lock file.

For people not familiar with package lock files, they record _specific_
versions of resolved package versions, and their hash.

This is not a sophisticated attack. It requires compromising the build
environment. It's just to demonstrate that package lock files are only
useful for a very specific problem.

## Target project overview

The target project is in the `target-project` directory.

The main code file is `target-project/Program.cs`. Which on inspection
doesn't do much besides printing "Hello, World!".

The target project has a single dependency specified in
`target-project/target-project.csproj`. Which is `System.Text.Json`.

The package lock file can be inspected at `target-project/packages.lock.json`.
And both `RestorePackagesWithLockFile` and `RestoreLockedMode` have been enabled in the `target-project.csproj` file.

## Malicious package overview

`System.Text.Json` is a package that is on NuGet as well as being bundled with
the .NET SDK. As it is a standard part of .NET it makes a great candidate for
hijacking.

Someone who had more spare time, or resources, would probably create a fully
implemented version based on the upstream source code. But for demonstration
purposes I've only implemented one method.

Don't worry, it doesn't _actually_ do anything nefarious. It just returns
"Goodbye, World!" instead of "Hello, World!".

## Running the proof of concept

You can run the proof of concept in a browser using
[Gitpod](https://gitpod.io/#https://github.com/coderpatros/dotnet-package-lock-build-compromise-poc)
or run it locally using Docker.

To run it locally using Docker run the `localdev.sh` script. Please be
patient, it takes a while to build the environment as it has to download
the .NET SDK. But once it is ready, navigate to `http://localhost:3000`
in your browser. Once you are into the web based VS Code instance select
open folder and open the `/workspace` folder.

Once your instance is ready, start by confirming the target project behaves
as expected, run `run-target-project.sh` script in the VS Code terminal.

The final output should be "Hello, World!".

Next, put on your favourite black hoodie
and run the `compromise-build.sh` script.

Now, re-run the `run-target-project.sh` script.

The final output should now be "Goodbye, World!".

If you want to restore the SDK packages to the original state you can run the
`restore-build-integrity.sh` script.

## So how come this works?

The package lock file is only used when resolving package versions and
restoring them from package repositories to the local package cache.

msbuild doesn't care what you've got in your package lock file. It will
happily resolve other versions of dlls when building your project.

So we drop our "malicious" version of the `System.Text.Json.dll` file into the
SDK dll location. So msbuild resolves our "malicious" version instead.

Although I don't think this should be the behaviour, I believe it is as
designed. And I haven't seen any documentation to suggest that the package
lock file is intended to ensure the integrity of your _build_, just the _restore_.

Note: Even with this limitation I highly recommend you use package lock files
for your projects.
