#!/usr/bin/env bash

cd target-project
# restore packages
dotnet restore
# build the project
dotnet build
# run the project
dotnet run
