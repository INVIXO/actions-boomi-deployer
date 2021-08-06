import {PackagedComponentApi,Configuration} from "../generated";
import fetch from 'node-fetch';

function fetchAPI(input: RequestInfo, init?: RequestInit): Promise<Response> {
    let response: Promise<Response> = fetch("");
    response['trailer'] = null;

    return response;
}

export class Package extends PackagedComponentApi {
    
    
    constructor(){
        let configuration = new Configuration({
            fetchApi: fetchAPI,
            username: "BOOMI_TOKEN.Isaac.Livingston@invixo.com",
            password: "c7f6dbe7-4a62-4e67-9c35-bd89a843813d"
        })
        super(configuration);
    }
}

