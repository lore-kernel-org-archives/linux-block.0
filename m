Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E53C433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 10:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiBOKGC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 05:06:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiBOKGB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 05:06:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C83924F
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 02:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jiV+g/hzm3FCHU1Mry05zuZvudJcJN93Ahz09Tk15VU=; b=rEC8uWtMD7JxVhb2EwUPC6u2Uf
        b6h6x1ctO/VZFIHfILOvq3dQYKIVSgd1mqiwU3T5+7yq0cx6iVcowneTuqwNWRJL7YsKQapOJoWA2
        qaXZa6dDuTpIfpj9wIyMRot+HQP2cNC9TTnc//1mgCEeNUeS6QKJp4u3uMWKM2PH9XuaTBzG9++/b
        18UxX/A0PqONu1gMV6QgZIlaxUni/HI8BbosLYs9cxbFrOySx7Z9/R9zecwG0hO7+mXthNEXkw99K
        Pgf4d/OY5XeFIj6nYLW+rPDQXtqmKRcQ0nHz02NlPZDbtw368PuvDmx3eLiEsuK1ZoulMAGn7He79
        uU8mluow==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuiU-002E3T-OO; Tue, 15 Feb 2022 10:05:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 3/5] blk-mq: remove the request_queue argument to blk_insert_cloned_request
Date:   Tue, 15 Feb 2022 11:05:38 +0100
Message-Id: <20220215100540.3892965-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215100540.3892965-1-hch@lst.de>
References: <20220215100540.3892965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The request must be submitted to the queue it was allocated for, so
remove the extra request_queue argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 9 ++++-----
 drivers/md/dm-rq.c     | 2 +-
 include/linux/blk-mq.h | 3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fc132933397fb..886836a54064c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2843,11 +2843,11 @@ void blk_mq_submit_bio(struct bio *bio)
 #ifdef CONFIG_BLK_MQ_STACKING
 /**
  * blk_insert_cloned_request - Helper for stacking drivers to submit a request
- * @q:  the queue to submit the request
  * @rq: the request being queued
  */
-blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
+blk_status_t blk_insert_cloned_request(struct request *rq)
 {
+	struct request_queue *q = rq->q;
 	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
 	blk_status_t ret;
 
@@ -2881,8 +2881,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		return BLK_STS_IOERR;
 	}
 
-	if (rq->q->disk &&
-	    should_fail_request(rq->q->disk->part0, blk_rq_bytes(rq)))
+	if (q->disk && should_fail_request(q->disk->part0, blk_rq_bytes(rq)))
 		return BLK_STS_IOERR;
 
 	if (blk_crypto_insert_cloned_request(rq))
@@ -2895,7 +2894,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	blk_mq_run_dispatch_ops(rq->q,
+	blk_mq_run_dispatch_ops(q,
 			ret = blk_mq_request_issue_directly(rq, true));
 	if (ret)
 		blk_account_io_done(rq, ktime_get_ns());
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 579ab6183d4d8..2fcc9b7f391b3 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -311,7 +311,7 @@ static blk_status_t dm_dispatch_clone_request(struct request *clone, struct requ
 		clone->rq_flags |= RQF_IO_STAT;
 
 	clone->start_time_ns = ktime_get_ns();
-	r = blk_insert_cloned_request(clone->q, clone);
+	r = blk_insert_cloned_request(clone);
 	if (r != BLK_STS_OK && r != BLK_STS_RESOURCE && r != BLK_STS_DEV_RESOURCE)
 		/* must complete clone in terms of original request */
 		dm_complete_request(rq, r);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d319ffa59354a..3a41d50b85d3a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -952,8 +952,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		struct bio_set *bs, gfp_t gfp_mask,
 		int (*bio_ctr)(struct bio *, struct bio *, void *), void *data);
 void blk_rq_unprep_clone(struct request *rq);
-blk_status_t blk_insert_cloned_request(struct request_queue *q,
-		struct request *rq);
+blk_status_t blk_insert_cloned_request(struct request *rq);
 
 struct rq_map_data {
 	struct page **pages;
-- 
2.30.2

