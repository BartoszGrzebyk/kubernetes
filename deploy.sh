docker build -t vertigo090/complex-client:latest -t vertigo090/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t vertigo090/complex-server:latest -t vertigo090/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t vertigo090/complex-worker:latest -t vertigo090/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vertigo090/complex-client:latest
docker push vertigo090/complex-server:latest
docker push vertigo090/complex-worker:latest

docker push vertigo090/complex-client:$SHA
docker push vertigo090/complex-server:$SHA
docker push vertigo090/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vertigo090/complex-server:$SHA
kubectl set image deployments/client-deployment client=vertigo090/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=vertigo090/complex-worker:$SHA