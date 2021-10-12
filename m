Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EC4C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984D2610D1
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhJLKpZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbhJLKpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 06:45:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E9C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FcwtSHjpR4OrISLjx7ZwjsSRFr8BFo1dKRXPPQauluM=; b=RjIB9gjjN2KAS9xFM6c5u8m1Kt
        ZbtU04Gj+/1BfyQMflQGRhTZkHeclzSawm7O5ePHIg59alvWxfIJpzv4WjYshelNRW6e+XsnpR+sy
        7vpM89U7ZS97DBTi2ZgTAnQIO94M4ckZ82i/9SEWrQXE9FcIxlYsfFPWG9ihXcSYXBsW6TNZrh/NW
        9JGkMYH4LZe2S9rgeFaIebO+zHIHG27/1k6pNwSkl14ln1LppYzAjD58UwJymgvW6Qg3Uy5uq2Cey
        QzbuHZ9MwbeemePv2kw3dCzSJoL2S1R31Qk+0yghKmVlWY2f7ZGvHZSMDdHEAYsULGWpXDa+zmqE7
        d7vXU0zQ==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFEQ-006QKs-IE; Tue, 12 Oct 2021 10:42:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: cleanup and rename __blk_mq_alloc_request
Date:   Tue, 12 Oct 2021 12:40:44 +0200
Message-Id: <20211012104045.658051-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012104045.658051-1-hch@lst.de>
References: <20211012104045.658051-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The newly added loop for the cached requests in __blk_mq_alloc_request
is a little too convoluted for my taste, so unwind it a bit.  Also
rename the function to __blk_mq_alloc_requests now that it can allocate
more than a single request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ced94eb8e2979..3fe3350616f13 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -347,7 +347,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	return rq;
 }
 
-static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
+static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
 	struct elevator_queue *e = q->elevator;
@@ -388,36 +388,36 @@ static struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data)
 	 */
 	do {
 		tag = blk_mq_get_tag(data);
-		if (tag != BLK_MQ_NO_TAG) {
-			rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
-			if (!--data->nr_tags)
-				return rq;
-			if (e || data->hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
-				return rq;
-			rq->rq_next = *data->cached_rq;
-			*data->cached_rq = rq;
-			data->flags |= BLK_MQ_REQ_NOWAIT;
-			continue;
+		if (tag == BLK_MQ_NO_TAG) {
+			if (data->flags & BLK_MQ_REQ_NOWAIT)
+				break;
+			/*
+			 * Give up the CPU and sleep for a random short time to
+			 * ensure that thread using a realtime scheduling class
+			 * are migrated off the CPU, and thus off the hctx that
+			 * is going away.
+			 */
+			msleep(3);
+			goto retry;
 		}
-		if (data->flags & BLK_MQ_REQ_NOWAIT)
-			break;
 
-		/*
-		 * Give up the CPU and sleep for a random short time to ensure
-		 * that thread using a realtime scheduling class are migrated
-		 * off the CPU, and thus off the hctx that is going away.
-		 */
-		msleep(3);
-		goto retry;
+		rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
+		if (!--data->nr_tags || e ||
+		    (data->hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
+			return rq;
+
+		/* link into the cached list */
+		rq->rq_next = *data->cached_rq;
+		*data->cached_rq = rq;
+		data->flags |= BLK_MQ_REQ_NOWAIT;
 	} while (1);
 
-	if (data->cached_rq) {
-		rq = *data->cached_rq;
-		*data->cached_rq = rq->rq_next;
-		return rq;
-	}
+	if (!data->cached_rq)
+		return NULL;
 
-	return NULL;
+	rq = *data->cached_rq;
+	*data->cached_rq = rq->rq_next;
+	return rq;
 }
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
@@ -436,7 +436,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (ret)
 		return ERR_PTR(ret);
 
-	rq = __blk_mq_alloc_request(&data);
+	rq = __blk_mq_alloc_requests(&data);
 	if (!rq)
 		goto out_queue_exit;
 	rq->__data_len = 0;
@@ -2251,7 +2251,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 			plug->nr_ios = 1;
 			data.cached_rq = &plug->cached_rq;
 		}
-		rq = __blk_mq_alloc_request(&data);
+		rq = __blk_mq_alloc_requests(&data);
 		if (unlikely(!rq)) {
 			rq_qos_cleanup(q, bio);
 			if (bio->bi_opf & REQ_NOWAIT)
-- 
2.30.2

