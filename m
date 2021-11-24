Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C38C433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 06:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhKXGcI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 01:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbhKXGcI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 01:32:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5DC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 22:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eQm62iVzamGF1NbPJeYM6wsIBenXDFL9LJXPcF8bV/U=; b=fXkR1qa90pbho7Jcv7eKAdQUDZ
        J5gDdYQMr5S/a1l+tL9LJ6ZnIRctQ85E3Xlpk/7Wxe2QiegpQNvQcah+mJawU2OLlAwgB/LY0hciz
        3nGFWGVr7eiRNV8SP9dS3w/8Ih1MEOth63Y1+sfX5L9DXnuliJ34wGuVIqdngc3dFU8wwEku8zinh
        vFhKmuVYH5yfJPxT4+67pl5MTYr81TAlkadvitz3rTHkknv3O3lz9MmC9DEz5DDc1hlT6R3wKaNaY
        R9niQtESM9QehZFpaynH6qqCxpuffuyPptmQ5rIX/EJJp2XoecGx2zczVwcWfqWnSBHFmA6iChmZV
        lmuY4B7g==;
Received: from [2001:4bb8:191:f9ce:313b:d079:67e3:886] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mplm4-000XPa-AO; Wed, 24 Nov 2021 06:28:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2] blk-mq: cleanup request allocation
Date:   Wed, 24 Nov 2021 07:28:56 +0100
Message-Id: <20211124062856.1444266-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Refactor the request alloction so that blk_mq_get_cached_request tries
to find a cached request first, and the entirely separate and now
self contained blk_mq_get_new_requests allocates one or more requests
if that is not possible.

There is a small change in behavior as submit_bio_checks is called
twice now if a cached request is present but can't be used, but that
is a small price to pay for unwinding this code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - rebased to the latests for-5.17/block tree

 block/blk-mq.c | 90 +++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 52 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cb41c441aa8fa..0704a1400663b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2716,8 +2716,12 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	};
 	struct request *rq;
 
-	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
+	if (unlikely(bio_queue_enter(bio)))
 		return NULL;
+	if (unlikely(!submit_bio_checks(bio)))
+		goto queue_exit;
+	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
+		goto queue_exit;
 
 	rq_qos_throttle(q, bio);
 
@@ -2728,64 +2732,44 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	}
 
 	rq = __blk_mq_alloc_requests(&data);
-	if (rq)
-		return rq;
+	if (!rq)
+		goto fail;
+	return rq;
 
+fail:
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
-
+queue_exit:
+	blk_queue_exit(q);
 	return NULL;
 }
 
-static inline bool blk_mq_can_use_cached_rq(struct request *rq, struct bio *bio)
-{
-	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
-		return false;
-
-	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
-		return false;
-
-	return true;
-}
-
-static inline struct request *blk_mq_get_request(struct request_queue *q,
-						 struct blk_plug *plug,
-						 struct bio *bio,
-						 unsigned int nsegs)
+static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
+		struct blk_plug *plug, struct bio *bio, unsigned int nsegs)
 {
 	struct request *rq;
-	bool checked = false;
 
-	if (plug) {
-		rq = rq_list_peek(&plug->cached_rq);
-		if (rq && rq->q == q) {
-			if (unlikely(!submit_bio_checks(bio)))
-				return NULL;
-			if (blk_mq_attempt_bio_merge(q, bio, nsegs))
-				return NULL;
-			checked = true;
-			if (!blk_mq_can_use_cached_rq(rq, bio))
-				goto fallback;
-			rq->cmd_flags = bio->bi_opf;
-			plug->cached_rq = rq_list_next(rq);
-			INIT_LIST_HEAD(&rq->queuelist);
-			rq_qos_throttle(q, bio);
-			return rq;
-		}
-	}
+	if (!plug)
+		return NULL;
+	rq = rq_list_peek(&plug->cached_rq);
+	if (!rq || rq->q != q)
+		return NULL;
 
-fallback:
-	if (unlikely(bio_queue_enter(bio)))
+	if (unlikely(!submit_bio_checks(bio)))
 		return NULL;
-	if (unlikely(!checked && !submit_bio_checks(bio)))
-		goto out_put;
-	rq = blk_mq_get_new_requests(q, plug, bio, nsegs);
-	if (rq)
-		return rq;
-out_put:
-	blk_queue_exit(q);
-	return NULL;
+	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
+		return NULL;
+	if (blk_mq_get_hctx_type(bio->bi_opf) != rq->mq_hctx->type)
+		return NULL;
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
+		return NULL;
+
+	rq->cmd_flags = bio->bi_opf;
+	plug->cached_rq = rq_list_next(rq);
+	INIT_LIST_HEAD(&rq->queuelist);
+	rq_qos_throttle(q, bio);
+	return rq;
 }
 
 /**
@@ -2804,9 +2788,9 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 void blk_mq_submit_bio(struct bio *bio)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+	struct blk_plug *plug = blk_mq_plug(q, bio);
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct request *rq;
-	struct blk_plug *plug;
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
@@ -2820,10 +2804,12 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
 
-	plug = blk_mq_plug(q, bio);
-	rq = blk_mq_get_request(q, plug, bio, nr_segs);
-	if (unlikely(!rq))
-		return;
+	rq = blk_mq_get_cached_request(q, plug, bio, nr_segs);
+	if (!rq) {
+		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
+		if (unlikely(!rq))
+			return;
+	}
 
 	trace_block_getrq(bio);
 
-- 
2.30.2

