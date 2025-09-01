Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9330FF06
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721060; cv=none; b=B3MKuBsx7p20fDoVml/1qq43uDg1Pw+O9FUjAvdw1uN2pmlKr77AyjUVbl97mzxRqD0xUhaYqUbdviyMNNwLDSDeZ089L7YtkPBCC2BFpK8P/ghGk4D3I6SAhAG17YCusAOomBMwrR3WixWcfvbKuifm/HM68oyh7agdX+zu36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721060; c=relaxed/simple;
	bh=lZP9u6djhDQNUCzpnQVoRWe5jkFYPgwj2MrVCqgblnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpyZSCrboXz0BOkR+1w1wPhuyRXmokQUGCpZjaJonWsxWbhkD1N5+E2OLkPb9cWhoMQZbb4Qwa8Q2HqZ3Q3zHI0Na8BNTl+n6yOAgHOvSceqLpz7G3RWgx1sVGqJRqwA7Io7wqt2vos/ZVyY3706i3flHJuMC1rJGoLrGZnU3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpEB1T68; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpEB1T68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1jkZq7yFCBArcoPuAP25YzCpb4iSnd8Ega4BKOfOsc=;
	b=WpEB1T687c0qQmlwCFbXIPQ/C59+LUY/yBgpgiOREGLHFw9GbLF9dTJCi2Leb2YD5kaTNe
	Y8RH8izB1DPrAwSGv+swaw1B+fsnYsb85f8WdsWeIhWAXjE9iet7IRAPwMNEyk3MBfnDob
	5hWzosyxSDlP0yGRqRonzJLdFSJT6v4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-vJqD8XFIOp2lvN1P8v09HA-1; Mon,
 01 Sep 2025 06:04:16 -0400
X-MC-Unique: vJqD8XFIOp2lvN1P8v09HA-1
X-Mimecast-MFC-AGG-ID: vJqD8XFIOp2lvN1P8v09HA_1756721056
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E79C21956087;
	Mon,  1 Sep 2025 10:04:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CC301955E89;
	Mon,  1 Sep 2025 10:04:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 21/23] selftests: ublk: handle UBLK_U_IO_FETCH_IO_CMDS
Date: Mon,  1 Sep 2025 18:02:38 +0800
Message-ID: <20250901100242.3231000-22-ming.lei@redhat.com>
In-Reply-To: <20250901100242.3231000-1-ming.lei@redhat.com>
References: <20250901100242.3231000-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support for UBLK_U_IO_FETCH_IO_CMDS to enable efficient batch
fetching of I/O commands using multishot io_uring operations.

Key improvements:
- Implement multishot UBLK_U_IO_FETCH_IO_CMDS for continuous command fetching
- Add fetch buffer management with page-aligned, mlocked buffers
- Process fetched I/O command tags from kernel-provided buffers
- Integrate fetch operations with existing batch I/O infrastructure
- Significantly reduce uring_cmd issuing overhead through batching

The implementation uses two fetch buffers per thread with automatic
requeuing to maintain continuous I/O command flow. Each fetch operation
retrieves multiple command tags in a single syscall, dramatically
improving performance compared to individual command fetching.

Technical details:
- Fetch buffers are page-aligned and mlocked for optimal performance
- Uses IORING_URING_CMD_MULTISHOT for continuous operation
- Automatic buffer management and requeuing on completion
- Enhanced CQE handling for fetch command completions

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/batch.c | 142 ++++++++++++++++++++++++++-
 tools/testing/selftests/ublk/kublk.c |  14 ++-
 tools/testing/selftests/ublk/kublk.h |  14 +++
 3 files changed, 166 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index 83f6df61fed9..7f196be8e0e1 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -136,15 +136,63 @@ void ublk_batch_prepare(struct ublk_thread *t)
 	t->state |= UBLKS_T_BATCH_IO;
 }
 
+static void free_batch_fetch_buf(struct ublk_thread *t)
+{
+	int i;
+
+	for (i = 0; i < UBLKS_T_NR_FETCH_BUF; i++) {
+		io_uring_free_buf_ring(&t->ring, t->fetch[i].br, 1, i);
+		munlock(t->fetch[i].fetch_buf, t->fetch[i].fetch_buf_size);
+		free(t->fetch[i].fetch_buf);
+	}
+}
+
+static int alloc_batch_fetch_buf(struct ublk_thread *t)
+{
+	/* page aligned fetch buffer, and it is mlocked for speedup delivery */
+	unsigned pg_sz = getpagesize();
+	unsigned buf_size = round_up(t->dev->dev_info.queue_depth * 2, pg_sz);
+	int ret;
+	int i = 0;
+
+	for (i = 0; i < UBLKS_T_NR_FETCH_BUF; i++) {
+		t->fetch[i].fetch_buf_size = buf_size;
+
+		if (posix_memalign((void **)&t->fetch[i].fetch_buf, pg_sz,
+					t->fetch[i].fetch_buf_size))
+			return -ENOMEM;
+
+		/* lock fetch buffer page for fast fetching */
+		if (mlock(t->fetch[i].fetch_buf, t->fetch[i].fetch_buf_size))
+			ublk_err("%s: can't lock fetch buffer %s\n", __func__,
+				strerror(errno));
+		t->fetch[i].br = io_uring_setup_buf_ring(&t->ring, 1,
+			i, IOU_PBUF_RING_INC, &ret);
+		if (!t->fetch[i].br) {
+			ublk_err("Buffer ring register failed %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int ublk_batch_alloc_buf(struct ublk_thread *t)
 {
+	int ret;
+
 	ublk_assert(t->nr_commit_buf < 16);
-	return alloc_batch_commit_buf(t);
+
+	ret = alloc_batch_commit_buf(t);
+	if (ret)
+		return ret;
+	return alloc_batch_fetch_buf(t);
 }
 
 void ublk_batch_free_buf(struct ublk_thread *t)
 {
 	free_batch_commit_buf(t);
+	free_batch_fetch_buf(t);
 }
 
 static void ublk_init_batch_cmd(struct ublk_thread *t, __u16 q_id,
@@ -196,6 +244,84 @@ static void ublk_setup_commit_sqe(struct ublk_thread *t,
 	cmd->flags |= t->cmd_flags;
 }
 
+static void ublk_batch_queue_fetch(struct ublk_thread *t,
+				   struct ublk_queue *q,
+				   unsigned short buf_idx)
+{
+	unsigned short nr_elem = t->fetch[buf_idx].fetch_buf_size / 2;
+	struct io_uring_sqe *sqe;
+
+	io_uring_buf_ring_add(t->fetch[buf_idx].br, t->fetch[buf_idx].fetch_buf,
+			t->fetch[buf_idx].fetch_buf_size,
+			0, 0, 0);
+	io_uring_buf_ring_advance(t->fetch[buf_idx].br, 1);
+
+	ublk_io_alloc_sqes(t, &sqe, 1);
+
+	ublk_init_batch_cmd(t, q->q_id, sqe, UBLK_U_IO_FETCH_IO_CMDS, 2, nr_elem,
+			buf_idx);
+
+	sqe->rw_flags= IORING_URING_CMD_MULTISHOT;
+	sqe->buf_group = buf_idx;
+	sqe->flags |= IOSQE_BUFFER_SELECT;
+
+	t->fetch[buf_idx].fetch_buf_off = 0;
+}
+
+void ublk_batch_start_fetch(struct ublk_thread *t,
+			    struct ublk_queue *q)
+{
+	int i;
+
+	for (i = 0; i < UBLKS_T_NR_FETCH_BUF; i++)
+		ublk_batch_queue_fetch(t, q, i);
+}
+
+static unsigned short ublk_compl_batch_fetch(struct ublk_thread *t,
+				   struct ublk_queue *q,
+				   const struct io_uring_cqe *cqe)
+{
+	unsigned short buf_idx = user_data_to_tag(cqe->user_data);
+	unsigned start = t->fetch[buf_idx].fetch_buf_off;
+	unsigned end = start + cqe->res;
+	void *buf = t->fetch[buf_idx].fetch_buf;
+	int i;
+
+	if (cqe->res < 0) {
+		if (cqe->res == -ENOBUFS) {
+			if (start != t->fetch[buf_idx].fetch_buf_size)
+				ublk_err("%s: maybe cq overflow done %u\n", __func__, start);
+		}
+		return buf_idx;
+	}
+
+       if ((end - start) / 2 > q->q_depth) {
+               ublk_err("%s: fetch duplicated ios offset %u count %u\n", __func__, start, cqe->res);
+
+               for (i = start; i < end; i += 2) {
+                       unsigned short tag = *(unsigned short *)(buf + i);
+
+                       ublk_err("%u ", tag);
+               }
+               ublk_err("\n");
+       }
+
+	for (i = start; i < end; i += 2) {
+		unsigned short tag = *(unsigned short *)(buf + i);
+
+		if (tag == UBLK_BATCH_IO_UNUSED_TAG)
+			continue;
+
+		if (tag >= q->q_depth)
+			ublk_err("%s: bad tag %u\n", __func__, tag);
+
+		if (q->tgt_ops->queue_io)
+			q->tgt_ops->queue_io(t, q, tag);
+	}
+	t->fetch[buf_idx].fetch_buf_off = end;
+	return buf_idx;
+}
+
 int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q)
 {
 	unsigned short nr_elem = q->q_depth;
@@ -255,12 +381,26 @@ void ublk_batch_compl_cmd(struct ublk_thread *t,
 			  const struct io_uring_cqe *cqe)
 {
 	unsigned op = user_data_to_op(cqe->user_data);
+	struct ublk_queue *q;
+	unsigned buf_idx;
+	unsigned q_id;
 
 	if (op == _IOC_NR(UBLK_U_IO_PREP_IO_CMDS) ||
 			op == _IOC_NR(UBLK_U_IO_COMMIT_IO_CMDS)) {
 		ublk_batch_compl_commit_cmd(t, cqe, op);
 		return;
 	}
+
+	/* FETCH command is per queue */
+	q_id = user_data_to_q_id(cqe->user_data);
+	q = &t->dev->q[q_id];
+	buf_idx = ublk_compl_batch_fetch(t, q, cqe);
+
+	if (cqe->res < 0 && cqe->res != -ENOBUFS) {
+		 t->state |= UBLKS_T_STOPPING;
+	} else if (!(cqe->flags & IORING_CQE_F_MORE) || cqe->res == -ENOBUFS) {
+		ublk_batch_queue_fetch(t, q, buf_idx);
+	}
 }
 
 void ublk_batch_commit_io_cmds(struct ublk_thread *t)
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 42e9e7fb8d88..ceb2e80304a6 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -489,6 +489,10 @@ static int ublk_thread_init(struct ublk_thread *t)
 	int ring_depth = dev->tgt.sq_depth, cq_depth = dev->tgt.cq_depth;
 	int ret;
 
+	/* FETCH_IO_CMDS is multishot, so increase cq depth for BATCH_IO */
+	if (ublk_dev_batch_io(dev))
+		cq_depth += dev->dev_info.queue_depth;
+
 	ret = ublk_setup_ring(&t->ring, ring_depth, cq_depth,
 			IORING_SETUP_COOP_TASKRUN |
 			IORING_SETUP_SINGLE_ISSUER |
@@ -780,7 +784,7 @@ static void ublk_handle_cqe(struct ublk_thread *t,
 	unsigned q_id = user_data_to_q_id(cqe->user_data);
 	unsigned cmd_op = user_data_to_op(cqe->user_data);
 
-	if (cqe->res < 0 && cqe->res != -ENODEV)
+	if (cqe->res < 0 && cqe->res != -ENODEV && cqe->res != -ENOBUFS)
 		ublk_err("%s: res %d userdata %llx thread state %x\n", __func__,
 				cqe->res, cqe->user_data, t->state);
 
@@ -908,9 +912,13 @@ static void *ublk_io_handler_fn(void *data)
 	if (!ublk_thread_batch_io(t)) {
 		/* submit all io commands to ublk driver */
 		ublk_submit_fetch_commands(t);
-	} else if (!t->idx) {
+	} else {
+		struct ublk_queue *q = &t->dev->q[t->idx];
+
 		/* prepare all io commands in the 1st thread context */
-		ublk_batch_setup_queues(t);
+		if (!t->idx)
+			ublk_batch_setup_queues(t);
+		ublk_batch_start_fetch(t, q);
 	}
 
 	do {
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index e51ef2f32b5b..bfc010b66952 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -187,6 +187,13 @@ struct batch_commit_buf {
 	unsigned short count;
 };
 
+struct batch_fetch_buf {
+	struct io_uring_buf_ring *br;
+	void *fetch_buf;
+	unsigned int fetch_buf_size;
+	unsigned int fetch_buf_off;
+};
+
 struct ublk_thread {
 	struct ublk_dev *dev;
 	struct io_uring ring;
@@ -216,6 +223,10 @@ struct ublk_thread {
 #define UBLKS_T_COMMIT_BUF_INV_IDX  ((unsigned short)-1)
 	struct allocator commit_buf_alloc;
 	struct batch_commit_buf commit;
+
+	/* FETCH_IO_CMDS buffer */
+#define UBLKS_T_NR_FETCH_BUF 	2
+	struct batch_fetch_buf fetch[UBLKS_T_NR_FETCH_BUF];
 };
 
 struct ublk_dev {
@@ -453,6 +464,9 @@ static inline unsigned short ublk_batch_io_buf_idx(
 
 /* Queue UBLK_U_IO_PREP_IO_CMDS for a specific queue with batch elements */
 int ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_queue *q);
+/* Start fetching I/O commands using multishot UBLK_U_IO_FETCH_IO_CMDS */
+void ublk_batch_start_fetch(struct ublk_thread *t,
+			    struct ublk_queue *q);
 /* Handle completion of batch I/O commands (prep/commit) */
 void ublk_batch_compl_cmd(struct ublk_thread *t,
 			  const struct io_uring_cqe *cqe);
-- 
2.47.0

