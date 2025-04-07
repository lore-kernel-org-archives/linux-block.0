Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C824EA98
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031783; cv=none; b=cfmUHSKQOtAI1VV93KlMtQBRndyhv66X8bwixVkb3t/krIofCvSYXhYaeQAlcZYjdsjKhlVTJqgG5F4AFegOc7k7ufhczL49wA3QPumPCvdMVwGw2+kwjb36DztKaxNFILBwLmwXfErAK+oYqy6panUVTOypJLOSyxj8YralQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031783; c=relaxed/simple;
	bh=UOxG08axcRfeH5XDpOdg9YCCRFE7cRE5gOhtmOmsCso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8Tel3WJYmdxyedHCgIpJMRFuRrcKEYd8QGrBy3y/+crHhUIII5AefGkr1F84Cp9NP3odUAaWUl+2XWCa/Jw21ReNZVNYK+l6mHOBNK2A3DQ3Qs3Wz97Nneb0m47okLYWrnXgPHxyWyqj+JnJFNknGs91ImM8HxHsNCX5g2ZB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FT3BrTrx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FT3BrTrx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HjG8ZzpwWdcYeU7qdEWdh3QqCDdxs3LjqELU/jRK+M=;
	b=FT3BrTrx/9nMamAYVgGUldBp3AP7ERs0S52oru79eGXUEsHxLa4jhjYv/TQo2UGyEtBwol
	VPdUZ5kq5AAa1R4imWcKal6nKmtfULbIxHcjMGMwdqr8HcNLwoPlHdBWSBbB8/iBvg5w3R
	KhiIq12GBEOsHmb3PYyY0ayDU4yLiaA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-q3-gnguKPYOvnJ6zgySjPw-1; Mon,
 07 Apr 2025 09:16:17 -0400
X-MC-Unique: q3-gnguKPYOvnJ6zgySjPw-1
X-Mimecast-MFC-AGG-ID: q3-gnguKPYOvnJ6zgySjPw_1744031776
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6969619560B3;
	Mon,  7 Apr 2025 13:16:16 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C84A1801A6D;
	Mon,  7 Apr 2025 13:16:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 06/13] selftests: ublk: run stress tests in parallel
Date: Mon,  7 Apr 2025 21:15:17 +0800
Message-ID: <20250407131526.1927073-7-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Run stress tests in parallel, meantime add shell local function to
simplify the two stress tests.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh   | 34 +++++++++++++++-
 .../testing/selftests/ublk/test_stress_01.sh  | 39 +++++++------------
 .../testing/selftests/ublk/test_stress_02.sh  | 39 +++++++------------
 3 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index c43bd1d5c9c0..87fd0c824b77 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -230,7 +230,7 @@ __run_io_and_remove()
 	local kill_server=$3
 
 	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
-		--rw=readwrite --iodepth=64 --size="${size}" --numjobs=4 \
+		--rw=readwrite --iodepth=256 --size="${size}" --numjobs=4 \
 		--runtime=20 --time_based > /dev/null 2>&1 &
 	sleep 2
 	if [ "${kill_server}" = "yes" ]; then
@@ -248,6 +248,38 @@ __run_io_and_remove()
 	wait
 }
 
+run_io_and_remove()
+{
+	local size=$1
+	local dev_id
+	shift 1
+
+	dev_id=$(_add_ublk_dev "$@")
+	_check_add_dev "$TID" $?
+
+	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs. remove device(ublk add $*)"
+	if ! __run_io_and_remove "$dev_id" "${size}" "no"; then
+		echo "/dev/ublkc$dev_id isn't removed"
+		exit 255
+	fi
+}
+
+run_io_and_kill_daemon()
+{
+	local size=$1
+	local dev_id
+	shift 1
+
+	dev_id=$(_add_ublk_dev "$@")
+	_check_add_dev "$TID" $?
+
+	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs kill ublk server(ublk add $*)"
+	if ! __run_io_and_remove "$dev_id" "${size}" "yes"; then
+		echo "/dev/ublkc$dev_id isn't removed res ${res}"
+		exit 255
+	fi
+}
+
 _ublk_test_top_dir()
 {
 	cd "$(dirname "$0")" && pwd
diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testing/selftests/ublk/test_stress_01.sh
index 61fdbdfe70bc..7d3150f057d4 100755
--- a/tools/testing/selftests/ublk/test_stress_01.sh
+++ b/tools/testing/selftests/ublk/test_stress_01.sh
@@ -7,37 +7,28 @@ ERR_CODE=0
 
 ublk_io_and_remove()
 {
-	local size=$1
-	local dev_id
-	shift 1
-
-	dev_id=$(_add_ublk_dev "$@")
-	_check_add_dev $TID $?
-
-	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs. remove device(ublk add $*)"
-	if ! __run_io_and_remove "$dev_id" "${size}" "no"; then
-		echo "/dev/ublkc$dev_id isn't removed"
-		exit 255
+	run_io_and_remove "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
 	fi
 }
 
-_prep_test "stress" "run IO and remove device"
-
-ublk_io_and_remove 8G -t null -q 4
-ERR_CODE=$?
-if [ ${ERR_CODE} -ne 0 ]; then
-	_show_result $TID $ERR_CODE
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
 fi
 
+_prep_test "stress" "run IO and remove device"
+
 _create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
 
-ublk_io_and_remove 256M -t loop -q 4 "${UBLK_BACKFILES[0]}"
-ERR_CODE=$?
-if [ ${ERR_CODE} -ne 0 ]; then
-	_show_result $TID $ERR_CODE
-fi
+ublk_io_and_remove 8G -t null -q 4 &
+ublk_io_and_remove 256M -t loop -q 4 "${UBLK_BACKFILES[0]}" &
+ublk_io_and_remove 256M -t stripe -q 4 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
 
-ublk_io_and_remove 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}"
-ERR_CODE=$?
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
index 7643e58637c8..1a9065125ae1 100755
--- a/tools/testing/selftests/ublk/test_stress_02.sh
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -5,39 +5,30 @@
 TID="stress_02"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 ublk_io_and_kill_daemon()
 {
-	local size=$1
-	local dev_id
-	shift 1
-
-	dev_id=$(_add_ublk_dev "$@")
-	_check_add_dev $TID $?
-
-	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs kill ublk server(ublk add $*)"
-	if ! __run_io_and_remove "$dev_id" "${size}" "yes"; then
-		echo "/dev/ublkc$dev_id isn't removed res ${res}"
-		exit 255
+	run_io_and_kill_daemon "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
 	fi
 }
 
 _prep_test "stress" "run IO and kill ublk server"
 
-ublk_io_and_kill_daemon 8G -t null -q 4
-ERR_CODE=$?
-if [ ${ERR_CODE} -ne 0 ]; then
-	_show_result $TID $ERR_CODE
-fi
-
 _create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
 
-ublk_io_and_kill_daemon 256M -t loop -q 4 "${UBLK_BACKFILES[0]}"
-ERR_CODE=$?
-if [ ${ERR_CODE} -ne 0 ]; then
-	_show_result $TID $ERR_CODE
-fi
+ublk_io_and_kill_daemon 8G -t null -q 4 &
+ublk_io_and_kill_daemon 256M -t loop -q 4 "${UBLK_BACKFILES[0]}" &
+ublk_io_and_kill_daemon 256M -t stripe -q 4 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
 
-ublk_io_and_kill_daemon 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}"
-ERR_CODE=$?
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.47.0

