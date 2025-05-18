Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FD14EC5B
	for <linux-block@vger.kernel.org>; Sun, 18 May 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747574038; cv=none; b=RXrdtHE2OKEqH588VzH5sWHD7OPJVJs1au/mrWxB0dNMJHGCfcJdA3M05nn63XIQRhatZlVaqHB2ELOy10/+yt0y7kevmJ2UQDC3BuY15UVFAyUz1fmgxWF/A/p/DaCdLk7PkfCAham8IxVahBFTeIoiOngQ+OfT7WZ31b1PGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747574038; c=relaxed/simple;
	bh=dDSMI+LMH4mH6naMFbU4Tue2pgdvFlbPXvP0VozcHkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0pxMWseJrNqSL8Y2mVklH52NzuZt1oZ78szpoWUPn0HTc3uaf+d/xXkKPdHNaqms/0B4W060I0EShS0JHkOEzPvnQp920QM+hdogVwJ14r09kn05j4gWXVP/Vl72ztH6QFF8Zf6LmNsa094a1iEBDDIrevtvmRt2IGJqPwxcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IzJ2AEV9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzJ2AEV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747574035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXPI7xJ3lEfXRsgXGccgSqGxV9dczQeiNeardZ8s+9M=;
	b=IzJ2AEV9Nlwkk2Bn87rqAmvYRPKUY8zjhb8wAhKS24AF528ruWWPe8YgEYimD6RouGKeYg
	3gxsCR/C/zK1Pve/EOpJ/9wyKKK84afhlGL1/X2DJVy+edWHkhg+gfTcRKvBNfOlx++uti
	JkU08OnAavbeT1xGCXSfbOpnoTRGwog=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-AlIsM4HlPC2xFKCmD-OezA-1; Sun,
 18 May 2025 09:13:51 -0400
X-MC-Unique: AlIsM4HlPC2xFKCmD-OezA-1
X-Mimecast-MFC-AGG-ID: AlIsM4HlPC2xFKCmD-OezA_1747574030
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BC221956050;
	Sun, 18 May 2025 13:13:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.32])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84A151955F1B;
	Sun, 18 May 2025 13:13:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 6/6] selftests: ublk: add test for covering UBLK_AUTO_BUF_REG_FALLBACK
Date: Sun, 18 May 2025 21:13:01 +0800
Message-ID: <20250518131303.195957-7-ming.lei@redhat.com>
In-Reply-To: <20250518131303.195957-1-ming.lei@redhat.com>
References: <20250518131303.195957-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add test for covering UBLK_AUTO_BUF_REG_FALLBACK:

- pass '--auto_zc_fallback' to null target, which requires both F_AUTO_BUF_REG
and F_SUPPORT_ZERO_COPY for handling UBLK_AUTO_BUF_REG_FALLBACK

- add ->buf_index() method for returning invalid buffer index to trigger
UBLK_AUTO_BUF_REG_FALLBACK

- add generic_09 for running the test

- add --auto_zc_fallback test in stress_03/stress_04/stress_05

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/fault_inject.c   |  5 ++
 tools/testing/selftests/ublk/file_backed.c    |  5 ++
 tools/testing/selftests/ublk/kublk.c          | 50 ++++++++++++++-----
 tools/testing/selftests/ublk/kublk.h          | 11 ++++
 tools/testing/selftests/ublk/null.c           | 14 +++++-
 tools/testing/selftests/ublk/stripe.c         |  5 ++
 .../testing/selftests/ublk/test_generic_09.sh | 28 +++++++++++
 .../testing/selftests/ublk/test_stress_03.sh  |  1 +
 .../testing/selftests/ublk/test_stress_04.sh  |  1 +
 .../testing/selftests/ublk/test_stress_05.sh  |  1 +
 11 files changed, 108 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_09.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 14d574ac142c..2a2ef0cb54bc 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -16,6 +16,7 @@ TEST_PROGS += test_generic_06.sh
 TEST_PROGS += test_generic_07.sh
 
 TEST_PROGS += test_generic_08.sh
+TEST_PROGS += test_generic_09.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index 94a8e729ba4c..5421774d7867 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -16,6 +16,11 @@ static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
 	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
 	unsigned long dev_size = 250UL << 30;
 
+	if (ctx->auto_zc_fallback) {
+		ublk_err("%s: not support auto_zc_fallback\n", __func__);
+		return -EINVAL;
+	}
+
 	dev->tgt.dev_size = dev_size;
 	dev->tgt.params = (struct ublk_params) {
 		.types = UBLK_PARAM_TYPE_BASIC,
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 9dc00b217a66..509842df9bee 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -149,6 +149,11 @@ static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		},
 	};
 
+	if (ctx->auto_zc_fallback) {
+		ublk_err("%s: not support auto_zc_fallback\n", __func__);
+		return -EINVAL;
+	}
+
 	ret = backing_file_tgt_init(dev);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 5c02e78c5fcd..5d3d95968992 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -405,7 +405,8 @@ static void ublk_queue_deinit(struct ublk_queue *q)
 		free(q->ios[i].buf_addr);
 }
 
-static int ublk_queue_init(struct ublk_queue *q)
+static int ublk_queue_init(struct ublk_queue *q,
+			   unsigned char auto_zc_fallback)
 {
 	struct ublk_dev *dev = q->dev;
 	int depth = dev->dev_info.queue_depth;
@@ -424,8 +425,11 @@ static int ublk_queue_init(struct ublk_queue *q)
 		q->state |= UBLKSRV_NO_BUF;
 		if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY)
 			q->state |= UBLKSRV_ZC;
-		if (dev->dev_info.flags & UBLK_F_AUTO_BUF_REG)
+		if (dev->dev_info.flags & UBLK_F_AUTO_BUF_REG) {
 			q->state |= UBLKSRV_AUTO_BUF_REG;
+			if (auto_zc_fallback)
+				q->state |= UBLKSRV_AUTO_BUF_REG_FALLBACK;
+		}
 	}
 
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
@@ -528,14 +532,19 @@ static void ublk_dev_unprep(struct ublk_dev *dev)
 	close(dev->fds[0]);
 }
 
-static void ublk_set_auto_buf_reg(struct io_uring_sqe *sqe,
-				  unsigned short buf_idx,
-				  unsigned char flags)
+static void ublk_set_auto_buf_reg(const struct ublk_queue *q,
+				  struct io_uring_sqe *sqe,
+				  unsigned short tag)
 {
-	struct ublk_auto_buf_reg buf = {
-		.index = buf_idx,
-		.flags = flags,
-	};
+	struct ublk_auto_buf_reg buf = {};
+
+	if (q->tgt_ops->buf_index)
+		buf.index = q->tgt_ops->buf_index(q, tag);
+	else
+		buf.index = tag;
+
+	if (q->state & UBLKSRV_AUTO_BUF_REG_FALLBACK)
+		buf.flags = UBLK_AUTO_BUF_REG_FALLBACK;
 
 	sqe->addr = ublk_auto_buf_reg_to_sqe_addr(&buf);
 }
@@ -595,7 +604,7 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
 		cmd->addr	= 0;
 
 	if (q->state & UBLKSRV_AUTO_BUF_REG)
-		ublk_set_auto_buf_reg(sqe[0], tag, 0);
+		ublk_set_auto_buf_reg(q, sqe[0], tag);
 
 	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, 0);
 	io_uring_sqe_set_data64(sqe[0], user_data);
@@ -747,6 +756,7 @@ struct ublk_queue_info {
 	struct ublk_queue 	*q;
 	sem_t 			*queue_sem;
 	cpu_set_t 		*affinity;
+	unsigned char 		auto_zc_fallback;
 };
 
 static void *ublk_io_handler_fn(void *data)
@@ -756,7 +766,7 @@ static void *ublk_io_handler_fn(void *data)
 	int dev_id = q->dev->dev_info.dev_id;
 	int ret;
 
-	ret = ublk_queue_init(q);
+	ret = ublk_queue_init(q, info->auto_zc_fallback);
 	if (ret) {
 		ublk_err("ublk dev %d queue %d init queue failed\n",
 				dev_id, q->q_id);
@@ -849,6 +859,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		qinfo[i].q = &dev->q[i];
 		qinfo[i].queue_sem = &queue_sem;
 		qinfo[i].affinity = &affinity_buf[i];
+		qinfo[i].auto_zc_fallback = ctx->auto_zc_fallback;
 		pthread_create(&dev->q[i].thread, NULL,
 				ublk_io_handler_fn,
 				&qinfo[i]);
@@ -1264,7 +1275,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 
 	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
 			exe, recovery ? "recover" : "add");
-	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--debug_mask mask] [-r 0|1 ] [-g]\n");
+	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1 ] [-g]\n");
 	printf("\t[-e 0|1 ] [-i 0|1]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
@@ -1319,7 +1330,8 @@ int main(int argc, char *argv[])
 		{ "recovery_fail_io",	1,	NULL, 'e'},
 		{ "recovery_reissue",	1,	NULL, 'i'},
 		{ "get_data",		1,	NULL, 'g'},
-		{ "auto_zc",		0,	NULL,  0},
+		{ "auto_zc",		0,	NULL,  0 },
+		{ "auto_zc_fallback", 	0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1390,6 +1402,8 @@ int main(int argc, char *argv[])
 				ctx.fg = 1;
 			if (!strcmp(longopts[option_idx].name, "auto_zc"))
 				ctx.flags |= UBLK_F_AUTO_BUF_REG;
+			if (!strcmp(longopts[option_idx].name, "auto_zc_fallback"))
+				ctx.auto_zc_fallback = 1;
 			break;
 		case '?':
 			/*
@@ -1413,6 +1427,16 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	/* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT_ZERO_COPY */
+	if (ctx.auto_zc_fallback &&
+	    !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
+		    (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) {
+		ublk_err("%s: auto_zc_fallback is set but neither "
+				"F_AUTO_BUF_REG nor F_SUPPORT_ZERO_COPY is enabled\n",
+					__func__);
+		return -EINVAL;
+	}
+
 	i = optind;
 	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
 		ctx.files[ctx.nr_files++] = argv[i++];
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index ebbfad9e70aa..9af930e951a3 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -84,6 +84,7 @@ struct dev_ctx {
 	unsigned int	all:1;
 	unsigned int	fg:1;
 	unsigned int	recovery:1;
+	unsigned int	auto_zc_fallback:1;
 
 	int _evtfd;
 	int _shmid;
@@ -141,6 +142,9 @@ struct ublk_tgt_ops {
 	 */
 	void (*parse_cmd_line)(struct dev_ctx *ctx, int argc, char *argv[]);
 	void (*usage)(const struct ublk_tgt_ops *ops);
+
+	/* return buffer index for UBLK_F_AUTO_BUF_REG */
+	unsigned short (*buf_index)(const struct ublk_queue *, int tag);
 };
 
 struct ublk_tgt {
@@ -170,6 +174,7 @@ struct ublk_queue {
 #define UBLKSRV_NO_BUF		(1U << 2)
 #define UBLKSRV_ZC		(1U << 3)
 #define UBLKSRV_AUTO_BUF_REG		(1U << 4)
+#define UBLKSRV_AUTO_BUF_REG_FALLBACK	(1U << 5)
 	unsigned state;
 	pid_t tid;
 	pthread_t thread;
@@ -205,6 +210,12 @@ struct ublk_dev {
 extern unsigned int ublk_dbg_mask;
 extern int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag);
 
+
+static inline int ublk_io_auto_zc_fallback(const struct ublksrv_io_desc *iod)
+{
+	return !!(iod->op_flags & UBLK_IO_F_NEED_REG_BUF);
+}
+
 static inline int is_target_io(__u64 user_data)
 {
 	return (user_data & (1ULL << 63)) != 0;
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 1362dd422c6e..44aca31cf2b0 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -116,7 +116,7 @@ static int ublk_null_queue_io(struct ublk_queue *q, int tag)
 	unsigned zc = ublk_queue_use_zc(q);
 	int queued;
 
-	if (auto_zc)
+	if (auto_zc && !ublk_io_auto_zc_fallback(iod))
 		queued = null_queue_auto_zc_io(q, tag);
 	else if (zc)
 		queued = null_queue_zc_io(q, tag);
@@ -128,9 +128,21 @@ static int ublk_null_queue_io(struct ublk_queue *q, int tag)
 	return 0;
 }
 
+/*
+ * return invalid buffer index for triggering auto buffer register failure,
+ * then UBLK_IO_RES_NEED_REG_BUF handling is covered
+ */
+static unsigned short ublk_null_buf_index(const struct ublk_queue *q, int tag)
+{
+	if (q->state & UBLKSRV_AUTO_BUF_REG_FALLBACK)
+		return (unsigned short)-1;
+	return tag;
+}
+
 const struct ublk_tgt_ops null_tgt_ops = {
 	.name = "null",
 	.init_tgt = ublk_null_tgt_init,
 	.queue_io = ublk_null_queue_io,
 	.tgt_io_done = ublk_null_io_done,
+	.buf_index = ublk_null_buf_index,
 };
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 8fd8faeb5e76..404a143bf3d6 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -288,6 +288,11 @@ static int ublk_stripe_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	loff_t bytes = 0;
 	int ret, i, mul = 1;
 
+	if (ctx->auto_zc_fallback) {
+		ublk_err("%s: not support auto_zc_fallback\n", __func__);
+		return -EINVAL;
+	}
+
 	if ((chunk_size & (chunk_size - 1)) || !chunk_size) {
 		ublk_err("invalid chunk size %u\n", chunk_size);
 		return -EINVAL;
diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tools/testing/selftests/ublk/test_generic_09.sh
new file mode 100755
index 000000000000..bb6f77ca5522
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_09.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_09"
+ERR_CODE=0
+
+if ! _have_feature "AUTO_BUF_REG"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "null" "basic IO test"
+
+dev_id=$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fallback)
+_check_add_dev $TID $?
+
+# run fio over the two disks
+fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
+ERR_CODE=$?
+
+_cleanup_test "null"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
index b5a5520dcae6..7d728ce50774 100755
--- a/tools/testing/selftests/ublk/test_stress_03.sh
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -37,6 +37,7 @@ if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_remove 8G -t null -q 4 --auto_zc &
 	ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
 wait
 
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 5b49a8025002..9bcfa64ea1f0 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -36,6 +36,7 @@ if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
 wait
 
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index 6f758f6070a5..bcfc904cefc6 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -64,6 +64,7 @@ if _have_feature "AUTO_BUF_REG"; then
 	for reissue in $(seq 0 1); do
 		ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -r 1 -i "$reissue" &
 		ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+		ublk_io_and_remove 8G -t null -q 4 -g -z --auto_zc --auto_zc_fallback -r 1 -i "$reissue" &
 		wait
 	done
 fi
-- 
2.47.0

