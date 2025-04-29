Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54AB644
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893800; cv=none; b=XI1w4zF7SagC3Q41g68hFLUC6gwnFZejE/QkhI+UdkRk5x66jELQeUjz7Id10y49pVpIduSuvy55dpPm21oX24o++FjNeezpittgWt5NxEzhKyUyf9chCV2ZxjtRpme/XFYs+QR7iByfvY8hX0+mKuIJJHaj9tK0EeCE7j8H8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893800; c=relaxed/simple;
	bh=FKq/4A2iWcw9rgKpNlgOUQ3t4gozyAQlOn+NFl4c/Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/Iy21YpFUL32jFdLknD3cns/4xvnvr9y/mBL/6EYLFRnuB4IuzibOVhejG8K9uMEaqc/ROX0LxcD5jB9VjikmUyo10fvWx3K+sgf6a7CkJ/lpoaasXgs+BO8EDQqUUcn2m2n4CiANhjNOrYnrUgTiL5DKnwuF9R0kcYsVzr5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9aumBiI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9aumBiI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745893797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7pnsg5hfvr3NtuNZxnDbwi76bSEBMeSDYj3tfPInz4=;
	b=R9aumBiI91e7fhd5Ca9MdFKcp2KDuYMeaWWE+m+lXAC8S9LRk+56u/LQWPzfm3/ORXrv0t
	/vG6ydw0OR6bLI3pBWEU8pXB4xL25irCx28ZbAtXJz8c6x5QPqMGPHdq4BiBas2BKLy5q0
	SYOwboA6R9GBwC9/nsetLIUJUFXJdmo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-Ap2bITQVNdao1A8IXEyrMw-1; Mon,
 28 Apr 2025 22:29:55 -0400
X-MC-Unique: Ap2bITQVNdao1A8IXEyrMw-1
X-Mimecast-MFC-AGG-ID: Ap2bITQVNdao1A8IXEyrMw_1745893794
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FA3818001D5;
	Tue, 29 Apr 2025 02:29:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.57])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CA2519560A3;
	Tue, 29 Apr 2025 02:29:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6.15 v2 1/4] selftests: ublk: fix UBLK_F_NEED_GET_DATA
Date: Tue, 29 Apr 2025 10:29:36 +0800
Message-ID: <20250429022941.1718671-2-ming.lei@redhat.com>
In-Reply-To: <20250429022941.1718671-1-ming.lei@redhat.com>
References: <20250429022941.1718671-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Commit 57e13a2e8cd2 ("selftests: ublk: support user recovery") starts to
support UBLK_F_NEED_GET_DATA for covering recovery feature, however the
ublk utility implementation isn't done correctly.

Fix it by supporting UBLK_F_NEED_GET_DATA correctly.

Also add test generic_07 for covering UBLK_F_NEED_GET_DATA.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 22 +++++++++------
 tools/testing/selftests/ublk/kublk.h          |  1 +
 .../testing/selftests/ublk/test_generic_07.sh | 28 +++++++++++++++++++
 .../testing/selftests/ublk/test_stress_05.sh  |  8 +++---
 5 files changed, 48 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_07.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index ec4624a283bc..f34ac0bac696 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -9,6 +9,7 @@ TEST_PROGS += test_generic_03.sh
 TEST_PROGS += test_generic_04.sh
 TEST_PROGS += test_generic_05.sh
 TEST_PROGS += test_generic_06.sh
+TEST_PROGS += test_generic_07.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e57a1486bb48..842b40736a9b 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -536,12 +536,17 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 	if (!(io->flags & UBLKSRV_IO_FREE))
 		return 0;
 
-	/* we issue because we need either fetching or committing */
+	/*
+	 * we issue because we need either fetching or committing or
+	 * getting data
+	 */
 	if (!(io->flags &
-		(UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
+		(UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP | UBLKSRV_NEED_GET_DATA)))
 		return 0;
 
-	if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
+	if (io->flags & UBLKSRV_NEED_GET_DATA)
+		cmd_op = UBLK_U_IO_NEED_GET_DATA;
+	else if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
 		cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
 	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
 		cmd_op = UBLK_U_IO_FETCH_REQ;
@@ -658,6 +663,9 @@ static void ublk_handle_cqe(struct io_uring *r,
 		assert(tag < q->q_depth);
 		if (q->tgt_ops->queue_io)
 			q->tgt_ops->queue_io(q, tag);
+	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
+		io->flags |= UBLKSRV_NEED_GET_DATA | UBLKSRV_IO_FREE;
+		ublk_queue_io_cmd(q, io, tag);
 	} else {
 		/*
 		 * COMMIT_REQ will be completed immediately since no fetching
@@ -1237,7 +1245,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 
 	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
 			exe, recovery ? "recover" : "add");
-	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask] [-r 0|1 ] [-g 0|1]\n");
+	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask] [-r 0|1 ] [-g]\n");
 	printf("\t[-e 0|1 ] [-i 0|1]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
@@ -1313,7 +1321,7 @@ int main(int argc, char *argv[])
 
 	opterr = 0;
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:az",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:gaz",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -1351,9 +1359,7 @@ int main(int argc, char *argv[])
 				ctx.flags |= UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE;
 			break;
 		case 'g':
-			value = strtol(optarg, NULL, 10);
-			if (value)
-				ctx.flags |= UBLK_F_NEED_GET_DATA;
+			ctx.flags |= UBLK_F_NEED_GET_DATA;
 			break;
 		case 0:
 			if (!strcmp(longopts[option_idx].name, "debug_mask"))
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 918db5cd633f..44ee1e4ac55b 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -115,6 +115,7 @@ struct ublk_io {
 #define UBLKSRV_NEED_FETCH_RQ		(1UL << 0)
 #define UBLKSRV_NEED_COMMIT_RQ_COMP	(1UL << 1)
 #define UBLKSRV_IO_FREE			(1UL << 2)
+#define UBLKSRV_NEED_GET_DATA           (1UL << 3)
 	unsigned short flags;
 	unsigned short refs;		/* used by target code only */
 
diff --git a/tools/testing/selftests/ublk/test_generic_07.sh b/tools/testing/selftests/ublk/test_generic_07.sh
new file mode 100755
index 000000000000..cba86451fa5e
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_07.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_07"
+ERR_CODE=0
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "generic" "test UBLK_F_NEED_GET_DATA"
+
+_create_backfile 0 256M
+dev_id=$(_add_ublk_dev -t loop -q 2 -g "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+# run fio over the ublk disk
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
+ERR_CODE=$?
+if [ "$ERR_CODE" -eq 0 ]; then
+	_mkfs_mount_test /dev/ublkb"${dev_id}"
+	ERR_CODE=$?
+fi
+
+_cleanup_test "generic"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index a7071b10224d..88601b48f1cd 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -47,15 +47,15 @@ _create_backfile 0 256M
 _create_backfile 1 256M
 
 for reissue in $(seq 0 1); do
-	ublk_io_and_remove 8G -t null -q 4 -g 1 -r 1 -i "$reissue" &
-	ublk_io_and_remove 256M -t loop -q 4 -g 1 -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_remove 8G -t null -q 4 -g -r 1 -i "$reissue" &
+	ublk_io_and_remove 256M -t loop -q 4 -g -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
 	wait
 done
 
 if _have_feature "ZERO_COPY"; then
 	for reissue in $(seq 0 1); do
-		ublk_io_and_remove 8G -t null -q 4 -g 1 -z -r 1 -i "$reissue" &
-		ublk_io_and_remove 256M -t loop -q 4 -g 1 -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+		ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i "$reissue" &
+		ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
 		wait
 	done
 fi
-- 
2.47.0

