import asyncdispatch, httpclient, json, strutils, uri

const api = "https://fakestoreapi.com"
var headers = newHttpHeaders({
    "Connection": "keep-alive",
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36",
    "Host": "fakestoreapi.com",
    "Accept": "application/json",
    "Content-Type": "application/json"
})

# Products API
proc get_products*(limit: int = 0): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    var url = api & "/products"
    if limit > 0:
      url &= "?limit=" & $limit
    let response = await client.get(url)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_product*(id: int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/products/" & $id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc create_product*(data: JsonNode): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.post(api & "/products", $data)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc update_product*(id: int, data: JsonNode): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.put(api & "/products/" & $id, $data)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc delete_product*(id: int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.delete(api & "/products/" & $id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

# Get all categories
proc get_categories*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/products/categories")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

# Get products in specific category
proc get_products_by_category*(category: string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let encoded_category = encodeUrl(category)
    let response = await client.get(api & "/products/category/" & encoded_category)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

# Users API
proc get_users*(limit: int = 0): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    var url = api & "/users"
    if limit > 0:
      url &= "?limit=" & $limit
    let response = await client.get(url)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_user*(id: int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/users/" & $id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc create_user*(data: JsonNode): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.post(api & "/users", $data)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc update_user*(id: int, data: JsonNode): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.put(api & "/users/" & $id, $data)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc delete_user*(id: int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.delete(api & "/users/" & $id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

# Carts API
proc get_carts*(limit: int = 0): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    var url = api & "/carts"
    if limit > 0:
      url &= "?limit=" & $limit
    let response = await client.get(url)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_cart*(id: int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/carts/" & $id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_user_carts*(user_id: int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.get(api & "/carts/user/" & $user_id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc create_cart*(data: JsonNode): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.post(api & "/carts", $data)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc update_cart*(id: int, data: JsonNode): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.put(api & "/carts/" & $id, $data)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc delete_cart*(id: int): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let response = await client.delete(api & "/carts/" & $id)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

# Auth API
proc login*(username: string, password: string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  client.headers = headers
  try:
    let body_data = %*{
      "username": username,
      "password": password
    }
    let response = await client.post(api & "/auth/login", $body_data)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()
