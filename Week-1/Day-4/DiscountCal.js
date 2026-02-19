let amount = 4500;
let discount = 0;
let finalPayableAmount;

if (amount >= 5000) {
    discount = amount * 0.20;
}
else if (amount >= 3000) {
    discount = amount * 0.10;
}
else {
    discount = 0;
}

finalPayableAmount = amount - discount;

console.log(discount);
console.log(finalPayableAmount);
