docker build -t cchadwickk/multi-client:latest -t cchadwickk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cchadwickk/multi-server:latest -t cchadwickk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cchadwickk/multi-worker:latest -t cchadwickk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cchadwickk/multi-client:latest
docker push cchadwickk/multi-worker:latest
docker push cchadwickk/multi-server:latest

docker push cchadwickk/multi-client:$SHA
docker push cchadwickk/multi-worker:$SHA
docker push cchadwickk/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cchadwickk/multi-server:$SHA
kubectl set image deployments/client-deployment client=cchadwickk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cchadwickk/multi-worker:$SHA