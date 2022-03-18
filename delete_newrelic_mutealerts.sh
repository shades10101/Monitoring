#!/bin/bash
#

#Decalre variables
search_condition=test
ruleids=()

#GraphQL API call utilizing NRQL to get all mute rule IDs and saving it to response.json
curl https://api.newrelic.com/graphql -H 'Content-Type: application/json' -H 'API-Key: NRAK-~~~~' --data-binary '{"query":"{\n  actor {\n    account(id: 2884944) {\n      alerts {\n        mutingRules {\n          name\n          id\n        }\n      }\n    }\n  }\n}\n", "variables":""}' | json_pp > response.json

# Grepping for our search condition and the rule ID that accompanies it, then saving to text file
grep -E .*\n.*"$search_condition".* response.json -B 1 > tmp.txt
# Grepping for just the 8 digit rule ids
grep -Eo "[0-9]{8}" tmp.txt > results.txt

# Create an array out of results.txt
mapfile -t ruleids < results.txt

# Loop for each item in the array
# Delete each mute rule
for i in "${ruleids[@]}"
do
    echo "$i"
    # GraphQL API call to delete mute rules.
    curl https://api.newrelic.com/graphql -H 'Content-Type: application/json' -H 'API-Key: NRAK-~~~~' --data-binary '{"query":"mutation {\n  alertsMutingRuleDelete(accountId: 2884944, id: '$i') {\n    id\n  }\n}\n", "variables":""}'
done
