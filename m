Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5938C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4647206D4
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 18:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ig93Vrj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEPS2J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgEPS2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 14:28:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8399EC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PsNaK5XnNETQkmIqINa8CS5GIAqxMwy+H4U1HLrVtes=; b=Ig93Vrj5bE9ZPbuKwHquL6wdb4
        kTWOe8W0F4PfEuGB+0CzFdPjQI29wY12QQmuKrNK5L7JOO+ZTbLCZkXE9lLoG9DWg3xZPdCMlxNuc
        CyIf0O7puHv/A4wE3ZdNCjkFCfmK/T2UNSAPCw0oO1+gGt+MNc8vIr83fwxnBuY2Tevw0918Rjzzq
        MXqfOwcUNUZCJX5g2u241BRs9sN0MqFhDNipqlbKnq582yEwPucjtOgkv26pa4CRD0jpehJOZAxiF
        hTkTdjs5Ed30qUEJxy3TtD7LqwSCv0HRvrfIdcI2/i8fyINW0PkETKk5rb6i3TpYFmXxj7zi9Nbg4
        E9SUfGWQ==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ja1Xa-0007nh-LQ; Sat, 16 May 2020 18:28:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/4] blk-mq: move the call to blk_queue_enter_live out of blk_mq_get_request
Date:   Sat, 16 May 2020 20:27:58 +0200
Message-Id: <20200516182801.482930-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516182801.482930-1-hch@lst.de>
References: <20200516182801.482930-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the blk_queue_enter_live calls into the callers, where they can
successively be cleaned up.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4f8adef7fd0d9..b7e06673a30ba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -342,8 +342,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	bool clear_ctx_on_error = false;
 	u64 alloc_time_ns = 0;
 
-	blk_queue_enter_live(q);
-
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = ktime_get_ns();
@@ -379,7 +377,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	if (tag == BLK_MQ_TAG_FAIL) {
 		if (clear_ctx_on_error)
 			data->ctx = NULL;
-		blk_queue_exit(q);
 		return NULL;
 	}
 
@@ -409,16 +406,19 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (ret)
 		return ERR_PTR(ret);
 
+	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
 	blk_queue_exit(q);
 
 	if (!rq)
-		return ERR_PTR(-EWOULDBLOCK);
-
+		goto out_queue_exit;
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
 	rq->bio = rq->biotail = NULL;
 	return rq;
+out_queue_exit:
+	blk_queue_exit(q);
+	return ERR_PTR(-EWOULDBLOCK);
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
@@ -450,21 +450,24 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
 	 */
+	ret = -EXDEV;
 	alloc_data.hctx = q->queue_hw_ctx[hctx_idx];
-	if (!blk_mq_hw_queue_mapped(alloc_data.hctx)) {
-		blk_queue_exit(q);
-		return ERR_PTR(-EXDEV);
-	}
+	if (!blk_mq_hw_queue_mapped(alloc_data.hctx))
+		goto out_queue_exit;
 	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
+	ret = -EWOULDBLOCK;
+	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
 	blk_queue_exit(q);
 
 	if (!rq)
-		return ERR_PTR(-EWOULDBLOCK);
-
+		goto out_queue_exit;
 	return rq;
+out_queue_exit:
+	blk_queue_exit(q);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
@@ -2043,8 +2046,10 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	rq_qos_throttle(q, bio);
 
 	data.cmd_flags = bio->bi_opf;
+	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
+		blk_queue_exit(q);
 		rq_qos_cleanup(q, bio);
 		if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
-- 
2.26.2

