Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0DA4A08
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425064; cv=none; b=aRbUm+4LPMgoSQjb/wnjjZQZxQw+yaqxjLow/nXLsPBjMU2XGgCFncg9TqySnQC2id+daHdY6GnMprNFwo9SPg9axxKUBq2TsWaZqBHpMJrJ8nvji/9xuzNoUXalJm2rarBobVC3s+5GT79zBulHPUZXxCJBAv1kRQ0ev8b+cU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425064; c=relaxed/simple;
	bh=Zj3xN/GTLN65dpecMInalL5LBXC9PSVcPLJjd9dh/DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnZh3CdcozPvrP/z6BJPPlvh7/kN5FALZVU95/HO4XAPEUua9YLdLACsuGQ0xfZdxgR+p7Q1Hkia8OK5g6ZBAVnnuKqarHII6JxfQSbrPV9/EWfVEWm0QAGGy9QYsaOU83b6rXW3YMU+LMkSOfJkUCiUN1IV16tSvOu2FM1zyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzRDg7n+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzRDg7n+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744425061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUWLyIvvL4VNb2mx45tum6JpA97JHvk4NRlZCob/SUY=;
	b=BzRDg7n+wqU5XPfr6C8iK+oMJC5Z+kcx39AEQ0EJOHQ1D9jRf806dGn8gXCJ+EleGXMTTP
	9myWu9G3G6Tbj6ZrtqgwHQbF3UpZpXCX4eKXcNAgIjFbsB4VLffMYBq5fwLPOS41aUgA5Y
	NzR/3y2oNBuIxJ2XIHpQt8pAzrZ3N30=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-1JwkWGqKPXO9chF0-3YR7Q-1; Fri,
 11 Apr 2025 22:30:59 -0400
X-MC-Unique: 1JwkWGqKPXO9chF0-3YR7Q-1
X-Mimecast-MFC-AGG-ID: 1JwkWGqKPXO9chF0-3YR7Q_1744425058
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94EA31800EC5;
	Sat, 12 Apr 2025 02:30:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5CD8180175B;
	Sat, 12 Apr 2025 02:30:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 03/13] selftests: ublk: cleanup backfile automatically
Date: Sat, 12 Apr 2025 10:30:19 +0800
Message-ID: <20250412023035.2649275-4-ming.lei@redhat.com>
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Use global array of $UBLK_BACKFILES for storing all backfile name, then
clean them automatically.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh   | 36 ++++++++++++-------
 tools/testing/selftests/ublk/test_loop_01.sh  |  8 ++---
 tools/testing/selftests/ublk/test_loop_02.sh  |  8 ++---
 tools/testing/selftests/ublk/test_loop_03.sh  |  8 ++---
 tools/testing/selftests/ublk/test_loop_04.sh  |  9 +++--
 tools/testing/selftests/ublk/test_loop_05.sh  |  8 ++---
 .../testing/selftests/ublk/test_stress_01.sh  | 16 ++++-----
 .../testing/selftests/ublk/test_stress_02.sh  | 16 ++++-----
 .../testing/selftests/ublk/test_stripe_01.sh  | 12 +++----
 .../testing/selftests/ublk/test_stripe_02.sh  | 13 +++----
 .../testing/selftests/ublk/test_stripe_03.sh  | 12 +++----
 .../testing/selftests/ublk/test_stripe_04.sh  | 13 +++----
 12 files changed, 70 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index a88b35943227..c7d04da7235a 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -30,18 +30,26 @@ _run_fio_verify_io() {
 }
 
 _create_backfile() {
-	local my_size=$1
-	local my_file
+	local index=$1
+	local new_size=$2
+	local old_file
+	local new_file
 
-	my_file=$(mktemp ublk_file_"${my_size}"_XXXXX)
-	truncate -s "${my_size}" "${my_file}"
-	echo "$my_file"
+	old_file="${UBLK_BACKFILES[$index]}"
+	[ -f "$old_file" ] && rm -f "$old_file"
+
+	new_file=$(mktemp ublk_file_"${new_size}"_XXXXX)
+	truncate -s "${new_size}" "${new_file}"
+	UBLK_BACKFILES["$index"]="$new_file"
 }
 
-_remove_backfile() {
-	local file=$1
+_remove_files() {
+	local file
 
-	[ -f "$file" ] && rm -f "$file"
+	for file in "${UBLK_BACKFILES[@]}"; do
+		[ -f "$file" ] && rm -f "$file"
+	done
+	[ -f "$UBLK_TMP" ] && rm -f "$UBLK_TMP"
 }
 
 _create_tmp_dir() {
@@ -129,7 +137,10 @@ _show_result()
 			echo "$1 : [FAIL]"
 		fi
 	fi
-	[ "$2" -ne 0 ] && exit "$2"
+	if [ "$2" -ne 0 ]; then
+		_remove_files
+		exit "$2"
+	fi
 	return 0
 }
 
@@ -138,16 +149,16 @@ _check_add_dev()
 {
 	local tid=$1
 	local code=$2
-	shift 2
+
 	if [ "${code}" -ne 0 ]; then
-		_remove_test_files "$@"
 		_show_result "${tid}" "${code}"
 	fi
 }
 
 _cleanup_test() {
 	"${UBLK_PROG}" del -a
-	rm -f "$UBLK_TMP"
+
+	_remove_files
 }
 
 _have_feature()
@@ -247,6 +258,7 @@ UBLK_TMP=$(mktemp ublk_test_XXXXX)
 UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
 UBLK_TEST_SHOW_RESULT=1
+UBLK_BACKFILES=()
 export UBLK_PROG
 export UBLK_TEST_QUIET
 export UBLK_TEST_SHOW_RESULT
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
index 1ef8b6044777..833fa0dbc700 100755
--- a/tools/testing/selftests/ublk/test_loop_01.sh
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -12,10 +12,10 @@ fi
 
 _prep_test "loop" "write and verify test"
 
-backfile_0=$(_create_backfile 256M)
+_create_backfile 0 256M
 
-dev_id=$(_add_ublk_dev -t loop "$backfile_0")
-_check_add_dev $TID $? "${backfile_0}"
+dev_id=$(_add_ublk_dev -t loop "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
@@ -23,6 +23,4 @@ ERR_CODE=$?
 
 _cleanup_test "loop"
 
-_remove_backfile "$backfile_0"
-
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing/selftests/ublk/test_loop_02.sh
index 03863d825e07..874568b3646b 100755
--- a/tools/testing/selftests/ublk/test_loop_02.sh
+++ b/tools/testing/selftests/ublk/test_loop_02.sh
@@ -8,15 +8,13 @@ ERR_CODE=0
 
 _prep_test "loop" "mkfs & mount & umount"
 
-backfile_0=$(_create_backfile 256M)
-dev_id=$(_add_ublk_dev -t loop "$backfile_0")
-_check_add_dev $TID $? "$backfile_0"
+_create_backfile 0 256M
+dev_id=$(_add_ublk_dev -t loop "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
 _cleanup_test "loop"
 
-_remove_backfile "$backfile_0"
-
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing/selftests/ublk/test_loop_03.sh
index e9ca744de8b1..c30f797c6429 100755
--- a/tools/testing/selftests/ublk/test_loop_03.sh
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -12,9 +12,9 @@ fi
 
 _prep_test "loop" "write and verify over zero copy"
 
-backfile_0=$(_create_backfile 256M)
-dev_id=$(_add_ublk_dev -t loop -z "$backfile_0")
-_check_add_dev $TID $? "$backfile_0"
+_create_backfile 0 256M
+dev_id=$(_add_ublk_dev -t loop -z "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
@@ -22,6 +22,4 @@ ERR_CODE=$?
 
 _cleanup_test "loop"
 
-_remove_backfile "$backfile_0"
-
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_04.sh b/tools/testing/selftests/ublk/test_loop_04.sh
index 1435422c38ec..b01d75b3214d 100755
--- a/tools/testing/selftests/ublk/test_loop_04.sh
+++ b/tools/testing/selftests/ublk/test_loop_04.sh
@@ -8,15 +8,14 @@ ERR_CODE=0
 
 _prep_test "loop" "mkfs & mount & umount with zero copy"
 
-backfile_0=$(_create_backfile 256M)
-dev_id=$(_add_ublk_dev -t loop -z "$backfile_0")
-_check_add_dev $TID $? "$backfile_0"
+_create_backfile 0 256M
+
+dev_id=$(_add_ublk_dev -t loop -z "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
 _cleanup_test "loop"
 
-_remove_backfile "$backfile_0"
-
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_05.sh b/tools/testing/selftests/ublk/test_loop_05.sh
index 2e6e2e6978fc..de2141533074 100755
--- a/tools/testing/selftests/ublk/test_loop_05.sh
+++ b/tools/testing/selftests/ublk/test_loop_05.sh
@@ -12,10 +12,10 @@ fi
 
 _prep_test "loop" "write and verify test"
 
-backfile_0=$(_create_backfile 256M)
+_create_backfile 0 256M
 
-dev_id=$(_add_ublk_dev -q 2 -t loop "$backfile_0")
-_check_add_dev $TID $? "${backfile_0}"
+dev_id=$(_add_ublk_dev -q 2 -t loop "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
@@ -23,6 +23,4 @@ ERR_CODE=$?
 
 _cleanup_test "loop"
 
-_remove_backfile "$backfile_0"
-
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testing/selftests/ublk/test_stress_01.sh
index a8be24532b24..4c37a2cf13a3 100755
--- a/tools/testing/selftests/ublk/test_stress_01.sh
+++ b/tools/testing/selftests/ublk/test_stress_01.sh
@@ -10,17 +10,13 @@ ublk_io_and_remove()
 {
 	local size=$1
 	shift 1
-	local backfile=""
-	if echo "$@" | grep -q "loop"; then
-		backfile=${*: -1}
-	fi
+
 	DEV_ID=$(_add_ublk_dev "$@")
-	_check_add_dev $TID $? "${backfile}"
+	_check_add_dev $TID $?
 
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs. remove device(ublk add $*)"
 	if ! __run_io_and_remove "${DEV_ID}" "${size}" "no"; then
 		echo "/dev/ublkc${DEV_ID} isn't removed"
-		_remove_backfile "${backfile}"
 		exit 255
 	fi
 }
@@ -33,15 +29,15 @@ if [ ${ERR_CODE} -ne 0 ]; then
 	_show_result $TID $ERR_CODE
 fi
 
-BACK_FILE=$(_create_backfile 256M)
-ublk_io_and_remove 256M -t loop -q 4 "${BACK_FILE}"
+_create_backfile 0 256M
+
+ublk_io_and_remove 256M -t loop -q 4 "${UBLK_BACKFILES[0]}"
 ERR_CODE=$?
 if [ ${ERR_CODE} -ne 0 ]; then
 	_show_result $TID $ERR_CODE
 fi
 
-ublk_io_and_remove 256M -t loop -q 4 -z "${BACK_FILE}"
+ublk_io_and_remove 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}"
 ERR_CODE=$?
 _cleanup_test "stress"
-_remove_backfile "${BACK_FILE}"
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
index 2159e4cc8140..4b6ad441d500 100755
--- a/tools/testing/selftests/ublk/test_stress_02.sh
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -10,17 +10,13 @@ ublk_io_and_kill_daemon()
 {
 	local size=$1
 	shift 1
-	local backfile=""
-	if echo "$@" | grep -q "loop"; then
-		backfile=${*: -1}
-	fi
+
 	DEV_ID=$(_add_ublk_dev "$@")
-	_check_add_dev $TID $? "${backfile}"
+	_check_add_dev $TID $?
 
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs kill ublk server(ublk add $*)"
 	if ! __run_io_and_remove "${DEV_ID}" "${size}" "yes"; then
 		echo "/dev/ublkc${DEV_ID} isn't removed res ${res}"
-		_remove_backfile "${backfile}"
 		exit 255
 	fi
 }
@@ -33,15 +29,15 @@ if [ ${ERR_CODE} -ne 0 ]; then
 	_show_result $TID $ERR_CODE
 fi
 
-BACK_FILE=$(_create_backfile 256M)
-ublk_io_and_kill_daemon 256M -t loop -q 4 "${BACK_FILE}"
+_create_backfile 0 256M
+
+ublk_io_and_kill_daemon 256M -t loop -q 4 "${UBLK_BACKFILES[0]}"
 ERR_CODE=$?
 if [ ${ERR_CODE} -ne 0 ]; then
 	_show_result $TID $ERR_CODE
 fi
 
-ublk_io_and_kill_daemon 256M -t loop -q 4 -z "${BACK_FILE}"
+ublk_io_and_kill_daemon 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}"
 ERR_CODE=$?
 _cleanup_test "stress"
-_remove_backfile "${BACK_FILE}"
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_01.sh b/tools/testing/selftests/ublk/test_stripe_01.sh
index 7e387ef656ea..4e4f0fdf3c9b 100755
--- a/tools/testing/selftests/ublk/test_stripe_01.sh
+++ b/tools/testing/selftests/ublk/test_stripe_01.sh
@@ -12,19 +12,15 @@ fi
 
 _prep_test "stripe" "write and verify test"
 
-backfile_0=$(_create_backfile 256M)
-backfile_1=$(_create_backfile 256M)
+_create_backfile 0 256M
+_create_backfile 1 256M
 
-dev_id=$(_add_ublk_dev -t stripe "$backfile_0" "$backfile_1")
-_check_add_dev $TID $? "${backfile_0}"
+dev_id=$(_add_ublk_dev -t stripe "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
+_check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=512M
 ERR_CODE=$?
 
 _cleanup_test "stripe"
-
-_remove_backfile "$backfile_0"
-_remove_backfile "$backfile_1"
-
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_02.sh b/tools/testing/selftests/ublk/test_stripe_02.sh
index e8a45fa82dde..5820ab2efba4 100755
--- a/tools/testing/selftests/ublk/test_stripe_02.sh
+++ b/tools/testing/selftests/ublk/test_stripe_02.sh
@@ -8,17 +8,14 @@ ERR_CODE=0
 
 _prep_test "stripe" "mkfs & mount & umount"
 
-backfile_0=$(_create_backfile 256M)
-backfile_1=$(_create_backfile 256M)
-dev_id=$(_add_ublk_dev -t stripe "$backfile_0" "$backfile_1")
-_check_add_dev $TID $? "$backfile_0" "$backfile_1"
+_create_backfile 0 256M
+_create_backfile 1 256M
+
+dev_id=$(_add_ublk_dev -t stripe "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
+_check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
 _cleanup_test "stripe"
-
-_remove_backfile "$backfile_0"
-_remove_backfile "$backfile_1"
-
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_03.sh b/tools/testing/selftests/ublk/test_stripe_03.sh
index c1b34af36145..20b977e27814 100755
--- a/tools/testing/selftests/ublk/test_stripe_03.sh
+++ b/tools/testing/selftests/ublk/test_stripe_03.sh
@@ -12,19 +12,15 @@ fi
 
 _prep_test "stripe" "write and verify test"
 
-backfile_0=$(_create_backfile 256M)
-backfile_1=$(_create_backfile 256M)
+_create_backfile 0 256M
+_create_backfile 1 256M
 
-dev_id=$(_add_ublk_dev -q 2 -t stripe "$backfile_0" "$backfile_1")
-_check_add_dev $TID $? "${backfile_0}"
+dev_id=$(_add_ublk_dev -q 2 -t stripe "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
+_check_add_dev $TID $?
 
 # run fio over the ublk disk
 _run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=512M
 ERR_CODE=$?
 
 _cleanup_test "stripe"
-
-_remove_backfile "$backfile_0"
-_remove_backfile "$backfile_1"
-
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testing/selftests/ublk/test_stripe_04.sh
index 1f2b642381d1..1b51ed2f1d84 100755
--- a/tools/testing/selftests/ublk/test_stripe_04.sh
+++ b/tools/testing/selftests/ublk/test_stripe_04.sh
@@ -8,17 +8,14 @@ ERR_CODE=0
 
 _prep_test "stripe" "mkfs & mount & umount on zero copy"
 
-backfile_0=$(_create_backfile 256M)
-backfile_1=$(_create_backfile 256M)
-dev_id=$(_add_ublk_dev -t stripe -z -q 2 "$backfile_0" "$backfile_1")
-_check_add_dev $TID $? "$backfile_0" "$backfile_1"
+_create_backfile 0 256M
+_create_backfile 1 256M
+
+dev_id=$(_add_ublk_dev -t stripe -z -q 2 "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
+_check_add_dev $TID $?
 
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
 _cleanup_test "stripe"
-
-_remove_backfile "$backfile_0"
-_remove_backfile "$backfile_1"
-
 _show_result $TID $ERR_CODE
-- 
2.47.0

