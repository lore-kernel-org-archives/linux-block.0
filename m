Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D02311C0C
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678121; cv=none; b=mDbvB7lghWyQpK09MYzAiJC3S01F0PkDmhiELXpB3/zKRPXD1OnG74eqH6wSeAgu9IqVvvxNXO83mEA5cRwyLIKOFRwfPYbYUSuC/zlZaVGP/hLCXQVJEcemshbBM4y6IduQPydYVOdwqUpkDAtGb9HdTWDlR4bWt1lNWlZ/JiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678121; c=relaxed/simple;
	bh=bpMj+5iJHb0HItYhdwJPBNL7yd6120JB6BmDfWc4IIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+dpJBDUxJK5eh6XZySKw6YFH4Bs5R8Ig+r2JCFRlL49voY7raB1SJYNkBPK4P1bAXYqbtmOA0ap3OVSC6QlujQ6sn5AyJu1J8bbIz2d8aYRRSVv9CIyfC8HkKMdmwNO/Fdk66fRsi0xK601u6/quGMIDK6MVYOUnARaO/irhiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HV3kHws6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HV3kHws6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764678118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yAOTot2+IdfJy0TEgJ6Iw4zloe0w//2T4DOJDh9HAg=;
	b=HV3kHws6nb2fdlGJBYf/P6hi0pM7XbC9LvRTrcj20J/Jb9CmrXnV4/z5HviNlF2K+Svdkv
	ubczZiVfZhXTbAHP7Wro78xe82pxEXL+M9g9Mom+iSURvcBd9kbCbg9PHT21vhxYQEdnuw
	udOH5bElkEqsvmDdzQ0u1eUVad6+auM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-vUmvVbF6OKik9IYYDtDWyQ-1; Tue,
 02 Dec 2025 07:21:55 -0500
X-MC-Unique: vUmvVbF6OKik9IYYDtDWyQ-1
X-Mimecast-MFC-AGG-ID: vUmvVbF6OKik9IYYDtDWyQ_1764678114
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19C1C180034D;
	Tue,  2 Dec 2025 12:21:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DC3F180047F;
	Tue,  2 Dec 2025 12:21:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 18/21] selftests: ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
Date: Tue,  2 Dec 2025 20:19:12 +0800
Message-ID: <20251202121917.1412280-19-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-1-ming.lei@redhat.com>
References: <20251202121917.1412280-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Implement UBLK_U_IO_COMMIT_IO_CMDS to enable efficient batched
completion of I/O operations in the batch I/O framework.

This completes the batch I/O infrastructure by adding the commit
phase that notifies the kernel about completed I/O operations:

Key features:
- Batch multiple I/O completions into single UBLK_U_IO_COMMIT_IO_CMDS
- Dynamic commit buffer allocation and management per thread
- Automatic commit buffer preparation before processing events
- Commit buffer submission after processing completed I/Os
- Integration with existing completion workflows

Implementation details:
- ublk_batch_prep_commit() allocates and initializes commit buffers
- ublk_batch_complete_io() adds completed I/Os to current batch
- ublk_batch_commit_io_cmds() submits batched completions to kernel
- Modified ublk_process_io() to handle batch commit lifecycle
- Enhanced ublk_complete_io() to route to batch or legacy completion

The commit buffer stores completion information (tag, result, buffer
details) for multiple I/Os, then submits them all at once, significantly
reducing syscall overhead compared to individual I/O completions.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/batch.c | 74 ++++++++++++++++++++++++++--
 tools/testing/selftests/ublk/kublk.c |  8 ++-
 tools/testing/selftests/ublk/kublk.h | 69 +++++++++++++++++---------
 3 files changed, 122 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index 01f00c21dfdb..e240d4decedf 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -174,7 +174,7 @@ static void ublk_init_batch_cmd(struct ublk_thread *t, __u16 q_id,
 	cmd->elem_bytes = elem_bytes;
 	cmd->nr_elem	= nr_elem;
 
-	user_data = build_user_data(buf_idx, _IOC_NR(op), 0, q_id, 0);
+	user_data = build_user_data(buf_idx, _IOC_NR(op), nr_elem, q_id, 0);
 	io_uring_sqe_set_data64(sqe, user_data);
 
 	t->cmd_inflight += 1;
@@ -244,9 +244,11 @@ static void ublk_batch_compl_commit_cmd(struct ublk_thread *t,
 
 	if (op == _IOC_NR(UBLK_U_IO_PREP_IO_CMDS))
 		ublk_assert(cqe->res == 0);
-	else if (op == _IOC_NR(UBLK_U_IO_COMMIT_IO_CMDS))
-		;//assert(cqe->res == t->commit_buf_size);
-	else
+	else if (op == _IOC_NR(UBLK_U_IO_COMMIT_IO_CMDS)) {
+		int nr_elem = user_data_to_tgt_data(cqe->user_data);
+
+		ublk_assert(cqe->res == t->commit_buf_elem_size * nr_elem);
+	} else
 		ublk_assert(0);
 
 	ublk_free_commit_buf(t, buf_idx);
@@ -263,3 +265,67 @@ void ublk_batch_compl_cmd(struct ublk_thread *t,
 		return;
 	}
 }
+
+void ublk_batch_commit_io_cmds(struct ublk_thread *t)
+{
+	struct io_uring_sqe *sqe;
+	unsigned short buf_idx;
+	unsigned short nr_elem = t->commit.done;
+
+	/* nothing to commit */
+	if (!nr_elem) {
+		ublk_free_commit_buf(t, t->commit.buf_idx);
+		return;
+	}
+
+	ublk_io_alloc_sqes(t, &sqe, 1);
+	buf_idx = t->commit.buf_idx;
+	sqe->addr = (__u64)t->commit.elem;
+	sqe->len = nr_elem * t->commit_buf_elem_size;
+
+	/* commit isn't per-queue command */
+	ublk_init_batch_cmd(t, t->commit.q_id, sqe, UBLK_U_IO_COMMIT_IO_CMDS,
+			t->commit_buf_elem_size, nr_elem, buf_idx);
+	ublk_setup_commit_sqe(t, sqe, buf_idx);
+}
+
+static void ublk_batch_init_commit(struct ublk_thread *t,
+				   unsigned short buf_idx)
+{
+	/* so far only support 1:1 queue/thread mapping */
+	t->commit.q_id = t->idx;
+	t->commit.buf_idx = buf_idx;
+	t->commit.elem = ublk_get_commit_buf(t, buf_idx);
+	t->commit.done = 0;
+	t->commit.count = t->commit_buf_size /
+		t->commit_buf_elem_size;
+}
+
+void ublk_batch_prep_commit(struct ublk_thread *t)
+{
+	unsigned short buf_idx = ublk_alloc_commit_buf(t);
+
+	ublk_assert(buf_idx != UBLKS_T_COMMIT_BUF_INV_IDX);
+	ublk_batch_init_commit(t, buf_idx);
+}
+
+void ublk_batch_complete_io(struct ublk_thread *t, struct ublk_queue *q,
+			    unsigned tag, int res)
+{
+	struct batch_commit_buf *cb = &t->commit;
+	struct ublk_batch_elem *elem = (struct ublk_batch_elem *)(cb->elem +
+			cb->done * t->commit_buf_elem_size);
+	struct ublk_io *io = &q->ios[tag];
+
+	ublk_assert(q->q_id == t->commit.q_id);
+
+	elem->tag = tag;
+	elem->buf_index = ublk_batch_io_buf_idx(t, q, tag);
+	elem->result = res;
+
+	if (!ublk_queue_no_buf(q))
+		elem->buf_addr	= (__u64) (uintptr_t) io->buf_addr;
+
+	cb->done += 1;
+	ublk_assert(cb->done <= cb->count);
+}
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e981fcf18475..6565e804679c 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -852,7 +852,13 @@ static int ublk_process_io(struct ublk_thread *t)
 		return -ENODEV;
 
 	ret = io_uring_submit_and_wait(&t->ring, 1);
-	reapped = ublk_reap_events_uring(t);
+	if (ublk_thread_batch_io(t)) {
+		ublk_batch_prep_commit(t);
+		reapped = ublk_reap_events_uring(t);
+		ublk_batch_commit_io_cmds(t);
+	} else {
+		reapped = ublk_reap_events_uring(t);
+	}
 
 	ublk_dbg(UBLK_DBG_THREAD, "submit result %d, reapped %d stop %d idle %d\n",
 			ret, reapped, (t->state & UBLKS_T_STOPPING),
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 51fad0f4419b..0a355653d64c 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -182,6 +182,14 @@ struct ublk_batch_elem {
 	__u64 buf_addr;
 };
 
+struct batch_commit_buf {
+	unsigned short q_id;
+	unsigned short buf_idx;
+	void *elem;
+	unsigned short done;
+	unsigned short count;
+};
+
 struct ublk_thread {
 	struct ublk_dev *dev;
 	unsigned idx;
@@ -207,6 +215,7 @@ struct ublk_thread {
 	void *commit_buf;
 #define UBLKS_T_COMMIT_BUF_INV_IDX  ((unsigned short)-1)
 	struct allocator commit_buf_alloc;
+	struct batch_commit_buf commit;
 
 	struct io_uring ring;
 };
@@ -416,30 +425,6 @@ static inline struct ublk_io *ublk_get_io(struct ublk_queue *q, unsigned tag)
 	return &q->ios[tag];
 }
 
-static inline int ublk_complete_io(struct ublk_thread *t, struct ublk_queue *q,
-				   unsigned tag, int res)
-{
-	struct ublk_io *io = &q->ios[tag];
-
-	ublk_mark_io_done(io, res);
-
-	return ublk_queue_io_cmd(t, io);
-}
-
-static inline void ublk_queued_tgt_io(struct ublk_thread *t, struct ublk_queue *q,
-				      unsigned tag, int queued)
-{
-	if (queued < 0)
-		ublk_complete_io(t, q, tag, queued);
-	else {
-		struct ublk_io *io = ublk_get_io(q, tag);
-
-		t->io_inflight += queued;
-		io->tgt_ios = queued;
-		io->result = 0;
-	}
-}
-
 static inline int ublk_completed_tgt_io(struct ublk_thread *t,
 					struct ublk_queue *q, unsigned tag)
 {
@@ -493,6 +478,42 @@ int ublk_batch_alloc_buf(struct ublk_thread *t);
 /* Free commit buffers and cleanup batch allocator */
 void ublk_batch_free_buf(struct ublk_thread *t);
 
+/* Prepare a new commit buffer for batching completed I/O operations */
+void ublk_batch_prep_commit(struct ublk_thread *t);
+/* Submit UBLK_U_IO_COMMIT_IO_CMDS with batched completed I/O operations */
+void ublk_batch_commit_io_cmds(struct ublk_thread *t);
+/* Add a completed I/O operation to the current batch commit buffer */
+void ublk_batch_complete_io(struct ublk_thread *t, struct ublk_queue *q,
+			    unsigned tag, int res);
+
+static inline int ublk_complete_io(struct ublk_thread *t, struct ublk_queue *q,
+				   unsigned tag, int res)
+{
+	if (ublk_queue_batch_io(q)) {
+		ublk_batch_complete_io(t, q, tag, res);
+		return 0;
+	} else {
+		struct ublk_io *io = &q->ios[tag];
+
+		ublk_mark_io_done(io, res);
+		return ublk_queue_io_cmd(t, io);
+	}
+}
+
+static inline void ublk_queued_tgt_io(struct ublk_thread *t, struct ublk_queue *q,
+				      unsigned tag, int queued)
+{
+	if (queued < 0)
+		ublk_complete_io(t, q, tag, queued);
+	else {
+		struct ublk_io *io = ublk_get_io(q, tag);
+
+		t->io_inflight += queued;
+		io->tgt_ios = queued;
+		io->result = 0;
+	}
+}
+
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
-- 
2.47.0

