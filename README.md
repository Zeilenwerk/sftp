# SFTP Server

Run SFTP as a non-root user with Dropbear.

## Usage

```shell
$ docker run -d -e 'USER_ENCRYPTED_PASSWORD=my-encrypted-password' -p 2222:2222 zeilenwerk/sftp
```

To generate an encrypted password, you can run the following command:

```shell
$ echo -n 'your-actual-password' | docker run -i --rm atmoz/makepasswd --crypt-md5 --clearfrom=-
```

Then you can log in using SFTP:

```shell
$ sftp -P 2222 sftp@localhost
```
