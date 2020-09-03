# Envoy Chuncked Header Bug

For https://github.com/envoyproxy/envoy/issues/7753

```
➜  curl -s localhost:8000/nolimit/headers -H "Authorization: Bearer foo"
{
  "headers": {
    "Accept": "*/*",
    "Content-Length": "0",           <--- No Rate limit, only ext_authz
    "Host": "localhost:8000",
    "User-Agent": "curl/7.68.0",
    "X-Envoy-Expected-Rq-Timeout-Ms": "15000",
    "X-Envoy-Original-Path": "/nolimit/headers",
    "X-Ext-Auth-Ratelimit": "LCa0a2j/xo/5m0U8HTBBNBNCLXBkg7+g+YpeiGJm564="
  }
}
➜  curl -s localhost:8000/headers -H "Authorization: Bearer foo"
{
  "headers": {
    "Accept": "*/*",
    "Host": "localhost:8000",
    "Transfer-Encoding": "chunked",    <--- Rate limit and ext_authz 
    "User-Agent": "curl/7.68.0",
    "X-Envoy-Expected-Rq-Timeout-Ms": "15000",
    "X-Ext-Auth-Ratelimit": "LCa0a2j/xo/5m0U8HTBBNBNCLXBkg7+g+YpeiGJm564="
  }
}
```