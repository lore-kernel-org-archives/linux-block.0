Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943A0C43334
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 06:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiGWG2Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jul 2022 02:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGWG2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jul 2022 02:28:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F3912610
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 23:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iQIyO1ovAfO29MB7MkE0TuXEbqoNeiZYFLAaoHhuKD4=; b=m5auQRLPdrsPJHSIVfjgiklcvD
        +y8Wf7jb7DR2GlcpT9EbsL9jywlpMnyvnKkS8WgLlkUps8kbxEPIDLAziCw4B/NGwQTt0a/Ir3Li5
        IAlhfJSidE7f9Dam+4PZWfzsxw9kMehZN6BKEgXnlNU8y9weFCYlbtfP3/8R2LW2qaV9dgua/J4eJ
        0qe4bNeCGnHxeYlQ2XXkK3DpPlybumDp5ErOqdW8OzSU7IJvrtUr4smRaJp/zTWlHVrogjFGjKdYB
        1OUIIfjxct1yb4UziMiw6pvxYRpU7Efq1/kfIsYJfO5a0UnC5Xm9yKTIpnnk8EutWSl8YoptKaIk2
        zChfUaUA==;
Received: from [2001:4bb8:199:fe1f:951f:1322:520f:5e75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oF8ch-00GLfQ-J6; Sat, 23 Jul 2022 06:28:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/6] block: change the blk_queue_bounce calling convention
Date:   Sat, 23 Jul 2022 08:28:12 +0200
Message-Id: <20220723062816.2210784-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220723062816.2210784-1-hch@lst.de>
References: <20220723062816.2210784-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The double indirect bio leads to somewhat suboptimal code generation.
Instead return the (original or split) bio, and make sure the
request_queue arguments to the lower level helpers is passed after the
bio to avoid constant reshuffling of the argument passing registers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c |  2 +-
 block/blk.h    | 10 ++++++----
 block/bounce.c | 26 +++++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 790f55453f1b1..7adba3eeba1c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2815,7 +2815,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
-	blk_queue_bounce(q, &bio);
+	bio = blk_queue_bounce(bio, q);
 	if (bio_may_exceed_limits(bio, q))
 		bio = __bio_split_to_limits(bio, q, &nr_segs);
 
diff --git a/block/blk.h b/block/blk.h
index 623be4c2e60c1..f50c8fcded99e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -378,7 +378,7 @@ static inline void blk_throtl_bio_endio(struct bio *bio) { }
 static inline void blk_throtl_stat_add(struct request *rq, u64 time) { }
 #endif
 
-void __blk_queue_bounce(struct request_queue *q, struct bio **bio);
+struct bio *__blk_queue_bounce(struct bio *bio, struct request_queue *q);
 
 static inline bool blk_queue_may_bounce(struct request_queue *q)
 {
@@ -387,10 +387,12 @@ static inline bool blk_queue_may_bounce(struct request_queue *q)
 		max_low_pfn >= max_pfn;
 }
 
-static inline void blk_queue_bounce(struct request_queue *q, struct bio **bio)
+static inline struct bio *blk_queue_bounce(struct bio *bio,
+		struct request_queue *q)
 {
-	if (unlikely(blk_queue_may_bounce(q) && bio_has_data(*bio)))
-		__blk_queue_bounce(q, bio);	
+	if (unlikely(blk_queue_may_bounce(q) && bio_has_data(bio)))
+		return __blk_queue_bounce(bio, q);
+	return bio;
 }
 
 #ifdef CONFIG_BLK_CGROUP_IOLATENCY
diff --git a/block/bounce.c b/block/bounce.c
index c8f487af7be37..7cfcb242f9a11 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -199,24 +199,24 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	return NULL;
 }
 
-void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
+struct bio *__blk_queue_bounce(struct bio *bio_orig, struct request_queue *q)
 {
 	struct bio *bio;
-	int rw = bio_data_dir(*bio_orig);
+	int rw = bio_data_dir(bio_orig);
 	struct bio_vec *to, from;
 	struct bvec_iter iter;
 	unsigned i = 0, bytes = 0;
 	bool bounce = false;
 	int sectors;
 
-	bio_for_each_segment(from, *bio_orig, iter) {
+	bio_for_each_segment(from, bio_orig, iter) {
 		if (i++ < BIO_MAX_VECS)
 			bytes += from.bv_len;
 		if (PageHighMem(from.bv_page))
 			bounce = true;
 	}
 	if (!bounce)
-		return;
+		return bio_orig;
 
 	/*
 	 * Individual bvecs might not be logical block aligned. Round down
@@ -225,13 +225,13 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 	 */
 	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >>
 			SECTOR_SHIFT;
-	if (sectors < bio_sectors(*bio_orig)) {
-		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
-		bio_chain(bio, *bio_orig);
-		submit_bio_noacct(*bio_orig);
-		*bio_orig = bio;
+	if (sectors < bio_sectors(bio_orig)) {
+		bio = bio_split(bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
+		bio_chain(bio, bio_orig);
+		submit_bio_noacct(bio_orig);
+		bio_orig = bio;
 	}
-	bio = bounce_clone_bio(*bio_orig);
+	bio = bounce_clone_bio(bio_orig);
 
 	/*
 	 * Bvec table can't be updated by bio_for_each_segment_all(),
@@ -254,7 +254,7 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 		to->bv_page = bounce_page;
 	}
 
-	trace_block_bio_bounce(*bio_orig);
+	trace_block_bio_bounce(bio_orig);
 
 	bio->bi_flags |= (1 << BIO_BOUNCED);
 
@@ -263,6 +263,6 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 	else
 		bio->bi_end_io = bounce_end_io_write;
 
-	bio->bi_private = *bio_orig;
-	*bio_orig = bio;
+	bio->bi_private = bio_orig;
+	return bio;
 }
-- 
2.30.2

