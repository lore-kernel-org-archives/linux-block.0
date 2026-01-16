Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CD332912
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573264; cv=none; b=iPXYwAnSK3bdCsVbPDqkDcdx1U4EZxPoZI8ALlBZ2WA5uE+93i38EFuSeMlzoOSe3ueBhpU8zySORR1HRTlXX+XubfSiQpjfidfWtV/JQFdVzkhyt3P3Oq0sMiv57/gdu0tXW/KVDq06//aYsKkzbYLZ/BjEKlqCxJjuugtydS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573264; c=relaxed/simple;
	bh=XUJ7B6zNu22wFul21UTL7QpsBIWfWqUKi1chgSKLfPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn26Grb7WbZoA4RlILWCg+iXt709AkP35wrh+ksubRzqPXP3Vq6E+AwlQ2Z3E3XSRX9dqqGMg5M8Yn430FZoJSpkEaxL4BfIJ1cITEjg17ckqwgenbvqfQ5mUgjwftiMvD33lF9dcp3sOBVE90RPnAHT9rxeI4HLcY6cqm0VjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0/Lk1u6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0/Lk1u6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGItAHnlEsQSO0lGJhsh33fkFL7q3XrhglboCOujBJ4=;
	b=Q0/Lk1u6hA96a88zCVz3qeb6DyJCQVc0F11hWTJUqbyWBPQlwDVStiexb26zPUyY4RBZ1P
	3goG3ymEDkv58q5jqfF4L12FhKZ3Q823WA7UANUMkbJTG8gtfq6tNL247up2IIL/MlTOvV
	4NdruBoLZap2HK4GE2sNXgL235A6Uaw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-rcZgYS2RMlyNigOkjuYdbg-1; Fri,
 16 Jan 2026 09:20:54 -0500
X-MC-Unique: rcZgYS2RMlyNigOkjuYdbg-1
X-Mimecast-MFC-AGG-ID: rcZgYS2RMlyNigOkjuYdbg_1768573253
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 855B718005BE;
	Fri, 16 Jan 2026 14:20:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8679A180049F;
	Fri, 16 Jan 2026 14:20:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 23/24] selftests: ublk: add --batch/-b for enabling F_BATCH_IO
Date: Fri, 16 Jan 2026 22:18:56 +0800
Message-ID: <20260116141859.719929-24-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add --batch/-b for enabling F_BATCH_IO.

Add batch_01 for covering its basic function.

Add stress_08 and stress_09 for covering stress test.

Add recovery test for F_BATCH_IO in generic_04 and generic_05.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  4 ++
 tools/testing/selftests/ublk/kublk.c          | 15 ++++++-
 tools/testing/selftests/ublk/test_batch_01.sh | 32 +++++++++++++
 .../testing/selftests/ublk/test_generic_04.sh |  5 +++
 .../testing/selftests/ublk/test_generic_05.sh |  5 +++
 .../testing/selftests/ublk/test_stress_08.sh  | 45 +++++++++++++++++++
 .../testing/selftests/ublk/test_stress_09.sh  | 44 ++++++++++++++++++
 7 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_batch_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_09.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index f2da8b403537..520e18e224f2 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -25,6 +25,8 @@ TEST_PROGS += test_generic_14.sh
 TEST_PROGS += test_generic_15.sh
 TEST_PROGS += test_generic_16.sh
 
+TEST_PROGS += test_batch_01.sh
+
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
 TEST_PROGS += test_null_03.sh
@@ -51,6 +53,8 @@ TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
 TEST_PROGS += test_stress_06.sh
 TEST_PROGS += test_stress_07.sh
+TEST_PROGS += test_stress_08.sh
+TEST_PROGS += test_stress_09.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index df5dc128cc89..1c91cd127505 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1595,7 +1595,8 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
 		FEAT_NAME(UBLK_F_INTEGRITY),
-		FEAT_NAME(UBLK_F_SAFE_STOP_DEV)
+		FEAT_NAME(UBLK_F_SAFE_STOP_DEV),
+		FEAT_NAME(UBLK_F_BATCH_IO),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1693,6 +1694,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
 		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
+	printf("\t[--batch|-b]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
@@ -1765,6 +1767,7 @@ int main(int argc, char *argv[])
 		{ "csum_type",		1,	NULL,  0 },
 		{ "tag_size",		1,	NULL,  0 },
 		{ "safe",		0,	NULL,  0 },
+		{ "batch",              0,      NULL, 'b'},
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1788,12 +1791,15 @@ int main(int argc, char *argv[])
 
 	opterr = 0;
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gazu",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gazub",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
 			ctx.all = 1;
 			break;
+		case 'b':
+			ctx.flags |= UBLK_F_BATCH_IO;
+			break;
 		case 'n':
 			ctx.dev_id = strtol(optarg, NULL, 10);
 			break;
@@ -1898,6 +1904,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (ctx.per_io_tasks && (ctx.flags & UBLK_F_BATCH_IO)) {
+		ublk_err("per_io_task and F_BATCH_IO conflict\n");
+		return -EINVAL;
+	}
+
 	/* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT_ZERO_COPY */
 	if (ctx.auto_zc_fallback &&
 	    !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
diff --git a/tools/testing/selftests/ublk/test_batch_01.sh b/tools/testing/selftests/ublk/test_batch_01.sh
new file mode 100755
index 000000000000..9fa9fff5c62f
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_batch_01.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="batch_01"
+ERR_CODE=0
+
+if ! _have_feature "BATCH_IO"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "generic" "test basic function of UBLK_F_BATCH_IO"
+
+_create_backfile 0 256M
+_create_backfile 1 256M
+
+dev_id=$(_add_ublk_dev -t loop -q 2 -b "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+if ! _mkfs_mount_test /dev/ublkb"${dev_id}"; then
+	_cleanup_test "generic"
+	_show_result $TID 255
+fi
+
+dev_id=$(_add_ublk_dev -t stripe -b --auto_zc "${UBLK_BACKFILES[0]}" "${UBLK_BACKFILES[1]}")
+_check_add_dev $TID $?
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "generic"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/testing/selftests/ublk/test_generic_04.sh
index baf5b156193d..be2292822bbe 100755
--- a/tools/testing/selftests/ublk/test_generic_04.sh
+++ b/tools/testing/selftests/ublk/test_generic_04.sh
@@ -26,6 +26,11 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+ublk_run_recover_test -t null -q 2 -r 1 -b &
+ublk_run_recover_test -t loop -q 2 -r 1 -b "${UBLK_BACKFILES[0]}" &
+ublk_run_recover_test -t stripe -q 2 -r 1 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
 ublk_run_recover_test -t null -q 2 -r 1 &
 ublk_run_recover_test -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
 ublk_run_recover_test -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/testing/selftests/ublk/test_generic_05.sh
index 7b5083afc02a..9b7f71c16d82 100755
--- a/tools/testing/selftests/ublk/test_generic_05.sh
+++ b/tools/testing/selftests/ublk/test_generic_05.sh
@@ -30,6 +30,11 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+ublk_run_recover_test -t null -q 2 -r 1 -z -b &
+ublk_run_recover_test -t loop -q 2 -r 1 -z -b "${UBLK_BACKFILES[0]}" &
+ublk_run_recover_test -t stripe -q 2 -r 1 -z -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
 ublk_run_recover_test -t null -q 2 -r 1 -z &
 ublk_run_recover_test -t loop -q 2 -r 1 -z "${UBLK_BACKFILES[0]}" &
 ublk_run_recover_test -t stripe -q 2 -r 1 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
diff --git a/tools/testing/selftests/ublk/test_stress_08.sh b/tools/testing/selftests/ublk/test_stress_08.sh
new file mode 100755
index 000000000000..190db0b4f2ad
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_08.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TID="stress_06"
+ERR_CODE=0
+
+ublk_io_and_remove()
+{
+	run_io_and_remove "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! _have_feature "ZERO_COPY"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "AUTO_BUF_REG"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "BATCH_IO"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "stress" "run IO and remove device(zero copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_io_and_remove 8G -t null -q 4 -b &
+ublk_io_and_remove 256M -t loop -q 4 --auto_zc -b "${UBLK_BACKFILES[0]}" &
+ublk_io_and_remove 256M -t stripe -q 4 --auto_zc -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -b &
+wait
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_09.sh b/tools/testing/selftests/ublk/test_stress_09.sh
new file mode 100755
index 000000000000..1b6bdb31da03
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_09.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TID="stress_07"
+ERR_CODE=0
+
+ublk_io_and_kill_daemon()
+{
+	run_io_and_kill_daemon "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "ZERO_COPY"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "AUTO_BUF_REG"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "BATCH_IO"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "stress" "run IO and kill ublk server(zero copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_io_and_kill_daemon 8G -t null -q 4 -z -b &
+ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc -b "${UBLK_BACKFILES[0]}" &
+ublk_io_and_kill_daemon 256M -t stripe -q 4 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback -b &
+wait
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE
-- 
2.47.0

