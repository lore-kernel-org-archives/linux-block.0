Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934018AbcJTNMa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 09:12:30 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/7] block: replace REQ_THROTTLED with a bio flag
Date: Thu, 20 Oct 2016 15:12:12 +0200
Message-Id: <1476969135-32732-5-git-send-email-hch@lst.de>
In-Reply-To: <1476969135-32732-1-git-send-email-hch@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It's the last bio-only REQ_* flag, and we have space for it in the bio
bi_flags field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-throttle.c      | 10 +++++-----
 include/linux/blk_types.h |  8 ++------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a3ea826..a6bb4fe 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -818,13 +818,13 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
 	tg->io_disp[rw]++;
 
 	/*
-	 * REQ_THROTTLED is used to prevent the same bio to be throttled
+	 * BIO_THROTTLED is used to prevent the same bio to be throttled
 	 * more than once as a throttled bio will go through blk-throtl the
 	 * second time when it eventually gets issued.  Set it when a bio
 	 * is being charged to a tg.
 	 */
-	if (!(bio->bi_opf & REQ_THROTTLED))
-		bio->bi_opf |= REQ_THROTTLED;
+	if (!bio_flagged(bio, BIO_THROTTLED))
+		bio_set_flag(bio, BIO_THROTTLED);
 }
 
 /**
@@ -1401,7 +1401,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	/* see throtl_charge_bio() */
-	if ((bio->bi_opf & REQ_THROTTLED) || !tg->has_rules[rw])
+	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
 		goto out;
 
 	spin_lock_irq(q->queue_lock);
@@ -1480,7 +1480,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	 * being issued.
 	 */
 	if (!throttled)
-		bio->bi_opf &= ~REQ_THROTTLED;
+		bio_clear_flag(bio, BIO_THROTTLED);
 	return throttled;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 44f9bca..6df722d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -119,6 +119,8 @@ struct bio {
 #define BIO_QUIET	6	/* Make BIO Quiet */
 #define BIO_CHAIN	7	/* chained bio, ->bi_remaining in effect */
 #define BIO_REFFED	8	/* bio has elevated ->bi_cnt */
+#define BIO_THROTTLED	9	/* This bio has already been subjected to
+				 * throttling rules. Don't do it again. */
 
 /*
  * Flags starting here get preserved by bio_reset() - this includes
@@ -165,10 +167,6 @@ enum rq_flag_bits {
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 
-	/* bio only flags */
-	__REQ_THROTTLED,	/* This bio has already been subjected to
-				 * throttling rules. Don't do it again. */
-
 	/* request only flags */
 	__REQ_SORTED,		/* elevator knows about this request */
 	__REQ_SOFTBARRIER,	/* may not be passed by ioscheduler */
@@ -213,8 +211,6 @@ enum rq_flag_bits {
 	(REQ_NOMERGE | REQ_STARTED | REQ_SOFTBARRIER | REQ_PREFLUSH | REQ_FUA | REQ_FLUSH_SEQ)
 
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
-#define REQ_THROTTLED		(1ULL << __REQ_THROTTLED)
-
 #define REQ_SORTED		(1ULL << __REQ_SORTED)
 #define REQ_SOFTBARRIER		(1ULL << __REQ_SOFTBARRIER)
 #define REQ_FUA			(1ULL << __REQ_FUA)
-- 
2.1.4

