let tarot = 'card_tarot_b6_c60';

let flippedcard1 = false;
let flippedcard2 = false;
let flippedcard3 = false;
let flippedcard4 = false;

document.onkeyup = function (data) {
    if (data.which == 27) { // Escape
        $.post(`https://${GetParentResourceName()}/CloseNui`)
        setTimeout(() => { $('.cards').css("display", "none"); }, 2000);
        $('.cards').animate({"top": "100%"}, 450)

        if (flippedcard1 === true) {
            var card = document.querySelector('.card');
            card.classList.toggle('is-flipped');
            flippedcard1 = false
        }
        if (flippedcard2 === true) {
            var card = document.querySelector('.card2');
            card.classList.toggle('is-flipped');
            flippedcard2 = false
        }

        if (flippedcard3 === true) {
            var card = document.querySelector('.card3');
            card.classList.toggle('is-flipped');
            flippedcard3 = false
        }

        if (flippedcard4 === true) {
            var card = document.querySelector('.card4');
            card.classList.toggle('is-flipped');
            flippedcard4 = false
        }
    }
};

addEventListener("message", function(event){
    let item = event.data;

    if(item.open == true) {
        if (item.class == "open") {
            $('.cards').css("display", "block");
            $('.cards').animate({"top": "30%"}, 450)
        } 
        if (item.class == "choose") {
            tarot = item.data   
        } 
    }

    // NUEVA PARTE 
    if ( item.action === "display_card") {
        const cardImagePath = item.card;
        card.setAttribute('src', cardImagePath);
        const cardContainer = document.getElementById("cardContainer");
        cardContainer.style.display = "block";
    } else if ( item.action === "hide_card") {
        card.setAttribute('src', ''); // Limpiar la imagen
        const cardContainer = document.getElementById("cardContainer");
        cardContainer.style.display = "none"; // Hide the card container
    }
});


$(document).on('click', '.card', function(e){
    e.preventDefault();
    var card = document.querySelector('.card');
    if (flippedcard1 === false) {
        card.classList.toggle('is-flipped');
        $.post(`https://${GetParentResourceName()}/randomCard`);

        setTimeout(() => { 
            document.getElementById("myImg").src = "img/" + tarot + ".png";
            // document.getElementById("myImg").src = "svg/" + tarot + ".svg";
            $.post(`https://${GetParentResourceName()}/Rewardtarot`, JSON.stringify({
                Tarot: tarot,
            }))
        }, 200);

        flippedcard1 = true
    }
});

$(document).on('click', '.card2', function(e){
    e.preventDefault();
    var card = document.querySelector('.card2');
    if (flippedcard2 === false) {
        card.classList.toggle('is-flipped');
        $.post(`https://${GetParentResourceName()}/randomCard`);

        setTimeout(() => {
            document.getElementById("myImg2").src = "img/" + tarot + ".png";
            // document.getElementById("myImg2").src = "svg/" + tarot + ".svg";
            $.post(`https://${GetParentResourceName()}/Rewardtarot`, JSON.stringify({
                Tarot: tarot,
            }))
        }, 200);

    
        flippedcard2 = true
    }
});

$(document).on('click', '.card3', function(e){
    e.preventDefault();
    var card = document.querySelector('.card3');
    if (flippedcard3 === false) {
        card.classList.toggle('is-flipped');
        $.post(`https://${GetParentResourceName()}/randomCard`);

        setTimeout(() => {
            document.getElementById("myImg3").src = "img/" + tarot + ".png";
            // document.getElementById("myImg3").src = "svg/" + tarot + ".svg";
            $.post(`https://${GetParentResourceName()}/Rewardtarot`, JSON.stringify({
                Tarot: tarot,
            }))
        }, 200);

        
        flippedcard3 = true
    }
});

$(document).on('click', '.card4', function(e){
    e.preventDefault();
    var card = document.querySelector('.card4');
    if (flippedcard4 === false) {
        card.classList.toggle('is-flipped');
        $.post(`https://${GetParentResourceName()}/randomCard`);

        setTimeout(() => {
            document.getElementById("myImg4").src = "img/" + tarot + ".png";
            // document.getElementById("myImg4").src = "svg/" + tarot + ".svg"; 
            $.post(`https://${GetParentResourceName()}/Rewardtarot`, JSON.stringify({
                Tarot: tarot,
            }))
        }, 200);

        
        flippedcard4 = true
    }
});

// NUEVA PARTE
window.addEventListener('keyup', function(data) {
    if (data.which == 27) {
        var cardContainer = document.getElementById("cardContainer");
        cardContainer.style.display = "none";
        fetch(`https://${GetParentResourceName()}/closeCard`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({ visible: false }),
        });
    }
});

let mouseX = 0,
    mouseY = 0,
    isMouseDown = false;
const card = document.getElementById("cardImage");

document.addEventListener("mousedown", function () {
    isMouseDown = true;
});

document.addEventListener("mouseup", function () {
    isMouseDown = false;
});

document.addEventListener("mousemove", function (e) {
    if (isMouseDown) {
    mouseX += e.movementX;
    mouseY += e.movementY;
    card.style.transform = `rotateY(${mouseX / 5}deg) rotateX(${ -mouseY / 5 }deg)`;
    }
});