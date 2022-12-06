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

 **imagem1** <https://drive.google.com/file/d/1vbQ8uniVHMMCQzB0HW0OOpEkjGnBVccK/view?usp=share_link>

 Abra um terminal e execute o comando **terraform init**, espere ele finalizar as configurações e depois digite **terraform apply -auto-approve**.
 Espere ele finalizar a criação da infraestrutura para seguir para proxima etapa.

 *Se preferir, acesse a aws e veja os recursos de vpc e subnets que foram criados via terraform*

 OK, temos nossa infraestrutura base criada, agora vamos criar nosso primeiro **EC2** com Jenkins que irá ser responsavel por facilitar nossas futuras alterações.

 ## Criando EC2 com Jenkins

 Com o VSCode aberto, clone o repositório que já deixamos pré configurado com as configurações da EC2 com Jenkins

 **HTTPS:** <https://github.com/bootcampimpacta/Jenkins-server.git>

 **SSH:** <git@github.com:bootcampimpacta/Jenkins-server.git>

 O resultado deve ser similar a imagem abaixo

 **imagem2** <https://drive.google.com/file/d/1YSBXWmKLFIDdprPgvMfMVtByujU7gy9W/view?usp=share_link>

 ***OBS: utilizamos aqui um shell script com as configurações para instalação de um docker para facilitar a configuração do Jenkins e é utilizado um outro repositório no github que armazena um dockerfile versionado com o que o container do Jenkins irá possuir, que no caso contém, Terraform e AwsCLI***

 Abra um terminal e execute o comando **terraform init**, espere ele finalizar as configurações e depois digite **terraform apply -auto-approve**.
 Espere ele finalizar a criação da infraestrutura para seguir para proxima etapa.

 Perceba que no final do processo o terminal irá exibir a URL de acesso do Jenkins que configuramos para facilitar o acesso, não necessitando acessar a AWS para descobrir o IP publico que foi gerado na criação da EC2

 _no exemplo abaixo o server gerou com o IP Publico 54.236.99.154_

 **imagem3** <https://drive.google.com/file/d/1NgnYBk7n1_iD4-e34J9dfyabPtU3_vqV/view?usp=share_link>

 Depois de uns 5 minutos, precisamos acessar o servidor do Jenkins pra fazer 2 atividas:
 - Pegar a senha incial para configurar o Jenkins
 - Configurar as credenciaos aws no servidor

 ### Pegandoa senha inicial

 Acesse o sevidor utilizando o comando _ssh -i terraform.pem ec2-user@IPdoServidor_ , nao se esqueça de pegar a chave **terraform.pem** que foi fornecida no e-mail.

 Dentro do servidor execute o comando **docker exec -ti jenkins-pod cat /var/jenkins_home/secrets/initialAdminPassword**, esse comando irá trazer a senha para configura o jenkins. Guarde-a pois iremos usa-la logo mais.

 **imagem4** <https://drive.google.com/file/d/1R1s3zWA1qOLzR3O1MLGaEqk9J5Z3nvfh/view?usp=share_link>

### Configurando AWS Credencials no Sevidor Jenkins

 Ainda dentro do servidor execute o comando **docker exec -ti jenkins-pod /bin/bash**, esse comando irá fazer entrar dentro do container onde está o Jenkins, logo após execute o comando  **aws configure**, assim como você configurou a conta da aws localmente alguns passos anteriormente, precisamos fazer a mesma configuração aqui.

 **imagem5** <https://drive.google.com/file/d/18oULe2_rfNiG1EsaDeONZyjAVFSb-quR/view?usp=share_link>

  AWS Access Key ID [None]: **informado no email**

  Secret Access Key [None]: **informado no email**

  Default region name [None]: **us-east-1**

  Default output format [None]: json

Assim que finalizar, digite **exit**.

## Configurando Jenkins
 Agora no Browser navegue para o Jenkins acessando URL **http://IPpublicoServidor/** e coloque a senha que pegou no passo anterior e prossiga.

 **imgem6** <https://drive.google.com/file/d/1AyCGRIsspXqU7MZKNzTHCu5_5pkfGA-P/view?usp=share_link>
 
 **Install sugested puglins**

 **imagem7** <https://drive.google.com/file/d/1iFO8SwkjEJ7qv96m9MGVX3wTXafQANQj/view?usp=share_link>

 No final da configuração preencha os campos com _bootcamp_ e com email _bootcampimpacta@gmail.com_ e **salve e continue**.
 
 **imagem8** <https://drive.google.com/file/d/1vtRHYKbmRMhWgd4O_57QkEg5jKufqNjd/view?usp=share_link>

 depois **salve e finish**. Depois **Start and use Jenkins**.

 **imagem9** <https://drive.google.com/file/d/12EfwqxzS5n2GukMiG8b17IbknoVfR4zb/view?usp=share_link>

 Pronto! Finalizamos a configuração do Jenkins agora vamos para a proxima etapa para subir um servidor grafana utilizando um pipeline do Jenkins.


 ## Configurando um pipeline para subir a EC2 do Grafana

 Iremos agora configurar uma pipeline no jenkins que recupera um repositório no Github com as configurações da EC2 e aplica na nossa conta AWS, utilize a configuração abaixo na criação do pipeline.

 ```js
    pipeline {
        agent any
        stages {
            stage('Clone') {
            steps {
                git url: 'https://github.com/bootcampimpacta/grafana-server.git', branch: 'main'
            }
            }

            stage('TF Init&Plan') {
            steps {
                script {
                sh 'terraform init'
                sh 'terraform plan -out=myplan.out'
                }
            }
            }

            stage('Approval') {
            steps {
                script {
                def userInput = input(id: 'confirm', message: 'Deseja alterar a Infraestrutura?', description: 'Acao ', name: 'Confirm')
                }
            }
            }

            stage('TF Apply') {
            steps {
                sh 'terraform apply myplan.out'
            }
            }
        }
    }
 ```

 Clique em **Create a job**

 **imagem10** <https://drive.google.com/file/d/1MUTTVDtXUo_bFvrocP5ysif26S0OyGPS/view?usp=share_link>

 De o nome da esteira de **IAC-GrafanaServer** ou outro nome que preferir mas que indique que essa esteira é resposavel pelo servidor do Grafana, selecione **pipeline** e clique em **OK**

 **imagem11** <https://drive.google.com/file/d/1AkAIYYJiVCFqz9PjXOPZA5npeS8dXPtU/view?usp=share_link>

 Role até a parte de baixo e vá em Pipeline e colque o script acima e salve. Pronto temos um pipeline que resgata as informações de um repositorio e publica uma EC2 de grafana usando terraform.

 **imagem12** <https://drive.google.com/file/d/1FDfVpbcY6YiAFU6XbjvxlDskPi6oqTZi/view?usp=share_link>

 Clique em **Build Now** e espere a inicialização da esteira.

 **imagem13** <https://drive.google.com/file/d/1a40q7e9wQtPzIOs8BS-4V0i93XlSFp6p/view?usp=share_link>

 Nossa pipeline tem um step de aprovação para poder prosseguir, clique em Procced e aguarde.

 **imagem14** <https://drive.google.com/file/d/12hyMGKZSKRxj6Rrz5BHlhVk3_BByO5JG/view?usp=share_link>

 Verifique o sucesso da esteira no ultimo step e solicite para ver os logs, perceba que no final ele indica qual IP publico foi gerado para acessar o grafana, acesse a url indicada.

 _No nosso exemplo a url foi http://3.216.104.230:3000/_

 **imagem15** <https://drive.google.com/file/d/1wBzAh91jj8pe-giuESVbGBeJTNVogsHv/view?usp=share_link>

 Acesse a URL e veja o Grafana. Usuario: **admin** e Senha: **admin**. Ele vai pedir para trocar de senha, use a senha que desejar.

 **imagem16** <https://drive.google.com/file/d/1wP8nELV1BGaj6C_DRz0Xw82l4LHMVSW_/view?usp=share_link>

 Pronto. Temos um servidor Grafana configurado usando IAC.

 **imagem17** <https://drive.google.com/file/d/1xU6NPcWZ-S3SxS6LSZb4NgL7i9teLhjI/view?usp=share_link>

## Configurar o Grafana para monitorar dados basicos das nossas EC2

 Acesse a parte de configuração do jenkins clicando na engrenagem e depois em data source

 **imagem18** <https://drive.google.com/file/d/1atVupflgUm1G9ZK7b2dck9b5kk_xcu7A/view?usp=share_link>

 Clique em **ADD DataSource** e depois procure por **cloudwatch**

 **imagem19** <https://drive.google.com/file/d/1--NIXBoKtyjjL8Of3kPo-Wc13IfS-B4D/view?usp=share_link>

 Selecione **Access & Secret Key**, coloque as senhas que foram passadas por e-mail e selecione a Default Region como **us-east-1**.
 Depois clique em **Save & test** no final da pagina.

 **imagem20** <https://drive.google.com/file/d/14dOK83Ky1s6TZsIFQwYt1vsLKFf1L4Gv/view?usp=share_link>

 Clique na aba **Dashboards** e importe o dashboard **Amazon EC2**.

 **imagem21** <https://drive.google.com/file/d/1SJlKO9riOUdsNxPaA44miqW8vY-FY_of/view?usp=share_link>

 Pronto. Agora basicamente temos um monitoramento de nossas EC2 atuais e de futuras EC2 de nossa cloud AWS.

 Volte para o inicio clicando em **Dashboards** e depois **Browse**

 **imagem22** <https://drive.google.com/file/d/1MPDXdifXXj4IZzjVup1_lZAVljYKGwRQ/view?usp=share_link>

 Selecione o dashboard **Amazon EC2**

 **imagem23** <https://drive.google.com/file/d/1AYZ_Y6abxo5Bjfm1qAbE3DmZWPd6GcVx/view?usp=share_link>

 Pronto. Minimamente já temos alguns dados.

 **imagem24** <https://drive.google.com/file/d/1s4Cx4A9CTtLBwWbZGspuiB3HMRSPWfTL/view?usp=share_link>

## Configurando um pipeline para subir a EC2 do OSTicket

 _OSTicket é uma aplicação opensource de mercado para gestão de chamados. Estamos utilizando nesse bootcamp apenas para demonstrar como é simples subir uma infraestrutura como código e utilizando containers com imagens previamente definidas._

 Para mais informações acesse <https://osticket.com/>

 Vamos retornar ao Jenkins e criar um novo pipeline utilizando o script abaixo apontando para o repositório que contem as configurações para subir a EC2 com o OSTicket.

 ```js
    pipeline {
        agent any
        stages {
            stage('Clone') {
            steps {
                git url: 'https://github.com/bootcampimpacta/osticket-server.git', branch: 'main'
            }
            }

            stage('TF Init&Plan') {
            steps {
                script {
                sh 'terraform init'
                sh 'terraform plan -out=myplan.out'
                }
            }
            }

            stage('Approval') {
            steps {
                script {
                def userInput = input(id: 'confirm', message: 'Deseja alterar a Infraestrutura?', description: 'Acao ', name: 'Confirm')
                }
            }
            }

            stage('TF Apply') {
            steps {
                sh 'terraform apply myplan.out'
            }
            }
        }
    }
 ```

 Volte ao inicio e clique em novo item.

 **imagem25** <https://drive.google.com/file/d/1s4Cx4A9CTtLBwWbZGspuiB3HMRSPWfTL/view?usp=share_link>

 De o nome da esteira de **IAC-OSTicketServer** ou outro nome que preferir mas que indique que essa esteira é resposavel pelo servidor do OSticket, selecione **pipeline** e clique em **OK**

 **imagem26** <https://drive.google.com/file/d/1Bb02_kLk3_Yo8cUoBrUln1H8n310C44z/view?usp=share_link>

 Role até a parte de baixo e vá em Pipeline e colque o script acima e salve. Pronto temos um pipeline que resgata as informações de um repositorio e publica uma EC2 de OSticket usando terraform.

 Clique em **Build Now** e espere a inicialização da esteira.

 **imagem27** <https://drive.google.com/file/d/1OdyFbOJctx1d-o6_5NYNKALZRoC3iI7-/view?usp=share_link>

 Nossa pipeline tem um step de aprovação para poder prosseguir, clique em Procced e aguarde.

 **imagem28** <https://drive.google.com/file/d/1AsJfZ0Vd6U1bp-0PdOCy_BAx93Mjv3qI/view?usp=share_link>

 Verifique o sucesso da esteira no ultimo step e solicite para ver os logs, perceba que no final ele indica qual IP publico foi gerado para acessar o OSTicket, acesse a url indicada.

 _Aguarde uns 10 minutos pois essa configuação de subida é um pouco mais demorada_

 _No nosso exemplo a url foi http://34.199.198.249:8080/scp/_

 **imagem29** <https://drive.google.com/file/d/15XnprI1Uo_x5NZEXnDQ87XP15L_vQK7i/view?usp=share_link>

 Para acessar basta colocaro usuario: **ostadmin** e senha: **Admin1**

 **imagem30** <https://drive.google.com/file/d/1FC2mLq_QduxDSg53IRvn4h-iQc4grVGY/view?usp=share_link>

 
 Se voltarmos ao Grafana, podemos perceber que esse novo servidor já está sendo monitorado.

 **imagem31** <https://drive.google.com/file/d/1YuzhnBMpstWTs8NNVPAUhCTMeAiyyOCa/view?usp=share_link>


## Inciar pipeline quando o repositorio sofrer alteração

 Vamos criar uma outra pipeline para alterar a infra base que criamos no começo desse projeto.

 Vá até o Jenkins e crie um novo pipeline utilizando o script abaixo. Vamos dar o nome de **IAC-Bootcamp**

 ```js
    pipeline {
        agent any
        stages {
            stage('Clone') {
            steps {
                git url: 'https://github.com/bootcampimpacta/InfraAsCode.git', branch: 'main'
            }
            }

            stage('TF Init&Plan') {
            steps {
                script {
                sh 'terraform init'
                sh 'terraform plan -out=myplan.out'
                }
            }
            }

            stage('Approval') {
            steps {
                script {
                def userInput = input(id: 'confirm', message: 'Deseja alterar a Infraestrutura?', description: 'Acao ', name: 'Confirm')
                }
            }
            }

            stage('TF Apply') {
            steps {
                sh 'terraform apply myplan.out'
            }
            }
        }
    }
 ```

 **imagem32** <https://drive.google.com/file/d/1swGembjB2vqxdpNpnvo2hDRs1E0JweWb/view?usp=share_link>

 Na configuração dessa esteira maque a opção **GitHub hook trigger for GITScm polling**.

 **imagem33** <https://drive.google.com/file/d/1RKebwzG7Ve5-OTM5b3WE1-4OmurYHYGK/view?usp=share_link>

 Selecione **GitHub Projetct** e coloque a URL: https://github.com/bootcampimpacta/InfraAsCode.git/ e salve

 **imagem33-1** <https://drive.google.com/file/d/1RmEnw6kAYpt_m45VXnRU5a7zOdKQdCmy/view?usp=share_link>

 Antes de prosseguirmos, precisamos ir na nossa conta do github que hospeda o nosso repositório e configurar um webhook para o nosso Jenkins, utilize o usuario e senha que foi passado via email.

 URL GitHub: <https://github.com/bootcampimpacta/InfraAsCode>

 Clique em **Settings**

 **imagem34** <https://drive.google.com/file/d/1O6Z0crnS5b_V3f00tbZG0dC23HRQ-lmI/view?usp=share_link>

 Clique em **Webhooks** e depois **Add webhooks**

 **imagem35** <https://drive.google.com/file/d/1bLJqA0DqP3G7GSTwXpvE0I_MbkSkTKGn/view?usp=share_link>

 Adicione a url **http://IP-DO-JENKINS/github-webhook/** selecione no Content type **application/json** e depois **Add webhook**

 _No nosso exemplo nossa URL ficou assim http://54.236.99.154/github-webhook/_

 **imagem36** <https://drive.google.com/file/d/1BWDOYgHjwWxLWZmgg3yRPpbXYt5MbySS/view?usp=share_link>

 Aguarde até ficar verde, atualize a pagina se for necessário

 **imagem37** <https://drive.google.com/file/d/1d78_ubyBhTcOcCtMPed4BDZYCssniNSi/view?usp=share_link>

 Pronto. Agora qualquer alteração no nosso repositório _InfraAsCode_ na branch _main_ vai startar a pipeline no jenkins

 Vamos testar.

 Volte a tela inicial e crie uma branch baseada na main.

 vamos criar uma branch chamada _testeAutomacao_

 Na branhc vamos alterar o arquivo main.tf diretamente na console para poder exemplificar.

 **imagem38** <https://drive.google.com/file/d/1_Yzqzxb9vwdbGxDrNp8Hb3F0jS_tngRS/view?usp=share_link>

 Clique no lapis para editar. Vamos adicionar uma nova tag para testar a automação.

 Adicione a Tag **Professor** com o valor **Pablo**

 Dalve e adicione o comentario de _teste de automação_ e clique **Commit Changes**

 **imagem39** <https://drive.google.com/file/d/1D87eXPeChee_fYA2Xq5nYk-tGJTO_fXe/view?usp=share_link>

 Volte para a tela inicial e crie um **Pull Request**

 **imagem40** <https://drive.google.com/file/d/1tGZVYxFDrGGAKwNlir32T-9DfZdJd_Lk/view?usp=share_link>

 Depois **Create Pull Request**

 **imagem41** <https://drive.google.com/file/d/1LWjRFyw4Eg6haiIcbkJfMN9K5KRJrSA1/view?usp=share_link>

 Espere até o merge automatico finalizar e depois clique em **Merge Pull Request**. Estamos oficializando na branch main a alteração que fizemos na branch testeAutomacao

 **imagem42** <https://drive.google.com/file/d/189_vgBAq7H7Z0NZpnTJqb2v6ZqN6EnBJ/view?usp=share_link>

 **Confirm Merge**

 **imagem43** <https://drive.google.com/file/d/1O6pVJxoMu6azj2xZctDAPQIKCp6IaAU1/view?usp=share_link>

 Volte para o Jenkins e perceba que a esteira inicou automaticamente

 **imagem44** <https://drive.google.com/file/d/1jfkqPGEJFu6sU3QdBOyGpyW6H4Ki3vdM/view?usp=share_link>

 Clique em proced e deixa a estaira finalizar.

 Uma nova tag foi adicionada aos nossos recursos de rede.

 **imagem45** <https://drive.google.com/file/d/1b7lHCsbhxr6dmRJfoySOtyI2-Oz8a8IL/view?usp=share_link>


 ## Considerações Finais

 No nosso bootcamp utilizamos o conceito de infraestrutura como código, containers com dockerfile customizados, imagens prontas da Docker Hub, Git para versionamentos dos nossos metadadose e o Grafana para fazer o monitoramento dos nossos recusos na nuvem, além de subir um servidor com uma aplicação open source para gerenciamento de chamados.

 Alunos Diego Alves dos Santos e Fabiano Vidal Rocha
 
 Turma 08 Cloud e Devops



























