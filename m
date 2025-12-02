Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9993101B6
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678136; cv=none; b=f9JK4HtzDES8jmIBiAnR44gkKdwdoyoDXBrPwsvv4DB+t3ruRyPsSC/AT7NYv75y/SY/RYxfu5VRRRSKxS1YeF/5UrKm+l55ILtuY7TK7fsRghu4PRXX8lHVOnQCI8s15qVWY2L6rhk5twyA19RazsS+rWZWJ1ozb5vo/G/eCe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678136; c=relaxed/simple;
	bh=YY9mPoiqq5mS8+hnJbS4J35F/PfORQJLXUIK+tPEQUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyvAAdxSYIEg9MD5XGf1Bn9jYyZe0aVLJ2qvo//0xYEuiOijgzoRVRW1Loi1WutJFH9A1lLbSK7p3t0ibChD88BsVir7x8kmAELx9oJokTiQyrcgdYA5YOK1wV0xdPQ+G7qV8a5Wgde1xpSv1MJqRlvQ9ELTxpM2FCa9XkdB5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGXSaRpm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGXSaRpm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764678133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBU4yUzkpU7XOjpcV4FFa6IcIMZ2uo+9+EbDZIGoy/A=;
	b=IGXSaRpmrV8YrywA2wGF9sazk957X4viQXIhLjHNlf1UbYB6uwnDxgu87KNK0aKIO5APON
	L7cIFhW6YFajV0uUokQQt7FqdyuWNXyBtDEP+z6JF0kJ6dwDPnOeVEVDeILhpMvxHMNy3P
	xB4Oj20Zwai9JGEpZMAFwyCA9n1tEdg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-L6rf_8-BNB-Hgo8PKX3Gtg-1; Tue,
 02 Dec 2025 07:22:09 -0500
X-MC-Unique: L6rf_8-BNB-Hgo8PKX3Gtg-1
X-Mimecast-MFC-AGG-ID: L6rf_8-BNB-Hgo8PKX3Gtg_1764678128
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AFEB180057A;
	Tue,  2 Dec 2025 12:22:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1B581800451;
	Tue,  2 Dec 2025 12:22:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 21/21] selftests: ublk: support arbitrary threads/queues combination
Date: Tue,  2 Dec 2025 20:19:15 +0800
Message-ID: <20251202121917.1412280-22-ming.lei@redhat.com>
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
- Added test_generic_15.sh: 4 threads vs 1 queue
- Added test_generic_16.sh: 1 thread vs 4 queues
- Validates correctness across different mapping scenarios

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |   2 +
 tools/testing/selftests/ublk/batch.c          | 199 +++++++++++++++---
 tools/testing/selftests/ublk/kublk.c          |  49 ++++-
 tools/testing/selftests/ublk/kublk.h          |  40 +++-
 .../testing/selftests/ublk/test_generic_15.sh |  30 +++
 .../testing/selftests/ublk/test_generic_16.sh |  30 +++
 6 files changed, 302 insertions(+), 48 deletions(-)
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
index 7db91f910944..db0747f13768 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -76,6 +76,7 @@ static void free_batch_commit_buf(struct ublk_thread *t)
 		free(t->commit_buf);
 	}
 	allocator_deinit(&t->commit_buf_alloc);
+	free(t->commit);
 }
 
 static int alloc_batch_commit_buf(struct ublk_thread *t)
@@ -84,7 +85,13 @@ static int alloc_batch_commit_buf(struct ublk_thread *t)
 	unsigned int total = buf_size * t->nr_commit_buf;
 	unsigned int page_sz = getpagesize();
 	void *buf = NULL;
-	int ret;
+	int i, ret, j = 0;
+
+	t->commit = calloc(t->nr_queues, sizeof(*t->commit));
+	for (i = 0; i < t->dev->dev_info.nr_hw_queues; i++) {
+		if (t->q_map[i])
+			t->commit[j++].q_id = i;
+	}
 
 	allocator_init(&t->commit_buf_alloc, t->nr_commit_buf);
 
@@ -107,6 +114,17 @@ static int alloc_batch_commit_buf(struct ublk_thread *t)
 	return ret;
 }
 
+static unsigned int ublk_thread_nr_queues(const struct ublk_thread *t)
+{
+	int i;
+	int ret = 0;
+
+	for (i = 0; i < t->dev->dev_info.nr_hw_queues; i++)
+		ret += !!t->q_map[i];
+
+	return ret;
+}
+
 void ublk_batch_prepare(struct ublk_thread *t)
 {
 	/*
@@ -119,10 +137,13 @@ void ublk_batch_prepare(struct ublk_thread *t)
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
@@ -144,11 +165,12 @@ static void free_batch_fetch_buf(struct ublk_thread *t)
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
@@ -159,7 +181,12 @@ static int alloc_batch_fetch_buf(struct ublk_thread *t)
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
@@ -185,7 +212,7 @@ int ublk_batch_alloc_buf(struct ublk_thread *t)
 {
 	int ret;
 
-	ublk_assert(t->nr_commit_buf < 16);
+	ublk_assert(t->nr_commit_buf < 2 * UBLK_MAX_QUEUES);
 
 	ret = alloc_batch_commit_buf(t);
 	if (ret)
@@ -271,13 +298,20 @@ static void ublk_batch_queue_fetch(struct ublk_thread *t,
 	t->fetch[buf_idx].fetch_buf_off = 0;
 }
 
-void ublk_batch_start_fetch(struct ublk_thread *t,
-			    struct ublk_queue *q)
+void ublk_batch_start_fetch(struct ublk_thread *t)
 {
 	int i;
+	int j = 0;
+
+	for (i = 0; i < t->dev->dev_info.nr_hw_queues; i++) {
+		if (t->q_map[i]) {
+			struct ublk_queue *q = &t->dev->q[i];
 
-	for (i = 0; i < UBLKS_T_NR_FETCH_BUF; i++)
-		ublk_batch_queue_fetch(t, q, i);
+			/* submit two fetch commands for each queue */
+			ublk_batch_queue_fetch(t, q, j++);
+			ublk_batch_queue_fetch(t, q, j++);
+		}
+	}
 }
 
 static unsigned short ublk_compl_batch_fetch(struct ublk_thread *t,
@@ -317,7 +351,7 @@ static unsigned short ublk_compl_batch_fetch(struct ublk_thread *t,
 	return buf_idx;
 }
 
-int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q)
+static int __ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q)
 {
 	unsigned short nr_elem = q->q_depth;
 	unsigned short buf_idx = ublk_alloc_commit_buf(t);
@@ -354,6 +388,22 @@ int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q)
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
@@ -398,59 +448,89 @@ void ublk_batch_compl_cmd(struct ublk_thread *t,
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
+
+	ublk_assert(q->q_id == cb->q_id);
 
+	elem = (struct ublk_batch_elem *)(cb->elem + cb->done * t->commit_buf_elem_size);
 	elem->tag = tag;
 	elem->buf_index = ublk_batch_io_buf_idx(t, q, tag);
 	elem->result = res;
@@ -461,3 +541,64 @@ void ublk_batch_complete_io(struct ublk_thread *t, struct ublk_queue *q,
 	cb->done += 1;
 	ublk_assert(cb->done <= cb->count);
 }
+
+void ublk_batch_setup_map(unsigned char (*q_thread_map)[UBLK_MAX_QUEUES],
+			   int nthreads, int queues)
+{
+	int i, j;
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
+		q_thread_map[j % nthreads][i % queues] = 1;
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
+			if (q_thread_map[j][i])
+				q_thread_map[j][i] = seq++;
+		}
+	}
+
+#if 0
+	for (j = 0; j < nthreads; j++) {
+		printf("thread %0d: ", j);
+		for (i = 0; i < queues; i++) {
+			if (q_thread_map[j][i])
+				printf("%03u ", i);
+		}
+		printf("\n");
+	}
+	printf("\n");
+	for (j = 0; j < nthreads; j++) {
+		for (i = 0; i < queues; i++) {
+			printf("%03u ", q_thread_map[j][i]);
+		}
+		printf("\n");
+	}
+#endif
+}
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 4c45482a847c..f88a12b5a368 100644
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
@@ -878,6 +879,7 @@ struct ublk_thread_info {
 	sem_t 			*ready;
 	cpu_set_t 		*affinity;
 	unsigned long long	extra_flags;
+	unsigned char		(*q_thread_map)[UBLK_MAX_QUEUES];
 };
 
 static void ublk_thread_set_sched_affinity(const struct ublk_thread_info *info)
@@ -891,14 +893,18 @@ static void ublk_batch_setup_queues(struct ublk_thread *t)
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
+		if (t->q_map[i] == 0)
+			continue;
+
 		ret = ublk_batch_queue_prep_io_cmds(t, q);
-		ublk_assert(ret == 0);
-		ret = ublk_process_io(t);
 		ublk_assert(ret >= 0);
 	}
 }
@@ -912,6 +918,10 @@ static __attribute__((noinline)) int __ublk_io_handler_fn(struct ublk_thread_inf
 	int dev_id = info->dev->dev_info.dev_id;
 	int ret;
 
+	/* Copy per-thread queue mapping into thread-local variable */
+	if (info->q_thread_map)
+		memcpy(t.q_map, info->q_thread_map[info->idx], sizeof(t.q_map));
+
 	ret = ublk_thread_init(&t, info->extra_flags);
 	if (ret) {
 		ublk_err("ublk dev %d thread %u init failed\n",
@@ -927,12 +937,8 @@ static __attribute__((noinline)) int __ublk_io_handler_fn(struct ublk_thread_inf
 		/* submit all io commands to ublk driver */
 		ublk_submit_fetch_commands(&t);
 	} else {
-		struct ublk_queue *q = &t.dev->q[t.idx];
-
-		/* prepare all io commands in the 1st thread context */
-		if (!t.idx)
-			ublk_batch_setup_queues(&t);
-		ublk_batch_start_fetch(&t, q);
+		ublk_batch_setup_queues(&t);
+		ublk_batch_start_fetch(&t);
 	}
 
 	do {
@@ -1006,6 +1012,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	struct ublk_thread_info *tinfo;
 	unsigned long long extra_flags = 0;
 	cpu_set_t *affinity_buf;
+	unsigned char (*q_thread_map)[UBLK_MAX_QUEUES] = NULL;
 	void *thread_ret;
 	sem_t ready;
 	int ret, i;
@@ -1025,6 +1032,16 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	if (ret)
 		return ret;
 
+	if (ublk_dev_batch_io(dev)) {
+		q_thread_map = calloc(dev->nthreads, sizeof(*q_thread_map));
+		if (!q_thread_map) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+		ublk_batch_setup_map(q_thread_map, dev->nthreads,
+				     dinfo->nr_hw_queues);
+	}
+
 	if (ctx->auto_zc_fallback)
 		extra_flags = UBLKS_Q_AUTO_BUF_REG_FALLBACK;
 	if (ctx->no_ublk_fixed_fd)
@@ -1047,6 +1064,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		tinfo[i].idx = i;
 		tinfo[i].ready = &ready;
 		tinfo[i].extra_flags = extra_flags;
+		tinfo[i].q_thread_map = q_thread_map;
 
 		/*
 		 * If threads are not tied 1:1 to queues, setting thread
@@ -1066,6 +1084,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	for (i = 0; i < dev->nthreads; i++)
 		sem_wait(&ready);
 	free(affinity_buf);
+	free(q_thread_map);
 
 	/* everything is fine now, start us */
 	if (ctx->recovery)
@@ -1234,7 +1253,8 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 		goto fail;
 	}
 
-	if (nthreads != nr_queues && !ctx->per_io_tasks) {
+	if (nthreads != nr_queues && (!ctx->per_io_tasks &&
+				!(ctx->flags & UBLK_F_BATCH_IO))) {
 		ublk_err("%s: threads %u must be same as queues %u if "
 			"not using per_io_tasks\n",
 			__func__, nthreads, nr_queues);
@@ -1758,6 +1778,13 @@ int main(int argc, char *argv[])
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
index 222501048c24..565819cf2dfe 100644
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
@@ -198,8 +202,12 @@ struct batch_fetch_buf {
 };
 
 struct ublk_thread {
+	/* Thread-local copy of queue-to-thread mapping for this thread */
+	unsigned char q_map[UBLK_MAX_QUEUES];
+
 	struct ublk_dev *dev;
-	unsigned idx;
+	unsigned short idx;
+	unsigned short nr_queues;
 
 #define UBLKS_T_STOPPING	(1U << 0)
 #define UBLKS_T_IDLE	(1U << 1)
@@ -222,10 +230,10 @@ struct ublk_thread {
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
 
 	struct io_uring ring;
 };
@@ -465,6 +473,21 @@ static inline int ublk_queue_no_buf(const struct ublk_queue *q)
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
+	idx = t->q_map[q->q_id];
+	ublk_assert(idx != 0);
+	return idx - 1;
+}
+
 /*
  * Each IO's buffer index has to be calculated by this helper for
  * UBLKS_T_BATCH_IO
@@ -473,14 +496,13 @@ static inline unsigned short ublk_batch_io_buf_idx(
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
@@ -498,6 +520,8 @@ void ublk_batch_commit_io_cmds(struct ublk_thread *t);
 /* Add a completed I/O operation to the current batch commit buffer */
 void ublk_batch_complete_io(struct ublk_thread *t, struct ublk_queue *q,
 			    unsigned tag, int res);
+void ublk_batch_setup_map(unsigned char (*q_thread_map)[UBLK_MAX_QUEUES],
+			   int nthreads, int queues);
 
 static inline int ublk_complete_io(struct ublk_thread *t, struct ublk_queue *q,
 				   unsigned tag, int res)
diff --git a/tools/testing/selftests/ublk/test_generic_15.sh b/tools/testing/selftests/ublk/test_generic_15.sh
new file mode 100755
index 000000000000..0afd037235cf
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_15.sh
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
index 000000000000..32bcf4a3d0b4
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_16.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_16"
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

