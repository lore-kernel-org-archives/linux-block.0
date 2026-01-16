Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797C331A48
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573241; cv=none; b=STNVziiXA1SQHvmIQ4hNLRhF7SoLDgkzX9Gu1koIQ826kECioNaDiVGL1kjH2wGnmH108WBAdxlKFII7EzUr2MSvci6ILQMngwlCQOc2xI03wQ6k4A5FVVCuXFjHwj657OtlbbBLOQqRZAN0F5Fobq1gzpPqBY0GFh2nR5flI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573241; c=relaxed/simple;
	bh=7I0bpw1zuDrMSd9kvF9q5fkckR+S7XYxh1FtxMUY/Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb3A/DiDdDZIGOBoEe8uqDSBzZMYPLpNJKKJXtqCsWAeiw2izpTPZDjDnirnW9VhtDDOde3jb6hMtXQ+9qVlNZACzagN0u5ANaOMi8TpzXNPL6B48o6oVNHf65dUyWzxVS7xww0JJ2g0JMV++0njk2wN+Ey/98UPNrz5pxb9lcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPKbPl5z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPKbPl5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OPEdbfGTcDgB86WbAxw++74iT3Aa9rUHCm+8DnwNGE=;
	b=NPKbPl5zOJ++U/03O5twWvkpK/nkZAJAYWrbreXmW2d9frhVUt5HzKLeo2uH0J46NTRN6k
	lJ0+IcHkNdoeISWTRP3O2WToCndvd9SteAJYq2XA99ITQhK4zNRUUrwiT5TS32NTuQzRu2
	uX2KP7bLE2wT9hIsMhHGfyquhISEDZA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-VZhy02ZpO9SLcPMuV6JiKQ-1; Fri,
 16 Jan 2026 09:20:34 -0500
X-MC-Unique: VZhy02ZpO9SLcPMuV6JiKQ-1
X-Mimecast-MFC-AGG-ID: VZhy02ZpO9SLcPMuV6JiKQ_1768573233
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45F631800378;
	Fri, 16 Jan 2026 14:20:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 614401955F22;
	Fri, 16 Jan 2026 14:20:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 18/24] selftests: ublk: add batch buffer management infrastructure
Date: Fri, 16 Jan 2026 22:18:51 +0800
Message-ID: <20260116141859.719929-19-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add the foundational infrastructure for UBLK_F_BATCH_IO buffer
management including:

- Allocator utility functions for small sized per-thread allocation
- Batch buffer allocation and deallocation functions
- Buffer index management for commit buffers
- Thread state management for batch I/O mode
- Buffer size calculation based on device features

This prepares the groundwork for handling batch I/O commands by
establishing the buffer management layer needed for UBLK_U_IO_PREP_IO_CMDS
and UBLK_U_IO_COMMIT_IO_CMDS operations.

The allocator uses CPU sets for efficient per-thread buffer tracking,
and commit buffers are pre-allocated with 2 buffers per thread to handle
overlapping command operations.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/batch.c | 152 +++++++++++++++++++++++++++
 tools/testing/selftests/ublk/kublk.c |  26 ++++-
 tools/testing/selftests/ublk/kublk.h |  53 ++++++++++
 tools/testing/selftests/ublk/utils.h |  54 ++++++++++
 4 files changed, 282 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/batch.c

diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
new file mode 100644
index 000000000000..609e6073c9c0
--- /dev/null
+++ b/tools/testing/selftests/ublk/batch.c
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Description: UBLK_F_BATCH_IO buffer management
+ */
+
+#include "kublk.h"
+
+static inline void *ublk_get_commit_buf(struct ublk_thread *t,
+					unsigned short buf_idx)
+{
+	unsigned idx;
+
+	if (buf_idx < t->commit_buf_start ||
+			buf_idx >= t->commit_buf_start + t->nr_commit_buf)
+		return NULL;
+	idx = buf_idx - t->commit_buf_start;
+	return t->commit_buf + idx * t->commit_buf_size;
+}
+
+/*
+ * Allocate one buffer for UBLK_U_IO_PREP_IO_CMDS or UBLK_U_IO_COMMIT_IO_CMDS
+ *
+ * Buffer index is returned.
+ */
+static inline unsigned short ublk_alloc_commit_buf(struct ublk_thread *t)
+{
+	int idx = allocator_get(&t->commit_buf_alloc);
+
+	if (idx >= 0)
+		return  idx + t->commit_buf_start;
+	return UBLKS_T_COMMIT_BUF_INV_IDX;
+}
+
+/*
+ * Free one commit buffer which is used by UBLK_U_IO_PREP_IO_CMDS or
+ * UBLK_U_IO_COMMIT_IO_CMDS
+ */
+static inline void ublk_free_commit_buf(struct ublk_thread *t,
+					 unsigned short i)
+{
+	unsigned short idx = i - t->commit_buf_start;
+
+	ublk_assert(idx < t->nr_commit_buf);
+	ublk_assert(allocator_get_val(&t->commit_buf_alloc, idx) != 0);
+
+	allocator_put(&t->commit_buf_alloc, idx);
+}
+
+static unsigned char ublk_commit_elem_buf_size(struct ublk_dev *dev)
+{
+	if (dev->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_USER_COPY |
+				UBLK_F_AUTO_BUF_REG))
+		return 8;
+
+	/* one extra 8bytes for carrying buffer address */
+	return 16;
+}
+
+static unsigned ublk_commit_buf_size(struct ublk_thread *t)
+{
+	struct ublk_dev *dev = t->dev;
+	unsigned elem_size = ublk_commit_elem_buf_size(dev);
+	unsigned int total = elem_size * dev->dev_info.queue_depth;
+	unsigned int page_sz = getpagesize();
+
+	return round_up(total, page_sz);
+}
+
+static void free_batch_commit_buf(struct ublk_thread *t)
+{
+	if (t->commit_buf) {
+		unsigned buf_size = ublk_commit_buf_size(t);
+		unsigned int total = buf_size * t->nr_commit_buf;
+
+		munlock(t->commit_buf, total);
+		free(t->commit_buf);
+	}
+	allocator_deinit(&t->commit_buf_alloc);
+}
+
+static int alloc_batch_commit_buf(struct ublk_thread *t)
+{
+	unsigned buf_size = ublk_commit_buf_size(t);
+	unsigned int total = buf_size * t->nr_commit_buf;
+	unsigned int page_sz = getpagesize();
+	void *buf = NULL;
+	int ret;
+
+	allocator_init(&t->commit_buf_alloc, t->nr_commit_buf);
+
+	t->commit_buf = NULL;
+	ret = posix_memalign(&buf, page_sz, total);
+	if (ret || !buf)
+		goto fail;
+
+	t->commit_buf = buf;
+
+	/* lock commit buffer pages for fast access */
+	if (mlock(t->commit_buf, total))
+		ublk_err("%s: can't lock commit buffer %s\n", __func__,
+			strerror(errno));
+
+	return 0;
+
+fail:
+	free_batch_commit_buf(t);
+	return ret;
+}
+
+void ublk_batch_prepare(struct ublk_thread *t)
+{
+	/*
+	 * We only handle single device in this thread context.
+	 *
+	 * All queues have same feature flags, so use queue 0's for
+	 * calculate uring_cmd flags.
+	 *
+	 * This way looks not elegant, but it works so far.
+	 */
+	struct ublk_queue *q = &t->dev->q[0];
+
+	t->commit_buf_elem_size = ublk_commit_elem_buf_size(t->dev);
+	t->commit_buf_size = ublk_commit_buf_size(t);
+	t->commit_buf_start = t->nr_bufs;
+	t->nr_commit_buf = 2;
+	t->nr_bufs += t->nr_commit_buf;
+
+	t->cmd_flags = 0;
+	if (ublk_queue_use_auto_zc(q)) {
+		if (ublk_queue_auto_zc_fallback(q))
+			t->cmd_flags |= UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK;
+	} else if (!ublk_queue_no_buf(q))
+		t->cmd_flags |= UBLK_BATCH_F_HAS_BUF_ADDR;
+
+	t->state |= UBLKS_T_BATCH_IO;
+
+	ublk_log("%s: thread %d commit(nr_bufs %u, buf_size %u, start %u)\n",
+			__func__, t->idx,
+			t->nr_commit_buf, t->commit_buf_size,
+			t->nr_bufs);
+}
+
+int ublk_batch_alloc_buf(struct ublk_thread *t)
+{
+	ublk_assert(t->nr_commit_buf < 16);
+	return alloc_batch_commit_buf(t);
+}
+
+void ublk_batch_free_buf(struct ublk_thread *t)
+{
+	free_batch_commit_buf(t);
+}
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 51c4e20898a7..97248681d0e4 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -435,6 +435,8 @@ static void ublk_thread_deinit(struct ublk_thread *t)
 {
 	io_uring_unregister_buffers(&t->ring);
 
+	ublk_batch_free_buf(t);
+
 	io_uring_unregister_ring_fd(&t->ring);
 
 	if (t->ring.ring_fd > 0) {
@@ -531,15 +533,33 @@ static int ublk_thread_init(struct ublk_thread *t, unsigned long long extra_flag
 		unsigned nr_ios = dev->dev_info.queue_depth * dev->dev_info.nr_hw_queues;
 		unsigned max_nr_ios_per_thread = nr_ios / dev->nthreads;
 		max_nr_ios_per_thread += !!(nr_ios % dev->nthreads);
-		ret = io_uring_register_buffers_sparse(
-			&t->ring, max_nr_ios_per_thread);
+
+		t->nr_bufs = max_nr_ios_per_thread;
+	} else {
+		t->nr_bufs = 0;
+	}
+
+	if (ublk_dev_batch_io(dev))
+		 ublk_batch_prepare(t);
+
+	if (t->nr_bufs) {
+		ret = io_uring_register_buffers_sparse(&t->ring, t->nr_bufs);
 		if (ret) {
-			ublk_err("ublk dev %d thread %d register spare buffers failed %d",
+			ublk_err("ublk dev %d thread %d register spare buffers failed %d\n",
 					dev->dev_info.dev_id, t->idx, ret);
 			goto fail;
 		}
 	}
 
+	if (ublk_dev_batch_io(dev)) {
+		ret = ublk_batch_alloc_buf(t);
+		if (ret) {
+			ublk_err("ublk dev %d thread %d alloc batch buf failed %d\n",
+				dev->dev_info.dev_id, t->idx, ret);
+			goto fail;
+		}
+	}
+
 	io_uring_register_ring_fd(&t->ring);
 
 	if (flags & UBLKS_Q_NO_UBLK_FIXED_FD) {
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 311a75da9b21..424c333596ac 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -182,15 +182,40 @@ struct ublk_queue {
 	struct ublk_io ios[UBLK_QUEUE_DEPTH];
 };
 
+/* align with `ublk_elem_header` */
+struct ublk_batch_elem {
+	__u16 tag;
+	__u16 buf_index;
+	__s32 result;
+	__u64 buf_addr;
+};
+
 struct ublk_thread {
 	struct ublk_dev *dev;
 	unsigned idx;
 
 #define UBLKS_T_STOPPING	(1U << 0)
 #define UBLKS_T_IDLE	(1U << 1)
+#define UBLKS_T_BATCH_IO	(1U << 31) 	/* readonly */
 	unsigned state;
 	unsigned int cmd_inflight;
 	unsigned int io_inflight;
+
+	unsigned short nr_bufs;
+
+       /* followings are for BATCH_IO */
+	unsigned short commit_buf_start;
+	unsigned char  commit_buf_elem_size;
+       /*
+        * We just support single device, so pre-calculate commit/prep flags
+        */
+	unsigned short cmd_flags;
+	unsigned int   nr_commit_buf;
+	unsigned int   commit_buf_size;
+	void *commit_buf;
+#define UBLKS_T_COMMIT_BUF_INV_IDX  ((unsigned short)-1)
+	struct allocator commit_buf_alloc;
+
 	struct io_uring ring;
 };
 
@@ -211,6 +236,27 @@ struct ublk_dev {
 
 extern int ublk_queue_io_cmd(struct ublk_thread *t, struct ublk_io *io);
 
+static inline int __ublk_use_batch_io(__u64 flags)
+{
+	return flags & UBLK_F_BATCH_IO;
+}
+
+static inline int ublk_queue_batch_io(const struct ublk_queue *q)
+{
+	return __ublk_use_batch_io(q->flags);
+}
+
+static inline int ublk_dev_batch_io(const struct ublk_dev *dev)
+{
+	return __ublk_use_batch_io(dev->dev_info.flags);
+}
+
+/* only work for handle single device in this pthread context */
+static inline int ublk_thread_batch_io(const struct ublk_thread *t)
+{
+	return t->state & UBLKS_T_BATCH_IO;
+}
+
 static inline void ublk_set_integrity_params(const struct dev_ctx *ctx,
 					     struct ublk_params *params)
 {
@@ -465,6 +511,13 @@ static inline int ublk_queue_no_buf(const struct ublk_queue *q)
 	return ublk_queue_use_zc(q) || ublk_queue_use_auto_zc(q);
 }
 
+/* Initialize batch I/O state and calculate buffer parameters */
+void ublk_batch_prepare(struct ublk_thread *t);
+/* Allocate and register commit buffers for batch operations */
+int ublk_batch_alloc_buf(struct ublk_thread *t);
+/* Free commit buffers and cleanup batch allocator */
+void ublk_batch_free_buf(struct ublk_thread *t);
+
 extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
diff --git a/tools/testing/selftests/ublk/utils.h b/tools/testing/selftests/ublk/utils.h
index 17eefed73690..aab522f26167 100644
--- a/tools/testing/selftests/ublk/utils.h
+++ b/tools/testing/selftests/ublk/utils.h
@@ -21,6 +21,60 @@
 #define round_up(val, rnd) \
 	(((val) + ((rnd) - 1)) & ~((rnd) - 1))
 
+/* small sized & per-thread allocator */
+struct allocator {
+	unsigned int size;
+	cpu_set_t *set;
+};
+
+static inline int allocator_init(struct allocator *a, unsigned size)
+{
+	a->set = CPU_ALLOC(size);
+	a->size = size;
+
+	if (a->set)
+		return 0;
+	return -ENOMEM;
+}
+
+static inline void allocator_deinit(struct allocator *a)
+{
+	CPU_FREE(a->set);
+	a->set = NULL;
+	a->size = 0;
+}
+
+static inline int allocator_get(struct allocator *a)
+{
+	int i;
+
+	for (i = 0; i < a->size; i += 1) {
+		size_t set_size = CPU_ALLOC_SIZE(a->size);
+
+		if (!CPU_ISSET_S(i, set_size, a->set)) {
+			CPU_SET_S(i, set_size, a->set);
+			return i;
+		}
+	}
+
+	return -1;
+}
+
+static inline void allocator_put(struct allocator *a, int i)
+{
+	size_t set_size = CPU_ALLOC_SIZE(a->size);
+
+	if (i >= 0 && i < a->size)
+		CPU_CLR_S(i, set_size, a->set);
+}
+
+static inline int allocator_get_val(struct allocator *a, int i)
+{
+	size_t set_size = CPU_ALLOC_SIZE(a->size);
+
+	return CPU_ISSET_S(i, set_size, a->set);
+}
+
 static inline unsigned int ilog2(unsigned int x)
 {
 	if (x == 0)
-- 
2.47.0

