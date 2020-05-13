Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811CEC47077
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B5520769
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U0GnBRet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgEMLEZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbgEMLEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:04:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B67CC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VZzHkI7YYwFmXNGJ2V1buUhwiisiMiuS6s1oh+Jtlv8=; b=U0GnBRetr7RxarTOKCDyNdbsIx
        CEuZvkfLp01XaASJ4+nw7nQwIMdxS9f5osXs/Zm6FS6SP2ra9c6Yk06f1j0JJDcTw+17FYrz6uWSN
        UYC7/prtTphfBr3OcmFu3kVa+k/lA4dLS6NDmZ9yDIIQah5/qqEvTeNNkLfnCvkDB6aqhhZ2J5JO2
        ky5u4KfysnotB3Q+Cmax3pfm6TpIgFuy57SlmadfoHXFi0Ya3r8Z197ypCHHcPpScvxTkkkyBL0m6
        ERP+k3iUY+Di3oGoAUKKXmTsOqXxzRbiANpEfbdiLnpNvT6lVh9XGBTyZ/5MmiZGP3nnxzHuMbvCC
        7Oe7RMtQ==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYpBY-0006iG-Pf; Wed, 13 May 2020 11:04:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: move the call to blk_queue_enter_live out of blk_mq_get_request
Date:   Wed, 13 May 2020 13:04:16 +0200
Message-Id: <20200513110419.2362556-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513110419.2362556-1-hch@lst.de>
References: <20200513110419.2362556-1-hch@lst.de>
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
---
 block/blk-mq.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ee695bdf8739..9865a36e6a6e3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -340,8 +340,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	bool clear_ctx_on_error = false;
 	u64 alloc_time_ns = 0;
 
-	blk_queue_enter_live(q);
-
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
 		alloc_time_ns = ktime_get_ns();
@@ -377,7 +375,6 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	if (tag == BLK_MQ_TAG_FAIL) {
 		if (clear_ctx_on_error)
 			data->ctx = NULL;
-		blk_queue_exit(q);
 		return NULL;
 	}
 
@@ -407,11 +404,14 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (ret)
 		return ERR_PTR(ret);
 
+	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
 	blk_queue_exit(q);
 
-	if (!rq)
+	if (!rq) {
+		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
+	}
 
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
@@ -456,11 +456,14 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
+	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
 	blk_queue_exit(q);
 
-	if (!rq)
+	if (!rq) {
+		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
+	}
 
 	return rq;
 }
@@ -2038,8 +2041,10 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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

