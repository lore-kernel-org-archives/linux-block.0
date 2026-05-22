Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A93806CA
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435877; cv=none; b=XMo32kW5W5IlfWqfHAwa4e2JX40Ist1mX51N2mr6MBL5S7paYiiqpHlfVjqDFkhulTWBEEjXUJMYVan768zkWaQwCeFYsuqJd3Qg65+UHEbp9BwOUpS8058WilUmMxEeJV+XaAhKb2nxH8rQAASZOZ7T1RKMf8J7O53w3iDep3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435877; c=relaxed/simple;
	bh=cG59MKXvsLnNQjbPVy+zN5zPoIgShcL0fQirxowDftU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfuQmgcf1AYWQjT9Ayf92CxufHt8+UOxLko6RE8CToRCLWmRttC/J86cqUloSxkwe6nC2rU7VLBUER8jiU5vG4BsQbr0g3MUIzg20wJAxGWlWB76eXV1d2EkZvJxISWDaLZaZx8QA9CMblsTj8bjZjb+jo3ExkwJ3PbxZH1KqZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T/ddH+fp; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T/ddH+fp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779435876; x=1810971876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cG59MKXvsLnNQjbPVy+zN5zPoIgShcL0fQirxowDftU=;
  b=T/ddH+fprqIGh82R146y7YxuZAN+jvcaJmzw+bKCtlnRxOwq2Z5wLery
   XtcJRADUkbGV3MtfMGZptNFI8LP0O3Y0sBSbSNC97z0XUlYOqwhet/jDr
   5wGkNvPO9MujW1JH+M+oXnPpeWA1+spELqp9nDhLh+5QRpm0eKFQND8eY
   SAJ5bEZd3lZrBNvtF8MLQs+AjPpjUiMUDKhGfriqxyWRXZL1z/WSZiXUT
   tCf1kzTy1gFte6xh1W3ekg3FlCQdj13w4fmrwC0//XKlRTkPjXH0HnQi1
   9r3s1ukQsKHGmQtZmDsMVjO3RABwNuxkuR11V/X7FRgxlmEqV9MNwrT6P
   w==;
X-CSE-ConnectionGUID: WtWWm3B+R6Spn76+Ux0s8g==
X-CSE-MsgGUID: XJ5I6EsHSaOGj9KNJEnN8w==
X-IronPort-AV: E=Sophos;i="6.24,161,1774281600"; 
   d="scan'208";a="148290455"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2026 15:44:28 +0800
X-CSE-ConnectionGUID: V2csKvanQHyF35aP7s1HRA==
X-CSE-MsgGUID: Mp6CLSEiRviSz2mzp17yXQ==
IronPort-SDR: 6a100936_nQCJbwtg4w0upYvLNpZw9BZ+9/GC+jjBHvFSU/hlclv//Go
 cRcH7ekevIItO/uhaS3N4Ez6FlI46WiQJ4zxpbQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2026 00:43:49 -0700
X-CSE-ConnectionGUID: Ez8T1a8CQxm5Lo4MNeNw0g==
X-CSE-MsgGUID: TLYZgRzBS1iCoBihn/VeZA==
WDCIronportException: Internal
Received: from wdap-hzhmxgfxvd.ad.shared (HELO shinmob.wdc.com) ([10.224.105.12])
  by uls-op-esai1-o.wdc.com with ESMTP; 22 May 2026 00:43:49 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Ted Ts'o <tytso@mit.edu>,
	dennis.maisenbacher@wdc.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests RFC 2/2] check: add summary statistics to JSON report and --stats option
Date: Fri, 22 May 2026 16:43:45 +0900
Message-ID: <20260522074345.227515-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522074345.227515-1-shinichiro.kawasaki@wdc.com>
References: <20260522074345.227515-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add summary statistics (total, passed, failed, not run, time) to JSON
output. The JSON now includes a "summary" object with aggregate
statistics.

Add --stats (-s) option to print summary statistics to stdout when
--json option is not specified. This provides a quick way to see test
results summary without generating a full JSON file.

Add STATS_FILE for storing summary statistics and helper functions such
as _write_stats, _increment_stat, and _add_runtime etc, to access the
stats file.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 6ddb064..8dd1b69 100755
--- a/check
+++ b/check
@@ -518,6 +518,7 @@ _call_test() {
 	_write_test_run
 	_output_test_run
 	_write_json_test_run
+	_update_stat
 
 	if [[ ${TEST_RUN["status"]} = fail ]]; then
 		case "${TEST_RUN["reason"]}" in
@@ -1056,6 +1057,95 @@ declare JSON_OUTPUT_FILE
 declare JSON_OUTPUT_TEMP
 # plain text file with single number for JSON array comma placement
 declare COUNTER_FILE
+# plain text file with 5 numbers (total, passed, failed, not_run, time)
+declare STATS_FILE
+
+_init_stats() {
+	[[ -z $STATS && -z $JSON_OUTPUT ]] && return
+
+	STATS_FILE=$(mktemp -p "${TMPDIR:-/tmp}" blktests_stats_XXXXXX)
+	# Initialize summary statistics to 0
+	_write_stats 0 0 0 0 0
+}
+
+_finalize_stats() {
+	 [[ -z $STATS ]] && return
+
+	local -a stats
+	mapfile -t stats < "$STATS_FILE"
+
+	echo "total: ${stats[0]}"
+	echo "passed: ${stats[1]}"
+	echo "failed: ${stats[2]}"
+	echo "not run: ${stats[3]}"
+	echo "time: ${stats[4]}s"
+
+	rm -f "$STATS_FILE"
+}
+
+# write 5 numbers (total, passed, failed, not_run, time)
+_write_stats() {
+	local e
+
+	for e in "${@}"; do
+		echo "${e/ /}"
+	done > "$STATS_FILE"
+}
+
+_increment_stat() {
+	local field=$1
+	local -a stats
+	mapfile -t stats < "$STATS_FILE"
+
+	case "$field" in
+	total)
+		((stats[0]++))
+		;;
+	passed)
+		((stats[1]++))
+		;;
+	failed)
+		((stats[2]++))
+		;;
+	notrun)
+		((stats[3]++))
+		;;
+	esac
+
+	_write_stats "${stats[@]}"
+}
+
+_add_runtime() {
+	local runtime=$1
+	local -a stats
+
+	mapfile -t stats < "$STATS_FILE"
+	stats[4]=$(awk "BEGIN {print ${stats[4]} + ${runtime%s}}")
+	_write_stats "${stats[@]}"
+}
+
+# Update summary statistics in file if stats tracking is enabled
+_update_stat() {
+	[[ -z $STATS_FILE ]] && return
+
+	_increment_stat total
+	case ${TEST_RUN["status"]} in
+	"pass")
+		_increment_stat passed
+		;;
+	"fail")
+		_increment_stat failed
+		;;
+	"not run")
+		_increment_stat notrun
+		;;
+	esac
+
+	# Add runtime to total
+	if [[ -n ${TEST_RUN["runtime"]} ]]; then
+		_add_runtime "${TEST_RUN["runtime"]}"
+	fi
+}
 
 _init_json_output() {
 	[[ -z $JSON_OUTPUT ]] && return
@@ -1075,7 +1165,28 @@ _finalize_json_output() {
 	[[ -z $JSON_OUTPUT ]] && return
 
 	# Close the results array
-	echo '  ]' >> "$JSON_OUTPUT_TEMP"
+	echo '  ],' >> "$JSON_OUTPUT_TEMP"
+
+	# Read summary statistics from file
+	local -a stats
+	mapfile -t stats < "$STATS_FILE"
+	local json_total="${stats[0]}"
+	local json_passed="${stats[1]}"
+	local json_failed="${stats[2]}"
+	local json_notrun="${stats[3]}"
+	local json_total_time="${stats[4]}"
+
+	# Write summary object
+	local summary="  \"summary\": {
+	    \"total\": $json_total,
+	    \"passed\": $json_passed,
+	    \"failed\": $json_failed,
+	    \"not run\": $json_notrun,
+	    \"time\": \"${json_total_time}s\"
+	  }"
+
+	echo "$summary" >> "$JSON_OUTPUT_TEMP"
+
 	# Close the JSON object
 	echo '}' >> "$JSON_OUTPUT_TEMP"
 
@@ -1187,6 +1298,7 @@ _check() {
 	SRCDIR="$(realpath src)"
 
 	_init_json_output
+	_init_stats
 
 	local test_dev test_name
 	local -a all_test_devs_in_array
@@ -1253,6 +1365,7 @@ _check() {
 	fi
 
 	_finalize_json_output
+	_finalize_stats
 
 	return $ret
 }
@@ -1305,6 +1418,8 @@ Test runs:
 
   -j, --json=FILE	 write test results in JSON format to the given file
 
+  -s, --stats		 print summary statistics to stdout
+
 Miscellaneous:
   -c, --config=FILE	 load configuration from FILE instead of the default
 			 (\"./config\"); if this option is used multiple times,
@@ -1326,7 +1441,7 @@ Miscellaneous:
 
 _check_dependencies
 
-if ! TEMP=$(getopt -o 'do:q::x:c:j:h' --long 'device-only,quick::,exclude:,output:,config:,json:,help' -n "$0" -- "$@"); then
+if ! TEMP=$(getopt -o 'do:q::x:c:j:sh' --long 'device-only,quick::,exclude:,output:,config:,json:,stats,help' -n "$0" -- "$@"); then
 	exit 1
 fi
 
@@ -1359,6 +1474,10 @@ while true; do
 			OPTION_JSON="$2"
 			shift 2
 			;;
+		'-s'|'--stats')
+			OPTION_STATS=1
+			shift
+			;;
 		'-c'|'--config')
 			# shellcheck source=/dev/null
 			. "$2"
@@ -1392,6 +1511,7 @@ DEVICE_ONLY="${OPTION_DEVICE_ONLY:-${DEVICE_ONLY:-0}}"
 OUTPUT="${OPTION_OUTPUT:-${OUTPUT:-results}}"
 
 JSON_OUTPUT="${OPTION_JSON:-${JSON_OUTPUT:-}}"
+STATS="${OPTION_STATS:-${STATS:-}}"
 
 QUICK_RUN="${OPTION_QUICK_RUN:-${QUICK_RUN:-0}}"
 if [[ -n $OPTION_QUICK_RUN && $OPTION_QUICK_RUN -ne 0 ]]; then
-- 
2.54.0

