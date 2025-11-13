# fakestoreapi
api for fakestoreapi.com site for test fake json
# Example
```nim
import asyncdispatch, fakestoreapi, json, strutils
let data = waitFor get_products(3)
echo data
```

# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
