docker build -t clintlosee/multi-client:latest -t clintlosee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t clintlosee/multi-server:latest -t clintlosee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t clintlosee/multi-worker:latest -t clintlosee/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push clintlosee/multi-client:latest
docker push clintlosee/multi-server:latest
docker push clintlosee/multi-worker:latest

docker push clintlosee/multi-client:$SHA
docker push clintlosee/multi-server:$SHA
docker push clintlosee/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=clintlosee/multi-server:$SHA
kubectl set image deployments/client-deployment client=clintlosee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=clintlosee/multi-worker:$SHA
