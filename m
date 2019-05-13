Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D960AC04AB3
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB75020879
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4SoSkas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEMGjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 02:39:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEMGi7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 02:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4y/2DPa+qj3r8jDsbLfHcOtnwWS/+v0C0Eu3kFh8clQ=; b=T4SoSkasV2i50dZvTsVvfD8hhy
        i1AN9w3uic1hKXz9KLUDPXbW3zSH7zd0Vh+RER1oXF1CDa/lXjhmBVM0tT8+Tazil92px5rtrixxJ
        7xKXG+T6FilpEK3T7W3AACp0j2yhGIiy85fzpkwVorOn8PzPcfQRsWkYQ9KAnTPeQoKg1FPpiTy/Z
        xyI4owO9BJJu79ZYiawdTRz1OQ364VQ4a00ERQu463NOOvw6ZBfoK37qxLfCwlAPqfiYTF2zijtsH
        Wq0wm40uBAm5CkjCXH8ZcW1VWYF8sZOXR+QM2kOkZCozTTXVfpkGLt7EluRq+vPkfRO9TJ4H5gsrE
        viHaBChw==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ4by-0007RA-1M; Mon, 13 May 2019 06:38:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: [PATCH 08/10] block: simplify blk_recalc_rq_segments
Date:   Mon, 13 May 2019 08:37:52 +0200
Message-Id: <20190513063754.1520-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513063754.1520-1-hch@lst.de>
References: <20190513063754.1520-1-hch@lst.de>
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
index 84118411626c..c894c9887dca 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1198,7 +1198,7 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
 	 * Recalculate it to check the request correctly on this queue's
 	 * limitation.
 	 */
-	blk_recalc_rq_segments(rq);
+	rq->nr_phys_segments = blk_recalc_rq_segments(rq);
 	if (rq->nr_phys_segments > queue_max_segments(q)) {
 		printk(KERN_ERR "%s: over max segments limit.\n", __func__);
 		return -EIO;
@@ -1466,7 +1466,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
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
index a18d0b9fe353..5352cdb876a6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -204,7 +204,7 @@ struct request *attempt_back_merge(struct request_queue *q, struct request *rq);
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

