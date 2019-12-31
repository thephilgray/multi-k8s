docker build -t thephilgray/multi-client:latest -t thephilgray/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thephilgray/multi-server:latest -t thephilgray/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thephilgray/multi-worker:latest -t thephilgray/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push thephilgray/multi-client:latest
docker push thephilgray/multi-server:latest
docker push thephilgray/multi-worker:latest
docker push thephilgray/multi-client:$SHA
docker push thephilgray/multi-server:$SHA
docker push thephilgray/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=thephilgray/multi-server:$SHA
kubectl set image deployments/client-deployment client=thephilgray/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thephilgray/multi-worker:$SHA