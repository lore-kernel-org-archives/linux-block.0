Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D176FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 14:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiGTOZE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiGTOZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 10:25:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7FA509F4
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=v9oHPWij7fJYlxFetZ2chbFLF9F7MhnpQh64o/n/174=; b=aVYn26v8x5XnQmPnjAAZoiKHK1
        BNXSbtZSv1vkOXkenComyfWd/3Fn56Sig/gsPN0aldz240edVFo4GANaSIkwY4mBuhC9ioBe59iqA
        3FA6SfXa4X0UqxjNSQzLZiIF7yElY9oukVHTiXzUkvuP35ef30VPnj4ChDv8SIZ0ZG7JRdb7hzccF
        1KlaDVFBNGvoa8RaAM1QGa0il+2BprthbwLSJGufiM2DQl/FD8zuEh8ghRWuYkA9i9SjelrLwYRGa
        8joOY3lgZR+d8S5CKQtX85xBmzNVJQMNUbsbv0B1auT2UrWEy8TiryDQeXnzDoKdZFiK9fWOnXQhd
        1yB34yUQ==;
Received: from [2001:4bb8:18a:6f7a:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEAdJ-006ngq-VK; Wed, 20 Jul 2022 14:25:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/5] block: move ->bio_split to the gendisk
Date:   Wed, 20 Jul 2022 16:24:52 +0200
Message-Id: <20220720142456.1414262-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720142456.1414262-1-hch@lst.de>
References: <20220720142456.1414262-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only non-passthrough requests are split by the block layer and use the
->bio_split bio_set.  Move it from the request_queue to the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |  9 +--------
 block/blk-merge.c      | 20 ++++++++++----------
 block/blk-sysfs.c      |  2 --
 block/genhd.c          |  9 ++++++++-
 drivers/md/dm.c        |  2 +-
 include/linux/blkdev.h |  3 ++-
 6 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 123468b9d2e43..59f13d011949d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -377,7 +377,6 @@ static void blk_timeout_work(struct work_struct *work)
 struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 {
 	struct request_queue *q;
-	int ret;
 
 	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
 			GFP_KERNEL | __GFP_ZERO, node_id);
@@ -396,13 +395,9 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 	if (q->id < 0)
 		goto fail_srcu;
 
-	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
-	if (ret)
-		goto fail_id;
-
 	q->stats = blk_alloc_queue_stats();
 	if (!q->stats)
-		goto fail_split;
+		goto fail_id;
 
 	q->node = node_id;
 
@@ -439,8 +434,6 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 
 fail_stats:
 	blk_free_queue_stats(q->stats);
-fail_split:
-	bioset_exit(&q->bio_split);
 fail_id:
 	ida_free(&blk_queue_ida, q->id);
 fail_srcu:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3c3f785f558af..e657f1dc824cb 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -328,26 +328,26 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
  * Split a bio into two bios, chain the two bios, submit the second half and
  * store a pointer to the first half in *@bio. If the second bio is still too
  * big it will be split by a recursive call to this function. Since this
- * function may allocate a new bio from q->bio_split, it is the responsibility
- * of the caller to ensure that q->bio_split is only released after processing
- * of the split bio has finished.
+ * function may allocate a new bio from disk->bio_split, it is the
+ * responsibility of the caller to ensure that disk->bio_split is only released
+ * after processing of the split bio has finished.
  */
 void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		       unsigned int *nr_segs)
 {
+	struct bio_set *bs = &(*bio)->bi_bdev->bd_disk->bio_split;
 	struct bio *split = NULL;
 
 	switch (bio_op(*bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
-		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
+		split = blk_bio_discard_split(q, *bio, bs, nr_segs);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
-				nr_segs);
+		split = blk_bio_write_zeroes_split(q, *bio, bs, nr_segs);
 		break;
 	default:
-		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
+		split = blk_bio_segment_split(q, *bio, bs, nr_segs);
 		break;
 	}
 
@@ -368,9 +368,9 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
  *
  * Split a bio into two bios, chains the two bios, submit the second half and
  * store a pointer to the first half in *@bio. Since this function may allocate
- * a new bio from q->bio_split, it is the responsibility of the caller to ensure
- * that q->bio_split is only released after processing of the split bio has
- * finished.
+ * a new bio from disk->bio_split, it is the responsibility of the caller to
+ * ensure that disk->bio_split is only released after processing of the split
+ * bio has finished.
  */
 void blk_queue_split(struct bio **bio)
 {
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c0303026752d5..e1f009aba6fd2 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -779,8 +779,6 @@ static void blk_release_queue(struct kobject *kobj)
 	if (queue_is_mq(q))
 		blk_mq_release(q);
 
-	bioset_exit(&q->bio_split);
-
 	if (blk_queue_has_srcu(q))
 		cleanup_srcu_struct(q->srcu);
 
diff --git a/block/genhd.c b/block/genhd.c
index 44dfcf67ed96a..150494e8742b0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1138,6 +1138,8 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
+	bioset_exit(&disk->bio_split);
+
 	blkcg_exit_queue(disk->queue);
 
 	disk_release_events(disk);
@@ -1330,9 +1332,12 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	if (!disk)
 		goto out_put_queue;
 
+	if (bioset_init(&disk->bio_split, BIO_POOL_SIZE, 0, 0))
+		goto out_free_disk;
+
 	disk->bdi = bdi_alloc(node_id);
 	if (!disk->bdi)
-		goto out_free_disk;
+		goto out_free_bioset;
 
 	/* bdev_alloc() might need the queue, set before the first call */
 	disk->queue = q;
@@ -1370,6 +1375,8 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	iput(disk->part0->bd_inode);
 out_free_bdi:
 	bdi_put(disk->bdi);
+out_free_bioset:
+	bioset_exit(&disk->bio_split);
 out_free_disk:
 	kfree(disk);
 out_put_queue:
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 54c2a23f4e55c..b163de50f3c6b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1693,7 +1693,7 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 	 */
 	WARN_ON_ONCE(!dm_io_flagged(io, DM_IO_WAS_SPLIT));
 	io->split_bio = bio_split(bio, io->sectors, GFP_NOIO,
-				  &md->queue->bio_split);
+				  &md->disk->bio_split);
 	bio_chain(io->split_bio, bio);
 	trace_block_split(io->split_bio, bio->bi_iter.bi_sector);
 	submit_bio_noacct(bio);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d04bdf549efa9..97d3ef8f3f416 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -140,6 +140,8 @@ struct gendisk {
 	struct request_queue *queue;
 	void *private_data;
 
+	struct bio_set bio_split;
+
 	int flags;
 	unsigned long state;
 #define GD_NEED_PART_SCAN		0
@@ -531,7 +533,6 @@ struct request_queue {
 
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
-	struct bio_set		bio_split;
 
 	struct dentry		*debugfs_dir;
 	struct dentry		*sched_debugfs_dir;
-- 
2.30.2

