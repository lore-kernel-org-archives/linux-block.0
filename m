Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A31714B3
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630009; cv=none; b=qUsb0lUr8KMFYzUjsJRKnOlvpe8IybWnO44oad+0MgoKK5jNqpdNO6Aj5MR5VypcYa+GRN3T3mSFUcDZp4CCmtK/L52vhHXszLRXoNskklqrenTh61zbdYUILQfCN0bw/nO1JyAhRPDtYnP6N3xkL0VHzzM5/ifZkaRLyFjdfb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630009; c=relaxed/simple;
	bh=YpzY/PxkqmdLdgoRUW8GT1KwE3+f0UxQeXSsITFAJWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6HmVc3TYyMkhykiME864QcaX4XbPR4T+bnrJb2Yp0qQvuzB5gGnQ2Je9D6yCrLPU6dORhFPDUYJ86YSz1lD503IlxVtbqemFFbWsxUKjYxXncyfcmf3mkXHKOYbbhCme/TaLoNAlithav/AXbZKKO3qdF+4OAFhcnqFs9pUAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGc23G7s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGc23G7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744630005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7b2LxptHBN/rkK2Q9H7e142g/d5WV1lB/Nb5AFd6DVY=;
	b=KGc23G7sKmTI70W95cyYEj/oq5P5jAIRgUABFpBE0ODbHrDLy5BVCzDSG0rloD7s/2Rjxn
	XlBIeufgfyDxlNWE4iZPjSCJx2Y5/+qHMIb6R3QaLB8+gDqpOcYWiXQFaSxS5yewTFqqXE
	eSBq7XCxOR+jtqc+D2ACLUDIaLuZ/yI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-5B1ci2YyNyCp692TWyuK-w-1; Mon,
 14 Apr 2025 07:26:42 -0400
X-MC-Unique: 5B1ci2YyNyCp692TWyuK-w-1
X-Mimecast-MFC-AGG-ID: 5B1ci2YyNyCp692TWyuK-w_1744630001
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71CC9180899B;
	Mon, 14 Apr 2025 11:26:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48EDF1801A6D;
	Mon, 14 Apr 2025 11:26:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 9/9] selftests: ublk: add generic_06 for covering fault inject
Date: Mon, 14 Apr 2025 19:25:50 +0800
Message-ID: <20250414112554.3025113-10-ming.lei@redhat.com>
In-Reply-To: <20250414112554.3025113-1-ming.lei@redhat.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Uday Shankar <ushankar@purestorage.com>

Add one simple fault inject target, and verify if it can be exited in
expected period.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  4 +-
 tools/testing/selftests/ublk/fault_inject.c   | 98 +++++++++++++++++++
 tools/testing/selftests/ublk/kublk.c          |  3 +-
 tools/testing/selftests/ublk/kublk.h          | 12 ++-
 .../testing/selftests/ublk/test_generic_06.sh | 41 ++++++++
 5 files changed, 155 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/fault_inject.c
 create mode 100755 tools/testing/selftests/ublk/test_generic_06.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index dddc64036aa1..ec4624a283bc 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS += test_generic_02.sh
 TEST_PROGS += test_generic_03.sh
 TEST_PROGS += test_generic_04.sh
 TEST_PROGS += test_generic_05.sh
+TEST_PROGS += test_generic_06.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
@@ -31,7 +32,8 @@ TEST_GEN_PROGS_EXTENDED = kublk
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c
+$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
+	fault_inject.c
 
 check:
 	shellcheck -x -f gcc *.sh
diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
new file mode 100644
index 000000000000..94a8e729ba4c
--- /dev/null
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Fault injection ublk target. Hack this up however you like for
+ * testing specific behaviors of ublk_drv. Currently is a null target
+ * with a configurable delay before completing each I/O. This delay can
+ * be used to test ublk_drv's handling of I/O outstanding to the ublk
+ * server when it dies.
+ */
+
+#include "kublk.h"
+
+static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
+				      struct ublk_dev *dev)
+{
+	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	unsigned long dev_size = 250UL << 30;
+
+	dev->tgt.dev_size = dev_size;
+	dev->tgt.params = (struct ublk_params) {
+		.types = UBLK_PARAM_TYPE_BASIC,
+		.basic = {
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift		= 12,
+			.io_min_shift		= 9,
+			.max_sectors		= info->max_io_buf_bytes >> 9,
+			.dev_sectors		= dev_size >> 9,
+		},
+	};
+
+	dev->private_data = (void *)(unsigned long)(ctx->fault_inject.delay_us * 1000);
+	return 0;
+}
+
+static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	struct io_uring_sqe *sqe;
+	struct __kernel_timespec ts = {
+		.tv_nsec = (long long)q->dev->private_data,
+	};
+
+	ublk_queue_alloc_sqes(q, &sqe, 1);
+	io_uring_prep_timeout(sqe, &ts, 1, 0);
+	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, 1);
+
+	ublk_queued_tgt_io(q, tag, 1);
+
+	return 0;
+}
+
+static void ublk_fault_inject_tgt_io_done(struct ublk_queue *q, int tag,
+					  const struct io_uring_cqe *cqe)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+
+	if (cqe->res != -ETIME)
+		ublk_err("%s: unexpected cqe res %d\n", __func__, cqe->res);
+
+	if (ublk_completed_tgt_io(q, tag))
+		ublk_complete_io(q, tag, iod->nr_sectors << 9);
+	else
+		ublk_err("%s: io not complete after 1 cqe\n", __func__);
+}
+
+static void ublk_fault_inject_cmd_line(struct dev_ctx *ctx, int argc, char *argv[])
+{
+	static const struct option longopts[] = {
+		{ "delay_us", 	1,	NULL,  0  },
+		{ 0, 0, 0, 0 }
+	};
+	int option_idx, opt;
+
+	ctx->fault_inject.delay_us = 0;
+	while ((opt = getopt_long(argc, argv, "",
+				  longopts, &option_idx)) != -1) {
+		switch (opt) {
+		case 0:
+			if (!strcmp(longopts[option_idx].name, "delay_us"))
+				ctx->fault_inject.delay_us = strtoll(optarg, NULL, 10);
+		}
+	}
+}
+
+static void ublk_fault_inject_usage(const struct ublk_tgt_ops *ops)
+{
+	printf("\tfault_inject: [--delay_us us (default 0)]\n");
+}
+
+const struct ublk_tgt_ops fault_inject_tgt_ops = {
+	.name = "fault_inject",
+	.init_tgt = ublk_fault_inject_tgt_init,
+	.queue_io = ublk_fault_inject_queue_io,
+	.tgt_io_done = ublk_fault_inject_tgt_io_done,
+	.parse_cmd_line = ublk_fault_inject_cmd_line,
+	.usage = ublk_fault_inject_usage,
+};
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 0cd6dce3f303..759f06637146 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -12,6 +12,7 @@ static const struct ublk_tgt_ops *tgt_ops_list[] = {
 	&null_tgt_ops,
 	&loop_tgt_ops,
 	&stripe_tgt_ops,
+	&fault_inject_tgt_ops,
 };
 
 static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
@@ -1234,7 +1235,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 {
 	int i;
 
-	printf("%s %s -t [null|loop|stripe] [-q nr_queues] [-d depth] [-n dev_id]\n",
+	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
 			exe, recovery ? "recover" : "add");
 	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask] [-r 0|1 ] [-g 0|1]\n");
 	printf("\t[-e 0|1 ] [-i 0|1]\n");
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 3d2b9f14491c..29571eb296f1 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -68,6 +68,11 @@ struct stripe_ctx {
 	unsigned int    chunk_size;
 };
 
+struct fault_inject_ctx {
+	/* fault_inject */
+	unsigned long   delay_us;
+};
+
 struct dev_ctx {
 	char tgt_type[16];
 	unsigned long flags;
@@ -81,6 +86,9 @@ struct dev_ctx {
 	unsigned int	fg:1;
 	unsigned int	recovery:1;
 
+	/* fault_inject */
+	long long	delay_us;
+
 	int _evtfd;
 	int _shmid;
 
@@ -88,7 +96,8 @@ struct dev_ctx {
 	struct ublk_dev *shadow_dev;
 
 	union {
-		struct stripe_ctx  stripe;
+		struct stripe_ctx 	stripe;
+		struct fault_inject_ctx fault_inject;
 	};
 };
 
@@ -384,6 +393,7 @@ static inline int ublk_queue_use_zc(const struct ublk_queue *q)
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
+extern const struct ublk_tgt_ops fault_inject_tgt_ops;
 
 void backing_file_tgt_deinit(struct ublk_dev *dev);
 int backing_file_tgt_init(struct ublk_dev *dev);
diff --git a/tools/testing/selftests/ublk/test_generic_06.sh b/tools/testing/selftests/ublk/test_generic_06.sh
new file mode 100755
index 000000000000..b67230c42c84
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_06.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_06"
+ERR_CODE=0
+
+_prep_test "fault_inject" "fast cleanup when all I/Os of one hctx are in server"
+
+# configure ublk server to sleep 2s before completing each I/O
+dev_id=$(_add_ublk_dev -t fault_inject -q 2 -d 1 --delay_us 2000000)
+_check_add_dev $TID $?
+
+STARTTIME=${SECONDS}
+
+dd if=/dev/urandom of=/dev/ublkb${dev_id} oflag=direct bs=4k count=1 status=none > /dev/null 2>&1 &
+dd_pid=$!
+
+__ublk_kill_daemon ${dev_id} "DEAD"
+
+wait $dd_pid
+dd_exitcode=$?
+
+ENDTIME=${SECONDS}
+ELAPSED=$(($ENDTIME - $STARTTIME))
+
+# assert that dd sees an error and exits quickly after ublk server is
+# killed. previously this relied on seeing an I/O timeout and so would
+# take ~30s
+if [ $dd_exitcode -eq 0 ]; then
+        echo "dd unexpectedly exited successfully!"
+        ERR_CODE=255
+fi
+if [ $ELAPSED -ge 5 ]; then
+        echo "dd took $ELAPSED seconds to exit (>= 5s tolerance)!"
+        ERR_CODE=255
+fi
+
+_cleanup_test "fault_inject"
+_show_result $TID $ERR_CODE
-- 
2.47.0

