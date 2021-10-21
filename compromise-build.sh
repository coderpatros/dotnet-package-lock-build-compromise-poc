#!/usr/bin/env bash

# first we'll backup the original unmodified dll, it can be restored by running "restore-build-integrity.sh"
cp -n $HOME/dotnet/shared/Microsoft.NETCore.App/5.0.11/System.Text.Json.dll $HOME/dotnet/shared/Microsoft.NETCore.App/5.0.11/System.Text.Json.dll.bak

# alright, let's do this, muhahahah!
cd System.Text.Json
dotnet publish
# let's copy our "malicious" dll into the SDK dll location
sudo cp bin/Debug/net5.0/publish/System.Text.Json.dll $HOME/dotnet/shared/Microsoft.NETCore.App/5.0.11/System.Text.Json.dll
