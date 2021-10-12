Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD64C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B443F6101D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhJLKqq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbhJLKqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 06:46:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509B1C061745
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aqywkq0PZFemtldC+K5gTAGSE5y2SFq6cwZcxjiLe6s=; b=q46iPuJ70evS6J1P74NYIJOAxW
        scefIU1yk/kL/ar5KUdcC14f0sB2piYkN7uPb/vnUZNunyjJKH2t1IRIlwylOyGjdwHV5Awet2a8T
        ciAEbKdBUY9UbdKmVOWhQXZrmyK7cGc8oF8y7uBTfzpyhunVIwcJ6cElGRtkxP0a60ZsK4enRlC1W
        JT/xANm8XIwuN+sVqULxkAy8s6BczyAeC+QxtOc72+XKcdO02gmxOKBixHWiesK3VhebNbiEVwUbR
        8GLGHAtbQianjVxFAxz5mhfDNfBIBGuzu/IXwrRaSG07LhyzUBnsIzFvuLAyBJrdc40CnkvCbggB4
        uT7rCxVw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFFi-006QPD-SU; Tue, 12 Oct 2021 10:44:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: cleanup blk_mq_submit_bio
Date:   Tue, 12 Oct 2021 12:40:45 +0200
Message-Id: <20211012104045.658051-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012104045.658051-1-hch@lst.de>
References: <20211012104045.658051-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the blk_mq_alloc_data stack allocation only into the branch
that actually needs it, and use rq->mq_hctx instead of data.hctx
to refer to the hctx.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3fe3350616f13..38e6651d8b94c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2209,10 +2209,6 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
-	struct blk_mq_alloc_data data = {
-		.q		= q,
-		.nr_tags	= 1,
-	};
 	struct request *rq;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
@@ -2243,9 +2239,13 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		rq = plug->cached_rq;
 		plug->cached_rq = rq->rq_next;
 		INIT_LIST_HEAD(&rq->queuelist);
-		data.hctx = rq->mq_hctx;
 	} else {
-		data.cmd_flags = bio->bi_opf;
+		struct blk_mq_alloc_data data = {
+			.q		= q,
+			.nr_tags	= 1,
+			.cmd_flags	= bio->bi_opf,
+		};
+
 		if (plug) {
 			data.nr_tags = plug->nr_ios;
 			plug->nr_ios = 1;
@@ -2264,7 +2264,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_track(q, rq, bio);
 
-	cookie = request_to_qc_t(data.hctx, rq);
+	cookie = request_to_qc_t(rq->mq_hctx, rq);
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
@@ -2279,7 +2279,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	if (unlikely(is_flush_fua)) {
 		/* Bypass scheduler for flush requests */
 		blk_insert_flush(rq);
-		blk_mq_run_hw_queue(data.hctx, true);
+		blk_mq_run_hw_queue(rq->mq_hctx, true);
 	} else if (plug && (q->nr_hw_queues == 1 ||
 		   blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
 		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
@@ -2326,18 +2326,17 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		trace_block_plug(q);
 
 		if (same_queue_rq) {
-			data.hctx = same_queue_rq->mq_hctx;
 			trace_block_unplug(q, 1, true);
-			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
-					&cookie);
+			blk_mq_try_issue_directly(same_queue_rq->mq_hctx,
+						  same_queue_rq, &cookie);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) ||
-			!data.hctx->dispatch_busy) {
+		   !rq->mq_hctx->dispatch_busy) {
 		/*
 		 * There is no scheduler and we can try to send directly
 		 * to the hardware.
 		 */
-		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
+		blk_mq_try_issue_directly(rq->mq_hctx, rq, &cookie);
 	} else {
 		/* Default case. */
 		blk_mq_sched_insert_request(rq, false, true, true);
-- 
2.30.2

