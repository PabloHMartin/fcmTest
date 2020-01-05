import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();


// const db = admin.firestore();
const fcm = admin.messaging();
export interface Puppy {
    name?: string
}

/**
 * send notification to topic on firestore document create
 */
export const sendToTopic = functions.firestore
    .document('puppies/{puppyId}')
    .onCreate(async (snapshot) => {
        const puppy = snapshot.data();
        const payload: admin.messaging.MessagingPayload = {
            notification: {
                title: 'New Puppy!',
                body: `${puppy?.name} is ready for adoption!`,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }

        };
        return fcm.sendToTopic('puppies', payload);
    });