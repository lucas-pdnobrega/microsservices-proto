$GITHUB_USERNAME = "ruandg"
$GITHUB_EMAIL = "lucaspdn04@gmail.com"

$SERVICE_NAME = "order"
$RELEASE_VERSION = "v1.2.3"

Write-Host "Instalando Plugins protobuf"
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
Write-Host "Gerando código fonte Go de $SERVICE_NAME"
if (!(Test-Path "golang")) {
    New-Item -ItemType Directory -Path "golang"
}

protoc --go_out=./golang `
  --go_opt=paths=source_relative `
  --go-grpc_out=./golang `
  --go-grpc_opt=paths=source_relative `
  ./$SERVICE_NAME/*.proto
Write-Host "Arquivos de $SERVICE_NAME gerados"
Get-ChildItem -Path "./golang/$SERVICE_NAME"

Set-Location "golang/$SERVICE_NAME"
go mod init "github.com/$GITHUB_USERNAME/microservices-proto/golang/$SERVICE_NAME"
go mod tidy
Write-Host "Serviços gerados!"
