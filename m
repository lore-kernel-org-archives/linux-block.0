Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD21FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942F460F43
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhITMpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhITMpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:45:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67999C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L968Hz3Y98xwJn/yoMiH3/QJQvmLQBEtd/AKKBHeLFg=; b=KMizDVzIkmj6TAXJ3RXXWAwLpx
        TXBlkLxgTKmYYDAQDwW/GTObGfZaWmTEY0b8LbdyKAQX+01zHsB2BV2UdudNAXZOwoe/7bdpAuCbz
        7iiJdItD4Tu6lJkABWYwOAgxpse7qBEs90SUg5Nhiw5t4EDJZj9AR8NIUpWjOlSC/cFb86/dqu3mf
        JcylaQzzdaYbFSc3Qao9H8/PphqNxnqJND/PXYx5FKPzpu/bZ3F3ijFwhBwBG/5vEJuvELvKVopPQ
        heKQgrwOXVBBs+nXcZo2EuGpxfZBLy/AIxt01XyhkAxNLp7j35zEqcdHl3t6KatqatKjK68ce3lTJ
        feZpixvQ==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIe3-002fWl-6H; Mon, 20 Sep 2021 12:43:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 15/17] block: move a few merge helpers out of <linux/blkdev.h>
Date:   Mon, 20 Sep 2021 14:33:26 +0200
Message-Id: <20210920123328.1399408-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These are block-layer internal helpers, so move them to block/blk.h and
block/blk-merge.c.  Also update a comment a bit to use better grammar.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-merge.c      | 24 ++++++++++++++++
 block/blk.h            | 38 +++++++++++++++++++++++++
 include/linux/blkdev.h | 64 ------------------------------------------
 3 files changed, 62 insertions(+), 64 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7a5c81c02c800..39f210da399a6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -558,6 +558,23 @@ static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 	return queue_max_segments(rq->q);
 }
 
+static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
+						  sector_t offset)
+{
+	struct request_queue *q = rq->q;
+
+	if (blk_rq_is_passthrough(rq))
+		return q->limits.max_hw_sectors;
+
+	if (!q->limits.chunk_sectors ||
+	    req_op(rq) == REQ_OP_DISCARD ||
+	    req_op(rq) == REQ_OP_SECURE_ERASE)
+		return blk_queue_get_max_sectors(q, req_op(rq));
+
+	return min(blk_max_size_offset(q, offset, 0),
+			blk_queue_get_max_sectors(q, req_op(rq)));
+}
+
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 		unsigned int nr_phys_segs)
 {
@@ -718,6 +735,13 @@ static enum elv_merge blk_try_req_merge(struct request *req,
 	return ELEVATOR_NO_MERGE;
 }
 
+static inline bool blk_write_same_mergeable(struct bio *a, struct bio *b)
+{
+	if (bio_page(a) == bio_page(b) && bio_offset(a) == bio_offset(b))
+		return true;
+	return false;
+}
+
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be held.
diff --git a/block/blk.h b/block/blk.h
index 82ab26add08df..deb8393e34eec 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -94,6 +94,44 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 	return __bvec_gap_to_prev(q, bprv, offset);
 }
 
+static inline bool rq_mergeable(struct request *rq)
+{
+	if (blk_rq_is_passthrough(rq))
+		return false;
+
+	if (req_op(rq) == REQ_OP_FLUSH)
+		return false;
+
+	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
+		return false;
+
+	if (req_op(rq) == REQ_OP_ZONE_APPEND)
+		return false;
+
+	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
+		return false;
+	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
+		return false;
+
+	return true;
+}
+
+/*
+ * There are two different ways to handle DISCARD merges:
+ *  1) If max_discard_segments > 1, the driver treats every bio as a range and
+ *     send the bios to controller together. The ranges don't need to be
+ *     contiguous.
+ *  2) Otherwise, the request will be normal read/write requests.  The ranges
+ *     need to be contiguous.
+ */
+static inline bool blk_discard_mergable(struct request *req)
+{
+	if (req_op(req) == REQ_OP_DISCARD &&
+	    queue_max_discard_segments(req->q) > 1)
+		return true;
+	return false;
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 46a703394f7f4..be534040ca9c3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -745,37 +745,6 @@ static inline bool rq_is_sync(struct request *rq)
 	return op_is_sync(rq->cmd_flags);
 }
 
-static inline bool rq_mergeable(struct request *rq)
-{
-	if (blk_rq_is_passthrough(rq))
-		return false;
-
-	if (req_op(rq) == REQ_OP_FLUSH)
-		return false;
-
-	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
-		return false;
-
-	if (req_op(rq) == REQ_OP_ZONE_APPEND)
-		return false;
-
-	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
-		return false;
-	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
-		return false;
-
-	return true;
-}
-
-static inline bool blk_write_same_mergeable(struct bio *a, struct bio *b)
-{
-	if (bio_page(a) == bio_page(b) &&
-	    bio_offset(a) == bio_offset(b))
-		return true;
-
-	return false;
-}
-
 static inline unsigned int blk_queue_depth(struct request_queue *q)
 {
 	if (q->queue_depth)
@@ -1030,23 +999,6 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 	return min(q->limits.max_sectors, chunk_sectors);
 }
 
-static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
-						  sector_t offset)
-{
-	struct request_queue *q = rq->q;
-
-	if (blk_rq_is_passthrough(rq))
-		return q->limits.max_hw_sectors;
-
-	if (!q->limits.chunk_sectors ||
-	    req_op(rq) == REQ_OP_DISCARD ||
-	    req_op(rq) == REQ_OP_SECURE_ERASE)
-		return blk_queue_get_max_sectors(q, req_op(rq));
-
-	return min(blk_max_size_offset(q, offset, 0),
-			blk_queue_get_max_sectors(q, req_op(rq)));
-}
-
 static inline unsigned int blk_rq_count_bios(struct request *rq)
 {
 	unsigned int nr_bios = 0;
@@ -1490,22 +1442,6 @@ static inline int queue_limit_discard_alignment(struct queue_limits *lim, sector
 	return offset << SECTOR_SHIFT;
 }
 
-/*
- * Two cases of handling DISCARD merge:
- * If max_discard_segments > 1, the driver takes every bio
- * as a range and send them to controller together. The ranges
- * needn't to be contiguous.
- * Otherwise, the bios/requests will be handled as same as
- * others which should be contiguous.
- */
-static inline bool blk_discard_mergable(struct request *req)
-{
-	if (req_op(req) == REQ_OP_DISCARD &&
-	    queue_max_discard_segments(req->q) > 1)
-		return true;
-	return false;
-}
-
 static inline int bdev_discard_alignment(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.30.2

