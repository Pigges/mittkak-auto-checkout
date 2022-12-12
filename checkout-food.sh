OUTPUT_FILE="checkout-food.log" # where to save the log file

API_URL="https://mittkak.nu/v1/checkout-food"
AUTH="Authorization: Basic BASE64AUTH" # BASE64AUTH => your credentials in base64
TOKEN="token: TOKEN" # TOKEN => token needed to checkout food. this is usually found in the school canteen.

CURL_RETURN_CODE=0

CURL_OUTPUT=`curl -s -w httpcode=%{http_code} --request GET \
          --url ${API_URL} \
            --header "${AUTH}" \
              --header "${TOKEN}" 2> /dev/null` || CURL_RETURN_CODE=$?

NOW=$(date +"%m-%d-%Y")

if [ ${CURL_RETURN_CODE} -ne 0 ]; then
    echo "${NOW}: fail --> Curl connection failed with return code - ${CURL_RETURN_CODE}" >> ${OUTPUT_FILE}
else
    # Check http code for curl operation/response in  CURL_OUTPUT
    httpCode=$(echo "${CURL_OUTPUT}" | sed -e 's/.*\httpcode=//')
    # Get response
    RESPONSE=$(echo "${CURL_OUTPUT}" | sed -e 's/httpcode.*//')
    if [ ${httpCode} = 200 ]; then
        CHECKOUT=$(/usr/bin/node /opt/checkout-food/parse.js "${RESPONSE}")
        echo "${NOW}: success --> HTTP ${httpCode} --> ${CHECKOUT}" >> ${OUTPUT_FILE}
    else
        echo "${NOW}: fail --> HTTP ${httpCode} --> ${RESPONSE}" >> ${OUTPUT_FILE}
    fi
fi
