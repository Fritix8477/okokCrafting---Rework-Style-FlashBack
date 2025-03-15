function addStr(str, index, stringToAdd){
	return str.substring(0, index) + stringToAdd + str.substring(index, str.length);
}

var isTimerOn = false;
var lastTime;
let isAnimating = false;
var lastCraftPercentage = "N/A";

window.addEventListener('message', function(event) {
	item = event.data;
	switch (event.data.action) {
		case 'openCraft':
			var craft = event.data.craft;
			var num = craft.length;
			var paragraph = '';
			var row = '<div class="row">';
			var lastRowNum = 0;
			var job = event.data.job;
			var added = 0

			for(var i = 0; i < num; i++) {
				for(var i1 = 0; i1 < craft[i].job.length; i1++){
					if(craft[i].job[i1] == job || craft[i].job[i1] == ''){
						var itemName = event.data.itemNames;
						var itemId = craft[i].item;
						added++
						row += `
    						<div class="col-md-4">
       	 						<div class="card item-card" id="${itemId}wb_${event.data.wb}">
            <div class="card-body item-card-body d-flex flex-column justify-content-left align-items-left"
                style="background: linear-gradient(to right, rgba(0, 0, 0, 0.50), rgba(0, 0, 0, 0.20))"
                id="selected${itemId}wb_${event.data.wb}">
                <span id="timecraft">
                    <i class="fas fa-clock"></i> ${craft[i].time ? craft[i].time + "s" : "N/A"}
                </span>
                <span id="percentagecraft">
                    <i class="fas fa-percentage"></i> ${craft[i].successCraftPercentage !== undefined ? craft[i].successCraftPercentage + "%" : "N/A"}
                </span>
                <img src="icons/${itemId}.png" class="side-image"
                    style="max-width: 80px; height: auto; margin-left: 85px;">
					

                <div class="item-title">${itemName[itemId]}</div>
				<div class="item-id">${itemId}</div>
				<div class="item-qinfos">1 piece</div>
            </div>
        </div>
    </div>
`;
						var myEle = document.getElementById(itemId+"wb_"+event.data.wb);
					if(!myEle) {
						$(document).on('click', "#"+itemId+"wb_"+event.data.wb, function() {
							allID = this.id;
							id = allID.substring(0, allID.indexOf('wb_'));
							$('.item-card-body').css('background-color', 'rgba(220, 220, 220, 0.20)');
                            $('#selected'+this.id).css('background', 'linear-gradient(to right, rgba(0, 0, 0, .5), rgba(0, 0, 0, .2))');
							var sound = new Audio('click.mp3');
							sound.volume = 0.3;
							sound.play();
							$.post('https://fb_crafting/action', JSON.stringify({
								action: "craft",
								item: id,
								crafts: craft,
								itemName: itemName,
							}));
						});
					}

					if ((added) % 100000000000 === 0) {
							row = addStr(row, row.length, `</div><div class="row mt-4">`);
							lastRowNum = row.length+6;
						}
					}
				}
			}
			row += `</div>`;
			
			$('#craft-table').html(row);
			$('.title-name').html(event.data.name);

			$('.title').fadeIn();
			$('.itemslist').fadeIn();
			$('.crafting-body').fadeIn();
		break
		case 'openSideCraft':
			var canCraft = true;
			var num = event.data.recipe.length;
			var recipe = ``;
			var img = `
				<div class="image_itemselected">
					<img src="icons/${event.data.itemNameID}.png" class="image" alt="Image">
					<span style="position: absolute; align-items: center; top: 3%; color: #fff; font-weight: 700; font-size: 30px;" class="ms-2">${event.data.itemName}</span>
				</div>
			`;
		
			$('#side-image').html(img);
			$('#craft-time').attr("data-base-time", event.data.time).html(event.data.time);
		
			$('#craft-percentage').html(event.data.percentage + "%");
		
			for (var i = 0; i < num; i++) {
				var idName = event.data.recipe[i][0];
				if (event.data.recipe[i][2]) {
					recipe += `
						<div class="d-flex justify-content-start align-items-center mx-1 flex-wrap">
							<div class="custom-item-card square-card">
								<img src="icons/${event.data.recipe[i][0]}.png" class="image_components">
								<div class="item-info">
									<span class="item-quantity">${event.data.inventory[i].key} / ${event.data.recipe[i][1]}</span>
								</div>
							</div>
						</div>
					`;							
				} else {
					recipe += `
						<div class="d-flex align-items-center mx-1">
							<img src="icons/${event.data.recipe[i][0]}.png" class="image_components">
							<span style="color: #fff; font-weight: 600; font-size: 20px;" class="ms-2">${event.data.itemNames[idName]} x${event.data.recipe[i][1]} (${event.data.inventory[i].key})</span>
						</div>
					`;
				}
		
				if (event.data.recipe[i][1] > event.data.inventory[i].key) {
					canCraft = false;
				}
			}
		
			if (canCraft) {
				$('#craft-button-div').html(`
					<button type="button" id="craft-button" data-item="${event.data.itemNameID}" data-recipe="${event.data.recipe}" data-amount="${event.data.itemAmount}"data-percentage="${event.data.successCraftPercentage}" onclick="craft(this)" class="btn btn-blue flex-grow-1 mt-4" style="border-radius: .2vh; flex-basis: 80%; width: 50%; font-weight: 400; display: flex; align-items: center; justify-content: center; position: absolute; bottom: -15vh; left: 50%; transform: translateX(-50%);"><i class="fas fa-tools" style="margin-right: 8px;"></i>Fabriquer</button>
				`);
				$('#craft-button').fadeIn();
			} else {
				$('#craft-button').fadeOut();
			}
			$('#craft-percentage').html((event.data.percentage !== undefined ? event.data.percentage + "%" : lastCraftPercentage));
			$('.components-responsive').html(recipe);
			$('.itemrequirements').fadeIn();
		break
		case 'ShowCraftCount':
    var time = event.data.time;
    var totalTime = event.data.totalTime;

    if (isNaN(totalTime) || totalTime <= 0) {
        totalTime = 10;
    }

    var progressBar = document.getElementById("crafting-progress");
    if (progressBar) {
        var percentage = ((totalTime - time) / totalTime) * 100;
        progressBar.style.width = percentage + "%";
    }

    if (!isTimerOn) {
        isTimerOn = true;
        $('.timer').fadeIn();
    }

    lastTime = time;
    break;
	case 'CompleteCraftCount':
		case 'FailedCraftCount':
			$('.timer').fadeOut();
			setTimeout(() => {
				$('#crafting-progress').css("width", "0%");
			}, 400);
			break;
		
			
				case 'FailedCraftCount':
					var itemName = event.data.name;
				
					$('.timer-card-body').css('background-color', '#990b0b');
					$('#crafting-text').html(`Failed to craft`);
					$('#item-name').html(`${itemName}`);
					$('#item-timer').html(`0s`);
					var progressBar = document.getElementById("crafting-progress");
					progressBar.value = 0;
				
					$('#cog').removeClass('fa-spin');
					$('#cog').removeClass('fa-cog');
				
					$('#cog').addClass('fa-times');
					break;
				
					case 'HideCraftCount':
					isTimerOn = false;
					$('.timer').fadeOut();
					setTimeout(function(){
						$('#cog').removeClass('fa-times');
						$('#cog').removeClass('fa-check');
						$('#cog').addClass('fa-spin');
						$('#cog').addClass('fa-cog');

						$('.timer-card-body').css('background-color', 'rgba(31, 94, 255, 1)');
					}, 400);
					break
	}
});

$(document).ready(function() {
    $('#fleche').on('click', function() {
        $('.crafting-body').fadeOut();
        $('.title').fadeOut();
        $('.itemslist').fadeOut();
        $('.itemrequirements').fadeOut();

        document.querySelector('.quantite').value = '';

        $.post('https://fb_crafting/action', JSON.stringify({
            action: "close",
        }));
    });
});


function craft(t) {
    var itemId = t.dataset.item;
    var recipe = t.dataset.recipe;
    var amount = parseInt(document.querySelector('.quantite').value) || 1;

    var baseTime = parseInt($('#craft-time').attr('data-base-time')) || 0;
    var totalTime = baseTime * amount;

    $.post('https://fb_crafting/action', JSON.stringify({
        action: "craft-button",
        itemID: itemId,
        recipe: recipe,
        amount: amount,
        totalTime: totalTime,
    }));
}

function updateProgressBar(totalTime) {
    if (isAnimating) return;
    isAnimating = true;

    var element = document.getElementById("crafting-progress");
    var startTime = Date.now();
    var duration = totalTime * 1000;

    function animate() {
        var currentTime = Date.now();
        var elapsedTime = currentTime - startTime;
        var progress = Math.min((elapsedTime / duration) * 100, 100);
        element.style.width = progress + '%';

        if (progress < 100) {
            requestAnimationFrame(animate);
        } else {
            isAnimating = false;
        }
    }

    requestAnimationFrame(animate);
}

window.addEventListener('message', function(event) {

    if (event.data.percentage !== undefined) {
        lastCraftPercentage = event.data.percentage + "%";
    }

    $('#craft-percentage').html(lastCraftPercentage);

    switch (event.data.action) {
        case 'ShowCraftCount':
            var totalTime = event.data.totalTime || event.data.time;
            updateProgressBar(totalTime);
            $('.custom-timer').fadeIn();
            break;
        case 'CompleteCraftCount':
        case 'FailedCraftCount':
            setTimeout(function() {
                $('.custom-timer').fadeOut();
				document.querySelector('.quantite').value = '';
            }, 500);
            break;
    }
});

function onCraftAction() {
    var quantite = document.querySelector('.quantite').value;
    if (quantite > 0) {
        quantite = parseInt(quantite);
        for (var i = 0; i < quantite; i++) {
            craftItem();
        }
    }
}

function craftItem() {
    var progressBar = document.getElementById("crafting-progress");
    var width = 0;
    var interval = setInterval(function() {
        if (width >= 100) {
            clearInterval(interval);
        } else {
            width++;
            progressBar.style.width = width + '%'; 
        }
    }, 100);
}

document.querySelector('.quantite').addEventListener('input', function() {
    if (this.value < 0) this.value = 1;
});

document.addEventListener("keydown", function(event) {
    if (event.key === "Escape") {
        closeCraftUI();
    }
});

function closeCraftUI() {
    $('.crafting-body').fadeOut();
    $('.title').fadeOut();
    $('.itemslist').fadeOut();
    $('.itemrequirements').fadeOut();

    document.querySelector('.quantite').value = '';

    $.post('https://fb_crafting/action', JSON.stringify({
        action: "close",
    }));
}

document.addEventListener("DOMContentLoaded", function () {
    var quantityInput = document.querySelector(".quantite");
    var timeDisplay = document.getElementById("craft-time");

    if (quantityInput && timeDisplay) {
        quantityInput.addEventListener("input", function () {
            var baseTime = parseInt(timeDisplay.getAttribute("data-base-time")) || 15;
            var quantity = parseInt(quantityInput.value) || 1;
            var totalTime = baseTime * quantity;

            timeDisplay.innerHTML = totalTime;
        });
    }
});

document.querySelector('.quantite').addEventListener('input', function() {
    if (this.value < 0) this.value = 1;
});


