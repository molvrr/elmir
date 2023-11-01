import { Elm } from './Main.elm';

const $root = document.createElement('div');
const token = document.querySelector("meta[name='csrf-token']").getAttribute("content")
document.body.appendChild($root);

const app = Elm.Main.init({
  node: $root
});

app.ports.csrfToken.send(token)
