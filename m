Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00E34F26F
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435877; cv=none; b=WRjVXkbSCBCbopCocLTeHvizwLLynmfGKQ1mUKs5Sjg3AnmDZCYT4zJSsliQx/oldn5YsFUMn1EWkB4vnJsw0Qflme45pJbsxviCCFJPhSjCQREgofu8fmEoqoZzkYxs1OM9D/z7z8I7fXxAyHBo67qNLcaxhUg6cQuxD5Okfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435877; c=relaxed/simple;
	bh=xX7MhM6hs11x4RYYewlXi66Oqp2vskLiZ4DjCSUJ+pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMS7ucyH6JPagWAHfRfSW64sGiB02j9PQEHNRrvijgxwF9o2XV8dMgbfz25EcbtOnE71x2VdafmOHLAfbpvcMIRhITmXtnMv8vrwDBRDHsZmqCSXgvMxhPAn406kNKacfw90KLtrBrmUVAIear+ftzZeY46C4SxiWwdU1lX6PXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hPtFQW5s; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hPtFQW5s"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779435876; x=1810971876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xX7MhM6hs11x4RYYewlXi66Oqp2vskLiZ4DjCSUJ+pA=;
  b=hPtFQW5sHwoRdxTN+/jqjXT9V9o15dOralfHp2mxvLuZVx/9XF0H2ucn
   /HKIwRc3K2VBkYJbEek/fsnXj9FDdiimS9LXaMiPxzdnglZ5rnK9IjnLL
   2P8rNojUnBA68afVGy+f+0Ey4WPEgPiByWGkl2bvB1+Oqmz0Zt1LyrEkB
   4Q7GKg2AQSGl4xb4FRlnTcVq+jxrDbeOFUqQl1R46DiuJemWjJhVQnjak
   lFqK/3FehJ/4LsgVxAz1JupNoP0HRgnn1l5Wu6trImnwXii19gIY6CQCO
   qulQL05xcMv8Z5bJzOkUNYXErKv+N2M3zg9+BlBiHwzJVlHA6GzHVRYXI
   w==;
X-CSE-ConnectionGUID: vSUZFQf4R9maCCoG30nRIA==
X-CSE-MsgGUID: lXNEnICAS1SoRIc3HDa1GQ==
X-IronPort-AV: E=Sophos;i="6.24,161,1774281600"; 
   d="scan'208";a="148290454"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2026 15:44:28 +0800
X-CSE-ConnectionGUID: v2m1tZ8fQeWp9+fzncdE8g==
X-CSE-MsgGUID: CNVvEgkPRUOPpbMuWw28xA==
IronPort-SDR: 6a100935_Ije22l3fjPfUkr/7tsZStyb6rwtJkQCNdIlEnEyXsknyOrN
 GjHnAyNM4bp2O4DwItHjwYx1i9vX3IJ1HMYvNTw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2026 00:43:48 -0700
X-CSE-ConnectionGUID: 0Hu+nfStRsqx18wzhNQrRg==
X-CSE-MsgGUID: Zv0/Nj+kTpqbPlIpE7jeow==
WDCIronportException: Internal
Received: from wdap-hzhmxgfxvd.ad.shared (HELO shinmob.wdc.com) ([10.224.105.12])
  by uls-op-esai1-o.wdc.com with ESMTP; 22 May 2026 00:43:48 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Ted Ts'o <tytso@mit.edu>,
	dennis.maisenbacher@wdc.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests RFC 1/2] check: add JSON format output option for test results
Date: Fri, 22 May 2026 16:43:44 +0900
Message-ID: <20260522074345.227515-2-shinichiro.kawasaki@wdc.com>
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

Add --json command-line option to write test results in JSON format to a
specified file. The JSON output uses the "results" array containing test
result objects with name, status, description, runtime, and additional
fields like exit_status or skip_reasons depending on the test outcome.

To write result objects separated with commas, it is required to know
the number of the objects to properly handle the comma placement. For
that purpose, use a file-based counter since tests run in subshells and
environment variables don't share state across subshells. This counter
file and the temporary JSON output file are created using mktemp.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 1 deletion(-)

diff --git a/check b/check
index c166fae..6ddb064 100755
--- a/check
+++ b/check
@@ -302,6 +302,34 @@ _output_status() {
 	echo "]"
 }
 
+_write_json_test_run() {
+	local device
+	local skip_reasons
+
+	if [[ ${TEST_RUN["status"]} == "not run" && -v SKIP_REASONS ]]; then
+		skip_reasons=$(IFS=';'; echo "${SKIP_REASONS[*]}")
+	fi
+	if [[ "${TEST_DEV:-}" ]]; then
+		device="$(basename "$TEST_DEV")"
+	elif [[ "${TEST_DEV_ARRAY:-}" ]]; then
+		local dev
+		local -a devs
+		for dev in "${TEST_DEV_ARRAY[@]}"; do
+			devs+=("${dev##*/}")
+		done
+		device=$(IFS=' '; echo "${devs[*]}")
+	fi
+
+	_write_json_entry "$TEST_NAME" \
+		"${TEST_RUN["status"]}" \
+		"${TEST_RUN["description"]}" \
+		"${TEST_RUN["runtime"]}" \
+		"${TEST_RUN["reason"]:-}" \
+		"${TEST_RUN["exit_status"]:-}" \
+		"$device" \
+		"$skip_reasons"
+}
+
 _output_skip_reasons()
 {
 	for reason in "${SKIP_REASONS[@]}"; do
@@ -489,6 +517,7 @@ _call_test() {
 
 	_write_test_run
 	_output_test_run
+	_write_json_test_run
 
 	if [[ ${TEST_RUN["status"]} = fail ]]; then
 		case "${TEST_RUN["reason"]}" in
@@ -723,7 +752,10 @@ _check_and_call_test_device() {
 	for TEST_DEV in "${TEST_DEVS[@]}"; do
 		if [[ $TEST_DEV == fallback ]]; then
 			if [[ -v SKIP_REASONS ]]; then
+				local skip_reasons
+				skip_reasons=$(IFS=';'; echo "${SKIP_REASONS[*]}")
 				_output_notrun "$TEST_NAME"
+				_write_json_skip_entry "$TEST_NAME" "$skip_reasons"
 				return 0
 			fi
 
@@ -1019,10 +1051,143 @@ declare -a TEST_DEV_ARRAY
 declare -A TEST_DEV_ARRAY_SYSFS_DIRS
 declare -A TEST_CASE_DEV_ARRAY
 declare -A TEST_CASE_DEV_ARRAY_SYSFS_DIRS
+
+declare JSON_OUTPUT_FILE
+declare JSON_OUTPUT_TEMP
+# plain text file with single number for JSON array comma placement
+declare COUNTER_FILE
+
+_init_json_output() {
+	[[ -z $JSON_OUTPUT ]] && return
+
+	JSON_OUTPUT_FILE="$JSON_OUTPUT"
+	JSON_OUTPUT_TEMP=$(mktemp blktests_json_XXXXXX)
+	COUNTER_FILE=$(mktemp blktests_counter_XXXXXX)
+
+	# Create/truncate the JSON file and write opening structure
+	echo '{' > "$JSON_OUTPUT_TEMP"
+	echo '  "results": [' >> "$JSON_OUTPUT_TEMP"
+
+	echo "0" > "$COUNTER_FILE"
+}
+
+_finalize_json_output() {
+	[[ -z $JSON_OUTPUT ]] && return
+
+	# Close the results array
+	echo '  ]' >> "$JSON_OUTPUT_TEMP"
+	# Close the JSON object
+	echo '}' >> "$JSON_OUTPUT_TEMP"
+
+	cp "$JSON_OUTPUT_TEMP" "$JSON_OUTPUT_FILE"
+	rm -f "$COUNTER_FILE" "$JSON_OUTPUT_TEMP"
+}
+
+_inc_counter() {
+	local counter
+
+	counter=$(<"$COUNTER_FILE")
+	((counter++))
+	echo "$counter" > "$COUNTER_FILE"
+	echo "$counter"
+}
+
+_add_json_entry() {
+	local counter=$1
+	local json_entry="$2"
+
+	# Add comma to previous entry if not the first entry
+	if ((counter > 1 )); then
+		# Add comma after the previous closing brace
+		sed -i '$ s/}/},/' "$JSON_OUTPUT_TEMP"
+	fi
+
+	echo "$json_entry" >> "$JSON_OUTPUT_TEMP"
+}
+
+_write_json_entry() {
+	local test_name="$1"
+	local status="$2"
+	local description="$3"
+	local runtime="$4"
+	local reason="$5"
+	local exit_status="$6"
+	local device="$7"
+	local skip_reasons="$8"
+	local counter
+
+	[[ -z $JSON_OUTPUT ]] && return
+
+	counter=$(_inc_counter)
+
+	local json_entry="    {
+      \"name\": \"$test_name\",
+      \"status\": \"$status\",
+      \"description\": \"$description\",
+      \"runtime\": \"$runtime\""
+
+	if [[ -n $reason ]]; then
+		json_entry+=","
+		json_entry+="
+      \"reason\": \"$reason\""
+	fi
+
+	if [[ -n $exit_status ]]; then
+		json_entry+=","
+		json_entry+="
+      \"exit_status\": $exit_status"
+	fi
+
+	if [[ -n $device ]]; then
+		json_entry+=","
+		json_entry+="
+      \"device\": \"$device\""
+	fi
+
+	if [[ -n $skip_reasons ]]; then
+		json_entry+=","
+		json_entry+="
+      \"skip_reasons\": \"$skip_reasons\""
+	fi
+
+	json_entry+="
+    }"
+
+	_add_json_entry "$counter" "$json_entry"
+}
+
+_write_json_skip_entry() {
+	local test_name="$1"
+	local skip_reasons="$2"
+
+	[[ -z $JSON_OUTPUT ]] && return
+
+	counter=$(_inc_counter)
+
+	local json_entry="    {
+      \"name\": \"$test_name\",
+      \"status\": \"not run\",
+      \"description\": \"\",
+      \"runtime\": \"\""
+
+	if [[ -n $skip_reasons ]]; then
+		json_entry+=","
+		json_entry+="
+      \"skip_reasons\": \"$skip_reasons\""
+	fi
+
+	json_entry+="
+    }"
+
+	_add_json_entry "$counter" "$json_entry"
+}
+
 _check() {
 	# shellcheck disable=SC2034
 	SRCDIR="$(realpath src)"
 
+	_init_json_output
+
 	local test_dev test_name
 	local -a all_test_devs_in_array
 	local km_log="${OUTPUT}/start.kmemleak"
@@ -1087,6 +1252,8 @@ _check() {
 		(($? != 0)) && ret=1
 	fi
 
+	_finalize_json_output
+
 	return $ret
 }
 
@@ -1136,6 +1303,8 @@ Test runs:
   -x, --exclude=TEST	 exclude a test (or test group) from the list of
 			 tests to run
 
+  -j, --json=FILE	 write test results in JSON format to the given file
+
 Miscellaneous:
   -c, --config=FILE	 load configuration from FILE instead of the default
 			 (\"./config\"); if this option is used multiple times,
@@ -1157,7 +1326,7 @@ Miscellaneous:
 
 _check_dependencies
 
-if ! TEMP=$(getopt -o 'do:q::x:c:h' --long 'device-only,quick::,exclude:,output:,config:,help' -n "$0" -- "$@"); then
+if ! TEMP=$(getopt -o 'do:q::x:c:j:h' --long 'device-only,quick::,exclude:,output:,config:,json:,help' -n "$0" -- "$@"); then
 	exit 1
 fi
 
@@ -1186,6 +1355,10 @@ while true; do
 			OPTION_EXCLUDE+=("$2")
 			shift 2
 			;;
+		'-j'|'--json')
+			OPTION_JSON="$2"
+			shift 2
+			;;
 		'-c'|'--config')
 			# shellcheck source=/dev/null
 			. "$2"
@@ -1218,6 +1391,8 @@ DEVICE_ONLY="${OPTION_DEVICE_ONLY:-${DEVICE_ONLY:-0}}"
 
 OUTPUT="${OPTION_OUTPUT:-${OUTPUT:-results}}"
 
+JSON_OUTPUT="${OPTION_JSON:-${JSON_OUTPUT:-}}"
+
 QUICK_RUN="${OPTION_QUICK_RUN:-${QUICK_RUN:-0}}"
 if [[ -n $OPTION_QUICK_RUN && $OPTION_QUICK_RUN -ne 0 ]]; then
 	TIMEOUT="${OPTION_TIMEOUT:-${TIMEOUT:-30}}"
-- 
2.54.0

