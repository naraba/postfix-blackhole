# Postfix-Blackhole

Postfixに送られたメールをローカルファイルに保管するのみ

## 起動

```
$ sudo docker run -it -p 25:25 -p 80:80 postfix-blackhole
```

## 確認

サンプルメール
```
$ python3 ./sample-client.py
```

受信は localhost:80 にアクセス

## 参考

* [docker-postfix-blackhole](https://github.com/feathj/docker-postfix-blackhole)

