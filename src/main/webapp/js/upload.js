
// File Preview

const fileInput = document.getElementById("fileInput");
const fileNamePreview = document.getElementById("fileNamePreview");

fileInput.addEventListener("change", function () {

    if (this.files.length > 0) {

        fileNamePreview.innerText = this.files[0].name;

    } else {

        fileNamePreview.innerText = "No file selected";

    }

});

// Elements

const copiesInput = document.getElementById("copies");
const printType = document.getElementById("printType");

const deliveryCheck = document.getElementById("deliveryCheck");
const deliveryFields = document.getElementById("deliveryFields");
const deliveryType = document.getElementById("deliveryType");

const summaryCopies = document.getElementById("summaryCopies");
const printCost = document.getElementById("printCost");
const extraCost = document.getElementById("extraCost");
const discountAmount = document.getElementById("discountAmount");
const deliveryCost = document.getElementById("deliveryCost");
const gst = document.getElementById("gst");
const totalAmount = document.getElementById("totalAmount");

const extraServices =
document.querySelectorAll(".extra-service");

// Coupon Discount

let discount = 0;

// Delivery Date

function setDeliveryDate() {

    let today = new Date();

    today.setDate(today.getDate() + 2);

    document.getElementById("deliveryDate").innerText =
        today.toLocaleDateString();

}

// Bill Calculation

function calculateBill() {

    let copies = parseInt(copiesInput.value) || 1;

    let printRate = parseInt(printType.value);

    let baseCost = copies * printRate;

    let extras = 0;

    extraServices.forEach(service => {

        if (service.checked) {

            extras += parseInt(service.value);

        }

    });

    let delivery = 0;

    if (deliveryCheck.checked) {

        delivery = parseInt(deliveryType.value);

    }

    let subtotal =
        baseCost +
        extras +
        delivery -
        discount;

    if (subtotal < 0) {

        subtotal = 0;

    }

    let gstAmount = subtotal * 0.05;

    let finalTotal =
        subtotal +
        gstAmount;

    // Update Summary

    summaryCopies.innerText =
        copies;

    printCost.innerText =
        `₹${baseCost}`;

    extraCost.innerText =
        `₹${extras}`;

    discountAmount.innerText =
        `₹${discount}`;

    deliveryCost.innerText =
        `₹${delivery}`;

    gst.innerText =
        `₹${gstAmount.toFixed(2)}`;

    totalAmount.innerText =
        `₹${finalTotal.toFixed(2)}`;

}

// Coupon Apply

document
.getElementById("applyCoupon")
.addEventListener("click", () => {

    const coupon =
        document
        .getElementById("couponCode")
        .value
        .trim()
        .toUpperCase();

    const message =
        document
        .getElementById("couponMessage");

    if (coupon === "WELCOME10") {

        discount = 10;

        message.innerHTML =
            "✅ Coupon Applied Successfully";

        message.style.color =
            "green";

    }
    else {

        discount = 0;

        message.innerHTML =
            "❌ Invalid Coupon";

        message.style.color =
            "red";

    }

    calculateBill();

});

// Delivery Toggle

deliveryCheck.addEventListener("change", () => {

    if (deliveryCheck.checked) {

        deliveryFields.style.display =
            "block";

    }
    else {

        deliveryFields.style.display =
            "none";

    }

    calculateBill();

});

// Events

copiesInput.addEventListener(
    "input",
    calculateBill
);

printType.addEventListener(
    "change",
    calculateBill
);

deliveryType.addEventListener(
    "change",
    calculateBill
);

extraServices.forEach(service => {

    service.addEventListener(
        "change",
        calculateBill
    );

});

// Initial Load

setDeliveryDate();
calculateBill();


document.querySelector("form")
.addEventListener("submit", function () {

    const totalText =
        document.getElementById("totalAmount")
        .innerText;
		
	console.log("Total = " + totalText);
		
    document.getElementById("hiddenTotal")
        .value =
        totalText.replace("₹", "");

});

