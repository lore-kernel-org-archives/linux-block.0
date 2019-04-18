Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB68DC282DD
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 14:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9487F2083D
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 14:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbfDROGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:06:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:49672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389363AbfDROGo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 10:06:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62C8FAFDB;
        Thu, 18 Apr 2019 14:06:42 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@gmail.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: use static bio_set for bio_split() calls
Date:   Thu, 18 Apr 2019 16:06:32 +0200
Message-Id: <20190418140632.60606-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When calling blk_queue_split() it will be using the per-queue
bioset to allocate the split bio from. However, blk_steal_bios()
might move the bio to another queue, _and_ the original queue
might be removed completely (nvme is especially prone to do so).
That leaves the bvecs of the split bio with a missing / destroyed
mempool, and a really fun crash in bio_endio().

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-core.c       |  9 +--------
 block/blk-merge.c      | 36 ++++++++++++++++++++++++------------
 block/blk-sysfs.c      |  2 --
 include/linux/blkdev.h |  1 -
 4 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4673ebe42255..9317e3de2337 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -474,7 +474,6 @@ static void blk_timeout_work(struct work_struct *work)
 struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 {
 	struct request_queue *q;
-	int ret;
 
 	q = kmem_cache_alloc_node(blk_requestq_cachep,
 				gfp_mask | __GFP_ZERO, node_id);
@@ -488,13 +487,9 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	if (q->id < 0)
 		goto fail_q;
 
-	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
-	if (ret)
-		goto fail_id;
-
 	q->backing_dev_info = bdi_alloc_node(gfp_mask, node_id);
 	if (!q->backing_dev_info)
-		goto fail_split;
+		goto fail_id;
 
 	q->stats = blk_alloc_queue_stats();
 	if (!q->stats)
@@ -544,8 +539,6 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	blk_free_queue_stats(q->stats);
 fail_stats:
 	bdi_put(q->backing_dev_info);
-fail_split:
-	bioset_exit(&q->bio_split);
 fail_id:
 	ida_simple_remove(&blk_queue_ida, q->id);
 fail_q:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8f96d683b577..9c8636794944 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -12,6 +12,12 @@
 
 #include "blk.h"
 
+/*
+ * bio_split_bio_set is the bio-set containing bio and iovec memory pools used
+ * by bio_split.
+ */
+struct bio_set bio_split_bio_set;
+
 /*
  * Check if the two bvecs from two bios can be merged to one segment.  If yes,
  * no need to check gap between the two bios since the 1st bio and the 1st bvec
@@ -77,7 +83,6 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 
 static struct bio *blk_bio_discard_split(struct request_queue *q,
 					 struct bio *bio,
-					 struct bio_set *bs,
 					 unsigned *nsegs)
 {
 	unsigned int max_discard_sectors, granularity;
@@ -116,11 +121,11 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 	if (split_sectors > tmp)
 		split_sectors -= tmp;
 
-	return bio_split(bio, split_sectors, GFP_NOIO, bs);
+	return bio_split(bio, split_sectors, GFP_NOIO, &bio_split_bio_set);
 }
 
 static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
-		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
+		struct bio *bio, unsigned *nsegs)
 {
 	*nsegs = 1;
 
@@ -130,12 +135,12 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 	if (bio_sectors(bio) <= q->limits.max_write_zeroes_sectors)
 		return NULL;
 
-	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
+	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO,
+			 &bio_split_bio_set);
 }
 
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
 					    struct bio *bio,
-					    struct bio_set *bs,
 					    unsigned *nsegs)
 {
 	*nsegs = 1;
@@ -146,7 +151,8 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
 	if (bio_sectors(bio) <= q->limits.max_write_same_sectors)
 		return NULL;
 
-	return bio_split(bio, q->limits.max_write_same_sectors, GFP_NOIO, bs);
+	return bio_split(bio, q->limits.max_write_same_sectors, GFP_NOIO,
+			 &bio_split_bio_set);
 }
 
 static inline unsigned get_max_io_size(struct request_queue *q,
@@ -230,7 +236,6 @@ static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
 
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
-					 struct bio_set *bs,
 					 unsigned *segs)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
@@ -290,7 +295,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	*segs = nsegs;
 
 	if (do_split) {
-		new = bio_split(bio, sectors, GFP_NOIO, bs);
+		new = bio_split(bio, sectors, GFP_NOIO, &bio_split_bio_set);
 		if (new)
 			bio = new;
 	}
@@ -310,16 +315,16 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 	switch (bio_op(*bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-		split = blk_bio_discard_split(q, *bio, &q->bio_split, &nsegs);
+		split = blk_bio_discard_split(q, *bio, &nsegs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split, &nsegs);
+		split = blk_bio_write_zeroes_split(q, *bio, &nsegs);
 		break;
 	case REQ_OP_WRITE_SAME:
-		split = blk_bio_write_same_split(q, *bio, &q->bio_split, &nsegs);
+		split = blk_bio_write_same_split(q, *bio, &nsegs);
 		break;
 	default:
-		split = blk_bio_segment_split(q, *bio, &q->bio_split, &nsegs);
+		split = blk_bio_segment_split(q, *bio, &nsegs);
 		break;
 	}
 
@@ -979,3 +984,10 @@ enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 		return ELEVATOR_FRONT_MERGE;
 	return ELEVATOR_NO_MERGE;
 }
+
+static int __init blk_bio_split_init(void)
+{
+	return bioset_init(&bio_split_bio_set, BIO_POOL_SIZE, 0,
+			   BIOSET_NEED_BVECS);
+}
+subsys_initcall(blk_bio_split_init);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 422327089e0f..e72785751f1a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -868,8 +868,6 @@ static void __blk_release_queue(struct work_struct *work)
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
-	bioset_exit(&q->bio_split);
-
 	ida_simple_remove(&blk_queue_ida, q->id);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4b85dc066264..31e9b37e71d4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -552,7 +552,6 @@ struct request_queue {
 
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
-	struct bio_set		bio_split;
 
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
-- 
2.16.4

