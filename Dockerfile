FROM node:10

WORKDIR /usr/src/app

COPY . /usr/src/app/


RUN npm install



RUN ls /usr/src/app
RUN ls /usr/src/app/public

EXPOSE 3000

ENV REACT_APP_BACKEND_URL=http://nyamtsu.pp.ua/api
CMD npm start




