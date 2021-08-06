import {Package, CreatePackagedComponentRequest} from '../lib';
import fetch from 'node-fetch';


async function createPackagedComponent() {
  const packageAPI = new Package();

  const request: CreatePackagedComponentRequest = {
    packagedComponent: {
      componentId: "3c1cabc3-45b8-49dd-95fe-d7bce88f998b",
      notes: "Created via npm by Isaac"
    }
  };
  const response = await packageAPI.createPackagedComponent(request);

  //const response = await fetch("http://www.example.com");

  console.log(response);
}

createPackagedComponent();