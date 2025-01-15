Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364191DD874
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981241; cv=none; b=IdRpxcgjDxEP4WLLIc2MD6Qf3pVmmVPG6506YREowt8A4EFMlgFyy9+uUSbT6vTGQF9DrecaEtl3thPDxt5I13MVOXM6dScAVk778p/kbEf1V9UbAoC7/Ubm/EUdbK6Q/5KNxR/BEaL1JHlEfnVTMDKfl6vr0cpv6SORSIxYrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981241; c=relaxed/simple;
	bh=AIWGLAFmYK7HmxLiqsKkn4tnss5KadvATTg9LJLXdEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDAGIqeLTbKX08GQv4EhB3eT2VPtsT8PUZr9bXTHNX3Hze4CKZdAiAm/hriu8twkZUjw/K2a5e3BDd8lHPsA6o2YnnYrN5l8XTCn8KS247b9+GwpBeIPNQIfGBg/0GtaU0dcnlTZRwLAU9B/5cvH+XvdQ0vuaIqIbVFXipH9bXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yMSMPirE; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yMSMPirE"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjL4ppSz6CmM6d;
	Wed, 15 Jan 2025 22:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981232; x=1739573233; bh=WfoHu
	efnwx8BAwBgYDC7Q/3S4Nf80YWNAHsqKZY4Tss=; b=yMSMPirE47xhKx19BsK4K
	7fa/7z9T9VAaxic4rQoumUN293/235uqAg/auQsGyj8jONXY8rjQcidKLEWfHgpc
	g5Gd/tDHzAZ5eTyExq/GHKA0Zm6wgNfE0tHAAT0o2QYzzOG3fvoMDvUQ5z4Ts6/B
	rLJkUA7G04tPvegsPOfs6rlv5KuI8ezXVHeyG/KxHzUdEMye2AGwlsUgLLvUag3C
	bYIvtvlQacf9LKRFAFgXjPFOlJs9CJgNfIhNrEpX+DoWMyL1aOhCSqfK51HTrtKM
	laLtzUIX9dgjzIzhlUa6IPV5NGo6SuiYw41+6CejHSoJP8FFlneuU1FpQGBOW9u5
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Lw3up8S2K4mx; Wed, 15 Jan 2025 22:47:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLjB29bMz6CmQyl;
	Wed, 15 Jan 2025 22:47:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v17 05/14] blk-mq: Restore the zoned write order when requeuing
Date: Wed, 15 Jan 2025 14:46:39 -0800
Message-ID: <20250115224649.3973718-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250115224649.3973718-1-bvanassche@acm.org>
References: <20250115224649.3973718-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Zoned writes may be requeued. This happens if a block driver returns
BLK_STS_RESOURCE, to handle SCSI unit attentions or by the SCSI error
handler after error handling has finished. Requests may be requeued in
another order than submitted. Restore the request order if requests are
requeued. Add RQF_DONTPREP to RQF_NOMERGE_FLAGS because this patch may
cause RQF_DONTPREP requests to be sent to the code that checks whether
a request can be merged and RQF_DONTPREP requests must not be merged.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-iosched.c    |  2 ++
 block/blk-mq.c         | 20 +++++++++++++++++++-
 block/blk-mq.h         |  2 ++
 block/kyber-iosched.c  |  2 ++
 block/mq-deadline.c    |  7 ++++++-
 include/linux/blk-mq.h | 13 ++++++++++++-
 6 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 167542201603..ffa4ca3aad62 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6276,6 +6276,8 @@ static void bfq_insert_request(struct blk_mq_hw_ctx=
 *hctx, struct request *rq,
=20
 	if (flags & BLK_MQ_INSERT_AT_HEAD) {
 		list_add(&rq->queuelist, &bfqd->dispatch);
+	} else if (flags & BLK_MQ_INSERT_ORDERED) {
+		blk_mq_insert_ordered(rq, &bfqd->dispatch);
 	} else if (!bfqq) {
 		list_add_tail(&rq->queuelist, &bfqd->dispatch);
 	} else {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4262c85be206..01478777ae5f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1557,7 +1557,9 @@ static void blk_mq_requeue_work(struct work_struct =
*work)
 		 * already.  Insert it into the hctx dispatch list to avoid
 		 * block layer merges for the request.
 		 */
-		if (rq->rq_flags & RQF_DONTPREP)
+		if (blk_rq_is_seq_zoned_write(rq))
+			blk_mq_insert_request(rq, BLK_MQ_INSERT_ORDERED);
+		else if (rq->rq_flags & RQF_DONTPREP)
 			blk_mq_request_bypass_insert(rq, 0);
 		else
 			blk_mq_insert_request(rq, BLK_MQ_INSERT_AT_HEAD);
@@ -2592,6 +2594,20 @@ static void blk_mq_insert_requests(struct blk_mq_h=
w_ctx *hctx,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
=20
+void blk_mq_insert_ordered(struct request *rq, struct list_head *list)
+{
+	struct request_queue *q =3D rq->q;
+	struct request *rq2;
+
+	list_for_each_entry(rq2, list, queuelist)
+		if (rq2->q =3D=3D q && blk_rq_pos(rq2) > blk_rq_pos(rq))
+			break;
+
+	/* Insert rq before rq2. If rq2 is the list head, append at the end. */
+	list_add_tail(&rq->queuelist, &rq2->queuelist);
+}
+EXPORT_SYMBOL_GPL(blk_mq_insert_ordered);
+
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags=
)
 {
 	struct request_queue *q =3D rq->q;
@@ -2646,6 +2662,8 @@ static void blk_mq_insert_request(struct request *r=
q, blk_insert_t flags)
 		spin_lock(&ctx->lock);
 		if (flags & BLK_MQ_INSERT_AT_HEAD)
 			list_add(&rq->queuelist, &ctx->rq_lists[hctx->type]);
+		else if (flags & BLK_MQ_INSERT_ORDERED)
+			blk_mq_insert_ordered(rq, &ctx->rq_lists[hctx->type]);
 		else
 			list_add_tail(&rq->queuelist,
 				      &ctx->rq_lists[hctx->type]);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d5536dcf2182..4035643c51a7 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -40,8 +40,10 @@ enum {
=20
 typedef unsigned int __bitwise blk_insert_t;
 #define BLK_MQ_INSERT_AT_HEAD		((__force blk_insert_t)0x01)
+#define BLK_MQ_INSERT_ORDERED		((__force blk_insert_t)0x02)
=20
 void blk_mq_submit_bio(struct bio *bio);
+void blk_mq_insert_ordered(struct request *rq, struct list_head *list);
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp=
_batch *iob,
 		unsigned int flags);
 void blk_mq_exit_queue(struct request_queue *q);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index dc31f2dfa414..2877cce690f3 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -603,6 +603,8 @@ static void kyber_insert_requests(struct blk_mq_hw_ct=
x *hctx,
 		trace_block_rq_insert(rq);
 		if (flags & BLK_MQ_INSERT_AT_HEAD)
 			list_move(&rq->queuelist, head);
+		else if (flags & BLK_MQ_INSERT_ORDERED)
+			blk_mq_insert_ordered(rq, head);
 		else
 			list_move_tail(&rq->queuelist, head);
 		sbitmap_set_bit(&khd->kcq_map[sched_domain],
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 754f6b7415cd..78534279adab 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -710,7 +710,12 @@ static void dd_insert_request(struct blk_mq_hw_ctx *=
hctx, struct request *rq,
 		 * set expire time and add to fifo list
 		 */
 		rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir];
-		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
+		if (flags & BLK_MQ_INSERT_ORDERED)
+			blk_mq_insert_ordered(rq,
+					      &per_prio->fifo_list[data_dir]);
+		else
+			list_add_tail(&rq->queuelist,
+				      &per_prio->fifo_list[data_dir]);
 	}
 }
=20
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a0a9007cc1e3..482d5432817c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -85,7 +85,7 @@ enum {
=20
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
+	(RQF_STARTED | RQF_FLUSH_SEQ | RQF_DONTPREP | RQF_SPECIAL_PAYLOAD)
=20
 enum mq_rq_state {
 	MQ_RQ_IDLE		=3D 0,
@@ -1152,4 +1152,15 @@ static inline int blk_rq_map_sg(struct request_que=
ue *q, struct request *rq,
 }
 void blk_dump_rq_flags(struct request *, char *);
=20
+static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
+{
+	switch (req_op(rq)) {
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+		return bdev_zone_is_seq(rq->q->disk->part0, blk_rq_pos(rq));
+	default:
+		return false;
+	}
+}
+
 #endif /* BLK_MQ_H */
