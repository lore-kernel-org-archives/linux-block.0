Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E27261D;
	Fri, 23 Jan 2026 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167363; cv=none; b=WtCIkAc+yDqSjbp71zCjCgXMv+IiqYZ2lXgtP42firEcLDoUAoXz1H8GuzX5UtFZnOzVEtGMV+rW7RK/vNuKt2oio/5xy/2OndcLHGiEx07CZ+rewAXSp3qao3IVG2srlzBJ+8vmgvsFgTvsjU6nYacmAUlenIUYy4nYSFbKjV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167363; c=relaxed/simple;
	bh=UnGIWg0ZcvGDP7TKRHVWTrGtvWsOix2/9eOwXH07BbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKa0pLzaZCcPvr/EHGBxFuegR1SA+ChOvYIv3IFClMN0S1t/5rf5+/N5LDMrIYby1VSOZZKTJr3rxqp8t7L9CVDtgbEp5Q3usvMw7L/pHINkfVfRN+l1vun9OH+WRlzUfIWGZjlI4oQ3dWa775yefA+pKklR/2Jsof1Mphmt/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=G5p9tSql; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="G5p9tSql"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769167357; bh=UnGIWg0ZcvGDP7TKRHVWTrGtvWsOix2/9eOwXH07BbY=;
	h=From:To:Cc:Subject;
	b=G5p9tSqlQF0rbiyQWXtiWpcDQyVeeJm4SHtw8YLXX6OopN9zAZLYTvzI7e992kOjA
	 8VD1fmw1qPfYnnnSjY4ZJlAivD0SpEdnYhsRhSHes0zSWcCQEKrxAXdTEtiyHEyivE
	 mDyn57X2F8EdXmB2EIyMJbttNbG3G7b/RMITUTtQp5Fx0VAdE/t2+986ux9IgHSo11
	 Sp4IKmEjXup6KdtIcc+4VF/M/vSrrCZhuFDSJcRNm3MyKMJlnOr0gjhbObUPh6QuYV
	 K/YhpwYUxixZ2nViTCZR1Pv5xXPBdHtdYjOlEYmWaEZ9OpQ586kQ6wobi63qVCosXs
	 yvHLwEi0wEQREfwtNp+CFBV8nBDxbQKqs10c8lIa1IoEE9BG5LxgxRTrOuvQEkS7b8
	 VZEmSIuQxqwF5vBu2xKX81mEXNADmPUlN1IQ3Fbx4vYKC7D49LJ5FYoHeYZ2IsoHRL
	 mqr0Kf87zYjGdNirj0Thf+CaVqmIYs/NVkBX0zxjMy9ik9jEv4ZkKGy9vpKajvTtFM
	 HsT/Qh/SERFrdtRL0ye8iEhXYeN3UcLi1Qmwnv2jy+vJWYSKjc+ouB6hhuhPKc1EOx
	 OLxX3ohw08nPa8uj8KAQDw63CNBnfSJxOKTz/YoLgPlbD/Jr2MM7ZjHBqBSPJXrdPL
	 oTHYNXzfSUancJYPWxrefEQI=
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Alexander Atanasov <alex@zazolabs.com>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: ublk: use tmpdir for scratch files and improve relative paths use
Date: Fri, 23 Jan 2026 11:20:36 +0000
Message-ID: <20260123112039.1370223-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a temp dir for temporary files and use it instead of
placing them inside source tree.
Reference files in subdirectories relative to script's source dir
for bpftrace uses.
While there fix a typo.

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 tools/testing/selftests/ublk/test_common.sh     | 8 +++++---
 tools/testing/selftests/ublk/test_generic_01.sh | 5 +++--
 tools/testing/selftests/ublk/test_generic_02.sh | 5 +++--
 tools/testing/selftests/ublk/test_generic_12.sh | 5 +++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 7ff6ce79d62c..ab1ea5cc904a 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -43,7 +43,7 @@ _create_backfile() {
 	old_file="${UBLK_BACKFILES[$index]}"
 	[ -f "$old_file" ] && rm -f "$old_file"
 
-	new_file=$(mktemp ublk_file_"${new_size}"_XXXXX)
+	new_file=$(mktemp $TMPDIR/ublk_file_"${new_size}"_XXXXX)
 	truncate -s "${new_size}" "${new_file}"
 	UBLK_BACKFILES["$index"]="$new_file"
 }
@@ -55,6 +55,7 @@ _remove_files() {
 		[ -f "$file" ] && rm -f "$file"
 	done
 	[ -f "$UBLK_TMP" ] && rm -f "$UBLK_TMP"
+	rm -rf "$TMPDIR"
 }
 
 _create_tmp_dir() {
@@ -119,7 +120,7 @@ _prep_test() {
 	local type=$1
 	shift 1
 	modprobe ublk_drv > /dev/null 2>&1
-	UBLK_TMP=$(mktemp ublk_test_XXXXX)
+	UBLK_TMP=$(mktemp $TMPDIR/ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
 }
 
@@ -367,7 +368,7 @@ run_io_and_recover()
 
 	state=$(_recover_ublk_dev -n "$dev_id" "$@")
 	if [ "$state" != "LIVE" ]; then
-		echo "faile to recover to LIVE($state)"
+		echo "failed to recover to LIVE($state)"
 		return 255
 	fi
 
@@ -401,3 +402,4 @@ UBLK_BACKFILES=()
 export UBLK_PROG
 export UBLK_TEST_QUIET
 export UBLK_TEST_SHOW_RESULT
+export TMPDIR=$(mktemp -d ${TMPDIR:-/tmp}/ublktest-dir.XXXXXX)
diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
index 21a31cd5491a..5b06beee91ca 100755
--- a/tools/testing/selftests/ublk/test_generic_01.sh
+++ b/tools/testing/selftests/ublk/test_generic_01.sh
@@ -1,7 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TDIR=$(cd "$(dirname "$0")" && pwd)
+. $TDIR/test_common.sh
 
 TID="generic_01"
 ERR_CODE=0
@@ -20,7 +21,7 @@ dev_id=$(_add_ublk_dev -t null)
 _check_add_dev $TID $?
 
 dev_t=$(_get_disk_dev_t "$dev_id")
-bpftrace trace/seq_io.bt "$dev_t" "W" 1 > "$UBLK_TMP" 2>&1 &
+bpftrace $TDIR/trace/seq_io.bt "$dev_t" "W" 1 > "$UBLK_TMP" 2>&1 &
 btrace_pid=$!
 sleep 2
 
diff --git a/tools/testing/selftests/ublk/test_generic_02.sh b/tools/testing/selftests/ublk/test_generic_02.sh
index 12920768b1a0..1c0e3ab8afc7 100755
--- a/tools/testing/selftests/ublk/test_generic_02.sh
+++ b/tools/testing/selftests/ublk/test_generic_02.sh
@@ -1,7 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TDIR=$(cd "$(dirname "$0")" && pwd)
+. $TDIR/test_common.sh
 
 TID="generic_02"
 ERR_CODE=0
@@ -20,7 +21,7 @@ dev_id=$(_add_ublk_dev -t null -q 2)
 _check_add_dev $TID $?
 
 dev_t=$(_get_disk_dev_t "$dev_id")
-bpftrace trace/seq_io.bt "$dev_t" "W" 1 > "$UBLK_TMP" 2>&1 &
+bpftrace $TDIR/trace/seq_io.bt "$dev_t" "W" 1 > "$UBLK_TMP" 2>&1 &
 btrace_pid=$!
 sleep 2
 
diff --git a/tools/testing/selftests/ublk/test_generic_12.sh b/tools/testing/selftests/ublk/test_generic_12.sh
index b4046201b4d9..d4240ec94827 100755
--- a/tools/testing/selftests/ublk/test_generic_12.sh
+++ b/tools/testing/selftests/ublk/test_generic_12.sh
@@ -1,7 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TDIR=$(cd "$(dirname "$0")" && pwd)
+. $TDIR/test_common.sh
 
 TID="generic_12"
 ERR_CODE=0
@@ -21,7 +22,7 @@ dev_id=$(_add_ublk_dev -t null -q 4 -d 16 --nthreads $NTHREADS --per_io_tasks)
 _check_add_dev $TID $?
 
 dev_t=$(_get_disk_dev_t "$dev_id")
-bpftrace trace/count_ios_per_tid.bt "$dev_t" > "$UBLK_TMP" 2>&1 &
+bpftrace $TDIR/trace/count_ios_per_tid.bt "$dev_t" > "$UBLK_TMP" 2>&1 &
 btrace_pid=$!
 sleep 2
 
-- 
2.43.0

