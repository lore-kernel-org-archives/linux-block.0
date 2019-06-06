Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4A6C28D1E
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5608C20868
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sRsZIdS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfFFK3V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:29:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFFK3V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 06:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rmV5aKCMJFOjqTawLhKyBFe8QwFRyiAtoEGjYJRcGvs=; b=sRsZIdS+8oJoQdBenhK5ycvYaE
        0Hl85LosyWPStio6SYLYVIbhFoQqUUWJxhqHkfjp2slKW4Syn6QHCR5aq9MstyhQy8f42Ap/cjrB+
        GCNAloxNdbOgGzjSaSo+6vCdtFMqrImcWmXYwyudRCc9NzkKRkZ6rafJyNnpkIN58/B61DlYFU0GE
        bl6cjO2z6umiQqm/1MRNTWciS5xKmEXYluI+8mz/F/7ndVk24ZMVFlMnvbG6UF5wcffGTGAoemu7u
        SX12AV7FNL6atjBATIKfQP/mkWm/pRXi2nD5Ez+IDseS65DU33oeZhxK2b/6HWZdTLn/qvstB/WM3
        q4P1Z2sw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpe4-0000C8-Eb; Thu, 06 Jun 2019 10:29:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: [PATCH 4/6] block: simplify blk_recalc_rq_segments
Date:   Thu,  6 Jun 2019 12:29:02 +0200
Message-Id: <20190606102904.4024-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606102904.4024-1-hch@lst.de>
References: <20190606102904.4024-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Return the segement and let the callers assign them, which makes the code
a littler more obvious.  Also pass the request instead of q plus bio
chain, allowing for the use of rq_for_each_bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c  |  4 ++--
 block/blk-merge.c | 21 ++++++---------------
 block/blk.h       |  2 +-
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 48088dff4ec0..2287b8c2979c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1139,7 +1139,7 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
 	 * Recalculate it to check the request correctly on this queue's
 	 * limitation.
 	 */
-	blk_recalc_rq_segments(rq);
+	rq->nr_phys_segments = blk_recalc_rq_segments(rq);
 	if (rq->nr_phys_segments > queue_max_segments(q)) {
 		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
 			__func__, rq->nr_phys_segments, queue_max_segments(q));
@@ -1408,7 +1408,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		}
 
 		/* recalculate the number of segments */
-		blk_recalc_rq_segments(req);
+		req->nr_phys_segments = blk_recalc_rq_segments(req);
 	}
 
 	return true;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 72b4fd89a22d..2ea21ffd5f72 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -310,17 +310,16 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 }
 EXPORT_SYMBOL(blk_queue_split);
 
-static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
-					     struct bio *bio)
+unsigned int blk_recalc_rq_segments(struct request *rq)
 {
 	unsigned int nr_phys_segs = 0;
-	struct bvec_iter iter;
+	struct req_iterator iter;
 	struct bio_vec bv;
 
-	if (!bio)
+	if (!rq->bio)
 		return 0;
 
-	switch (bio_op(bio)) {
+	switch (bio_op(rq->bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
@@ -329,19 +328,11 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 		return 1;
 	}
 
-	for_each_bio(bio) {
-		bio_for_each_bvec(bv, bio, iter)
-			bvec_split_segs(q, &bv, &nr_phys_segs, NULL, UINT_MAX);
-	}
-
+	rq_for_each_bvec(bv, rq, iter)
+		bvec_split_segs(rq->q, &bv, &nr_phys_segs, NULL, UINT_MAX);
 	return nr_phys_segs;
 }
 
-void blk_recalc_rq_segments(struct request *rq)
-{
-	rq->nr_phys_segments = __blk_recalc_rq_segments(rq->q, rq->bio);
-}
-
 static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
 		struct scatterlist *sglist)
 {
diff --git a/block/blk.h b/block/blk.h
index 1390e8dbcdae..befdab456209 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -203,7 +203,7 @@ struct request *attempt_back_merge(struct request_queue *q, struct request *rq);
 struct request *attempt_front_merge(struct request_queue *q, struct request *rq);
 int blk_attempt_req_merge(struct request_queue *q, struct request *rq,
 				struct request *next);
-void blk_recalc_rq_segments(struct request *rq);
+unsigned int blk_recalc_rq_segments(struct request *rq);
 void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
-- 
2.20.1

