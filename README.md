# Projeto Django

## Tecnologias utilizadas

- **Python**: v. 3.12.4
- **Django**: v. 5.0.6
- **MySQL**: v. 8.07

## Passos iniciais após baixar o projeto do repositório

1. **Clonar o repositório** para sua máquina:
 
   ```bash
   git clone https://github.com/lucalves0/gerenciamento-almoxarifado.git)
   
2. Abrir o projeto em uma IDE compatível com Django (como PyCharm, VS Code, etc.)
3. Instalar as dependências: Verifique se todas as dependências necessárias estão instaladas na sua máquina, utilizando o comando abaixo (após ativar o ambiente virtual):

   ```bash
    pip install -r requirements.txt   
5. Configurar o ambiente virtual:
  - Abra o terminal na pasta onde o projeto foi clonado.
  - Execute o seguinte comando para permitir a execução de scripts PowerShell (no Windows):
    
     ```powershell
     Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

  - Ative o ambiente virtual: 
      ```bash
      .\.venv\Scripts\activate
5. Executar o projeto: Com o ambiente virtual ativado, rode o servidor de desenvolvimento com o comando:

   ```bash
    python manage.py runserver   
## Comando para baixar o banco de dados em sua máquina:
 
   ```bash
    mysql -u username -p nome_do_banco < caminho_para_o_backup.sql
