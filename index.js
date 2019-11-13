const fs = require('fs');
const readline = require('readline');
var execSync = require('child_process').execSync;
const { google } = require('googleapis');
const { Storage } = require('@google-cloud/storage');


// If modifying these scopes, delete token.json.
const SCOPES = ['https://www.googleapis.com/auth/spreadsheets'];
// The file token.json stores the user's access and refresh tokens, and is
// created automatically when the authorization flow completes for the first
// time.
const TOKEN_PATH = 'token.json';

const storage = new Storage();
const bucketName = 'bostonhacks2019-day-of.appspot.com';

// Load client secrets from a local file.
fs.readFile('client_secret_919481446476-l706901bs3orr9o23ikcp3jvmn4e2eks.apps.googleusercontent.com.json', (err, content) => {
    if (err) return console.log('Error loading client secret file:', err);
    // Authorize a client with credentials, then call the Google Sheets API.
    authorize(JSON.parse(content), createPasses);
});

/**
 * Create an OAuth2 client with the given credentials, and then execute the
 * given callback function.
 * @param {Object} credentials The authorization client credentials.
 * @param {function} callback The callback to call with the authorized client.
 */
function authorize(credentials, callback) {
    const { client_secret, client_id, redirect_uris } = credentials.installed;
    const oAuth2Client = new google.auth.OAuth2(
        client_id, client_secret, redirect_uris[0]);

    // Check if we have previously stored a token.
    fs.readFile(TOKEN_PATH, (err, token) => {
        if (err) return getNewToken(oAuth2Client, callback);
        oAuth2Client.setCredentials(JSON.parse(token));
        callback(oAuth2Client);
    });
}

/**
 * Get and store new token after prompting for user authorization, and then
 * execute the given callback with the authorized OAuth2 client.
 * @param {google.auth.OAuth2} oAuth2Client The OAuth2 client to get token for.
 * @param {getEventsCallback} callback The callback for the authorized client.
 */
function getNewToken(oAuth2Client, callback) {
    const authUrl = oAuth2Client.generateAuthUrl({
        access_type: 'offline',
        scope: SCOPES,
    });
    console.log('Authorize this app by visiting this url:', authUrl);
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    rl.question('Enter the code from that page here: ', (code) => {
        rl.close();
        oAuth2Client.getToken(code, (err, token) => {
            if (err) return console.error('Error while trying to retrieve access token', err);
            oAuth2Client.setCredentials(token);
            // Store the token to disk for later program executions
            fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
                if (err) return console.error(err);
                console.log('Token stored to', TOKEN_PATH);
            });
            callback(oAuth2Client);
        });
    });
}

/**
 * Prints the names and majors of students in a sample spreadsheet:
 * @see https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
 * @param {google.auth.OAuth2} auth The authenticated Google OAuth client.
 */
function createPasses(auth) {
    const sheets = google.sheets({ version: 'v4', auth });
    sheets.spreadsheets.values.get({
        spreadsheetId: '1dD94ZpGxgyYovrNs11kOjv6cxj6XtUby7Zqz2TH-exw',
        range: 'A2:D714',
    }, async (err, res) => {
        if (err) return console.log('The API returned an error: ' + err);
        const rows = res.data.values;
        if (rows.length) {
            for (let index = 0; index < rows.length; index++) {
                if (rows[index][3] == 0) {
                    var json = JSON.parse(fs.readFileSync('./Event.pass/pass.json').toString());
                    json.barcode.message = rows[index][0].toString();
                    json.serialNumber = rows[index][0].toString();
                    fs.writeFileSync('./Event.pass/pass.json', JSON.stringify(json));
                    execSync(`./signpass -p Event.pass/ -o ${rows[index][0]}.pkpass`);
                    var filename = `${rows[index][0]}.pkpass`;
                    await storage.bucket(bucketName).upload(filename, {
                        gzip: true,
                        metadata: {
                            cacheControl: 'public, max-age=31536000',
                        },
                    });
                    await storage
                        .bucket(bucketName)
                        .file(filename)
                        .makePublic();
                    let values = [["1"]];
                    let resource = {
                        values,
                    };
                    sheets.spreadsheets.values.update({
                        spreadsheetId: '1dD94ZpGxgyYovrNs11kOjv6cxj6XtUby7Zqz2TH-exw',
                        range: `D${index + 2}`,
                        valueInputOption: 'RAW',
                        resource
                    }, (err, resp) => {
                        if (err) return console.log('The API returned an error: ' + err);
                        values = [[`http://storage.googleapis.com/bostonhacks2019-day-of.appspot.com/${rows[index][0]}.pkpass`]];
                        resource = { values };
                        sheets.spreadsheets.values.update({
                            spreadsheetId: '1dD94ZpGxgyYovrNs11kOjv6cxj6XtUby7Zqz2TH-exw',
                            range: `J${index + 2}`,
                            valueInputOption: 'RAW',
                            resource
                        }, (err, resp) => {
                            if (err) return console.log('The API returned an error: ' + err);
                            values = [[`https://chart.apis.google.com/chart?chs=200x200&cht=qr&chld=|1&chl=${rows[index][0]}`]];
                            resource = { values };
                            sheets.spreadsheets.values.update({
                                spreadsheetId: '1dD94ZpGxgyYovrNs11kOjv6cxj6XtUby7Zqz2TH-exw',
                                range: `K${index + 2}`,
                                valueInputOption: 'RAW',
                                resource
                            }, (err, resp) => {
                                if (err) return console.log('The API returned an error: ' + err);

                            });
                        });
                    });
                    fs.unlinkSync(`${rows[index][0]}.pkpass`);
                } else {
                    console.log("Done");
                }
            }
        } else {
            console.log('No data found.');
        }
    });
}