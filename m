Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97160C54FCB
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7697C20728
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uT9rBLS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDYRJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbgDYRJ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:09:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8826CC09B04D
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AQPXtODk+6L4IXNtysoa6Tt8f3llRP0MPsnKdnvBIuY=; b=uT9rBLS5yKGaIRL0wJM+pi7fHF
        O7kfT5h8eE8SoiZ0As9LhLrP361SKRxtdooiv0rLWAgG0VvgBjR8n4/NrnMjXT7Tf6efy9huxCAbh
        DulWPXnTCTt6SxT1AedeY2SThbo14E3lDDDe6jwAEbw/WKZr3pMQxl7woGX34FCzmglzKinVO/pzX
        HWNyvxoVEbk+fi0JN7d0Dz8L87t6kc7W4UNaBFc1RnT7MHPq/hvdYYdeTvfThfruo1XEsfpSDJf8D
        56bzHlJ9N6A6PA1wo+phohinlwrtBTcq6npn/NWTD76Ry/RCvH6jrpllsL9EO87bWLegda64omDVl
        yFuJMDKQ==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJQ-0001jX-2s; Sat, 25 Apr 2020 17:09:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 04/11] block: add a bio_queue_enter helper
Date:   Sat, 25 Apr 2020 19:09:37 +0200
Message-Id: <20200425170944.968861-5-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425170944.968861-1-hch@lst.de>
References: <20200425170944.968861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a little helper that passes the right nowait flag to blk_queue_enter
based on the bio flag, and terminates the bio with the right error code
if entering the queue fails.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 50 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 81a291085c6ca..7f11560bfddbb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -440,6 +440,23 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	}
 }
 
+static inline int bio_queue_enter(struct bio *bio)
+{
+	struct request_queue *q = bio->bi_disk->queue;
+	bool nowait = bio->bi_opf & REQ_NOWAIT;
+	int ret;
+
+	ret = blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0);
+	if (unlikely(ret)) {
+		if (nowait && !blk_queue_dying(q))
+			bio_wouldblock_error(bio);
+		else
+			bio_io_error(bio);
+	}
+
+	return ret;
+}
+
 void blk_queue_exit(struct request_queue *q)
 {
 	percpu_ref_put(&q->q_usage_counter);
@@ -1049,10 +1066,8 @@ blk_qc_t generic_make_request(struct bio *bio)
 	current->bio_list = bio_list_on_stack;
 	do {
 		struct request_queue *q = bio->bi_disk->queue;
-		blk_mq_req_flags_t flags = bio->bi_opf & REQ_NOWAIT ?
-			BLK_MQ_REQ_NOWAIT : 0;
 
-		if (likely(blk_queue_enter(q, flags) == 0)) {
+		if (likely(bio_queue_enter(bio) == 0)) {
 			struct bio_list lower, same;
 
 			/* Create a fresh bio_list for all subordinate requests */
@@ -1079,12 +1094,6 @@ blk_qc_t generic_make_request(struct bio *bio)
 			bio_list_merge(&bio_list_on_stack[0], &lower);
 			bio_list_merge(&bio_list_on_stack[0], &same);
 			bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
-		} else {
-			if (unlikely(!blk_queue_dying(q) &&
-					(bio->bi_opf & REQ_NOWAIT)))
-				bio_wouldblock_error(bio);
-			else
-				bio_io_error(bio);
 		}
 		bio = bio_list_pop(&bio_list_on_stack[0]);
 	} while (bio);
@@ -1106,30 +1115,19 @@ EXPORT_SYMBOL(generic_make_request);
 blk_qc_t direct_make_request(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	bool nowait = bio->bi_opf & REQ_NOWAIT;
 	blk_qc_t ret;
 
-	if (WARN_ON_ONCE(q->make_request_fn))
-		goto io_error;
-	if (!generic_make_request_checks(bio))
+	if (WARN_ON_ONCE(q->make_request_fn)) {
+		bio_io_error(bio);
 		return BLK_QC_T_NONE;
-
-	if (unlikely(blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0))) {
-		if (nowait && !blk_queue_dying(q))
-			goto would_block;
-		goto io_error;
 	}
-
+	if (!generic_make_request_checks(bio))
+		return BLK_QC_T_NONE;
+	if (unlikely(bio_queue_enter(bio)))
+		return BLK_QC_T_NONE;
 	ret = blk_mq_make_request(q, bio);
 	blk_queue_exit(q);
 	return ret;
-
-would_block:
-	bio_wouldblock_error(bio);
-	return BLK_QC_T_NONE;
-io_error:
-	bio_io_error(bio);
-	return BLK_QC_T_NONE;
 }
 EXPORT_SYMBOL_GPL(direct_make_request);
 
-- 
2.26.1

