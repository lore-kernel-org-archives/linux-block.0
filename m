Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86148C25B06
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiG0QYl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiG0QYF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:24:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3AD4E603
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nEGchU77p4QUvjk9ENFRTDaA3ghZQQDcKFLJ+m9H1lU=; b=OJnU8TMq02Vhaqg4eMUZycTqYJ
        JEnENeBXDy7attLa5fRLOCOnYw5m7eqk5wKLp2q5Xtm7uBKgdPZSE8lUKYvonOFgjlVx9e0Y8PweZ
        6xBi/RWmHuTC6aTbVPT/uUY7d/zEMG01wiTvBXVn2YjWka9HvVRvapJZo4v1tq9DrRd2hjs8yUD3Z
        fX43LF/YuG8OgpuzcH2/ocikm2Uj8M+hb3i7ICCP+ROgmKM0mQ+piOGlk2t7xZib7CtBSId3D4mMS
        cm5OramNNSBimnX0vtHG8auvwwdfsirwVyOhgDbS1jOXRs24QYTd5tqHlJTc6YLsSzQGF9br08nL6
        YZvL2AhA==;
Received: from [2607:fb90:18d2:b6be:6d6f:ba8a:ca81:9775] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjoS-00FUex-SA; Wed, 27 Jul 2022 16:23:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/6] block: change the blk_queue_bounce calling convention
Date:   Wed, 27 Jul 2022 12:22:56 -0400
Message-Id: <20220727162300.3089193-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220727162300.3089193-1-hch@lst.de>
References: <20220727162300.3089193-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-mq.c |  2 +-
 block/blk.h    | 10 ++++++----
 block/bounce.c | 26 +++++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7a756ffb15679..f469808579525 100644
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
index 42d00d032bd2a..1cc813241cd4f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -383,7 +383,7 @@ static inline void blk_throtl_bio_endio(struct bio *bio) { }
 static inline void blk_throtl_stat_add(struct request *rq, u64 time) { }
 #endif
 
-void __blk_queue_bounce(struct request_queue *q, struct bio **bio);
+struct bio *__blk_queue_bounce(struct bio *bio, struct request_queue *q);
 
 static inline bool blk_queue_may_bounce(struct request_queue *q)
 {
@@ -392,10 +392,12 @@ static inline bool blk_queue_may_bounce(struct request_queue *q)
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

