Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA33128B2
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678127; cv=none; b=Bxkaxpvq7891T0ATHN1LAz9hZtJEOADj3U6lfQc7kMC4nkm8fN1dVOovopxUrzjiCFwtk25JrYCmC2iIMVi+GV9TdM7ZKkE7+yCbmzo7upNfMZvynXcc/V7tonO7kJG1KrERxpSLgQ4xAIYOBCr6gsqFJ/K0dP6DDulZfO7sDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678127; c=relaxed/simple;
	bh=td9BdQ73RevVUqY4XXeS1HnJhm/84KEq7qT7lMsqt7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRymOXNEonfjssVK4huKlaSbTyt6ZmnCAs0EP0gY5oa6kxq4yeDZ5EWEsreyRj12VirWEYbMsY3v7+cL18N5GR8tvbuFFciE+VXjlYkv49hCE7eNvLycS1jxbcelssSLBkwfzGUXCiXGkheKYZrYl0hqVwz9Wb4RHRDzFEHdxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxoY9rLX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxoY9rLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764678124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQJnBIBYAnoQSmrJaZgHtFaDWnARquQeEzKnKbb8Z5A=;
	b=fxoY9rLXHBADSuvmOB9Uh4d96JT6WlwEf/MFuFEHRytKCJMu9ExmaAy4jeVaRHABG7pQHM
	44gPxXmTvqTlZqTE+z+3txNk2Qxz1c/CoyVbUREKid3rkFiRCTsQ37iV9Ju3ysytuFvAA8
	fLMQsKprY4P5Ii30Xh6mfBc6QjA2SIk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-dIZt_Eu8MAWBTKBrnZZAmw-1; Tue,
 02 Dec 2025 07:22:02 -0500
X-MC-Unique: dIZt_Eu8MAWBTKBrnZZAmw-1
X-Mimecast-MFC-AGG-ID: dIZt_Eu8MAWBTKBrnZZAmw_1764678121
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B656D195609F;
	Tue,  2 Dec 2025 12:22:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE9FB1800451;
	Tue,  2 Dec 2025 12:22:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 20/21] selftests: ublk: add --batch/-b for enabling F_BATCH_IO
Date: Tue,  2 Dec 2025 20:19:14 +0800
Message-ID: <20251202121917.1412280-21-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-1-ming.lei@redhat.com>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add --batch/-b for enabling F_BATCH_IO.

Add generic_14 for covering its basic function.

Add stress_06 and stress_07 for covering stress test.

Add recovery test for F_BATCH_IO in generic_04 and generic_05.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  3 ++
 tools/testing/selftests/ublk/kublk.c          | 13 +++++-
 .../testing/selftests/ublk/test_generic_04.sh |  5 +++
 .../testing/selftests/ublk/test_generic_05.sh |  5 +++
 .../testing/selftests/ublk/test_generic_14.sh | 32 +++++++++++++
 .../testing/selftests/ublk/test_stress_06.sh  | 45 +++++++++++++++++++
 .../testing/selftests/ublk/test_stress_07.sh  | 44 ++++++++++++++++++
 7 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index a724276622d0..cbf57113b1a6 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -21,6 +21,7 @@ TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
+TEST_PROGS += test_generic_14.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
@@ -39,6 +40,8 @@ TEST_PROGS += test_stress_02.sh
 TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
+TEST_PROGS += test_stress_06.sh
+TEST_PROGS += test_stress_07.sh
 
 TEST_GEN_PROGS_EXTENDED = kublk
 
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index cb329c7aebc4..4c45482a847c 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1476,6 +1476,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
+		FEAT_NAME(UBLK_F_BATCH_IO),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1571,6 +1572,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1 ] [-g]\n");
 	printf("\t[-e 0|1 ] [-i 0|1] [--no_ublk_fixed_fd]\n");
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
+	printf("\t[--batch|-b]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
@@ -1633,6 +1635,7 @@ int main(int argc, char *argv[])
 		{ "nthreads",		1,	NULL,  0 },
 		{ "per_io_tasks",	0,	NULL,  0 },
 		{ "no_ublk_fixed_fd",	0,	NULL,  0 },
+		{ "batch",              0,      NULL, 'b'},
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1654,9 +1657,12 @@ int main(int argc, char *argv[])
 
 	opterr = 0;
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gaz",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gazb",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
+		case 'b':
+			ctx.flags |= UBLK_F_BATCH_IO;
+			break;
 		case 'a':
 			ctx.all = 1;
 			break;
@@ -1737,6 +1743,11 @@ int main(int argc, char *argv[])
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
diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/testing/selftests/ublk/test_generic_04.sh
index 8b533217d4a1..e84f4d748f97 100755
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
index 398e9e2b58e1..9fb66642b776 100755
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
diff --git a/tools/testing/selftests/ublk/test_generic_14.sh b/tools/testing/selftests/ublk/test_generic_14.sh
new file mode 100755
index 000000000000..e197961b07f1
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_14.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_14"
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
diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testing/selftests/ublk/test_stress_06.sh
new file mode 100755
index 000000000000..190db0b4f2ad
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_06.sh
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
diff --git a/tools/testing/selftests/ublk/test_stress_07.sh b/tools/testing/selftests/ublk/test_stress_07.sh
new file mode 100755
index 000000000000..1b6bdb31da03
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_07.sh
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

