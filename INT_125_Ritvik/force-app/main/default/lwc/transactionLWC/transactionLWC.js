import { LightningElement } from 'lwc';

export default class TransactionLWC extends LightningElement {
    greeting = 'World';

  changeHandler(event) {

    this.greeting = event.target.value;

  }
}