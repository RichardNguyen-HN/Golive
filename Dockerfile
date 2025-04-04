# ----- Build Stage -----
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY ./WebGC/WebGC.csproj ./WebGC/

# Restore dependencies
RUN dotnet restore ./WebGC/WebGC.csproj

# Copy everything and build
COPY . .
RUN dotnet publish ./WebGC/WebGC.csproj -c Release -o /app/publish

# ----- Runtime Stage -----
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Set entrypoint
ENTRYPOINT ["dotnet", "WebGC.dll"]
