document.addEventListener('DOMContentLoaded', function () {
  let firstName, lastName;

  const customerIdElement = document.getElementById('customer-id');
  if (customerIdElement) {
    const customer_id = customerIdElement.getAttribute('data-customer-id');

    fetch(`https://dummyjson.com/users/${customer_id}`)
      .then(response => response.json())
      .then(data => {
        firstName = data.firstName;
        lastName = data.lastName;
        const greetingElement = document.getElementById('greeting');
        greetingElement.innerHTML = `Hello ${firstName} ${lastName}`;
      })
      .catch(error => {
        console.error('Error fetching customer data:', error);
      });
  }
});
