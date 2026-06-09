#!/bin/sh -u

results_dir=/tmp/results
linters=$(find /usr/local/bin/linters/ -name '*.sh' -exec basename -s .sh {} \;)

mkdir -p "$results_dir"

parallel --will-cite \
         --tag \
         --jobs +0 \
         --joblog "$results_dir/joblog" \
         --results "$results_dir" \
         /usr/local/bin/linters/{}.sh ::: $linters

overall_exit=$?

echo "Linters run summary" >> $GITHUB_STEP_SUMMARY
echo " | Linter | Result | " >> $GITHUB_STEP_SUMMARY
echo " | ------ | ------ | " >> $GITHUB_STEP_SUMMARY

tail -n +2 "$results_dir/joblog" | while IFS='	' read -r seq host starttime runtime send recv exitval signal command; do
    linter=$(basename "$command" -s .sh)
    target_url="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"
    context="Linter status: ${linter}"
    commit_status="success"
    description="No linting errors"
    summary_result=':white_check_mark:'

    if test "$exitval" != '0'; then
        commit_status="error"
        description="Some linting errors found"
        summary_result=':no_entry_sign:'
    fi

    gh api \
       --method POST \
       -H "Accept: application/vnd.github+json" \
       /repos/${GITHUB_REPOSITORY}/statuses/${GITHUB_SHA} \
       -f "state=${commit_status}" \
       -f "target_url=${target_url}" \
       -f "description=${description}" \
       -f "context=${context}"

    echo " | $linter | $summary_result | " >> $GITHUB_STEP_SUMMARY
done

for linter in $linters; do
    output_file="$(find $results_dir -type d -name "$linter")/stdout"
    echo "::group::$linter"
    cat $output_file
    echo "::endgroup::"
done

exit $overall_exit
