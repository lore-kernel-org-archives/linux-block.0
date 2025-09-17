Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1B369983
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109766; cv=none; b=YacecjsVKdnvNaSCbhv9vTBJQrEwjhrggZMuhVZIKVxyP4Wjm+0+0/Ylj04sn49Sr5yLAs3jHZW/bWNX60qKRy4Gs7eyrHAhNyE1dR04tvcQ4zGmoM7RnFpl3s32fefoVAFNHzIc2BMXUEgKXbThwyEvAlI9K3xR4O32LWjRo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109766; c=relaxed/simple;
	bh=QjzCA2bT1bprctBQHm6kTbuuH8CK6sIkATUpnOGx6hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdpAROt8+RsvWaUhxBfzWfHsoZeMjg87j2sRORjLF97kvb0hnnNZH9ugo2y5YCS8DAHIYDqInjx3uWC+pr6OG7n2yINw4xhNWf7T6NB6BNuObOGp+YoOe2d1jOLt5+FsLf1dIJ0/chHNyn4TxzoKb8VgaewQU2rO+R3K1Liu6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PaXHFSFz; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PaXHFSFz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758109764; x=1789645764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjzCA2bT1bprctBQHm6kTbuuH8CK6sIkATUpnOGx6hM=;
  b=PaXHFSFzvSwIM+e5bF2z0zAFC8QD30gqQIYYvtq5Ux1Kw8Wka2y2XWTm
   mOVUOpRMZYGhUMcMrGFMgsh7l+D6VG0tG6OGmatsHEpzX2Vje8QGEaBpU
   XiCSZacCQrclQTJIO55hVb1DJaWXb7YDjdOeneM/uaW76xZSUnIueU/8r
   Pzp5mxI/+l2ojizuFHZusQpGM01kXFjvYwVt8wnzN9xL6CSkD31f6wLjn
   9kY7AE7fRjaGgZ9Q9I+gMpu3DqSo0WFGLAtOaryXlw/hRbaY2wSNC+Iqq
   R6l6VDnN2byKnAe8tjwsKHpsY04FWsuOcXirwwHEltpIwpw/ewSycod/l
   g==;
X-CSE-ConnectionGUID: xS0tMFg0TdKly56RyKwhBg==
X-CSE-MsgGUID: 0YqQUXl2TfuiGZbLSEm/1g==
X-IronPort-AV: E=Sophos;i="6.18,271,1751212800"; 
   d="scan'208";a="122448569"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 19:49:24 +0800
IronPort-SDR: 68caa044_G+pSsnr0C3YLipDxcCCZOCX0fipO/2bYfh3AVuaaNfpuXjZ
 eBRWRk6rUfQDtS1Hi41csDk+CG3oa1y31j7hDXw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 04:49:24 -0700
WDCIronportException: Internal
Received: from dr34yd3.ad.shared (HELO shinmob.wdc.com) ([10.224.163.71])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2025 04:49:24 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/5] check, new: introduce test_device_array()
Date: Wed, 17 Sep 2025 20:49:14 +0900
Message-ID: <20250917114920.142996-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
References: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As to the test target devices defined in TEST_DEVS variable, blktests
assumes that each test case with test_device() function is run for each
single device defined in TEST_DEVS. On the other hand, it is suggested
to support a test case for not a single device but multiple devices.

To fulfill this request, introduce a new test function
test_device_array() and TEST_CASE_DEV_ARRAY. TEST_CASE_DEV_ARRAY is an
associative array. Test case names are the keys, and the lists of block
devices are the values of the associative array. When a test case
defines test_device_array() and users specify TEST_CASE_DEV_ARRAY in
the config file for the test case, the test_device_array() is called.
Blktests framework checks that each device in TEST_CASE_DEV_ARRAY is a
block device, then call device_requires() and group_device_requires()
for it. Blktests prepares TEST_DEV_ARRAY and TEST_DEV_ARRAY_SYSFS_DIRS
which contain the list of devices and corresponding sysfs paths, so that
test_device_array() can refer to these to run the test.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 148 insertions(+), 11 deletions(-)

diff --git a/check b/check
index cd6f927..eaf6853 100755
--- a/check
+++ b/check
@@ -26,7 +26,7 @@ _found_test() {
 
 	unset CAN_BE_ZONED DESCRIPTION QUICK TIMED requires device_requires \
 	      test test_device fallback_device cleanup_fallback_device \
-	      set_conditions
+	      set_conditions test_device_array
 
 	# shellcheck disable=SC1090
 	if ! . "tests/${test_name}"; then
@@ -39,14 +39,20 @@ _found_test() {
 	fi
 
 	_check_exclusive_functions test test_device || return 1
+	_check_exclusive_functions test test_device_array || return 1
+	_check_exclusive_functions test_device test_device_array || return 1
 
-	if ! declare -fF test >/dev/null && ! declare -fF test_device >/dev/null; then
-		_warning "${test_name} does not define test() or test_device()"
+	if ! declare -fF test >/dev/null && \
+			! declare -fF test_device >/dev/null && \
+			! declare -fF test_device_array >/dev/null; then
+		_warning "${test_name} does not define test(), test_device() or test_device_array()"
 		return 1
 	fi
 
-	if declare -fF device_requires >/dev/null && ! declare -fF test_device >/dev/null; then
-		_warning "${test_name} defines device_requires() but not test_device()"
+	if declare -fF device_requires >/dev/null && \
+			! declare -fF test_device >/dev/null && \
+			! declare -fF test_device_array >/dev/null; then
+		_warning "${test_name} defines device_requires() but not either test_device() or test_device_array()"
 		return 1
 	fi
 
@@ -71,7 +77,9 @@ _found_test() {
 	fi
 
 	if (( ! explicit )); then
-		if [[ $DEVICE_ONLY -ne 0 ]] && ! declare -fF test_device >/dev/null; then
+		if [[ $DEVICE_ONLY -ne 0 ]] && \
+			   ! declare -fF test_device >/dev/null && \
+			   ! declare -fF test_device_array >/dev/null; then
 			return
 		fi
 		if (( QUICK_RUN && !QUICK && !TIMED )); then
@@ -518,6 +526,75 @@ _check_and_call_test_device() {
 	return $ret
 }
 
+_get_test_device_array_key() {
+	local key
+
+	for key in "${!TEST_CASE_DEV_ARRAY[@]}"; do
+		if [[ $TEST_NAME == "$key" ]]; then
+			echo "$TEST_NAME"
+			return
+		fi
+	done
+
+	for key in "${!TEST_CASE_DEV_ARRAY[@]}"; do
+		if [[ $TEST_NAME =~ $key ]]; then
+			echo "$key"
+			return
+		fi
+	done
+
+	return 1
+}
+
+_check_and_call_test_device_array() {
+	local array_name="" key
+	local ret=0 i
+	local -a devs sysfs_dirs
+
+	if declare -fF requires >/dev/null; then
+		requires
+	fi
+
+	TEST_DEV_ARRAY=()
+	if key=$(_get_test_device_array_key); then
+		IFS=" " read -r -a devs <<< "${TEST_CASE_DEV_ARRAY[$key]}"
+		IFS=" " read -r -a sysfs_dirs <<< \
+		   "${TEST_CASE_DEV_ARRAY_SYSFS_DIRS[$key]}"
+		for ((i = 0; i < "${#devs[@]}"; i++)); do
+			TEST_DEV=${devs[$i]}
+			TEST_DEV_SYSFS=${sysfs_dirs[$i]}
+			if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
+				SKIP_REASONS+=("${TEST_DEV} is a zoned block device")
+			elif declare -fF device_requires >/dev/null; then
+				device_requires
+			fi
+			TEST_DEV_ARRAY+=("$TEST_DEV")
+			TEST_DEV_ARRAY_SYSFS_DIRS[$TEST_DEV]=$TEST_DEV_SYSFS
+			[[ -n $array_name ]] && array_name+="_"
+			array_name+="$(basename "$TEST_DEV")"
+		done
+	fi
+
+	if ((${#TEST_DEV_ARRAY[@]} == 0)); then
+		SKIP_REASONS+=("TEST_CASE_DEV_ARRAY is not defined for ${TEST_NAME}")
+	fi
+
+	unset TEST_DEV
+	unset TEST_DEV_SYSFS
+	RESULTS_DIR="$OUTPUT/${array_name}${postfix}"
+	# Avoid "if" and "!" for errexit in test cases
+	_call_test test_device_array
+	# shellcheck disable=SC2181
+	(($? != 0)) && ret=1
+
+	TEST_DEV_ARRAY=()
+	for ((i = 0; i < "${#devs[@]}"; i++)); do
+		unset "TEST_DEV_ARRAY_SYSFS_DIRS[${devs[i]}]"
+	done
+
+	return $ret
+}
+
 _run_test() {
 	TEST_NAME="$1"
 	CAN_BE_ZONED=0
@@ -554,7 +631,7 @@ _run_test() {
 			_check_and_call_test
 			ret=$?
 		fi
-	else
+	elif declare -fF test_device >/dev/null; then
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
 			declare -fF fallback_device >/dev/null; then
 			if ! test_dev=$(fallback_device); then
@@ -594,6 +671,9 @@ _run_test() {
 			unset "TEST_DEV_PART_SYSFS_DIRS[${TEST_DEVS[0]}]"
 			TEST_DEVS=()
 		fi
+	else
+		_check_and_call_test_device_array
+		ret=$?
 	fi
 
 	_unload_modules
@@ -604,6 +684,8 @@ _run_test() {
 _run_group() {
 	local tests=("$@")
 	local group="${tests["0"]%/*}"
+	local test_name
+	local -a devs sysfs_dirs
 
 	# shellcheck disable=SC1090
 	. "tests/${group}/rc"
@@ -637,6 +719,33 @@ _run_group() {
 		# Fix the array indices.
 		TEST_DEVS=("${TEST_DEVS[@]}")
 		unset TEST_DEV
+
+		for test_name in "${!TEST_CASE_DEV_ARRAY[@]}"; do
+			if [[ ! $test_name =~ ^${group}/ ]]; then
+				continue
+			fi
+			IFS=" " read -r -a devs <<< \
+			   "${TEST_CASE_DEV_ARRAY[$test_name]}"
+			IFS=" " read -r -a sysfs_dirs <<< \
+			   "${TEST_CASE_DEV_ARRAY_SYSFS_DIRS[$test_name]}"
+			for ((i = 0; i < ${#devs[@]}; i++)); do
+				TEST_DEV="${devs[$i]}"
+				TEST_DEV_SYSFS="${sysfs_dirs[$i]}"
+				unset TEST_DEV_PART_SYSFS
+				group_device_requires
+				if [[ -v SKIP_REASONS ]]; then
+					_output_notrun "${group}/*** => $(basename "$TEST_DEV")"
+					unset "devs[$i]"
+					unset "sysfs_dirs[$i]"
+					unset SKIP_REASONS
+				fi
+			done
+			# Fix the array elements.
+			TEST_CASE_DEV_ARRAY["$test_name"]="${devs[*]}"
+			TEST_CASE_DEV_ARRAY_SYSFS_DIRS["$test_name"]="${sysfs_dirs[*]}"
+			unset TEST_DEV
+			unset TEST_DEV_SYSFS
+		done
 	fi
 
 	local ret=0
@@ -652,7 +761,8 @@ _run_group() {
 
 _find_sysfs_dirs() {
 	local test_dev="$1"
-	local sysfs_path
+	local array_test_name="$2"
+	local sysfs_path sysfs_paths
 	local major=$((0x$(stat -L -c '%t' "$test_dev")))
 	local minor=$((0x$(stat -L -c '%T' "$test_dev")))
 
@@ -661,7 +771,12 @@ _find_sysfs_dirs() {
 		return 1
 	fi
 
-	if [[ -r "${sysfs_path}"/partition ]]; then
+	if [[ -n $array_test_name ]]; then
+		sysfs_paths=${TEST_CASE_DEV_ARRAY_SYSFS_DIRS["$array_test_name"]}
+		[[ -n $sysfs_paths ]] && sysfs_paths="${sysfs_paths} "
+		sysfs_paths+="$sysfs_path"
+		TEST_CASE_DEV_ARRAY_SYSFS_DIRS["$array_test_name"]="${sysfs_paths}"
+	elif [[ -r "${sysfs_path}"/partition ]]; then
 		# If the device is a partition device, cut the last device name
 		# of the canonical sysfs path to access to the sysfs of its
 		# holder device.
@@ -676,23 +791,45 @@ _find_sysfs_dirs() {
 
 declare -A TEST_DEV_SYSFS_DIRS
 declare -A TEST_DEV_PART_SYSFS_DIRS
+declare -a TEST_DEV_ARRAY
+# shellcheck disable=SC2034
+declare -A TEST_DEV_ARRAY_SYSFS_DIRS
+declare -A TEST_CASE_DEV_ARRAY
+declare -A TEST_CASE_DEV_ARRAY_SYSFS_DIRS
 _check() {
 	# shellcheck disable=SC2034
 	SRCDIR="$(realpath src)"
 
-	local test_dev
-	for test_dev in "${TEST_DEVS[@]}"; do
+	local test_dev test_name
+	local -a all_test_devs_in_array
+
+	for test_name in "${!TEST_CASE_DEV_ARRAY[@]}"; do
+		IFS=" " read -r -a all_test_devs_in_array <<< \
+			   "${TEST_CASE_DEV_ARRAY[$test_name]}"
+	done
+
+	for test_dev in "${TEST_DEVS[@]}" "${all_test_devs_in_array[@]}"; do
 		if [[ ! -e $test_dev ]]; then
 			_error "${test_dev} does not exist"
 		elif [[ ! -b $test_dev ]]; then
 			_error "${test_dev} is not a block device"
 		fi
+	done
 
+	for test_dev in "${TEST_DEVS[@]}"; do
 		if ! _find_sysfs_dirs "$test_dev"; then
 			_error "could not find sysfs directory for ${test_dev}"
 		fi
 	done
 
+	for test_name in "${!TEST_CASE_DEV_ARRAY[@]}"; do
+		for test_dev in ${TEST_CASE_DEV_ARRAY[$test_name]}; do
+			if ! _find_sysfs_dirs "$test_dev" "$test_name"; then
+				_error "could not find sysfs directory for ${test_dev}"
+			fi
+		done
+	done
+
 	local test_name group prev_group
 	local tests=()
 	local ret=0
-- 
2.51.0

