FROM ubuntu
# Update aptitude with new repo
ENV TZ=Europe/Kiev 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y git && \
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update; \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-5.0 
RUN mkdir Github && \
    cd Github
WORKDIR /Github && \   
    git clone https://github.com/Mykhailo-DevOps/DotNetCoreHelloFromAppSettings.git && \
    dotnet publish && \
    dotnet DotNetCoreHelloFromAppSettings/src/DotNetCoreHelloFromAppSettings/bin/Debug/netcoreapp5.0/DotNetCoreHelloFromAppSettings.dll && \
    dotnet test /DotNet/DotNetCoreHelloFromAppSettings/src/UnitTestProject/UnitTestProject.csproj        
VOLUME /var/lib/docker
