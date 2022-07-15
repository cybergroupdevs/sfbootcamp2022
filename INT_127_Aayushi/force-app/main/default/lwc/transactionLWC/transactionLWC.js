import { LightningElement, api, wire } from 'lwc';
import { getRecord} from 'lightning/uiRecordApi';

const BankAccount_FIELDS = [

    'Bank_Account__c.Name',

    'Bank_Account__c.LastModifiedById',

];

export default class TransactionLWC extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: BankAccount_FIELDS}) BankAccount;

    get BankAccountName() {

        // OPTION 1

        return this.BankAccount.data.fields.Name.value;
}
get email() {

    // OPTION 1

    return this.BankAccount.data.fields.LastModifiedById.value;
}
value = 'gyih';

    get options() {

        return [

            { label: 'Current', value: 'Current' },

            { label: 'Saving', value: 'Saving'},

        ];

    }

    handleChange(event) {

        this.value = event.detail.value;

    }

    valueReciever = 'gyih';

    get optionsReciever() {

        return [

            { label: 'Deposit', value: 'Deposit' },

            { label: 'Loan', value: 'Loan'},

        ];

    }

    handleChange(event) {
        this.valueReciver = event.detail.valueReciever;
    }

}