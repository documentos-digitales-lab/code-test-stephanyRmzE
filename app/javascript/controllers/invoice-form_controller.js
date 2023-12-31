import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "quantity", "product", "unitPrice", "submitButton", "total", "amount", "subTotal", "tax"];
  connect() {
    this.validateForm();
  }

  validateForm() {
    const isValid = this.hasIncompleteFields(); // Define the hasIncompleteFields function to check for incomplete fields

    this.submitButtonTarget.disabled = !isValid;

  }

  calculateTotal() {


      let sub_total = 0;


      this.quantityTargets.forEach((field, index) => {

        const quantityValue = field.value;
        const unitPriceField = this.unitPriceTargets[index];
        const unitPriceValue = unitPriceField.value;

        const amountTarget = this.amountTargets[index];

        if (quantityValue && unitPriceValue) {
          const amount = quantityValue * unitPriceValue;
          sub_total += amount;
          amountTarget.textContent = amount.toFixed(2);
        }
      });


      const tax = sub_total * 0.16;
      const total = sub_total + tax;
      this.taxTarget.textContent = tax.toFixed(2);
      this.subTotalTarget.textContent = sub_total.toFixed(2);
      this.totalTarget.textContent = total.toFixed(2);

  }




  hasIncompleteFields() {
    const form = this.element;
    const inputs = form.querySelectorAll("input[required]");

    for (const input of inputs) {
      if (!input.value) {
        return false;
      }
    }

    return true;
  }


  fieldValueChanged(event) {
    event.preventDefault();
    this.validateForm();
    this.calculateTotal();

  }
}
