const products = [
  { name: "Pen", price: 10, quantity: 2 },
  { name: "Book", price: 50, quantity: 1 }
];

const calculateTotal = () => {
  return products.reduce((sum, item) => sum + item.price * item.quantity, 0);
};

const getInvoice = () => {
  return products.map(item =>
    `${item.name} - ${item.price} x ${item.quantity} = ${item.price * item.quantity}`
  );
};

console.log("Invoice:");

getInvoice().forEach(line => console.log(line));

console.log("Total:", calculateTotal());