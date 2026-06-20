const fileInput = document.getElementById("fileInput");
const fileNamePreview = document.getElementById("fileNamePreview");
const copiesInput = document.getElementById("copies");
const printType = document.getElementById("printType");
const deliveryCheck = document.getElementById("deliveryCheck");
const deliveryFields = document.getElementById("deliveryFields");
const deliveryType = document.getElementById("deliveryType");
const deliveryAddress = document.getElementById("deliveryAddress");
const deliveryRequired = document.getElementById("deliveryRequired");
const summaryCopies = document.getElementById("summaryCopies");
const summaryPages = document.getElementById("summaryPages");
const printCost = document.getElementById("printCost");
const extraCost = document.getElementById("extraCost");
const discountAmount = document.getElementById("discountAmount");
const deliveryCost = document.getElementById("deliveryCost");
const gst = document.getElementById("gst");
const totalAmount = document.getElementById("totalAmount");
const deliveryDate = document.getElementById("deliveryDate");
const extraServices = document.querySelectorAll(".extra-service");
const uploadForm = document.querySelector("form");

let discount = 0;
let pageCount = 1;

fileInput.addEventListener("change", function () {
    if (this.files.length === 0) {
        fileNamePreview.innerText = "No file selected";
        pageCount = 1;
        calculateBill();
        return;
    }

    const file = this.files[0];
    fileNamePreview.innerText = file.name;

    if (file.name.toLowerCase().endsWith(".pdf")) {
        estimatePdfPages(file);
    } else {
        pageCount = 1;
        calculateBill();
    }
});

function estimatePdfPages(file) {
    const reader = new FileReader();

    reader.onload = async function () {
        try {
            if (window.pdfjsLib) {
                pdfjsLib.GlobalWorkerOptions.workerSrc =
                    "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js";

                const pdf = await pdfjsLib.getDocument({
                    data: new Uint8Array(reader.result)
                }).promise;

                pageCount = pdf.numPages || 1;
            }
        } catch (error) {
            console.error("PDF page count failed", error);
            pageCount = 1;
        }

        calculateBill();
    };

    reader.onerror = function () {
        pageCount = 1;
        calculateBill();
    };

    reader.readAsArrayBuffer(file);
}

function setDeliveryDate() {
    if (!deliveryCheck.checked) {
        deliveryDate.innerText = "Self Pickup";
        return;
    }

    const today = new Date();
    today.setDate(today.getDate() + (deliveryType.value === "50" ? 1 : 2));
    deliveryDate.innerText = today.toLocaleDateString("en-IN");
}

function setDeliveryFields() {
    const enabled = deliveryCheck.checked;
    deliveryFields.style.display = enabled ? "block" : "none";
    deliveryRequired.value = enabled ? "yes" : "no";

    deliveryFields.querySelectorAll("input, textarea, select").forEach(field => {
        field.disabled = !enabled;
    });

    deliveryAddress.required = enabled;

    if (!enabled) {
        deliveryAddress.value = "";
        deliveryAddress.setCustomValidity("");
    }
}

function calculateBill() {
    const copies = parseInt(copiesInput.value) || 1;
    const printRate = parseInt(printType.value);
    const baseCost = pageCount * copies * printRate;
    let extras = 0;

    extraServices.forEach(service => {
        if (service.checked) {
            extras += parseInt(service.value);
        }
    });

    const delivery = deliveryCheck.checked ? parseInt(deliveryType.value) : 0;
    let subtotal = baseCost + extras + delivery - discount;

    if (subtotal < 0) {
        subtotal = 0;
    }

    const gstAmount = subtotal * 0.05;
    const finalTotal = subtotal + gstAmount;

    summaryCopies.innerText = copies;
    summaryPages.innerText = pageCount;
    printCost.innerText = `₹${baseCost}`;
    extraCost.innerText = `₹${extras}`;
    discountAmount.innerText = `₹${discount}`;
    deliveryCost.innerText = `₹${delivery}`;
    gst.innerText = `₹${gstAmount.toFixed(2)}`;
    totalAmount.innerText = `₹${finalTotal.toFixed(2)}`;
    document.getElementById("hiddenTotal").value = finalTotal.toFixed(2);
    setDeliveryDate();
}

document.getElementById("applyCoupon").addEventListener("click", () => {
    const coupon = document.getElementById("couponCode").value.trim().toUpperCase();
    const message = document.getElementById("couponMessage");

    if (coupon === "WELCOME10") {
        discount = 10;
        message.innerHTML = "Coupon applied successfully";
        message.style.color = "green";
    } else {
        discount = 0;
        message.innerHTML = "Invalid coupon";
        message.style.color = "red";
    }

    calculateBill();
});

deliveryCheck.addEventListener("change", () => {
    setDeliveryFields();
    calculateBill();
});

copiesInput.addEventListener("input", calculateBill);
printType.addEventListener("change", calculateBill);
deliveryType.addEventListener("change", calculateBill);

extraServices.forEach(service => {
    service.addEventListener("change", calculateBill);
});

uploadForm.addEventListener("submit", function (event) {
    if (deliveryCheck.checked && deliveryAddress.value.trim() === "") {
        event.preventDefault();
        deliveryAddress.setCustomValidity("Please enter delivery address.");
        deliveryAddress.reportValidity();
        return;
    }

    deliveryAddress.setCustomValidity("");
    document.getElementById("hiddenTotal").value =
        totalAmount.innerText.replace("₹", "");
});

setDeliveryFields();
calculateBill();
