docker build -t pitbull959/multi-client:latest -t pitbull959/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pitbull959/multi-server:latest -t pitbull959/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pitbull959/multi-worker:latest -t pitbull959/multi-worker:$SHA -f ./worker/Dockerfile ./worker/

docker push pitbull959/multi-client:latest
docker push pitbull959/multi-server:latest
docker push pitbull959/multi-worker:latest

docker push pitbull959/multi-client:$SHA
docker push pitbull959/multi-server:$SHA
docker push pitbull959/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pitbull959/multi-server:$SHA
kubectl set image deployments/client-deployment client=pitbull959/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pitbull959/multi-worker:$SHA
