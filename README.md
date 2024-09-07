# convert_.pfx_to_pem_and_key
convert .pfx file to cert.pem and key.pem and full chain  files

follow the steps

1- Give permissions

```
chmod +x convert_pfx_interactive-v5.sh
```

2- Run the Script

```
./convert_pfx_interactive-v5.sh
```

3- Follow the Prompts 

The script will prompt you for the path to the .pfx file, the output prefix, and the password for the .pfx file (which will be hidden).

```
Enter the path to the .pfx file: /path/to/your/mycert.pfx

Enter the output prefix for the generated files: mycert

Enter the password for the .pfx file:
```

4- Completion Message

After the conversion is complete, you should see output indicating the files created.

5- Resulting Files

After running the script, you will have the following files in your current directory:
```
mycert.key: The private key extracted from the .pfx file (passwordless).
mycert.cert.pem: The certificate extracted from the .pfx file.
mycert.fullchain.pem: The full chain file, which includes both the certificate and the private key.
```

#Important Notes

Ensure that you have OpenSSL installed on your system.

Keep your private key secure and do not share it publicly. Storing the private key in a file that also contains the certificate can expose it to unauthorized access.
