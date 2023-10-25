function loadCustomerData() {
  const customerIdElement = document.getElementById('customer-id');

  if (customerIdElement) {
    const customer_id = customerIdElement.getAttribute('data-customer-id');

    fetch(`https://dummyjson.com/users/${customer_id}`)
      .then(response => response.json())
      .then(data => {
        const firstName = data.firstName;
        const lastName = data.lastName;
        const greetingElement = document.getElementById('name');
        greetingElement.innerHTML = `${firstName} ${lastName}`;
      })
      .catch(error => {
        console.error('Error fetching customer data:', error);
      });
  }
}

document.addEventListener('DOMContentLoaded', function () {
  // Load customer data when the page loads
  loadCustomerData();

  const button = document.getElementById('fetch-customer-data');

  if (button) {
    button.addEventListener('click', function () {
      const customerId = button.getAttribute('data-customer-id');

      // Make an API request to get the customer's data
      fetch(`https://dummyjson.com/users/${customerId}`)
        .then(response => response.json())
        .then(data => {
          const firstName = data.firstName;
          const lastName = data.lastName;
          const greetingElement = document.getElementById('name');
          greetingElement.innerHTML = `${firstName} ${lastName}`;
        })
        .catch(error => {
          console.error('Error fetching customer data:', error);
        });
    });
  }
});
