Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4116848D
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a85dKOUM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62146109
	for <linux-block@vger.kernel.org>; Sun, 12 Nov 2023 19:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699847564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nUxaAsVn1WBRgqyLk6C526VXC2Rw+tJpikfG2xr9e4c=;
	b=a85dKOUM4Du/m/JIDm+wKycq9itp3gOB1MYUAUyOjEL4cxJU5ryGuPWwffO+/7+SYqiqUX
	k+Qp+R51raOV1EDNkO+O3zIjj12gJJxm5+6TD0pVNbf1+AeFDYanU/Q6WT9SfuajKofRxc
	Av3BF2GGIn61Rvti8qMLoQFJA9nWjeQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-WnGZq4H5NliE5XT10ZFWEg-1; Sun, 12 Nov 2023 22:52:41 -0500
X-MC-Unique: WnGZq4H5NliE5XT10ZFWEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70CE0101A52D;
	Mon, 13 Nov 2023 03:52:41 +0000 (UTC)
Received: from localhost (unknown [10.72.120.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5D00A2166B26;
	Mon, 13 Nov 2023 03:52:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] blk-mq: make sure active queue usage is held for bio_integrity_prep()
Date: Mon, 13 Nov 2023 11:52:31 +0800
Message-ID: <20231113035231.2708053-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Christoph Hellwig <hch@infradead.org>

blk_integrity_unregister() can come if queue usage counter isn't held
for one bio with integrity prepared, so this request may be completed with
calling profile->complete_fn, then kernel panic.

Another constraint is that bio_integrity_prep() needs to be called
before bio merge.

Fix the issue by:

- call bio_integrity_prep() with one queue usage counter grabbed reliably

- call bio_integrity_prep() before bio merge

Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- remove blk_mq_cached_req()
	- move blk_mq_attempt_bio_merge() out of blk_mq_can_use_cached_rq(),
	  so that &bio isn't needed any more for blk_mq_can_use_cached_rq()
	- all are suggested from Christoph

 block/blk-mq.c | 75 +++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..900c1be1fee1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2858,11 +2858,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	};
 	struct request *rq;
 
-	if (unlikely(bio_queue_enter(bio)))
-		return NULL;
-
 	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
-		goto queue_exit;
+		return NULL;
 
 	rq_qos_throttle(q, bio);
 
@@ -2878,35 +2875,23 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
-queue_exit:
-	blk_queue_exit(q);
 	return NULL;
 }
 
-static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
-		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
+/* return true if this @rq can be used for @bio */
+static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
+		struct bio *bio)
 {
-	struct request *rq;
-	enum hctx_type type, hctx_type;
+	enum hctx_type type = blk_mq_get_hctx_type(bio->bi_opf);
+	enum hctx_type hctx_type = rq->mq_hctx->type;
 
-	if (!plug)
-		return NULL;
-	rq = rq_list_peek(&plug->cached_rq);
-	if (!rq || rq->q != q)
-		return NULL;
+	WARN_ON_ONCE(rq_list_peek(&plug->cached_rq) != rq);
 
-	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
-		*bio = NULL;
-		return NULL;
-	}
-
-	type = blk_mq_get_hctx_type((*bio)->bi_opf);
-	hctx_type = rq->mq_hctx->type;
 	if (type != hctx_type &&
 	    !(type == HCTX_TYPE_READ && hctx_type == HCTX_TYPE_DEFAULT))
-		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
-		return NULL;
+		return false;
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
+		return false;
 
 	/*
 	 * If any qos ->throttle() end up blocking, we will have flushed the
@@ -2914,12 +2899,12 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	 * before we throttle.
 	 */
 	plug->cached_rq = rq_list_next(rq);
-	rq_qos_throttle(q, *bio);
+	rq_qos_throttle(rq->q, bio);
 
 	blk_mq_rq_time_init(rq, 0);
-	rq->cmd_flags = (*bio)->bi_opf;
+	rq->cmd_flags = bio->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
-	return rq;
+	return true;
 }
 
 static void bio_set_ioprio(struct bio *bio)
@@ -2949,7 +2934,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct blk_plug *plug = blk_mq_plug(bio);
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
-	struct request *rq;
+	struct request *rq = NULL;
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
@@ -2960,20 +2945,36 @@ void blk_mq_submit_bio(struct bio *bio)
 			return;
 	}
 
-	if (!bio_integrity_prep(bio))
-		return;
-
 	bio_set_ioprio(bio);
 
-	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
-	if (!rq) {
-		if (!bio)
+	if (plug) {
+		rq = rq_list_peek(&plug->cached_rq);
+		if (rq && rq->q != q)
+			rq = NULL;
+	}
+	if (rq) {
+		if (!bio_integrity_prep(bio))
 			return;
-		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
-		if (unlikely(!rq))
+		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 			return;
+		if (blk_mq_can_use_cached_rq(rq, plug, bio))
+			goto done;
+		percpu_ref_get(&q->q_usage_counter);
+	} else {
+		if (unlikely(bio_queue_enter(bio)))
+			return;
+		if (!bio_integrity_prep(bio))
+			goto fail;
+	}
+
+	rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
+	if (unlikely(!rq)) {
+fail:
+		blk_queue_exit(q);
+		return;
 	}
 
+done:
 	trace_block_getrq(bio);
 
 	rq_qos_track(q, rq, bio);
-- 
2.41.0

