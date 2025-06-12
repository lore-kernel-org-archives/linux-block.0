Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4AF21ABB1
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714172; cv=none; b=RjedU1TQ4LvwvLN+3q/omu7dEqxC0ZgnohdhXemvBv6PU+GOYJtYTJoNWYEA75SZalm+mihmXjx7Bjj+JIoxJ6POfT/C7tHu5kqzSN6oKklx9NwVR1Qe9C0XgKvcyrkkoXbNP3arGnGMEmv5+Qc/uPu23Bkm3/KJYQ3/5bBIvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714172; c=relaxed/simple;
	bh=sb4UWIAgMFvtCa+h2KjPkFleaFFpiKRlQKK4XJjzLy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWv4qCbNcEWbk+UyJ2R15aetHcPo7VIVEiG7MszCdgOCb0tV8ZlExdTAD6a/uTnkyZLjCcyn0CTiw3FQLOGWxvQbppdAvHKZontwevpmPKzexLL42Epg7S29uUsed+YPev2r54s9jmgfMBHaKzHRLIxuutyYY2GjMhzBNs+NvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vj3Wb2wx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vj3Wb2wx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pgO0sELmdmd39auCcMP17xhwBfJw035c38KH2Vqo9+8=; b=Vj3Wb2wx2zjYw3skidqTbRkyPy
	/u8WCs7v4yMYjJ0ThnCuie9W9KmqqxUBF4I8FR7BygotLZUa/Qw9JUtt/boZ5hhiq5hgeMLCYye1Z
	Jn2G+2KfLjwvs+EunqE8FjdLo2Nx6vfCZfMldtdw5euKBwKLQ6WY368BWmuFM/XNwTNAVp/aTXAhm
	XQnlL0mKXIXLEM+uHWN6Lu8atP3D447UHEq//AXJErlTD3dvYBATUb+5e7mFJQYA7YX+fFg4GAiTq
	hTYOsySoY41Pamk9aDnrgKIk0CLNFQ7BK+rf2YjtOhMa6o+kNrcEv5n3vkUYDKOUUYAEnhh1qmaf6
	e4778nLw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPcaG-0000000CToH-48Qo;
	Thu, 12 Jun 2025 07:42:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: abuehaze@amazon.com,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: [PATCH, RFC] block: always use a list_head for requests
Date: Thu, 12 Jun 2025 09:42:38 +0200
Message-ID: <20250612074245.2718371-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Turn the remaining lists of requests into the standard doubly linked
list.  This removes a lot of hairy list manipulation code and allows
east reverse walking of the lists, which will be needed to improve
merging.

XXX: the ublk queue_rqs code is pretty much broken here, because
it's so different from the other drivers and I don't understand it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c              |  6 +--
 block/blk-merge.c             |  4 +-
 block/blk-mq.c                | 91 +++++++++++++----------------------
 block/blk-mq.h                |  2 +-
 drivers/block/null_blk/main.c | 10 ++--
 drivers/block/ublk_drv.c      | 42 +++++++---------
 drivers/block/virtio_blk.c    | 29 +++++------
 drivers/nvme/host/nvme.h      |  2 +-
 drivers/nvme/host/pci.c       | 31 ++++++------
 include/linux/blk-mq.h        | 63 ++++--------------------
 include/linux/blkdev.h        | 16 +++---
 io_uring/rw.c                 |  4 +-
 12 files changed, 113 insertions(+), 187 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..90e84f45d09f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1127,8 +1127,8 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 		return;
 
 	plug->cur_ktime = 0;
-	rq_list_init(&plug->mq_list);
-	rq_list_init(&plug->cached_rqs);
+	INIT_LIST_HEAD(&plug->mq_list);
+	INIT_LIST_HEAD(&plug->cached_rqs);
 	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
 	plug->multiple_queues = false;
@@ -1224,7 +1224,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 	 * queue for cached requests, we don't want a blocked task holding
 	 * up a queue freeze/quiesce event.
 	 */
-	if (unlikely(!rq_list_empty(&plug->cached_rqs)))
+	if (unlikely(!list_empty(&plug->cached_rqs)))
 		blk_mq_free_plug_rqs(plug);
 
 	plug->cur_ktime = 0;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3af1d284add5..64d1de374bd4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -995,10 +995,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	struct blk_plug *plug = current->plug;
 	struct request *rq;
 
-	if (!plug || rq_list_empty(&plug->mq_list))
+	if (!plug)
 		return false;
 
-	rq_list_for_each(&plug->mq_list, rq) {
+	list_for_each_entry(rq, &plug->mq_list, queuelist) {
 		if (rq->q == q) {
 			if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
 			    BIO_MERGE_OK)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..254b7d984ac8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -470,7 +470,7 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
 		prefetch(tags->static_rqs[tag]);
 		tag_mask &= ~(1UL << i);
 		rq = blk_mq_rq_ctx_init(data, tags, tag);
-		rq_list_add_head(data->cached_rqs, rq);
+		list_add(&rq->queuelist, data->cached_rqs);
 		nr++;
 	}
 	if (!(data->rq_flags & RQF_SCHED_TAGS))
@@ -605,7 +605,7 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 	if (!plug)
 		return NULL;
 
-	if (rq_list_empty(&plug->cached_rqs)) {
+	if (list_empty(&plug->cached_rqs)) {
 		if (plug->nr_ios == 1)
 			return NULL;
 		rq = blk_mq_rq_cache_fill(q, plug, opf, flags);
@@ -1177,7 +1177,6 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 
 	while ((rq = rq_list_pop(&iob->req_list)) != NULL) {
 		prefetch(rq->bio);
-		prefetch(rq->rq_next);
 
 		blk_complete_request(rq);
 		if (iob->need_ts)
@@ -1398,7 +1397,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
 	 */
 	if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
 		plug->has_elevator = true;
-	rq_list_add_tail(&plug->mq_list, rq);
+	list_add_tail(&rq->queuelist, &plug->mq_list);
 	plug->rq_count++;
 }
 
@@ -2780,7 +2779,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	return __blk_mq_issue_directly(hctx, rq, last);
 }
 
-static void blk_mq_issue_direct(struct rq_list *rqs)
+static void blk_mq_issue_direct(struct list_head *rqs)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
 	struct request *rq;
@@ -2788,7 +2787,7 @@ static void blk_mq_issue_direct(struct rq_list *rqs)
 	blk_status_t ret = BLK_STS_OK;
 
 	while ((rq = rq_list_pop(rqs))) {
-		bool last = rq_list_empty(rqs);
+		bool last = list_empty(rqs);
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx) {
@@ -2819,43 +2818,15 @@ static void blk_mq_issue_direct(struct rq_list *rqs)
 		blk_mq_commit_rqs(hctx, queued, false);
 }
 
-static void __blk_mq_flush_list(struct request_queue *q, struct rq_list *rqs)
+static void __blk_mq_flush_list(struct request_queue *q, struct list_head *rqs)
 {
 	if (blk_queue_quiesced(q))
 		return;
 	q->mq_ops->queue_rqs(rqs);
 }
 
-static unsigned blk_mq_extract_queue_requests(struct rq_list *rqs,
-					      struct rq_list *queue_rqs)
-{
-	struct request *rq = rq_list_pop(rqs);
-	struct request_queue *this_q = rq->q;
-	struct request **prev = &rqs->head;
-	struct rq_list matched_rqs = {};
-	struct request *last = NULL;
-	unsigned depth = 1;
-
-	rq_list_add_tail(&matched_rqs, rq);
-	while ((rq = *prev)) {
-		if (rq->q == this_q) {
-			/* move rq from rqs to matched_rqs */
-			*prev = rq->rq_next;
-			rq_list_add_tail(&matched_rqs, rq);
-			depth++;
-		} else {
-			/* leave rq in rqs */
-			prev = &rq->rq_next;
-			last = rq;
-		}
-	}
-
-	rqs->tail = last;
-	*queue_rqs = matched_rqs;
-	return depth;
-}
-
-static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned depth)
+static void blk_mq_dispatch_queue_requests(struct list_head *rqs,
+					   unsigned depth)
 {
 	struct request_queue *q = rq_list_peek(rqs)->q;
 
@@ -2869,39 +2840,36 @@ static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned depth)
 	 */
 	if (q->mq_ops->queue_rqs) {
 		blk_mq_run_dispatch_ops(q, __blk_mq_flush_list(q, rqs));
-		if (rq_list_empty(rqs))
+		if (list_empty(rqs))
 			return;
 	}
 
 	blk_mq_run_dispatch_ops(q, blk_mq_issue_direct(rqs));
 }
 
-static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
+static void blk_mq_dispatch_list(struct list_head *rqs, bool from_sched)
 {
 	struct blk_mq_hw_ctx *this_hctx = NULL;
 	struct blk_mq_ctx *this_ctx = NULL;
-	struct rq_list requeue_list = {};
+	LIST_HEAD(requeue_list);
+	LIST_HEAD(list);
+	struct request *rq, *n;
 	unsigned int depth = 0;
 	bool is_passthrough = false;
-	LIST_HEAD(list);
-
-	do {
-		struct request *rq = rq_list_pop(rqs);
 
+	list_for_each_entry_safe(rq, n, rqs, queuelist) {
 		if (!this_hctx) {
 			this_hctx = rq->mq_hctx;
 			this_ctx = rq->mq_ctx;
 			is_passthrough = blk_rq_is_passthrough(rq);
 		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
 			   is_passthrough != blk_rq_is_passthrough(rq)) {
-			rq_list_add_tail(&requeue_list, rq);
 			continue;
 		}
-		list_add_tail(&rq->queuelist, &list);
+		list_move_tail(&rq->queuelist, &list);
 		depth++;
-	} while (!rq_list_empty(rqs));
+	}
 
-	*rqs = requeue_list;
 	trace_block_unplug(this_hctx->queue, depth, !from_sched);
 
 	percpu_ref_get(&this_hctx->queue->q_usage_counter);
@@ -2921,17 +2889,27 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
 	percpu_ref_put(&this_hctx->queue->q_usage_counter);
 }
 
-static void blk_mq_dispatch_multiple_queue_requests(struct rq_list *rqs)
+static void blk_mq_dispatch_multiple_queue_requests(struct list_head *rqs)
 {
 	do {
-		struct rq_list queue_rqs;
-		unsigned depth;
+		struct request_queue *this_q = NULL;
+		struct request *rq, *n;
+		LIST_HEAD(queue_rqs);
+		unsigned depth = 0;
+
+		list_for_each_entry_safe(rq, n, rqs, queuelist) {
+			if (!this_q)
+				this_q = rq->q;
+			if (this_q == rq->q) {
+				list_move_tail(&rq->queuelist, &queue_rqs);
+				depth++;
+			}
+		}
 
-		depth = blk_mq_extract_queue_requests(rqs, &queue_rqs);
 		blk_mq_dispatch_queue_requests(&queue_rqs, depth);
-		while (!rq_list_empty(&queue_rqs))
+		while (!list_empty(&queue_rqs))
 			blk_mq_dispatch_list(&queue_rqs, false);
-	} while (!rq_list_empty(rqs));
+	} while (!list_empty(rqs));
 }
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
@@ -2955,15 +2933,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 			blk_mq_dispatch_multiple_queue_requests(&plug->mq_list);
 			return;
 		}
-
 		blk_mq_dispatch_queue_requests(&plug->mq_list, depth);
-		if (rq_list_empty(&plug->mq_list))
+		if (list_empty(&plug->mq_list))
 			return;
 	}
 
 	do {
 		blk_mq_dispatch_list(&plug->mq_list, from_schedule);
-	} while (!rq_list_empty(&plug->mq_list));
+	} while (!list_empty(&plug->mq_list));
 }
 
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index affb2e14b56e..1788ff0839c6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -153,7 +153,7 @@ struct blk_mq_alloc_data {
 
 	/* allocate multiple requests/tags in one go */
 	unsigned int nr_tags;
-	struct rq_list *cached_rqs;
+	struct list_head *cached_rqs;
 
 	/* input & output parameter */
 	struct blk_mq_ctx *ctx;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index aa163ae9b2aa..c457e7fd46c5 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1694,10 +1694,10 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static void null_queue_rqs(struct rq_list *rqlist)
+static void null_queue_rqs(struct list_head *rqlist)
 {
-	struct rq_list requeue_list = {};
 	struct blk_mq_queue_data bd = { };
+	LIST_HEAD(requeue_list);
 	blk_status_t ret;
 
 	do {
@@ -1706,10 +1706,10 @@ static void null_queue_rqs(struct rq_list *rqlist)
 		bd.rq = rq;
 		ret = null_queue_rq(rq->mq_hctx, &bd);
 		if (ret != BLK_STS_OK)
-			rq_list_add_tail(&requeue_list, rq);
-	} while (!rq_list_empty(rqlist));
+			list_add_tail(&rq->queuelist, &requeue_list);
+	} while (!list_empty(rqlist));
 
-	*rqlist = requeue_list;
+	list_splice(&requeue_list, rqlist);
 }
 
 static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c637ea010d34..73d3164bdddd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -101,7 +101,7 @@ struct ublk_uring_cmd_pdu {
 	 */
 	union {
 		struct request *req;
-		struct request *req_list;
+		struct list_head req_list;
 	};
 
 	/*
@@ -1325,24 +1325,19 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-	struct request *rq = pdu->req_list;
-	struct request *next;
+	struct request *rq;
 
-	do {
-		next = rq->rq_next;
-		rq->rq_next = NULL;
+	while ((rq = rq_list_pop(&pdu->req_list)))
 		ublk_dispatch_req(rq->mq_hctx->driver_data, rq, issue_flags);
-		rq = next;
-	} while (rq);
 }
 
-static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
+static void ublk_queue_cmd_list(struct request *req, struct ublk_io *io,
+		struct list_head *head)
 {
 	struct io_uring_cmd *cmd = io->cmd;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
-	pdu->req_list = rq_list_peek(l);
-	rq_list_init(l);
+	list_cut_before(&pdu->req_list, head, &req->queuelist);
 	io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
 }
 
@@ -1416,30 +1411,27 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static void ublk_queue_rqs(struct rq_list *rqlist)
+static void ublk_queue_rqs(struct list_head *rqlist)
 {
-	struct rq_list requeue_list = { };
-	struct rq_list submit_list = { };
 	struct ublk_io *io = NULL;
-	struct request *req;
+	struct request *req, *n;
+	LIST_HEAD(requeue_list);
 
-	while ((req = rq_list_pop(rqlist))) {
+	list_for_each_entry_safe(req, n, rqlist, queuelist) {
 		struct ublk_queue *this_q = req->mq_hctx->driver_data;
 		struct ublk_io *this_io = &this_q->ios[req->tag];
 
-		if (io && io->task != this_io->task && !rq_list_empty(&submit_list))
-			ublk_queue_cmd_list(io, &submit_list);
+		if (io && io->task != this_io->task)
+			ublk_queue_cmd_list(req, io, rqlist);
 		io = this_io;
 
-		if (ublk_prep_req(this_q, req, true) == BLK_STS_OK)
-			rq_list_add_tail(&submit_list, req);
-		else
-			rq_list_add_tail(&requeue_list, req);
+		if (ublk_prep_req(this_q, req, true) != BLK_STS_OK)
+			list_move_tail(&req->queuelist, &requeue_list);
 	}
 
-	if (!rq_list_empty(&submit_list))
-		ublk_queue_cmd_list(io, &submit_list);
-	*rqlist = requeue_list;
+	if (!list_empty(rqlist))
+		ublk_queue_cmd_list(io, rqlist);
+	list_splice(&requeue_list, rqlist);
 }
 
 static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30bca8cb7106..7bea94e17817 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -471,7 +471,7 @@ static bool virtblk_prep_rq_batch(struct request *req)
 }
 
 static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
-		struct rq_list *rqlist)
+		struct list_head *rqlist)
 {
 	struct request *req;
 	unsigned long flags;
@@ -498,29 +498,30 @@ static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
 		virtqueue_notify(vq->vq);
 }
 
-static void virtio_queue_rqs(struct rq_list *rqlist)
+static void virtio_queue_rqs(struct list_head *rqlist)
 {
-	struct rq_list submit_list = { };
-	struct rq_list requeue_list = { };
 	struct virtio_blk_vq *vq = NULL;
-	struct request *req;
+	LIST_HEAD(requeue_list);
+	struct request *req, *n;
 
-	while ((req = rq_list_pop(rqlist))) {
+	list_for_each_entry_safe(req, n, rqlist, queuelist) {
 		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req->mq_hctx);
 
-		if (vq && vq != this_vq)
+		if (vq && vq != this_vq) {
+			LIST_HEAD(submit_list);
+
+			list_cut_before(&submit_list, rqlist, &req->queuelist);
 			virtblk_add_req_batch(vq, &submit_list);
+		}
 		vq = this_vq;
 
-		if (virtblk_prep_rq_batch(req))
-			rq_list_add_tail(&submit_list, req);
-		else
-			rq_list_add_tail(&requeue_list, req);
+		if (!virtblk_prep_rq_batch(req))
+			list_move_tail(&req->queuelist, &requeue_list);
 	}
 
 	if (vq)
-		virtblk_add_req_batch(vq, &submit_list);
-	*rqlist = requeue_list;
+		virtblk_add_req_batch(vq, rqlist);
+	list_splice(&requeue_list, rqlist);
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -1187,7 +1188,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
 {
 	struct request *req;
 
-	rq_list_for_each(&iob->req_list, req) {
+	list_for_each_entry(req, &iob->req_list, queuelist) {
 		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
 		virtblk_cleanup_cmd(req);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a468cdc5b5cb..d5a99a73474a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -789,7 +789,7 @@ static __always_inline void nvme_complete_batch(struct io_comp_batch *iob,
 {
 	struct request *req;
 
-	rq_list_for_each(&iob->req_list, req) {
+	list_for_each_entry(req, &iob->req_list, queuelist) {
 		fn(req);
 		nvme_complete_batch_req(req);
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..5d34a00512fb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1051,11 +1051,11 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *rqlist)
+static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct list_head *rqlist)
 {
 	struct request *req;
 
-	if (rq_list_empty(rqlist))
+	if (list_empty(rqlist))
 		return;
 
 	spin_lock(&nvmeq->sq_lock);
@@ -1082,27 +1082,28 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
 }
 
-static void nvme_queue_rqs(struct rq_list *rqlist)
+static void nvme_queue_rqs(struct list_head *rqlist)
 {
-	struct rq_list submit_list = { };
-	struct rq_list requeue_list = { };
 	struct nvme_queue *nvmeq = NULL;
-	struct request *req;
+	LIST_HEAD(requeue_list);
+	struct request *req, *n;
 
-	while ((req = rq_list_pop(rqlist))) {
-		if (nvmeq && nvmeq != req->mq_hctx->driver_data)
+	list_for_each_entry_safe(req, n, rqlist, queuelist) {
+		if (nvmeq && nvmeq != req->mq_hctx->driver_data) {
+			LIST_HEAD(submit_list);
+
+			list_cut_before(&submit_list, rqlist, &req->queuelist);
 			nvme_submit_cmds(nvmeq, &submit_list);
+		}
 		nvmeq = req->mq_hctx->driver_data;
 
-		if (nvme_prep_rq_batch(nvmeq, req))
-			rq_list_add_tail(&submit_list, req);
-		else
-			rq_list_add_tail(&requeue_list, req);
+		if (!nvme_prep_rq_batch(nvmeq, req))
+			list_move_tail(&req->queuelist, &requeue_list);
 	}
 
 	if (nvmeq)
-		nvme_submit_cmds(nvmeq, &submit_list);
-	*rqlist = requeue_list;
+		nvme_submit_cmds(nvmeq, rqlist);
+	list_splice(&requeue_list, rqlist);
 }
 
 static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
@@ -1245,7 +1246,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	DEFINE_IO_COMP_BATCH(iob);
 
 	if (nvme_poll_cq(nvmeq, &iob)) {
-		if (!rq_list_empty(&iob.req_list))
+		if (!list_empty(&iob.req_list))
 			nvme_pci_complete_batch(&iob);
 		return IRQ_HANDLED;
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index de8c85a03bb7..592e87472229 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -120,10 +120,7 @@ struct request {
 	struct bio *bio;
 	struct bio *biotail;
 
-	union {
-		struct list_head queuelist;
-		struct request *rq_next;
-	};
+	struct list_head queuelist;
 
 	struct block_device *part;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
@@ -230,61 +227,21 @@ static inline unsigned short req_get_ioprio(struct request *req)
 #define rq_dma_dir(rq) \
 	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
 
-static inline int rq_list_empty(const struct rq_list *rl)
-{
-	return rl->head == NULL;
-}
-
-static inline void rq_list_init(struct rq_list *rl)
+static inline struct request *rq_list_peek(struct list_head *rl)
 {
-	rl->head = NULL;
-	rl->tail = NULL;
+	return list_first_entry_or_null(rl, struct request, queuelist);
 }
 
-static inline void rq_list_add_tail(struct rq_list *rl, struct request *rq)
+static inline struct request *rq_list_pop(struct list_head *rl)
 {
-	rq->rq_next = NULL;
-	if (rl->tail)
-		rl->tail->rq_next = rq;
-	else
-		rl->head = rq;
-	rl->tail = rq;
-}
-
-static inline void rq_list_add_head(struct rq_list *rl, struct request *rq)
-{
-	rq->rq_next = rl->head;
-	rl->head = rq;
-	if (!rl->tail)
-		rl->tail = rq;
-}
-
-static inline struct request *rq_list_pop(struct rq_list *rl)
-{
-	struct request *rq = rl->head;
-
-	if (rq) {
-		rl->head = rl->head->rq_next;
-		if (!rl->head)
-			rl->tail = NULL;
-		rq->rq_next = NULL;
-	}
+	struct request *rq;
 
+	rq = list_first_entry_or_null(rl, struct request, queuelist);
+	if (rq)
+		list_del(&rq->queuelist);
 	return rq;
 }
 
-static inline struct request *rq_list_peek(struct rq_list *rl)
-{
-	return rl->head;
-}
-
-#define rq_list_for_each(rl, pos)					\
-	for (pos = rq_list_peek((rl)); (pos); pos = pos->rq_next)
-
-#define rq_list_for_each_safe(rl, pos, nxt)				\
-	for (pos = rq_list_peek((rl)), nxt = pos->rq_next;		\
-		pos; pos = nxt, nxt = pos ? pos->rq_next : NULL)
-
 /**
  * enum blk_eh_timer_return - How the timeout handler should proceed
  * @BLK_EH_DONE: The block driver completed the command or will complete it at
@@ -574,7 +531,7 @@ struct blk_mq_ops {
 	 * empty the @rqlist completely, then the rest will be queued
 	 * individually by the block layer upon return.
 	 */
-	void (*queue_rqs)(struct rq_list *rqlist);
+	void (*queue_rqs)(struct list_head *rqlist);
 
 	/**
 	 * @get_budget: Reserve budget before queue request, once .queue_rq is
@@ -897,7 +854,7 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	else if (iob->complete != complete)
 		return false;
 	iob->need_ts |= blk_mq_need_time_stamp(req);
-	rq_list_add_tail(&iob->req_list, req);
+	list_add_tail(&req->queuelist, &iob->req_list);
 	return true;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a59880c809c7..2e9f371b2bf5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1065,11 +1065,6 @@ extern void blk_put_queue(struct request_queue *);
 
 void blk_mark_disk_dead(struct gendisk *disk);
 
-struct rq_list {
-	struct request *head;
-	struct request *tail;
-};
-
 #ifdef CONFIG_BLOCK
 /*
  * blk_plug permits building a queue of related requests by holding the I/O
@@ -1083,10 +1078,10 @@ struct rq_list {
  * blk_flush_plug() is called.
  */
 struct blk_plug {
-	struct rq_list mq_list; /* blk-mq requests */
+	struct list_head mq_list; /* blk-mq requests */
 
 	/* if ios_left is > 1, we can batch tag/rq allocations */
-	struct rq_list cached_rqs;
+	struct list_head cached_rqs;
 	u64 cur_ktime;
 	unsigned short nr_ios;
 
@@ -1762,7 +1757,7 @@ int bdev_thaw(struct block_device *bdev);
 void bdev_fput(struct file *bdev_file);
 
 struct io_comp_batch {
-	struct rq_list req_list;
+	struct list_head req_list;
 	bool need_ts;
 	void (*complete)(struct io_comp_batch *);
 };
@@ -1807,6 +1802,9 @@ bdev_atomic_write_unit_max_bytes(struct block_device *bdev)
 	return queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
 }
 
-#define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
+#define DEFINE_IO_COMP_BATCH(name)				\
+struct io_comp_batch name = {					\
+	.req_list	= LIST_HEAD_INIT((name).req_list),	\
+}
 
 #endif /* _LINUX_BLKDEV_H */
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 710d8cd53ebb..e767e08fee4a 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1344,12 +1344,12 @@ int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 			poll_flags |= BLK_POLL_ONESHOT;
 
 		/* iopoll may have completed current req */
-		if (!rq_list_empty(&iob.req_list) ||
+		if (!list_empty(&iob.req_list) ||
 		    READ_ONCE(req->iopoll_completed))
 			break;
 	}
 
-	if (!rq_list_empty(&iob.req_list))
+	if (!list_empty(&iob.req_list))
 		iob.complete(&iob);
 	else if (!pos)
 		return 0;
-- 
2.47.2

