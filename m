Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39476026
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876654; cv=none; b=NPn6kbSks1ndxz0138a6FWD8e25f+QZpymmQFbChCGeFiSHva+AJiYYPqVgIzvf5x200LCJ6TK6P0jzClDoZwZcQqqb89Wf095vMHr/7CXWHY19sZhjb4IdsF8N0lhTo2/Ne179DJiJ/k50X6m4gSHnKrrJm6oh55Vmvosoqt6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876654; c=relaxed/simple;
	bh=MIwefHBQ/b/PUC38lGo4pBEEbo02jfiBRAuokWpTur8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auxPqGT55sOPPW9+oaxFvZNrW6S0KLnv6HjCVKaTVW91zR70uk1r4i/g1TK0cX4tM5LJS865H63Lpcj5sYvQh8KGD1/f/AkMthae3Z52Ipmgfa2JPRQPvNCwGbQk3LJwN7TXzPI4jrIWyDPgULqO7cCF3TjzjzcI+bc28+CkLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYYhMZPM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYYhMZPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79WgihMW3M0BoDdhU3wtuNH5n7v0HbtYWrUAX76Tj+Q=;
	b=NYYhMZPMW7WaeGzVfm2cbHueQahpe3T3rQ9mNGtdBy92ZOCeYWr31v9MOC/L5nrZH4DsPu
	E2AZd4DUaf61Dv5BIChVulsPm4AsYwW/B9ABbEsv405xfUkHM80B3Olvw9eveNVVI3tHM2
	mxdaHWcoGR775nzAp8IBpgGE+KO/wj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-tLIekaRQPy-Jr5lAlo1e1A-1; Sat,
 31 Jan 2026 11:24:08 -0500
X-MC-Unique: tLIekaRQPy-Jr5lAlo1e1A-1
X-Mimecast-MFC-AGG-ID: tLIekaRQPy-Jr5lAlo1e1A_1769876647
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FB7A1956094;
	Sat, 31 Jan 2026 16:24:07 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C4A31956056;
	Sat, 31 Jan 2026 16:24:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/9] selftests: ublk: refactor test_loop_08 into separate functions
Date: Sun,  1 Feb 2026 00:23:33 +0800
Message-ID: <20260131162342.13872-3-ming.lei@redhat.com>
In-Reply-To: <20260131162342.13872-1-ming.lei@redhat.com>
References: <20260131162342.13872-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Encapsulate each test case in its own function for better organization
and maintainability:

- _setup_device(): device and backfile initialization
- _test_fill_and_verify(): initial data population
- _test_corrupted_reftag(): reftag corruption detection test
- _test_corrupted_data(): data corruption detection test
- _test_bad_apptag(): apptag mismatch detection test

Also fix temp file creation to use ${UBLK_TEST_DIR}/fio_err_XXXXX instead of
creating in current directory.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_loop_08.sh | 199 +++++++++++--------
 1 file changed, 115 insertions(+), 84 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_loop_08.sh
index 2caa7ba748fb..aaf1f52da559 100755
--- a/tools/testing/selftests/ublk/test_loop_08.sh
+++ b/tools/testing/selftests/ublk/test_loop_08.sh
@@ -13,98 +13,129 @@ if [[ "$fio_version" =~ fio-[0-9]+\.[0-9]+$ ]]; then
 	exit $UBLK_SKIP_CODE
 fi
 
+ERR_CODE=0
 
-_prep_test "loop" "end-to-end integrity"
+# Global variables set during device setup
+dev_id=""
+fio_args=""
+fio_err=""
 
-_create_backfile 0 256M
-_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
-integrity_params="--integrity_capable --integrity_reftag
-                  --metadata_size 64 --pi_offset 56 --csum_type t10dif"
-dev_id=$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILES[@]}")
-_check_add_dev $TID $?
-
-# 1M * (64 integrity bytes / 512 data bytes) = 128K
-fio_args="--ioengine io_uring --direct 1 --bsrange 512-1M --iodepth 32
-          --md_per_io_size 128K --pi_act 0 --pi_chk GUARD,REFTAG,APPTAG
-          --filename /dev/ublkb$dev_id"
-fio --name fill --rw randwrite $fio_args > /dev/null
-err=$?
-if [ $err != 0 ]; then
-	echo "fio fill failed"
-	_show_result $TID $err
-fi
+_setup_device() {
+	_create_backfile 0 256M
+	_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
 
-fio --name verify --rw randread $fio_args > /dev/null
-err=$?
-if [ $err != 0 ]; then
-	echo "fio verify failed"
-	_show_result $TID $err
-fi
+	local integrity_params="--integrity_capable --integrity_reftag
+		--metadata_size 64 --pi_offset 56 --csum_type t10dif"
+	dev_id=$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILES[@]}")
+	_check_add_dev "$TID" $?
 
-fio_err=$(mktemp fio_err_XXXXX)
+	# 1M * (64 integrity bytes / 512 data bytes) = 128K
+	fio_args="--ioengine io_uring --direct 1 --bsrange 512-1M --iodepth 32
+		--md_per_io_size 128K --pi_act 0 --pi_chk GUARD,REFTAG,APPTAG
+		--filename /dev/ublkb$dev_id"
 
-# Overwrite 4-byte reftag at offset 56 + 4 = 60
-dd_reftag_args="bs=1 seek=60 count=4 oflag=dsync conv=notrunc status=none"
-dd if=/dev/urandom "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
-err=$?
-if [ $err != 0 ]; then
-	echo "dd corrupted_reftag failed"
-	rm -f "$fio_err"
-	_show_result $TID $err
-fi
-if fio --name corrupted_reftag --rw randread $fio_args > /dev/null 2> "$fio_err"; then
-	echo "fio corrupted_reftag unexpectedly succeeded"
-	rm -f "$fio_err"
-	_show_result $TID 255
-fi
-expected_err="REFTAG compare error: LBA: 0 Expected=0, Actual="
-if ! grep -q "$expected_err" "$fio_err"; then
-	echo "fio corrupted_reftag message not found: $expected_err"
-	rm -f "$fio_err"
-	_show_result $TID 255
-fi
-# Reset to 0
-dd if=/dev/zero "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
-err=$?
-if [ $err != 0 ]; then
-	echo "dd restore corrupted_reftag failed"
-	rm -f "$fio_err"
-	_show_result $TID $err
-fi
+	fio_err=$(mktemp "${UBLK_TEST_DIR}"/fio_err_XXXXX)
+}
 
-dd_data_args="bs=512 count=1 oflag=direct,dsync conv=notrunc status=none"
-dd if=/dev/zero "of=${UBLK_BACKFILES[0]}" $dd_data_args
-err=$?
-if [ $err != 0 ]; then
-	echo "dd corrupted_data failed"
-	rm -f "$fio_err"
-	_show_result $TID $err
-fi
-if fio --name corrupted_data --rw randread $fio_args > /dev/null 2> "$fio_err"; then
-	echo "fio corrupted_data unexpectedly succeeded"
-	rm -f "$fio_err"
-	_show_result $TID 255
-fi
-expected_err="Guard compare error: LBA: 0 Expected=0, Actual="
-if ! grep -q "$expected_err" "$fio_err"; then
-	echo "fio corrupted_data message not found: $expected_err"
-	rm -f "$fio_err"
-	_show_result $TID 255
-fi
+_test_fill_and_verify() {
+	fio --name fill --rw randwrite $fio_args > /dev/null
+	if [ $? != 0 ]; then
+		echo "fio fill failed"
+		ERR_CODE=255
+		return 1
+	fi
 
-if fio --name bad_apptag --rw randread $fio_args --apptag 0x4321 > /dev/null 2> "$fio_err"; then
-	echo "fio bad_apptag unexpectedly succeeded"
-	rm -f "$fio_err"
-	_show_result $TID 255
-fi
-expected_err="APPTAG compare error: LBA: [0-9]* Expected=4321, Actual=1234"
-if ! grep -q "$expected_err" "$fio_err"; then
-	echo "fio bad_apptag message not found: $expected_err"
-	rm -f "$fio_err"
-	_show_result $TID 255
-fi
+	fio --name verify --rw randread $fio_args > /dev/null
+	if [ $? != 0 ]; then
+		echo "fio verify failed"
+		ERR_CODE=255
+		return 1
+	fi
+}
+
+_test_corrupted_reftag() {
+	local dd_reftag_args="bs=1 seek=60 count=4 oflag=dsync conv=notrunc status=none"
+	local expected_err="REFTAG compare error: LBA: 0 Expected=0, Actual="
+
+	# Overwrite 4-byte reftag at offset 56 + 4 = 60
+	dd if=/dev/urandom "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
+	if [ $? != 0 ]; then
+		echo "dd corrupted_reftag failed"
+		ERR_CODE=255
+		return 1
+	fi
+
+	if fio --name corrupted_reftag --rw randread $fio_args > /dev/null 2> "$fio_err"; then
+		echo "fio corrupted_reftag unexpectedly succeeded"
+		ERR_CODE=255
+		return 1
+	fi
+
+	if ! grep -q "$expected_err" "$fio_err"; then
+		echo "fio corrupted_reftag message not found: $expected_err"
+		ERR_CODE=255
+		return 1
+	fi
+
+	# Reset to 0
+	dd if=/dev/zero "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
+	if [ $? != 0 ]; then
+		echo "dd restore corrupted_reftag failed"
+		ERR_CODE=255
+		return 1
+	fi
+}
+
+_test_corrupted_data() {
+	local dd_data_args="bs=512 count=1 oflag=direct,dsync conv=notrunc status=none"
+	local expected_err="Guard compare error: LBA: 0 Expected=0, Actual="
+
+	dd if=/dev/zero "of=${UBLK_BACKFILES[0]}" $dd_data_args
+	if [ $? != 0 ]; then
+		echo "dd corrupted_data failed"
+		ERR_CODE=255
+		return 1
+	fi
+
+	if fio --name corrupted_data --rw randread $fio_args > /dev/null 2> "$fio_err"; then
+		echo "fio corrupted_data unexpectedly succeeded"
+		ERR_CODE=255
+		return 1
+	fi
+
+	if ! grep -q "$expected_err" "$fio_err"; then
+		echo "fio corrupted_data message not found: $expected_err"
+		ERR_CODE=255
+		return 1
+	fi
+}
+
+_test_bad_apptag() {
+	local expected_err="APPTAG compare error: LBA: [0-9]* Expected=4321, Actual=1234"
+
+	if fio --name bad_apptag --rw randread $fio_args --apptag 0x4321 > /dev/null 2> "$fio_err"; then
+		echo "fio bad_apptag unexpectedly succeeded"
+		ERR_CODE=255
+		return 1
+	fi
+
+	if ! grep -q "$expected_err" "$fio_err"; then
+		echo "fio bad_apptag message not found: $expected_err"
+		ERR_CODE=255
+		return 1
+	fi
+}
+
+_prep_test "loop" "end-to-end integrity"
+
+_setup_device
+
+_test_fill_and_verify && \
+_test_corrupted_reftag && \
+_test_corrupted_data && \
+_test_bad_apptag
 
 rm -f "$fio_err"
 
 _cleanup_test
-_show_result $TID 0
+_show_result "$TID" $ERR_CODE
-- 
2.47.0

