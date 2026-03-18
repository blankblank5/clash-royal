# Use .NET 8.0 SDK to build
FROM ://microsoft.com AS build
WORKDIR /src

# Copy all files and publish the main project
COPY . .
RUN dotnet publish "ClashRoyale/ClashRoyale.csproj" -c Release -o /app

# Final stage: Run the app
FROM ://microsoft.com
WORKDIR /app
COPY --from=build /app .
# Copy filter.json as required by the README
COPY ClashRoyale/filter.json . 

# Open the game port
EXPOSE 9339

ENTRYPOINT ["dotnet", "ClashRoyale.dll"]
