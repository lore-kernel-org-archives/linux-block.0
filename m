Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588F33B97D
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233683; cv=none; b=mGpM8aj3dXeEH9rk3JvI0327a9HeQFVda80iDtqj1NGXOrNmK73WAfpJLaQsd0NE+w8Z0OJHmMJI7H5g6k43l9PmOvzYQm9pjclc430/abYh7aiAScCxyNsZkjiUAHRi6P1FrpvXGUk9h8XuuAK7OIDvA/2yLTyw2aykCwKlUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233683; c=relaxed/simple;
	bh=0RECzsxygDxcRrkHPpnJ6C1H8OGoRNP33TlsSoXxXK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdjyscQN3L6uRWmI05fxqjSwcYsETC8HaBmD2DhQwpufIEmoBIK+rEUxPkBihv2/7ELOdxqzqM5HmMWQw10arQ3i8s8E/1MZG60hC98BRIU0LwEPXZKdvB2VkNG+CrB9bXF/CpjQnXXAd5Z80rTowaXE76XxEXPsj7VAl0bmdBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GC9DZLfN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC9DZLfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLOfloGCbFR77Guw5grjGI0RQhHfW7JXoQJ06Q0YPfA=;
	b=GC9DZLfNoACkHugEn24kE7Vgl5c0W5qmETSwVJoDf6dEL94Db8QrijjSYxF+Nl8ZdWb1vt
	2eWhed7xIuTdmH0D8rrqpb4i8y8TUC0fCtVa3AZQyb4aDFtjXrINXRlucDPcrSMDoEbZcr
	zv2vEn4WiLWDQkKFfEPXs1uYdrwd3Ao=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-7NgU_TC1NW2oAcjH46d8Fg-1; Thu,
 23 Oct 2025 11:34:36 -0400
X-MC-Unique: 7NgU_TC1NW2oAcjH46d8Fg-1
X-Mimecast-MFC-AGG-ID: 7NgU_TC1NW2oAcjH46d8Fg_1761233675
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61D8918002C1;
	Thu, 23 Oct 2025 15:34:35 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BF2C19540EB;
	Thu, 23 Oct 2025 15:34:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 25/25] selftests: ublk: support arbitrary threads/queues combination
Date: Thu, 23 Oct 2025 23:32:30 +0800
Message-ID: <20251023153234.2548062-26-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Enable flexible thread-to-queue mapping in batch I/O mode to support
arbitrary combinations of threads and queues, improving resource
utilization and scalability.

Key improvements:
- Support N:M thread-to-queue mapping (previously limited to 1:1)
- Dynamic buffer allocation based on actual queue assignment per thread
- Thread-safe queue preparation with spinlock protection
- Intelligent buffer index calculation for multi-queue scenarios
- Enhanced validation for thread/queue combination constraints

Implementation details:
- Add q_thread_map matrix to track queue-to-thread assignments
- Dynamic allocation of commit and fetch buffers per thread
- Round-robin queue assignment algorithm for load balancing
- Per-queue spinlock to prevent race conditions during prep
- Updated buffer index calculation using queue position within thread

This enables efficient configurations like:
- Any other N:M combinations for optimal resource matching

Testing:
- Added test_generic_14.sh: 4 threads vs 1 queue
- Added test_generic_15.sh: 1 thread vs 4 queues
- Validates correctness across different mapping scenarios

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |   2 +
 tools/testing/selftests/ublk/batch.c          | 200 +++++++++++++++---
 tools/testing/selftests/ublk/kublk.c          |  34 ++-
 tools/testing/selftests/ublk/kublk.h          |  37 +++-
 .../testing/selftests/ublk/test_generic_15.sh |  30 +++
 .../testing/selftests/ublk/test_generic_16.sh |  30 +++
 6 files changed, 285 insertions(+), 48 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_16.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index cbf57113b1a6..3dbd9a857716 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -22,6 +22,8 @@ TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_14.sh
+TEST_PROGS += test_generic_15.sh
+TEST_PROGS += test_generic_16.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index 69fb417ebf93..b640cf325472 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -70,6 +70,7 @@ static void free_batch_commit_buf(struct ublk_thread *t)
 {
 	free(t->commit_buf);
 	allocator_deinit(&t->commit_buf_alloc);
+	free(t->commit);
 }
 
 static int alloc_batch_commit_buf(struct ublk_thread *t)
@@ -79,7 +80,13 @@ static int alloc_batch_commit_buf(struct ublk_thread *t)
 	struct iovec iov[t->nr_commit_buf];
 	unsigned int page_sz = getpagesize();
 	void *buf = NULL;
-	int i, ret;
+	int i, ret, j = 0;
+
+	t->commit = calloc(t->nr_queues, sizeof(*t->commit));
+	for (i = 0; i < t->dev->dev_info.nr_hw_queues; i++) {
+		if (t->dev->q_thread_map[t->idx][i])
+			t->commit[j++].q_id = i;
+	}
 
 	allocator_init(&t->commit_buf_alloc, t->nr_commit_buf);
 
@@ -108,6 +115,17 @@ static int alloc_batch_commit_buf(struct ublk_thread *t)
 	return ret;
 }
 
+static unsigned int ublk_thread_nr_queues(const struct ublk_thread *t)
+{
+	int i;
+	int ret = 0;
+
+	for (i = 0; i < t->dev->dev_info.nr_hw_queues; i++)
+		ret += !!t->dev->q_thread_map[t->idx][i];
+
+	return ret;
+}
+
 void ublk_batch_prepare(struct ublk_thread *t)
 {
 	/*
@@ -120,10 +138,13 @@ void ublk_batch_prepare(struct ublk_thread *t)
 	 */
 	struct ublk_queue *q = &t->dev->q[0];
 
+	/* cache nr_queues because we don't support dynamic load-balance yet */
+	t->nr_queues = ublk_thread_nr_queues(t);
+
 	t->commit_buf_elem_size = ublk_commit_elem_buf_size(t->dev);
 	t->commit_buf_size = ublk_commit_buf_size(t);
 	t->commit_buf_start = t->nr_bufs;
-	t->nr_commit_buf = 2;
+	t->nr_commit_buf = 2 * t->nr_queues;
 	t->nr_bufs += t->nr_commit_buf;
 
 	t->cmd_flags = 0;
@@ -145,11 +166,12 @@ static void free_batch_fetch_buf(struct ublk_thread *t)
 {
 	int i;
 
-	for (i = 0; i < UBLKS_T_NR_FETCH_BUF; i++) {
+	for (i = 0; i < t->nr_fetch_bufs; i++) {
 		io_uring_free_buf_ring(&t->ring, t->fetch[i].br, 1, i);
 		munlock(t->fetch[i].fetch_buf, t->fetch[i].fetch_buf_size);
 		free(t->fetch[i].fetch_buf);
 	}
+	free(t->fetch);
 }
 
 static int alloc_batch_fetch_buf(struct ublk_thread *t)
@@ -160,7 +182,12 @@ static int alloc_batch_fetch_buf(struct ublk_thread *t)
 	int ret;
 	int i = 0;
 
-	for (i = 0; i < UBLKS_T_NR_FETCH_BUF; i++) {
+	/* double fetch buffer for each queue */
+	t->nr_fetch_bufs = t->nr_queues * 2;
+	t->fetch = calloc(t->nr_fetch_bufs, sizeof(*t->fetch));
+
+	/* allocate one buffer for each queue */
+	for (i = 0; i < t->nr_fetch_bufs; i++) {
 		t->fetch[i].fetch_buf_size = buf_size;
 
 		if (posix_memalign((void **)&t->fetch[i].fetch_buf, pg_sz,
@@ -186,7 +213,7 @@ int ublk_batch_alloc_buf(struct ublk_thread *t)
 {
 	int ret;
 
-	ublk_assert(t->nr_commit_buf < 16);
+	ublk_assert(t->nr_commit_buf < 2 * UBLK_MAX_QUEUES);
 
 	ret = alloc_batch_commit_buf(t);
 	if (ret)
@@ -273,13 +300,20 @@ static void ublk_batch_queue_fetch(struct ublk_thread *t,
 	t->fetch[buf_idx].fetch_buf_off = 0;
 }
 
-void ublk_batch_start_fetch(struct ublk_thread *t,
-			    struct ublk_queue *q)
+void ublk_batch_start_fetch(struct ublk_thread *t)
 {
 	int i;
+	int j = 0;
 
-	for (i = 0; i < UBLKS_T_NR_FETCH_BUF; i++)
-		ublk_batch_queue_fetch(t, q, i);
+	for (i = 0; i < t->dev->dev_info.nr_hw_queues; i++) {
+		if (t->dev->q_thread_map[t->idx][i]) {
+			struct ublk_queue *q = &t->dev->q[i];
+
+			/* submit two fetch commands for each queue */
+			ublk_batch_queue_fetch(t, q, j++);
+			ublk_batch_queue_fetch(t, q, j++);
+		}
+	}
 }
 
 static unsigned short ublk_compl_batch_fetch(struct ublk_thread *t,
@@ -322,7 +356,7 @@ static unsigned short ublk_compl_batch_fetch(struct ublk_thread *t,
 	return buf_idx;
 }
 
-int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q)
+static int __ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q)
 {
 	unsigned short nr_elem = q->q_depth;
 	unsigned short buf_idx = ublk_alloc_commit_buf(t);
@@ -359,6 +393,22 @@ int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q)
 	return 0;
 }
 
+int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q)
+{
+	int ret = 0;
+
+	pthread_spin_lock(&q->lock);
+	if (q->flags & UBLKS_Q_PREPARED)
+		goto unlock;
+	ret = __ublk_batch_queue_prep_io_cmds(t, q);
+	if (!ret)
+		q->flags |= UBLKS_Q_PREPARED;
+unlock:
+	pthread_spin_unlock(&q->lock);
+
+	return ret;
+}
+
 static void ublk_batch_compl_commit_cmd(struct ublk_thread *t,
 					const struct io_uring_cqe *cqe,
 					unsigned op)
@@ -403,59 +453,89 @@ void ublk_batch_compl_cmd(struct ublk_thread *t,
 	}
 }
 
-void ublk_batch_commit_io_cmds(struct ublk_thread *t)
+static void __ublk_batch_commit_io_cmds(struct ublk_thread *t,
+					struct batch_commit_buf *cb)
 {
 	struct io_uring_sqe *sqe;
 	unsigned short buf_idx;
-	unsigned short nr_elem = t->commit.done;
+	unsigned short nr_elem = cb->done;
 
 	/* nothing to commit */
 	if (!nr_elem) {
-		ublk_free_commit_buf(t, t->commit.buf_idx);
+		ublk_free_commit_buf(t, cb->buf_idx);
 		return;
 	}
 
 	ublk_io_alloc_sqes(t, &sqe, 1);
-	buf_idx = t->commit.buf_idx;
-	sqe->addr = (__u64)t->commit.elem;
+	buf_idx = cb->buf_idx;
+	sqe->addr = (__u64)cb->elem;
 	sqe->len = nr_elem * t->commit_buf_elem_size;
 
 	/* commit isn't per-queue command */
-	ublk_init_batch_cmd(t, t->commit.q_id, sqe, UBLK_U_IO_COMMIT_IO_CMDS,
+	ublk_init_batch_cmd(t, cb->q_id, sqe, UBLK_U_IO_COMMIT_IO_CMDS,
 			t->commit_buf_elem_size, nr_elem, buf_idx);
 	ublk_setup_commit_sqe(t, sqe, buf_idx);
 }
 
-static void ublk_batch_init_commit(struct ublk_thread *t,
-				   unsigned short buf_idx)
+void ublk_batch_commit_io_cmds(struct ublk_thread *t)
+{
+	int i;
+
+	for (i = 0; i < t->nr_queues; i++) {
+		struct batch_commit_buf *cb = &t->commit[i];
+
+		if (cb->buf_idx != UBLKS_T_COMMIT_BUF_INV_IDX)
+			__ublk_batch_commit_io_cmds(t, cb);
+	}
+
+}
+
+static void __ublk_batch_init_commit(struct ublk_thread *t,
+				     struct batch_commit_buf *cb,
+				     unsigned short buf_idx)
 {
 	/* so far only support 1:1 queue/thread mapping */
-	t->commit.q_id = t->idx;
-	t->commit.buf_idx = buf_idx;
-	t->commit.elem = ublk_get_commit_buf(t, buf_idx);
-	t->commit.done = 0;
-	t->commit.count = t->commit_buf_size /
+	cb->buf_idx = buf_idx;
+	cb->elem = ublk_get_commit_buf(t, buf_idx);
+	cb->done = 0;
+	cb->count = t->commit_buf_size /
 		t->commit_buf_elem_size;
 }
 
-void ublk_batch_prep_commit(struct ublk_thread *t)
+/* COMMIT_IO_CMDS is per-queue command, so use its own commit buffer */
+static void ublk_batch_init_commit(struct ublk_thread *t,
+				   struct batch_commit_buf *cb)
 {
 	unsigned short buf_idx = ublk_alloc_commit_buf(t);
 
 	ublk_assert(buf_idx != UBLKS_T_COMMIT_BUF_INV_IDX);
-	ublk_batch_init_commit(t, buf_idx);
+	ublk_assert(!ublk_batch_commit_prepared(cb));
+
+	__ublk_batch_init_commit(t, cb, buf_idx);
+}
+
+void ublk_batch_prep_commit(struct ublk_thread *t)
+{
+	int i;
+
+	for (i = 0; i < t->nr_queues; i++)
+		t->commit[i].buf_idx = UBLKS_T_COMMIT_BUF_INV_IDX;
 }
 
 void ublk_batch_complete_io(struct ublk_thread *t, struct ublk_queue *q,
 			    unsigned tag, int res)
 {
-	struct batch_commit_buf *cb = &t->commit;
-	struct ublk_batch_elem *elem = (struct ublk_batch_elem *)(cb->elem +
-			cb->done * t->commit_buf_elem_size);
+	unsigned q_t_idx = ublk_queue_idx_in_thread(t, q);
+	struct batch_commit_buf *cb = &t->commit[q_t_idx];
+	struct ublk_batch_elem *elem;
 	struct ublk_io *io = &q->ios[tag];
 
-	ublk_assert(q->q_id == t->commit.q_id);
+	if (!ublk_batch_commit_prepared(cb))
+		ublk_batch_init_commit(t, cb);
 
+	ublk_assert(q->q_id == cb->q_id);
+
+	elem = (struct ublk_batch_elem *)(cb->elem + cb->done * t->commit_buf_elem_size);
 	elem->tag = tag;
 	elem->buf_index = ublk_batch_io_buf_idx(t, q, tag);
 	elem->result = res;
@@ -466,3 +546,65 @@ void ublk_batch_complete_io(struct ublk_thread *t, struct ublk_queue *q,
 	cb->done += 1;
 	ublk_assert(cb->done <= cb->count);
 }
+
+void ublk_batch_setup_map(struct ublk_dev *dev)
+{
+	int i, j;
+	int nthreads = dev->nthreads;
+	int queues = dev->dev_info.nr_hw_queues;
+
+	/*
+	 * Setup round-robin queue-to-thread mapping for arbitrary N:M combinations.
+	 *
+	 * This algorithm distributes queues across threads (and threads across queues)
+	 * in a balanced round-robin fashion to ensure even load distribution.
+	 *
+	 * Examples:
+	 * - 2 threads, 4 queues: T0=[Q0,Q2], T1=[Q1,Q3]
+	 * - 4 threads, 2 queues: T0=[Q0], T1=[Q1], T2=[Q0], T3=[Q1]
+	 * - 3 threads, 3 queues: T0=[Q0], T1=[Q1], T2=[Q2] (1:1 mapping)
+	 *
+	 * Phase 1: Mark which queues each thread handles (boolean mapping)
+	 */
+	for (i = 0, j = 0; i < queues || j < nthreads; i++, j++) {
+		dev->q_thread_map[j % nthreads][i % queues] = 1;
+	}
+
+	/*
+	 * Phase 2: Convert boolean mapping to sequential indices within each thread.
+	 *
+	 * Transform from: q_thread_map[thread][queue] = 1 (handles queue)
+	 * To:             q_thread_map[thread][queue] = N (queue index within thread)
+	 *
+	 * This allows each thread to know the local index of each queue it handles,
+	 * which is essential for buffer allocation and management. For example:
+	 * - Thread 0 handling queues [0,2] becomes: q_thread_map[0][0]=1, q_thread_map[0][2]=2
+	 * - Thread 1 handling queues [1,3] becomes: q_thread_map[1][1]=1, q_thread_map[1][3]=2
+	 */
+	for (j = 0; j < nthreads; j++) {
+		unsigned char seq = 1;
+
+		for (i = 0; i < queues; i++) {
+			if (dev->q_thread_map[j][i])
+				dev->q_thread_map[j][i] = seq++;
+		}
+	}
+
+#if 0
+	for (j = 0; j < dev->nthreads; j++) {
+		printf("thread %0d: ", j);
+		for (i = 0; i < dev->dev_info.nr_hw_queues; i++) {
+			if (dev->q_thread_map[j][i])
+				printf("%03u ", i);
+		}
+		printf("\n");
+	}
+	printf("\n");
+	for (j = 0; j < dev->nthreads; j++) {
+		for (i = 0; i < dev->dev_info.nr_hw_queues; i++) {
+			printf("%03u ", dev->q_thread_map[j][i]);
+		}
+		printf("\n");
+	}
+#endif
+}
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index c15cb1cfec06..e54d03bb6989 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -442,6 +442,7 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned long long extra_flags)
 	int cmd_buf_size, io_buf_size;
 	unsigned long off;
 
+	pthread_spin_init(&q->lock, PTHREAD_PROCESS_PRIVATE);
 	q->tgt_ops = dev->tgt.ops;
 	q->flags = 0;
 	q->q_depth = depth;
@@ -495,7 +496,7 @@ static int ublk_thread_init(struct ublk_thread *t, unsigned long long extra_flag
 
 	/* FETCH_IO_CMDS is multishot, so increase cq depth for BATCH_IO */
 	if (ublk_dev_batch_io(dev))
-		cq_depth += dev->dev_info.queue_depth;
+		cq_depth += dev->dev_info.queue_depth * 2;
 
 	ret = ublk_setup_ring(&t->ring, ring_depth, cq_depth,
 			IORING_SETUP_COOP_TASKRUN |
@@ -588,6 +589,9 @@ static int ublk_dev_prep(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		return -1;
 	}
 
+	if (ublk_dev_batch_io(dev))
+		ublk_batch_setup_map(dev);
+
 	dev->fds[0] = fd;
 	if (dev->tgt.ops->init_tgt)
 		ret = dev->tgt.ops->init_tgt(ctx, dev);
@@ -891,14 +895,18 @@ static void ublk_batch_setup_queues(struct ublk_thread *t)
 {
 	int i;
 
-	/* setup all queues in the 1st thread */
 	for (i = 0; i < t->dev->dev_info.nr_hw_queues; i++) {
 		struct ublk_queue *q = &t->dev->q[i];
 		int ret;
 
+		/*
+		 * Only prepare io commands in the mapped thread context,
+		 * otherwise io command buffer index may not work as expected
+		 */
+		if (t->dev->q_thread_map[t->idx][i] == 0)
+			continue;
+
 		ret = ublk_batch_queue_prep_io_cmds(t, q);
-		ublk_assert(ret == 0);
-		ret = ublk_process_io(t);
 		ublk_assert(ret >= 0);
 	}
 }
@@ -931,12 +939,8 @@ static void *ublk_io_handler_fn(void *data)
 		/* submit all io commands to ublk driver */
 		ublk_submit_fetch_commands(t);
 	} else {
-		struct ublk_queue *q = &t->dev->q[t->idx];
-
-		/* prepare all io commands in the 1st thread context */
-		if (!t->idx)
-			ublk_batch_setup_queues(t);
-		ublk_batch_start_fetch(t, q);
+		ublk_batch_setup_queues(t);
+		ublk_batch_start_fetch(t);
 	}
 
 	do {
@@ -1220,7 +1224,8 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 		goto fail;
 	}
 
-	if (nthreads != nr_queues && !ctx->per_io_tasks) {
+	if (nthreads != nr_queues && (!ctx->per_io_tasks &&
+				!(ctx->flags & UBLK_F_BATCH_IO))) {
 		ublk_err("%s: threads %u must be same as queues %u if "
 			"not using per_io_tasks\n",
 			__func__, nthreads, nr_queues);
@@ -1744,6 +1749,13 @@ int main(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	if ((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
+			(ctx.flags & UBLK_F_BATCH_IO) &&
+			(ctx.nthreads > ctx.nr_hw_queues)) {
+		ublk_err("too many threads for F_AUTO_BUF_REG & F_BATCH_IO\n");
+		return -EINVAL;
+	}
+
 	i = optind;
 	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
 		ctx.files[ctx.nr_files++] = argv[i++];
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index d647281622c7..97cf6ddbec5d 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -166,12 +166,16 @@ struct ublk_queue {
 	const struct ublk_tgt_ops *tgt_ops;
 	struct ublksrv_io_desc *io_cmd_buf;
 
-/* borrow one bit of ublk uapi flags, which may never be used */
+/* borrow three bit of ublk uapi flags, which may never be used */
 #define UBLKS_Q_AUTO_BUF_REG_FALLBACK	(1ULL << 63)
 #define UBLKS_Q_NO_UBLK_FIXED_FD	(1ULL << 62)
+#define UBLKS_Q_PREPARED	(1ULL << 61)
 	__u64 flags;
 	int ublk_fd;	/* cached ublk char device fd */
 	struct ublk_io ios[UBLK_QUEUE_DEPTH];
+
+	/* used for prep io commands */
+	pthread_spinlock_t lock;
 };
 
 /* align with `ublk_elem_header` */
@@ -204,7 +208,8 @@ struct ublk_thread {
 	unsigned int io_inflight;
 
 	pthread_t thread;
-	unsigned idx;
+	unsigned short idx;
+	unsigned short nr_queues;
 
 #define UBLKS_T_STOPPING	(1U << 0)
 #define UBLKS_T_IDLE	(1U << 1)
@@ -225,11 +230,11 @@ struct ublk_thread {
 	void *commit_buf;
 #define UBLKS_T_COMMIT_BUF_INV_IDX  ((unsigned short)-1)
 	struct allocator commit_buf_alloc;
-	struct batch_commit_buf commit;
+	struct batch_commit_buf *commit;
 
 	/* FETCH_IO_CMDS buffer */
-#define UBLKS_T_NR_FETCH_BUF 	2
-	struct batch_fetch_buf fetch[UBLKS_T_NR_FETCH_BUF];
+	unsigned short nr_fetch_bufs;
+	struct batch_fetch_buf *fetch;
 };
 
 struct ublk_dev {
@@ -239,6 +244,7 @@ struct ublk_dev {
 	struct ublk_thread threads[UBLK_MAX_THREADS];
 	unsigned nthreads;
 	unsigned per_io_tasks;
+	unsigned char q_thread_map[UBLK_MAX_THREADS][UBLK_MAX_QUEUES];
 
 	int fds[MAX_BACK_FILES + 1];	/* fds[0] points to /dev/ublkcN */
 	int nr_fds;
@@ -468,6 +474,21 @@ static inline int ublk_queue_no_buf(const struct ublk_queue *q)
 	return ublk_queue_use_zc(q) || ublk_queue_use_auto_zc(q);
 }
 
+static inline int ublk_batch_commit_prepared(struct batch_commit_buf *cb)
+{
+	return cb->buf_idx != UBLKS_T_COMMIT_BUF_INV_IDX;
+}
+
+static inline unsigned ublk_queue_idx_in_thread(const struct ublk_thread *t,
+						const struct ublk_queue *q)
+{
+	unsigned char idx;
+
+	idx = t->dev->q_thread_map[t->idx][q->q_id];
+	ublk_assert(idx != 0);
+	return idx - 1;
+}
+
 /*
  * Each IO's buffer index has to be calculated by this helper for
  * UBLKS_T_BATCH_IO
@@ -476,14 +497,13 @@ static inline unsigned short ublk_batch_io_buf_idx(
 		const struct ublk_thread *t, const struct ublk_queue *q,
 		unsigned tag)
 {
-	return tag;
+	return ublk_queue_idx_in_thread(t, q) * q->q_depth + tag;
 }
 
 /* Queue UBLK_U_IO_PREP_IO_CMDS for a specific queue with batch elements */
 int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q);
 /* Start fetching I/O commands using multishot UBLK_U_IO_FETCH_IO_CMDS */
-void ublk_batch_start_fetch(struct ublk_thread *t,
-			    struct ublk_queue *q);
+void ublk_batch_start_fetch(struct ublk_thread *t);
 /* Handle completion of batch I/O commands (prep/commit) */
 void ublk_batch_compl_cmd(struct ublk_thread *t,
 			  const struct io_uring_cqe *cqe);
@@ -501,6 +521,7 @@ void ublk_batch_commit_io_cmds(struct ublk_thread *t);
 /* Add a completed I/O operation to the current batch commit buffer */
 void ublk_batch_complete_io(struct ublk_thread *t, struct ublk_queue *q,
 			    unsigned tag, int res);
+void ublk_batch_setup_map(struct ublk_dev *dev);
 
 static inline int ublk_complete_io(struct ublk_thread *t, struct ublk_queue *q,
 				   unsigned tag, int res)
diff --git a/tools/testing/selftests/ublk/test_generic_15.sh b/tools/testing/selftests/ublk/test_generic_15.sh
new file mode 100755
index 000000000000..16a41fd16428
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_15.sh
@@ -0,0 +1,30 @@
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
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "generic" "test UBLK_F_BATCH_IO with 4_threads vs. 1_queues"
+
+_create_backfile 0 512M
+
+dev_id=$(_add_ublk_dev -t loop -q 1 --nthreads 4 -b "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+# run fio over the ublk disk
+fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite \
+	--iodepth=32 --size=100M --numjobs=4 > /dev/null 2>&1
+ERR_CODE=$?
+
+_cleanup_test "generic"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_16.sh b/tools/testing/selftests/ublk/test_generic_16.sh
new file mode 100755
index 000000000000..6b7000b34a9d
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_16.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_15"
+ERR_CODE=0
+
+if ! _have_feature "BATCH_IO"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "generic" "test UBLK_F_BATCH_IO with 1_threads vs. 4_queues"
+
+_create_backfile 0 512M
+
+dev_id=$(_add_ublk_dev -t loop -q 4 --nthreads 1 -b "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+# run fio over the ublk disk
+fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite \
+	--iodepth=32 --size=100M --numjobs=4 > /dev/null 2>&1
+ERR_CODE=$?
+
+_cleanup_test "generic"
+_show_result $TID $ERR_CODE
-- 
2.47.0

