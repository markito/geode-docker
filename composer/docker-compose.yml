locator:
  image: apachegeode/geode
  hostname: locator
  mem_limit: 512m
  expose:
   - "10334"
   - "1099"
   - "7575"
  #  - "1024"
  ports:
   - "1099:1099"
   - "10334:10334"
   - "7575:7575"
   - "7070:7070"
  volumes:
   - ./scripts/:/scripts/
  command: /scripts/gfshWrapper.sh gfsh start locator --name=locator --mcast-port=0

server:
  image: apachegeode/geode
  mem_limit: 2g
  links:
   - locator:locator
  expose:
   - "8080"
   - "40404"
   - "1099"
  ports:
   - "40404"
  volumes:
   - ./scripts/:/scripts/
  command: /scripts/startServer.sh --server-port=40404 --max-heap=1G
