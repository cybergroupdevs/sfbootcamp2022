import { LightningElement, api, wire } from 'lwc';

import { getRecord} from 'lightning/uiRecordApi';



const BankFields = [

    'Bank_Account__c.Name',

    'Bank_Account__c.Customers__c',

];



export default class TransactionComponent extends LightningElement {

    @api recordId;

    @wire(getRecord, { recordId: '$recordId', field: BankFields}) BankAccount;

    get bankAccName() {


        return this.BankAccount.data.field.Name.value;

    }get CustName() {

        return this.BankAccount.data.field.Customers__c.value;

    }



    value = 'abcd';



    get Senderoptions() {

        return [

            { label: 'Current', value: 'Current' },

            { label: 'Saving', value: 'Saving'},

        ];

    }

    handleChange(event) {

        this.value = event.detail.value;

    }

    valueReciever = 'abcd';



    get Recieveroptions() {

        return [

            { label: 'Deposit', value: 'Deposit' },

            { label: 'Loan', value: 'Loan'},

        ];

    }

    handleChange(event) {

        this.valueReciver = event.detail.valueReciever;

    }



}