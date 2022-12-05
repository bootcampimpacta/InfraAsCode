# InfraAsCode Bootcamp
 Repositório para Armazenar a **Infraestrutura Como Código** do Bootcamp de Fabiano e Diego.

## Iniciando a Infraestrutura

 Primeiramente resgate os acessos do e-mail que foi enviado com o titulo de "Bootcamp Fabiano e Diego acessos", nesse e-mail irá conter.

 - ACESS KEY E SECRET KEY AWS
 - USUARIO E SENHA DO GITHUB
 - USUARIO E SENHA DA CONSOLE AWS

 Para que os proximos passos sejam executados de forma correta, tenha instalado em sua maquina o client do Terraform e o AWS CLI, seguem o links abaixo para facilitar instalação.

 **Instaladores**

 **Terraform:** <https://developer.hashicorp.com/terraform/downloads>

 **AWSCLI:** <https://docs.aws.amazon.com/pt_br/cli/latest/userguide/getting-started-install.html>


 **Configurando credenciais AWS**

 O Jeito mais rápido de configurar as credencias da AWS é através do aws configure. Abra um prompt de comando e digite _aws configure_ , 
 as informações abaixo serão solicitadas

 AWS Access Key ID [None]: **informado no email**

 AWS Secret Access Key [None]: **informado no email**

 Default region name [None]: **us-east-1**

 Default output format [None]: json

 
 ## Inicialzando a infraestrutura na aws

 ***Obs: Iremos utilizar o VSCode daqui para frente para realizar as atividades, caso não possua, acesse o link <https://code.visualstudio.com/download> para fazer odownload.***

 Com o VSCode aberto, clone o repositorio que já deixamos configurado com a infraestrutura do bootcamp.

 **HTTPS:** <https://github.com/bootcampimpacta/InfraAsCode.git>

 **SSH:** <git@github.com:bootcampimpacta/InfraAsCode.git>

 O resultado deve ser similar a imagem abaixo

 !(img1.jpg)

 Abra um terminal e execute o comando **terraform init**, espere ele finalizar as configurações e depois digite **terraform apply -auto-approve**.
 Espere ele finalizar a criação da infraestrutura para seguir para proxima etapa.

 *Se preferir, acesse a aws e veja os recursos de vpc e subnets que foram criados via terraform*

 OK, temos nossa infraestrutura base criada, agora vamos criar nosso primeiro **EC2** com Jenkins que irá ser responsavel por facilitar nossas futuras alterações.

 ## Criando EC2 com Jenkins

 Com o VSCode aberto, clone o repositório que já deixamos pré configurado com as configurações da EC2 com Jenkins

 **HTTPS:** <https://github.com/bootcampimpacta/Jenkins-server.git>

 **SSH:** <git@github.com:bootcampimpacta/Jenkins-server.git>

 O resultado deve ser similar a imagem abaixo

 !(img2)

 ***OBS: utilizamos aqui um shell script com as configurações para instalação de um docker para facilitar a configuração do Jenkins e é utilizado um outro repositório no github que armazena um dockerfile versionado com o que o container do Jenkins irá possuir, que no caso contém, Terraform e AwsCLI***

 Abra um terminal e execute o comando **terraform init**, espere ele finalizar as configurações e depois digite **terraform apply -auto-approve**.
 Espere ele finalizar a criação da infraestrutura para seguir para proxima etapa.

 Perceba que no final do processo o terminal irá exibir a URL de acesso do Jenkins que configuramos para facilitar o acesso, não necessitando acessar a AWS para descobrir o IP publico que foi gerado na criação da EC2

 !(img3)

 Depois de uns 5 minutos, precisamos acessar o servidor do Jenkins pra fazer 2 atividas:
 - Pegar a senha incial para configurar o Jenkins
 - Configurar as credenciaos aws no servidor

 ### Pegandoa senha inicial

 Acesse o sevidor utilizando o comando _ssh -i terraform.pem ec2-user@IPdoServidor_ , nao se esqueça de pegar a chave **terraform.pem** que foi fornecida no e-mail.

 Dentro do servidor execute o comando **docker exec -ti jenkins-pod cat /var/jenkins_home/secrets/initialAdminPassword**, esse comando irá trazer a senha para configura o jenkins. Guarde-a pois iremos usa-la logo mais.

### Configurando AWS Credencials no Sevidor Jenkins

 Ainda dentro do servidor execute o comando **docker exec -ti jenkins-pod /bin/bash**, esse comando irá fazer entrar dentro do container onde está o Jenkins, logo após execute o comando  **aws configure**, assim como você configurou a conta da aws localmente alguns passos anteriormente, precisamos fazer a mesma configuração aqui.

  AWS Access Key ID [None]: **informado no email**

  Secret Access Key [None]: **informado no email**

  Default region name [None]: **us-east-1**

  Default output format [None]: json

Assim que finalizar, digite **exit**.

## Configurando Jenkins
 Agora no Browser navegue para o Jenkins acessando URL **http://IPpublicoServidor/**






