// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})
socket.connect()

const createSocket = (topicId) => {
// Now that you are connected, you can join channels with a topic:
let channel = socket.channel(`comments:${topicId}`, {})
channel.join()
  .receive("ok", resp => { 
    renderComments(resp.comments);
  })
  .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on(`comments:${topicId}:new`, renderComment);

  document.querySelector(".add-comment").addEventListener("click", () => {
    const commentContent = document.querySelector("textarea").value;
    channel.push("comment:add", {content: commentContent});
  });
}

function renderComment(event) {
  document.querySelector(".collection").innerHTML += commentTemplate(event.comment);
}

function renderComments(comments) {
  console.log("Join successful");
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment);
  });
  document.querySelector(".collection").innerHTML = renderedComments.join("");
}

function commentTemplate(comment) {
  return `
  <li class="collection-item">
      ${comment.content}
    </li>`
}
window.createSocket = createSocket;