Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD7331230
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573248; cv=none; b=C4XEWKRLp1bZ9r75uEwr2/fL35lZ6Bacl5sCfBSnghWX6uc5jO87DRgc4zZbQPCtsFR8VOM10aVq+C59JCLqCozCKZBbBGi5ri4paSu3mSv1+p17gjCa+m+XwEIqS+7CMNs0D9qa2vCM0/FmZpy7CgRHBgFvZ0V0U4f46N3U3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573248; c=relaxed/simple;
	bh=wINhpfEcLKsDLBHwjGaFYpAhM1UYbEGxEFJ/8u2c1sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZewMiQICQ0SvLxVgD2pp6eK7ojouoXt159HjznuiKZNu75wi1JNquxKLfl5Y40D0c8KEL9Za6muayAASn0SbXOe90DatBvrrLhj47BRf/QTIZir9sB0bj3U/JY6UzjgmVejAeJSpS6RGS8HNvMNdJyG0JelJoisRLq+dBc8t+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBrLUBRe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBrLUBRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rXOajW6Ys4PT+P4w4MGXQ5rQppHPMhC8MjOOAjOOE4=;
	b=NBrLUBRecYPn+3UbBNHyPHgHvcyv8C3X86vAyTTCz7GbKSD2WM6H1bXXgWe6JHC/3vnbi+
	vqO6pQZaZNLUIwOgkmwHZEruxDL/FPX7EK6d+j4h/mL7DUDyVrZXBg++zvVCOjw25/qRge
	9Pkq8CW2xYoU8ohuQYpzGsDuZTbioNE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-o_kfmDjDPYWMyfltmwxf3Q-1; Fri,
 16 Jan 2026 09:20:38 -0500
X-MC-Unique: o_kfmDjDPYWMyfltmwxf3Q-1
X-Mimecast-MFC-AGG-ID: o_kfmDjDPYWMyfltmwxf3Q_1768573237
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AB8B1800378;
	Fri, 16 Jan 2026 14:20:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 422AB180049F;
	Fri, 16 Jan 2026 14:20:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 19/24] selftests: ublk: handle UBLK_U_IO_PREP_IO_CMDS
Date: Fri, 16 Jan 2026 22:18:52 +0800
Message-ID: <20260116141859.719929-20-ming.lei@redhat.com>
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

Implement support for UBLK_U_IO_PREP_IO_CMDS in the batch I/O framework:

- Add batch command initialization and setup functions
- Implement prep command queueing with proper buffer management
- Add command completion handling for prep and commit commands
- Integrate batch I/O setup into thread initialization
- Update CQE handling to support batch commands

The implementation uses the previously established buffer management
infrastructure to queue UBLK_U_IO_PREP_IO_CMDS commands. Commands are
prepared in the first thread context and use commit buffers for
efficient command batching.

Key changes:
- ublk_batch_queue_prep_io_cmds() prepares I/O command batches
- ublk_batch_compl_cmd() handles batch command completions
- Modified thread setup to use batch operations when enabled
- Enhanced buffer index calculation for batch mode

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/batch.c | 114 +++++++++++++++++++++++++++
 tools/testing/selftests/ublk/kublk.c |  50 +++++++++---
 tools/testing/selftests/ublk/kublk.h |  22 ++++++
 3 files changed, 174 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index 609e6073c9c0..079cae77add1 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -150,3 +150,117 @@ void ublk_batch_free_buf(struct ublk_thread *t)
 {
 	free_batch_commit_buf(t);
 }
+
+static void ublk_init_batch_cmd(struct ublk_thread *t, __u16 q_id,
+				struct io_uring_sqe *sqe, unsigned op,
+				unsigned short elem_bytes,
+				unsigned short nr_elem,
+				unsigned short buf_idx)
+{
+	struct ublk_batch_io *cmd;
+	__u64 user_data;
+
+	cmd = (struct ublk_batch_io *)ublk_get_sqe_cmd(sqe);
+
+	ublk_set_sqe_cmd_op(sqe, op);
+
+	sqe->fd	= 0;	/* dev->fds[0] */
+	sqe->opcode	= IORING_OP_URING_CMD;
+	sqe->flags	= IOSQE_FIXED_FILE;
+
+	cmd->q_id	= q_id;
+	cmd->flags	= 0;
+	cmd->reserved 	= 0;
+	cmd->elem_bytes = elem_bytes;
+	cmd->nr_elem	= nr_elem;
+
+	user_data = build_user_data(buf_idx, _IOC_NR(op), 0, q_id, 0);
+	io_uring_sqe_set_data64(sqe, user_data);
+
+	t->cmd_inflight += 1;
+
+	ublk_dbg(UBLK_DBG_IO_CMD, "%s: thread %u qid %d cmd_op %x data %lx "
+			"nr_elem %u elem_bytes %u buf_size %u buf_idx %d "
+			"cmd_inflight %u\n",
+			__func__, t->idx, q_id, op, user_data,
+			cmd->nr_elem, cmd->elem_bytes,
+			nr_elem * elem_bytes, buf_idx, t->cmd_inflight);
+}
+
+static void ublk_setup_commit_sqe(struct ublk_thread *t,
+				  struct io_uring_sqe *sqe,
+				  unsigned short buf_idx)
+{
+	struct ublk_batch_io *cmd;
+
+	cmd = (struct ublk_batch_io *)ublk_get_sqe_cmd(sqe);
+
+	/* Use plain user buffer instead of fixed buffer */
+	cmd->flags |= t->cmd_flags;
+}
+
+int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q)
+{
+	unsigned short nr_elem = q->q_depth;
+	unsigned short buf_idx = ublk_alloc_commit_buf(t);
+	struct io_uring_sqe *sqe;
+	void *buf;
+	int i;
+
+	ublk_assert(buf_idx != UBLKS_T_COMMIT_BUF_INV_IDX);
+
+	ublk_io_alloc_sqes(t, &sqe, 1);
+
+	ublk_assert(nr_elem == q->q_depth);
+	buf = ublk_get_commit_buf(t, buf_idx);
+	for (i = 0; i < nr_elem; i++) {
+		struct ublk_batch_elem *elem = (struct ublk_batch_elem *)(
+				buf + i * t->commit_buf_elem_size);
+		struct ublk_io *io = &q->ios[i];
+
+		elem->tag = i;
+		elem->result = 0;
+
+		if (ublk_queue_use_auto_zc(q))
+			elem->buf_index = ublk_batch_io_buf_idx(t, q, i);
+		else if (!ublk_queue_no_buf(q))
+			elem->buf_addr = (__u64)io->buf_addr;
+	}
+
+	sqe->addr = (__u64)buf;
+	sqe->len = t->commit_buf_elem_size * nr_elem;
+
+	ublk_init_batch_cmd(t, q->q_id, sqe, UBLK_U_IO_PREP_IO_CMDS,
+			t->commit_buf_elem_size, nr_elem, buf_idx);
+	ublk_setup_commit_sqe(t, sqe, buf_idx);
+	return 0;
+}
+
+static void ublk_batch_compl_commit_cmd(struct ublk_thread *t,
+					const struct io_uring_cqe *cqe,
+					unsigned op)
+{
+	unsigned short buf_idx = user_data_to_tag(cqe->user_data);
+
+	if (op == _IOC_NR(UBLK_U_IO_PREP_IO_CMDS))
+		ublk_assert(cqe->res == 0);
+	else if (op == _IOC_NR(UBLK_U_IO_COMMIT_IO_CMDS))
+		;//assert(cqe->res == t->commit_buf_size);
+	else
+		ublk_assert(0);
+
+	ublk_free_commit_buf(t, buf_idx);
+}
+
+void ublk_batch_compl_cmd(struct ublk_thread *t,
+			  const struct io_uring_cqe *cqe)
+{
+	unsigned op = user_data_to_op(cqe->user_data);
+
+	if (op == _IOC_NR(UBLK_U_IO_PREP_IO_CMDS) ||
+			op == _IOC_NR(UBLK_U_IO_COMMIT_IO_CMDS)) {
+		t->cmd_inflight--;
+		ublk_batch_compl_commit_cmd(t, cqe, op);
+		return;
+	}
+}
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 97248681d0e4..6119143e5525 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -840,6 +840,8 @@ static void ublk_handle_uring_cmd(struct ublk_thread *t,
 	unsigned tag = user_data_to_tag(cqe->user_data);
 	struct ublk_io *io = &q->ios[tag];
 
+	t->cmd_inflight--;
+
 	if (!fetch) {
 		t->state |= UBLKS_T_STOPPING;
 		io->flags &= ~UBLKS_IO_NEED_FETCH_RQ;
@@ -874,28 +876,30 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 {
 	struct ublk_dev *dev = t->dev;
 	unsigned q_id = user_data_to_q_id(cqe->user_data);
-	struct ublk_queue *q = &dev->q[q_id];
 	unsigned cmd_op = user_data_to_op(cqe->user_data);
 
 	if (cqe->res < 0 && cqe->res != -ENODEV)
-		ublk_err("%s: res %d userdata %llx queue state %x\n", __func__,
-				cqe->res, cqe->user_data, q->flags);
+		ublk_err("%s: res %d userdata %llx thread state %x\n", __func__,
+				cqe->res, cqe->user_data, t->state);
 
-	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d/%d) stopping %d\n",
-			__func__, cqe->res, q->q_id, user_data_to_tag(cqe->user_data),
-			cmd_op, is_target_io(cqe->user_data),
+	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (thread %d qid %d tag %u cmd_op %x "
+			"data %lx target %d/%d) stopping %d\n",
+			__func__, cqe->res, t->idx, q_id,
+			user_data_to_tag(cqe->user_data),
+			cmd_op, cqe->user_data, is_target_io(cqe->user_data),
 			user_data_to_tgt_data(cqe->user_data),
 			(t->state & UBLKS_T_STOPPING));
 
 	/* Don't retrieve io in case of target io */
 	if (is_target_io(cqe->user_data)) {
-		ublksrv_handle_tgt_cqe(t, q, cqe);
+		ublksrv_handle_tgt_cqe(t, &dev->q[q_id], cqe);
 		return;
 	}
 
-	t->cmd_inflight--;
-
-	ublk_handle_uring_cmd(t, q, cqe);
+	if (ublk_thread_batch_io(t))
+		ublk_batch_compl_cmd(t, cqe);
+	else
+		ublk_handle_uring_cmd(t, &dev->q[q_id], cqe);
 }
 
 static int ublk_reap_events_uring(struct ublk_thread *t)
@@ -952,6 +956,22 @@ static void ublk_thread_set_sched_affinity(const struct ublk_thread_info *info)
 				info->dev->dev_info.dev_id, info->idx);
 }
 
+static void ublk_batch_setup_queues(struct ublk_thread *t)
+{
+	int i;
+
+	/* setup all queues in the 1st thread */
+	for (i = 0; i < t->dev->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *q = &t->dev->q[i];
+		int ret;
+
+		ret = ublk_batch_queue_prep_io_cmds(t, q);
+		ublk_assert(ret == 0);
+		ret = ublk_process_io(t);
+		ublk_assert(ret >= 0);
+	}
+}
+
 static __attribute__((noinline)) int __ublk_io_handler_fn(struct ublk_thread_info *info)
 {
 	struct ublk_thread t = {
@@ -972,8 +992,14 @@ static __attribute__((noinline)) int __ublk_io_handler_fn(struct ublk_thread_inf
 	ublk_dbg(UBLK_DBG_THREAD, "tid %d: ublk dev %d thread %u started\n",
 			gettid(), dev_id, t.idx);
 
-	/* submit all io commands to ublk driver */
-	ublk_submit_fetch_commands(&t);
+	if (!ublk_thread_batch_io(&t)) {
+		/* submit all io commands to ublk driver */
+		ublk_submit_fetch_commands(&t);
+	} else if (!t.idx) {
+		/* prepare all io commands in the 1st thread context */
+		ublk_batch_setup_queues(&t);
+	}
+
 	do {
 		if (ublk_process_io(&t) < 0)
 			break;
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 424c333596ac..08320d44c7c2 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -440,10 +440,16 @@ static inline void ublk_set_sqe_cmd_op(struct io_uring_sqe *sqe, __u32 cmd_op)
 	addr[1] = 0;
 }
 
+static inline unsigned short ublk_batch_io_buf_idx(
+		const struct ublk_thread *t, const struct ublk_queue *q,
+		unsigned tag);
+
 static inline unsigned short ublk_io_buf_idx(const struct ublk_thread *t,
 					     const struct ublk_queue *q,
 					     unsigned tag)
 {
+	if (ublk_queue_batch_io(q))
+		return ublk_batch_io_buf_idx(t, q, tag);
 	return q->ios[tag].buf_index;
 }
 
@@ -511,6 +517,22 @@ static inline int ublk_queue_no_buf(const struct ublk_queue *q)
 	return ublk_queue_use_zc(q) || ublk_queue_use_auto_zc(q);
 }
 
+/*
+ * Each IO's buffer index has to be calculated by this helper for
+ * UBLKS_T_BATCH_IO
+ */
+static inline unsigned short ublk_batch_io_buf_idx(
+		const struct ublk_thread *t, const struct ublk_queue *q,
+		unsigned tag)
+{
+	return tag;
+}
+
+/* Queue UBLK_U_IO_PREP_IO_CMDS for a specific queue with batch elements */
+int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q);
+/* Handle completion of batch I/O commands (prep/commit) */
+void ublk_batch_compl_cmd(struct ublk_thread *t,
+			  const struct io_uring_cqe *cqe);
 /* Initialize batch I/O state and calculate buffer parameters */
 void ublk_batch_prepare(struct ublk_thread *t);
 /* Allocate and register commit buffers for batch operations */
-- 
2.47.0

