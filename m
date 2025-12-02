Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A33115AE
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678066; cv=none; b=pNUeLyHe5k5vPXzUGuH5Gg39gO317FVKOhV0WsjeeeabeDgvq85wNFP+wgWcJUzCAXUCcjLB3pcst757GjgWTbFEauOkQOVzynqAJnTmB7I/zoe16G4tefmyGXrEWNyaVkILFNt9QED2wz7qLhPeSx4BKA+llnJlRFqlaD2UAos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678066; c=relaxed/simple;
	bh=gPpArv/icUOTFOO7Vwj6AxDau6A7TKeECVn3O9rqyes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITNS7vM7F1kN+84Lyh7NtCdxW60KR/ans4wUgKa0wq9Hv7FJL5KxpfoByfyL9p4j5WM/OM/UndC7LkxPj8sDWpMh3FkIgbqhEplVTbhUvQ/RwyWvBxctJEppZd+BfWenPFTAYYxpJBUU66jOilpEMk27/Zm/e1wlwRK28T5M9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUesqAR5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUesqAR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764678062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiTGtCU5WfrL/txmfxpIdAOyWBSYyfikH6Id/auTmKI=;
	b=CUesqAR5gsXU6KsObZUK3L6XHR9Hcy9B3VG6gSlZ3xfU6GZQ+UP0diJPvXUGgx0JtZRfwT
	FQDhF58FVIS2AqxdGtW8di2Xmu5bCCtSEoldJ0Llq5h4cy4sUfAwCuc3ZgoXQ0HFgLcAJA
	wYgH1AD8tgWnPbPWQZxsNuB51kQTZa8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-SIril_PMPQu5wgne06bJvQ-1; Tue,
 02 Dec 2025 07:20:57 -0500
X-MC-Unique: SIril_PMPQu5wgne06bJvQ-1
X-Mimecast-MFC-AGG-ID: SIril_PMPQu5wgne06bJvQ_1764678056
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 619AD19560A7;
	Tue,  2 Dec 2025 12:20:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4BD6A180047F;
	Tue,  2 Dec 2025 12:20:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 08/21] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
Date: Tue,  2 Dec 2025 20:19:02 +0800
Message-ID: <20251202121917.1412280-9-ming.lei@redhat.com>
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

Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch processing
of I/O requests. This multishot uring_cmd allows the ublk server to fetch
multiple I/O commands in a single operation, significantly reducing
submission overhead compared to individual FETCH_REQ* commands.

Key Design Features:

1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch many I/O
   commands, with the batch size limited by the provided buffer length.

2. Dynamic Load Balancing: Multiple fetch commands can be submitted
   simultaneously, but only one is active at any time. This enables
   efficient load distribution across multiple server task contexts.

3. Implicit State Management: The implementation uses three key variables
   to track state:
   - evts_fifo: Queue of request tags awaiting processing
   - fcmd_head: List of available fetch commands
   - active_fcmd: Currently active fetch command (NULL = none active)

   States are derived implicitly:
   - IDLE: No fetch commands available
   - READY: Fetch commands available, none active
   - ACTIVE: One fetch command processing events

4. Lockless Reader Optimization: The active fetch command can read from
   evts_fifo without locking (single reader guarantee), while writers
   (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection. The memory
   barrier pairing plays key role for the single lockless reader
   optimization.

Implementation Details:

- ublk_queue_rq() and ublk_queue_rqs() save request tags to evts_fifo
- __ublk_acquire_fcmd() selects an available fetch command when
  events arrive and no command is currently active
- ublk_batch_dispatch() moves tags from evts_fifo to the fetch command's
  buffer and posts completion via io_uring_mshot_cmd_post_cqe()
- State transitions are coordinated via evts_lock to maintain consistency

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 392 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |   7 +
 2 files changed, 391 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 05bf9786751f..de6ce0e17b1b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -93,6 +93,7 @@
 
 /* ublk batch fetch uring_cmd */
 struct ublk_batch_fetch_cmd {
+	struct list_head node;
 	struct io_uring_cmd *cmd;
 	unsigned short buf_group;
 };
@@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
 	 */
 	struct ublk_queue *ubq;
 
-	u16 tag;
+	union {
+		u16 tag;
+		struct ublk_batch_fetch_cmd *fcmd; /* batch io only */
+	};
 };
 
 struct ublk_batch_io_data {
@@ -239,10 +243,37 @@ struct ublk_queue {
 	 * Make sure just one reader for fetching request from task work
 	 * function to ublk server, so no need to grab the lock in reader
 	 * side.
+	 *
+	 * Batch I/O State Management:
+	 *
+	 * The batch I/O system uses implicit state management based on the
+	 * combination of three key variables below.
+	 *
+	 * - IDLE: list_empty(&fcmd_head) && !active_fcmd
+	 *   No fetch commands available, events queue in evts_fifo
+	 *
+	 * - READY: !list_empty(&fcmd_head) && !active_fcmd
+	 *   Fetch commands available but none processing events
+	 *
+	 * - ACTIVE: active_fcmd
+	 *   One fetch command actively processing events from evts_fifo
+	 *
+	 * Key Invariants:
+	 * - At most one active_fcmd at any time (single reader)
+	 * - active_fcmd is always from fcmd_head list when non-NULL
+	 * - evts_fifo can be read locklessly by the single active reader
+	 * - All state transitions require evts_lock protection
+	 * - Multiple writers to evts_fifo require lock protection
 	 */
 	struct {
 		DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
 		spinlock_t evts_lock;
+
+		/* List of fetch commands available to process events */
+		struct list_head fcmd_head;
+
+		/* Currently active fetch command (NULL = none active) */
+		struct ublk_batch_fetch_cmd  *active_fcmd;
 	}____cacheline_aligned_in_smp;
 
 	struct ublk_io ios[] __counted_by(q_depth);
@@ -294,12 +325,20 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
+static void ublk_batch_dispatch(struct ublk_queue *ubq,
+				const struct ublk_batch_io_data *data,
+				struct ublk_batch_fetch_cmd *fcmd);
 
 static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
 {
 	return false;
 }
 
+static inline bool ublk_support_batch_io(const struct ublk_queue *ubq)
+{
+	return false;
+}
+
 static inline void ublk_io_lock(struct ublk_io *io)
 {
 	spin_lock(&io->lock);
@@ -620,13 +659,45 @@ static wait_queue_head_t ublk_idr_wq;	/* wait until one idr is freed */
 
 static DEFINE_MUTEX(ublk_ctl_mutex);
 
+static struct ublk_batch_fetch_cmd *
+ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
+{
+	struct ublk_batch_fetch_cmd *fcmd = kzalloc(sizeof(*fcmd), GFP_NOIO);
 
-static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data *data,
+	if (fcmd) {
+		fcmd->cmd = cmd;
+		fcmd->buf_group = READ_ONCE(cmd->sqe->buf_index);
+	}
+	return fcmd;
+}
+
+static void ublk_batch_free_fcmd(struct ublk_batch_fetch_cmd *fcmd)
+{
+	kfree(fcmd);
+}
+
+static void __ublk_release_fcmd(struct ublk_queue *ubq)
+{
+	WRITE_ONCE(ubq->active_fcmd, NULL);
+}
+
+/*
+ * Nothing can move on, so clear ->active_fcmd, and the caller should stop
+ * dispatching
+ */
+static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
+					const struct ublk_batch_io_data *data,
 					struct ublk_batch_fetch_cmd *fcmd,
 					int res)
 {
+	spin_lock(&ubq->evts_lock);
+	list_del(&fcmd->node);
+	WARN_ON_ONCE(fcmd != ubq->active_fcmd);
+	__ublk_release_fcmd(ubq);
+	spin_unlock(&ubq->evts_lock);
+
 	io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
-	fcmd->cmd = NULL;
+	ublk_batch_free_fcmd(fcmd);
 }
 
 static int ublk_batch_fetch_post_cqe(struct ublk_batch_fetch_cmd *fcmd,
@@ -1489,6 +1560,8 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
 	bool needs_filter;
 	int ret;
 
+	WARN_ON_ONCE(data->cmd != fcmd->cmd);
+
 	sel = io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, &len,
 					 data->issue_flags);
 	if (sel.val < 0)
@@ -1552,21 +1625,92 @@ static int __ublk_batch_dispatch(struct ublk_queue *ubq,
 	return ret;
 }
 
-static __maybe_unused void
+static struct ublk_batch_fetch_cmd *__ublk_acquire_fcmd(
+		struct ublk_queue *ubq)
+{
+	struct ublk_batch_fetch_cmd *fcmd;
+
+	lockdep_assert_held(&ubq->evts_lock);
+
+	/*
+	 * Ordering updating ubq->evts_fifo and checking ubq->active_fcmd.
+	 *
+	 * The pair is the smp_mb() in ublk_batch_dispatch().
+	 *
+	 * If ubq->active_fcmd is observed as non-NULL, the new added tags
+	 * can be visisible in ublk_batch_dispatch() with the barrier pairing.
+	 */
+	smp_mb();
+	if (READ_ONCE(ubq->active_fcmd)) {
+		fcmd = NULL;
+	} else {
+		fcmd = list_first_entry_or_null(&ubq->fcmd_head,
+				struct ublk_batch_fetch_cmd, node);
+		WRITE_ONCE(ubq->active_fcmd, fcmd);
+	}
+	return fcmd;
+}
+
+static void ublk_batch_tw_cb(struct io_uring_cmd *cmd,
+			   unsigned int issue_flags)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_batch_fetch_cmd *fcmd = pdu->fcmd;
+	struct ublk_batch_io_data data = {
+		.ub = pdu->ubq->dev,
+		.cmd = fcmd->cmd,
+		.issue_flags = issue_flags,
+	};
+
+	WARN_ON_ONCE(pdu->ubq->active_fcmd != fcmd);
+
+	ublk_batch_dispatch(pdu->ubq, &data, fcmd);
+}
+
+static void
 ublk_batch_dispatch(struct ublk_queue *ubq,
 		    const struct ublk_batch_io_data *data,
 		    struct ublk_batch_fetch_cmd *fcmd)
 {
+	struct ublk_batch_fetch_cmd *new_fcmd;
+	unsigned tried = 0;
 	int ret = 0;
 
+again:
 	while (!ublk_io_evts_empty(ubq)) {
 		ret = __ublk_batch_dispatch(ubq, data, fcmd);
 		if (ret <= 0)
 			break;
 	}
 
-	if (ret < 0)
-		ublk_batch_deinit_fetch_buf(data, fcmd, ret);
+	if (ret < 0) {
+		ublk_batch_deinit_fetch_buf(ubq, data, fcmd, ret);
+		return;
+	}
+
+	__ublk_release_fcmd(ubq);
+	/*
+	 * Order clearing ubq->active_fcmd from __ublk_release_fcmd() and
+	 * checking ubq->evts_fifo.
+	 *
+	 * The pair is the smp_mb() in __ublk_acquire_fcmd().
+	 */
+	smp_mb();
+	if (likely(ublk_io_evts_empty(ubq)))
+		return;
+
+	spin_lock(&ubq->evts_lock);
+	new_fcmd = __ublk_acquire_fcmd(ubq);
+	spin_unlock(&ubq->evts_lock);
+
+	if (!new_fcmd)
+		return;
+
+	/* Avoid lockup by allowing to handle at most 32 batches */
+	if (new_fcmd == fcmd && tried++ < 32)
+		goto again;
+
+	io_uring_cmd_complete_in_task(new_fcmd->cmd, ublk_batch_tw_cb);
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
@@ -1578,6 +1722,21 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 	ublk_dispatch_req(ubq, pdu->req, issue_flags);
 }
 
+static void ublk_batch_queue_cmd(struct ublk_queue *ubq, struct request *rq, bool last)
+{
+	unsigned short tag = rq->tag;
+	struct ublk_batch_fetch_cmd *fcmd = NULL;
+
+	spin_lock(&ubq->evts_lock);
+	kfifo_put(&ubq->evts_fifo, tag);
+	if (last)
+		fcmd = __ublk_acquire_fcmd(ubq);
+	spin_unlock(&ubq->evts_lock);
+
+	if (fcmd)
+		io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb);
+}
+
 static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
 	struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
@@ -1688,7 +1847,10 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_OK;
 	}
 
-	ublk_queue_cmd(ubq, rq);
+	if (ublk_support_batch_io(ubq))
+		ublk_batch_queue_cmd(ubq, rq, bd->last);
+	else
+		ublk_queue_cmd(ubq, rq);
 	return BLK_STS_OK;
 }
 
@@ -1700,6 +1862,19 @@ static inline bool ublk_belong_to_same_batch(const struct ublk_io *io,
 		(io->task == io2->task);
 }
 
+static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct ublk_queue *ubq = hctx->driver_data;
+	struct ublk_batch_fetch_cmd *fcmd;
+
+	spin_lock(&ubq->evts_lock);
+	fcmd = __ublk_acquire_fcmd(ubq);
+	spin_unlock(&ubq->evts_lock);
+
+	if (fcmd)
+		io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb);
+}
+
 static void ublk_queue_rqs(struct rq_list *rqlist)
 {
 	struct rq_list requeue_list = { };
@@ -1728,6 +1903,57 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 	*rqlist = requeue_list;
 }
 
+static void ublk_batch_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
+{
+	unsigned short tags[MAX_NR_TAG];
+	struct ublk_batch_fetch_cmd *fcmd;
+	struct request *rq;
+	unsigned cnt = 0;
+
+	spin_lock(&ubq->evts_lock);
+	rq_list_for_each(l, rq) {
+		tags[cnt++] = (unsigned short)rq->tag;
+		if (cnt >= MAX_NR_TAG) {
+			kfifo_in(&ubq->evts_fifo, tags, cnt);
+			cnt = 0;
+		}
+	}
+	if (cnt)
+		kfifo_in(&ubq->evts_fifo, tags, cnt);
+	fcmd = __ublk_acquire_fcmd(ubq);
+	spin_unlock(&ubq->evts_lock);
+
+	rq_list_init(l);
+	if (fcmd)
+		io_uring_cmd_complete_in_task(fcmd->cmd, ublk_batch_tw_cb);
+}
+
+static void ublk_batch_queue_rqs(struct rq_list *rqlist)
+{
+	struct rq_list requeue_list = { };
+	struct rq_list submit_list = { };
+	struct ublk_queue *ubq = NULL;
+	struct request *req;
+
+	while ((req = rq_list_pop(rqlist))) {
+		struct ublk_queue *this_q = req->mq_hctx->driver_data;
+
+		if (ublk_prep_req(this_q, req, true) != BLK_STS_OK) {
+			rq_list_add_tail(&requeue_list, req);
+			continue;
+		}
+
+		if (ubq && this_q != ubq && !rq_list_empty(&submit_list))
+			ublk_batch_queue_cmd_list(ubq, &submit_list);
+		ubq = this_q;
+		rq_list_add_tail(&submit_list, req);
+	}
+
+	if (!rq_list_empty(&submit_list))
+		ublk_batch_queue_cmd_list(ubq, &submit_list);
+	*rqlist = requeue_list;
+}
+
 static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 		unsigned int hctx_idx)
 {
@@ -1745,6 +1971,14 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.timeout	= ublk_timeout,
 };
 
+static const struct blk_mq_ops ublk_batch_mq_ops = {
+	.commit_rqs	= ublk_commit_rqs,
+	.queue_rq       = ublk_queue_rq,
+	.queue_rqs      = ublk_batch_queue_rqs,
+	.init_hctx	= ublk_init_hctx,
+	.timeout	= ublk_timeout,
+};
+
 static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	int i;
@@ -2122,6 +2356,56 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, issue_flags);
 }
 
+static void ublk_batch_cancel_cmd(struct ublk_queue *ubq,
+				  struct ublk_batch_fetch_cmd *fcmd,
+				  unsigned int issue_flags)
+{
+	bool done;
+
+	spin_lock(&ubq->evts_lock);
+	done = (READ_ONCE(ubq->active_fcmd) != fcmd);
+	if (done)
+		list_del(&fcmd->node);
+	spin_unlock(&ubq->evts_lock);
+
+	if (done) {
+		io_uring_cmd_done(fcmd->cmd, UBLK_IO_RES_ABORT, issue_flags);
+		ublk_batch_free_fcmd(fcmd);
+	}
+}
+
+static void ublk_batch_cancel_queue(struct ublk_queue *ubq)
+{
+	struct ublk_batch_fetch_cmd *fcmd;
+	LIST_HEAD(fcmd_list);
+
+	spin_lock(&ubq->evts_lock);
+	ubq->force_abort = true;
+	list_splice_init(&ubq->fcmd_head, &fcmd_list);
+	fcmd = READ_ONCE(ubq->active_fcmd);
+	if (fcmd)
+		list_move(&fcmd->node, &ubq->fcmd_head);
+	spin_unlock(&ubq->evts_lock);
+
+	while (!list_empty(&fcmd_list)) {
+		fcmd = list_first_entry(&fcmd_list,
+				struct ublk_batch_fetch_cmd, node);
+		ublk_batch_cancel_cmd(ubq, fcmd, IO_URING_F_UNLOCKED);
+	}
+}
+
+static void ublk_batch_cancel_fn(struct io_uring_cmd *cmd,
+				 unsigned int issue_flags)
+{
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	struct ublk_batch_fetch_cmd *fcmd = pdu->fcmd;
+	struct ublk_queue *ubq = pdu->ubq;
+
+	ublk_start_cancel(ubq->dev);
+
+	ublk_batch_cancel_cmd(ubq, fcmd, issue_flags);
+}
+
 /*
  * The ublk char device won't be closed when calling cancel fn, so both
  * ublk device and queue are guaranteed to be live
@@ -2173,6 +2457,11 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
 	int i;
 
+	if (ublk_support_batch_io(ubq)) {
+		ublk_batch_cancel_queue(ubq);
+		return;
+	}
+
 	for (i = 0; i < ubq->q_depth; i++)
 		ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
 }
@@ -3079,6 +3368,78 @@ static int ublk_check_batch_cmd(const struct ublk_batch_io_data *data)
 	return ublk_check_batch_cmd_flags(uc);
 }
 
+static int ublk_batch_attach(struct ublk_queue *ubq,
+			     struct ublk_batch_io_data *data,
+			     struct ublk_batch_fetch_cmd *fcmd)
+{
+	struct ublk_batch_fetch_cmd *new_fcmd = NULL;
+	bool free = false;
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(data->cmd);
+
+	spin_lock(&ubq->evts_lock);
+	if (unlikely(ubq->force_abort || ubq->canceling)) {
+		free = true;
+	} else {
+		list_add_tail(&fcmd->node, &ubq->fcmd_head);
+		new_fcmd = __ublk_acquire_fcmd(ubq);
+	}
+	spin_unlock(&ubq->evts_lock);
+
+	if (unlikely(free)) {
+		ublk_batch_free_fcmd(fcmd);
+		return -ENODEV;
+	}
+
+	pdu->ubq = ubq;
+	pdu->fcmd = fcmd;
+	io_uring_cmd_mark_cancelable(fcmd->cmd, data->issue_flags);
+
+	if (!new_fcmd)
+		goto out;
+
+	/*
+	 * If the two fetch commands are originated from same io_ring_ctx,
+	 * run batch dispatch directly. Otherwise, schedule task work for
+	 * doing it.
+	 */
+	if (io_uring_cmd_ctx_handle(new_fcmd->cmd) ==
+			io_uring_cmd_ctx_handle(fcmd->cmd)) {
+		data->cmd = new_fcmd->cmd;
+		ublk_batch_dispatch(ubq, data, new_fcmd);
+	} else {
+		io_uring_cmd_complete_in_task(new_fcmd->cmd,
+				ublk_batch_tw_cb);
+	}
+out:
+	return -EIOCBQUEUED;
+}
+
+static int ublk_handle_batch_fetch_cmd(struct ublk_batch_io_data *data)
+{
+	struct ublk_queue *ubq = ublk_get_queue(data->ub, data->header.q_id);
+	struct ublk_batch_fetch_cmd *fcmd = ublk_batch_alloc_fcmd(data->cmd);
+
+	if (!fcmd)
+		return -ENOMEM;
+
+	return ublk_batch_attach(ubq, data, fcmd);
+}
+
+static int ublk_validate_batch_fetch_cmd(struct ublk_batch_io_data *data,
+					 const struct ublk_batch_io *uc)
+{
+	if (!(data->cmd->flags & IORING_URING_CMD_MULTISHOT))
+		return -EINVAL;
+
+	if (uc->elem_bytes != sizeof(__u16))
+		return -EINVAL;
+
+	if (uc->flags != 0)
+		return -E2BIG;
+
+	return 0;
+}
+
 static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 				       unsigned int issue_flags)
 {
@@ -3098,6 +3459,11 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 	u32 cmd_op = cmd->cmd_op;
 	int ret = -EINVAL;
 
+	if (unlikely(issue_flags & IO_URING_F_CANCEL)) {
+		ublk_batch_cancel_fn(cmd, issue_flags);
+		return 0;
+	}
+
 	if (data.header.q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
@@ -3114,6 +3480,12 @@ static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		ret = ublk_handle_batch_commit_cmd(&data);
 		break;
+	case UBLK_U_IO_FETCH_IO_CMDS:
+		ret = ublk_validate_batch_fetch_cmd(&data, uc);
+		if (ret)
+			goto out;
+		ret = ublk_handle_batch_fetch_cmd(&data);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 	}
@@ -3323,6 +3695,7 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 		ret = ublk_io_evts_init(ubq, ubq->q_depth, numa_node);
 		if (ret)
 			goto fail;
+		INIT_LIST_HEAD(&ubq->fcmd_head);
 	}
 	ub->queues[q_id] = ubq;
 	ubq->dev = ub;
@@ -3445,7 +3818,10 @@ static void ublk_align_max_io_size(struct ublk_device *ub)
 
 static int ublk_add_tag_set(struct ublk_device *ub)
 {
-	ub->tag_set.ops = &ublk_mq_ops;
+	if (ublk_dev_support_batch_io(ub))
+		ub->tag_set.ops = &ublk_batch_mq_ops;
+	else
+		ub->tag_set.ops = &ublk_mq_ops;
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
 	ub->tag_set.numa_node = NUMA_NO_NODE;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 295ec8f34173..cd894c1d188e 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -120,6 +120,13 @@
 #define	UBLK_U_IO_COMMIT_IO_CMDS	\
 	_IOWR('u', 0x26, struct ublk_batch_io)
 
+/*
+ * Fetch io commands to provided buffer in multishot style,
+ * `IORING_URING_CMD_MULTISHOT` is required for this command.
+ */
+#define	UBLK_U_IO_FETCH_IO_CMDS 	\
+	_IOWR('u', 0x27, struct ublk_batch_io)
+
 /* only ABORT means that no re-fetch */
 #define UBLK_IO_RES_OK			0
 #define UBLK_IO_RES_NEED_GET_DATA	1
-- 
2.47.0

