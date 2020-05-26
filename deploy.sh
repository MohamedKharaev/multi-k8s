docker build -t mikharaev/multi-client:latest -t mikharaev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mikharaev/multi-server:latest -t mikharaev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mikharaev/multi-worker:latest -t mikharaev/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mikharaev/multi-client:latest
docker push mikharaev/multi-server:latest
docker push mikharaev/multi-worker:latest

docker push mikharaev/multi-client:$SHA
docker push mikharaev/multi-server:$SHA
docker push mikharaev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mikharaev/multi-server:$SHA
kubectl set image deployments/client-deployment client=mikharaev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mikharaev/multi-worker:$SHA
