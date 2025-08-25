Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306D26FA60
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126155; cv=none; b=QwZNYeuhy3sRNXO78qGsq3TWTaO46dpx9zfSA1tLUKLSPKeWvV46jAYDOXLo1cfWB1dl09PqxdEz/X3EZMtZBouPxgucdUKJk/avK18b2KWTrhIyI/PNntU150w1UlEpcKyQOZ0KloH00NDoKp3rh6evPnPanYER7VlTa30G+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126155; c=relaxed/simple;
	bh=qAV0qzuoRsGrtp/YyBUDUPhrWzzpcj9l3ocn7Xi06mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrEkqTBKVGVWE4gRn7Agw3b38AnRT62/ObmlJkN+UrX6u8grj/ThYurZ4dGcqjeyDeLIpq03SI8/YIZPCvROshl3+bOzs83uwlktNcjK4D9tzGRTZ9P9+2a+i2uBstcZtgJPmvo8emugupYja0XvDybXBwQ9WYWJPfngXoFTSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrjacFUp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrjacFUp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756126152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0eEP22hdUSKk4McIJD/B+MLPo22QefhGUTV4XXeY4Y=;
	b=CrjacFUpLIF1Js84g+PNtWhLlh1Y5vM68pRYGStFBRJjBL8vV8li2WQltWoBHP5ZCAEKe1
	1NeCbAHVjdIBY1/pahXl3BI8cNe0rrI1G9plBcUlM6co2Q/sSsI4hvnRVpz/wAlC6t0QcT
	awiNKqEQXvufXZPyjEsVQq6qg+9V9Yg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-U0BsVYmrMqannlUn62u7oQ-1; Mon,
 25 Aug 2025 08:49:06 -0400
X-MC-Unique: U0BsVYmrMqannlUn62u7oQ-1
X-Mimecast-MFC-AGG-ID: U0BsVYmrMqannlUn62u7oQ_1756126145
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AAAB18002FA;
	Mon, 25 Aug 2025 12:49:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1F5E1955F24;
	Mon, 25 Aug 2025 12:49:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/2] ublk selftests: add --no_ublk_fixed_fd for not using registered ublk char device
Date: Mon, 25 Aug 2025 20:48:25 +0800
Message-ID: <20250825124827.2391820-3-ming.lei@redhat.com>
In-Reply-To: <20250825124827.2391820-1-ming.lei@redhat.com>
References: <20250825124827.2391820-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a new command line option --no_ublk_fixed_fd that excludes the ublk
control device (/dev/ublkcN) from io_uring's registered files array.
When this option is used, only backing files are registered starting
from index 1, while the ublk control device is accessed using its raw
file descriptor.

Add ublk_get_registered_fd() helper function that returns the appropriate
file descriptor for use with io_uring operations, taking ublk_queue *
parameter instead of ublk_thread * for better performance.

Key optimizations implemented:
- Cache UBLKS_Q_NO_UBLK_FIXED_FD flag in ublk_queue.flags to avoid
  reading dev->no_ublk_fixed_fd in fast path
- Cache ublk char device fd in ublk_queue.ublk_fd for fast access
- Update ublk_get_registered_fd() to use ublk_queue * parameter
- Update io_uring_prep_buf_register/unregister() to use ublk_queue *
- Replace ublk_device * access with ublk_queue * access in fast paths

This improves performance by:
- Eliminating device structure traversal in hot paths
- Better cache locality with queue-local data access
- Reduced indirection for flag and fd lookups

The helper handles both modes:
- Normal mode: Returns registered file indices directly
- --no_ublk_fixed_fd mode: Returns raw FD for ublk device (index 0)
  and adjusted indices for backing files (index 1 becomes 0, etc.)

Also pass --no_ublk_fixed_fd to test_stress_04.sh for covering
plain ublk char device mode.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/file_backed.c    | 10 ++--
 tools/testing/selftests/ublk/kublk.c          | 38 ++++++++++++---
 tools/testing/selftests/ublk/kublk.h          | 46 +++++++++++++------
 tools/testing/selftests/ublk/null.c           |  4 +-
 tools/testing/selftests/ublk/stripe.c         |  4 +-
 .../testing/selftests/ublk/test_stress_04.sh  |  6 +--
 6 files changed, 75 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index 2d93ac860bd5..cd9fe69ecce2 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -20,7 +20,7 @@ static int loop_queue_flush_io(struct ublk_thread *t, struct ublk_queue *q,
 	struct io_uring_sqe *sqe[1];
 
 	ublk_io_alloc_sqes(t, sqe, 1);
-	io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
+	io_uring_prep_fsync(sqe[0], ublk_get_registered_fd(q, 1) /*fds[1]*/, IORING_FSYNC_DATASYNC);
 	io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
 	/* bit63 marks us as tgt io */
 	sqe[0]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
@@ -42,7 +42,7 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 		if (!sqe[0])
 			return -ENOMEM;
 
-		io_uring_prep_rw(op, sqe[0], 1 /*fds[1]*/,
+		io_uring_prep_rw(op, sqe[0], ublk_get_registered_fd(q, 1) /*fds[1]*/,
 				addr,
 				iod->nr_sectors << 9,
 				iod->start_sector << 9);
@@ -56,19 +56,19 @@ static int loop_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 
-	io_uring_prep_rw(op, sqe[1], 1 /*fds[1]*/, 0,
+	io_uring_prep_rw(op, sqe[1], ublk_get_registered_fd(q, 1) /*fds[1]*/, 0,
 		iod->nr_sectors << 9,
 		iod->start_sector << 9);
 	sqe[1]->buf_index = tag;
 	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
 	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
 
-	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	return 2;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 95188065b2e9..ede1725f32bb 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -432,7 +432,7 @@ static void ublk_thread_deinit(struct ublk_thread *t)
 	}
 }
 
-static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
+static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags)
 {
 	struct ublk_dev *dev = q->dev;
 	int depth = dev->dev_info.queue_depth;
@@ -446,6 +446,9 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 	q->flags = dev->dev_info.flags;
 	q->flags |= extra_flags;
 
+	/* Cache fd in queue for fast path access */
+	q->ublk_fd = dev->fds[0];
+
 	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
 	off = UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf_sz();
 	q->io_cmd_buf = mmap(0, cmd_buf_size, PROT_READ,
@@ -481,9 +484,10 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 	return -ENOMEM;
 }
 
-static int ublk_thread_init(struct ublk_thread *t)
+static int ublk_thread_init(struct ublk_thread *t, unsigned long long extra_flags)
 {
 	struct ublk_dev *dev = t->dev;
+	unsigned long long flags = dev->dev_info.flags | extra_flags;
 	int ring_depth = dev->tgt.sq_depth, cq_depth = dev->tgt.cq_depth;
 	int ret;
 
@@ -512,7 +516,17 @@ static int ublk_thread_init(struct ublk_thread *t)
 
 	io_uring_register_ring_fd(&t->ring);
 
-	ret = io_uring_register_files(&t->ring, dev->fds, dev->nr_fds);
+	if (flags & UBLKS_Q_NO_UBLK_FIXED_FD) {
+		/* Register only backing files starting from index 1, exclude ublk control device */
+		if (dev->nr_fds > 1) {
+			ret = io_uring_register_files(&t->ring, &dev->fds[1], dev->nr_fds - 1);
+		} else {
+			/* No backing files to register, skip file registration */
+			ret = 0;
+		}
+	} else {
+		ret = io_uring_register_files(&t->ring, dev->fds, dev->nr_fds);
+	}
 	if (ret) {
 		ublk_err("ublk dev %d thread %d register files failed %d\n",
 				t->dev->dev_info.dev_id, t->idx, ret);
@@ -626,9 +640,12 @@ int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io)
 
 	/* These fields should be written once, never change */
 	ublk_set_sqe_cmd_op(sqe[0], cmd_op);
-	sqe[0]->fd		= 0;	/* dev->fds[0] */
+	sqe[0]->fd	= ublk_get_registered_fd(q, 0);	/* dev->fds[0] */
 	sqe[0]->opcode	= IORING_OP_URING_CMD;
-	sqe[0]->flags	= IOSQE_FIXED_FILE;
+	if (q->flags & UBLKS_Q_NO_UBLK_FIXED_FD)
+		sqe[0]->flags	= 0;  /* Use raw FD, not fixed file */
+	else
+		sqe[0]->flags	= IOSQE_FIXED_FILE;
 	sqe[0]->rw_flags	= 0;
 	cmd->tag	= io->tag;
 	cmd->q_id	= q->q_id;
@@ -832,6 +849,7 @@ struct ublk_thread_info {
 	unsigned		idx;
 	sem_t 			*ready;
 	cpu_set_t 		*affinity;
+	unsigned long long	extra_flags;
 };
 
 static void *ublk_io_handler_fn(void *data)
@@ -844,7 +862,7 @@ static void *ublk_io_handler_fn(void *data)
 	t->dev = info->dev;
 	t->idx = info->idx;
 
-	ret = ublk_thread_init(t);
+	ret = ublk_thread_init(t, info->extra_flags);
 	if (ret) {
 		ublk_err("ublk dev %d thread %u init failed\n",
 				dev_id, t->idx);
@@ -934,6 +952,8 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	if (ctx->auto_zc_fallback)
 		extra_flags = UBLKS_Q_AUTO_BUF_REG_FALLBACK;
+	if (ctx->no_ublk_fixed_fd)
+		extra_flags |= UBLKS_Q_NO_UBLK_FIXED_FD;
 
 	for (i = 0; i < dinfo->nr_hw_queues; i++) {
 		dev->q[i].dev = dev;
@@ -951,6 +971,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		tinfo[i].dev = dev;
 		tinfo[i].idx = i;
 		tinfo[i].ready = &ready;
+		tinfo[i].extra_flags = extra_flags;
 
 		/*
 		 * If threads are not tied 1:1 to queues, setting thread
@@ -1471,7 +1492,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("%s %s -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id]\n",
 			exe, recovery ? "recover" : "add");
 	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1 ] [-g]\n");
-	printf("\t[-e 0|1 ] [-i 0|1]\n");
+	printf("\t[-e 0|1 ] [-i 0|1] [--no_ublk_fixed_fd]\n");
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
@@ -1534,6 +1555,7 @@ int main(int argc, char *argv[])
 		{ "size",		1,	NULL, 's'},
 		{ "nthreads",		1,	NULL,  0 },
 		{ "per_io_tasks",	0,	NULL,  0 },
+		{ "no_ublk_fixed_fd",	0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1613,6 +1635,8 @@ int main(int argc, char *argv[])
 				ctx.nthreads = strtol(optarg, NULL, 10);
 			if (!strcmp(longopts[option_idx].name, "per_io_tasks"))
 				ctx.per_io_tasks = 1;
+			if (!strcmp(longopts[option_idx].name, "no_ublk_fixed_fd"))
+				ctx.no_ublk_fixed_fd = 1;
 			break;
 		case '?':
 			/*
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 219233f8a053..9d5bbf559659 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -77,6 +77,7 @@ struct dev_ctx {
 	unsigned int	recovery:1;
 	unsigned int	auto_zc_fallback:1;
 	unsigned int	per_io_tasks:1;
+	unsigned int	no_ublk_fixed_fd:1;
 
 	int _evtfd;
 	int _shmid;
@@ -166,7 +167,9 @@ struct ublk_queue {
 
 /* borrow one bit of ublk uapi flags, which may never be used */
 #define UBLKS_Q_AUTO_BUF_REG_FALLBACK	(1ULL << 63)
+#define UBLKS_Q_NO_UBLK_FIXED_FD	(1ULL << 62)
 	__u64 flags;
+	int ublk_fd;	/* cached ublk char device fd */
 	struct ublk_io ios[UBLK_QUEUE_DEPTH];
 };
 
@@ -273,34 +276,48 @@ static inline int ublk_io_alloc_sqes(struct ublk_thread *t,
 	return nr_sqes;
 }
 
-static inline void io_uring_prep_buf_register(struct io_uring_sqe *sqe,
-		int dev_fd, int tag, int q_id, __u64 index)
+static inline int ublk_get_registered_fd(struct ublk_queue *q, int fd_index)
+{
+	if (q->flags & UBLKS_Q_NO_UBLK_FIXED_FD) {
+		if (fd_index == 0)
+			/* Return the raw ublk FD for index 0 */
+			return q->ublk_fd;
+		/* Adjust index for backing files (index 1 becomes 0, etc.) */
+		return fd_index - 1;
+	}
+	return fd_index;
+}
+
+static inline void __io_uring_prep_buf_reg_unreg(struct io_uring_sqe *sqe,
+		struct ublk_queue *q, int tag, int q_id, __u64 index)
 {
 	struct ublksrv_io_cmd *cmd = (struct ublksrv_io_cmd *)sqe->cmd;
+	int dev_fd = ublk_get_registered_fd(q, 0);
 
 	io_uring_prep_read(sqe, dev_fd, 0, 0, 0);
 	sqe->opcode		= IORING_OP_URING_CMD;
-	sqe->flags		|= IOSQE_FIXED_FILE;
-	sqe->cmd_op		= UBLK_U_IO_REGISTER_IO_BUF;
+	if (q->flags & UBLKS_Q_NO_UBLK_FIXED_FD)
+		sqe->flags	&= ~IOSQE_FIXED_FILE;
+	else
+		sqe->flags	|= IOSQE_FIXED_FILE;
 
 	cmd->tag		= tag;
 	cmd->addr		= index;
 	cmd->q_id		= q_id;
 }
 
-static inline void io_uring_prep_buf_unregister(struct io_uring_sqe *sqe,
-		int dev_fd, int tag, int q_id, __u64 index)
+static inline void io_uring_prep_buf_register(struct io_uring_sqe *sqe,
+		struct ublk_queue *q, int tag, int q_id, __u64 index)
 {
-	struct ublksrv_io_cmd *cmd = (struct ublksrv_io_cmd *)sqe->cmd;
+	__io_uring_prep_buf_reg_unreg(sqe, q, tag, q_id, index);
+	sqe->cmd_op		= UBLK_U_IO_REGISTER_IO_BUF;
+}
 
-	io_uring_prep_read(sqe, dev_fd, 0, 0, 0);
-	sqe->opcode		= IORING_OP_URING_CMD;
-	sqe->flags		|= IOSQE_FIXED_FILE;
+static inline void io_uring_prep_buf_unregister(struct io_uring_sqe *sqe,
+		struct ublk_queue *q, int tag, int q_id, __u64 index)
+{
+	__io_uring_prep_buf_reg_unreg(sqe, q, tag, q_id, index);
 	sqe->cmd_op		= UBLK_U_IO_UNREGISTER_IO_BUF;
-
-	cmd->tag		= tag;
-	cmd->addr		= index;
-	cmd->q_id		= q_id;
 }
 
 static inline void *ublk_get_sqe_cmd(const struct io_uring_sqe *sqe)
@@ -396,6 +413,7 @@ static inline int ublk_queue_no_buf(const struct ublk_queue *q)
 	return ublk_queue_use_zc(q) || ublk_queue_use_auto_zc(q);
 }
 
+
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index f0e0003a4860..280043f6b689 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -63,7 +63,7 @@ static int null_queue_zc_io(struct ublk_thread *t, struct ublk_queue *q,
 
 	ublk_io_alloc_sqes(t, sqe, 3);
 
-	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
 	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
@@ -71,7 +71,7 @@ static int null_queue_zc_io(struct ublk_thread *t, struct ublk_queue *q,
 	__setup_nop_io(tag, iod, sqe[1], q->q_id);
 	sqe[1]->flags |= IOSQE_IO_HARDLINK;
 
-	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
+	io_uring_prep_buf_unregister(sqe[2], q, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
 	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
 
 	// buf register is marked as IOSQE_CQE_SKIP_SUCCESS
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index 1fb9b7cc281b..791fa8dc1651 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -142,7 +142,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	ublk_io_alloc_sqes(t, sqe, s->nr + extra);
 
 	if (zc) {
-		io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, io->buf_index);
+		io_uring_prep_buf_register(sqe[0], q, tag, q->q_id, io->buf_index);
 		sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
 		sqe[0]->user_data = build_user_data(tag,
 			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
@@ -168,7 +168,7 @@ static int stripe_queue_tgt_rw_io(struct ublk_thread *t, struct ublk_queue *q,
 	if (zc) {
 		struct io_uring_sqe *unreg = sqe[s->nr + 1];
 
-		io_uring_prep_buf_unregister(unreg, 0, tag, q->q_id, io->buf_index);
+		io_uring_prep_buf_unregister(unreg, q, tag, q->q_id, io->buf_index);
 		unreg->user_data = build_user_data(
 			tag, ublk_cmd_op_nr(unreg->cmd_op), 0, q->q_id, 1);
 	}
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 40d1437ca298..3f901db4d09d 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -28,14 +28,14 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
-ublk_io_and_kill_daemon 8G -t null -q 4 -z &
-ublk_io_and_kill_daemon 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
+ublk_io_and_kill_daemon 8G -t null -q 4 -z --no_ublk_fixed_fd &
+ublk_io_and_kill_daemon 256M -t loop -q 4 -z --no_ublk_fixed_fd "${UBLK_BACKFILES[0]}" &
 ublk_io_and_kill_daemon 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 
 if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
 	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
-	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
 
-- 
2.47.0

