Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35739 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeAKNJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jan 2018 08:09:21 -0500
Received: by mail-wr0-f195.google.com with SMTP id n9so2117667wrg.2
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2018 05:09:20 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Tejun Heo <tj@kernel.org>, David Disseldorp <ddiss@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 1/2] block: fail op_is_write() requests to read-only partitions
Date: Thu, 11 Jan 2018 14:09:11 +0100
Message-Id: <1515676152-18476-2-git-send-email-idryomov@gmail.com>
In-Reply-To: <1515676152-18476-1-git-send-email-idryomov@gmail.com>
References: <1515676152-18476-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Regular block device writes go through blkdev_write_iter(), which does
bdev_read_only(), while zeroout/discard/etc requests are never checked,
both userspace- and kernel-triggered.  Add a generic catch-all check to
generic_make_request_checks() to actually enforce ioctl(BLKROSET) and
set_disk_ro(), which is used by quite a few drivers for things like
snapshots, read-only backing files/images, etc.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 block/blk-core.c | 56 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f843ae4f858d..44a6dfe47ae1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2062,6 +2062,21 @@ static inline bool should_fail_request(struct hd_struct *part,
 
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
+static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
+{
+	if (part->policy && op_is_write(bio_op(bio))) {
+		char b[BDEVNAME_SIZE];
+
+		printk(KERN_ERR
+		       "generic_make_request: Trying to write "
+			"to read-only block-device %s (partno %d)\n",
+			bio_devname(bio, b), part->partno);
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
@@ -2070,27 +2085,28 @@ static inline int blk_partition_remap(struct bio *bio)
 	struct hd_struct *p;
 	int ret = 0;
 
+	rcu_read_lock();
+	p = __disk_get_part(bio->bi_disk, bio->bi_partno);
+	if (unlikely(!p || should_fail_request(p, bio->bi_iter.bi_size) ||
+		     bio_check_ro(bio, p))) {
+		ret = -EIO;
+		goto out;
+	}
+
 	/*
 	 * Zone reset does not include bi_size so bio_sectors() is always 0.
 	 * Include a test for the reset op code and perform the remap if needed.
 	 */
-	if (!bio->bi_partno ||
-	    (!bio_sectors(bio) && bio_op(bio) != REQ_OP_ZONE_RESET))
-		return 0;
+	if (!bio_sectors(bio) && bio_op(bio) != REQ_OP_ZONE_RESET)
+		goto out;
 
-	rcu_read_lock();
-	p = __disk_get_part(bio->bi_disk, bio->bi_partno);
-	if (likely(p && !should_fail_request(p, bio->bi_iter.bi_size))) {
-		bio->bi_iter.bi_sector += p->start_sect;
-		bio->bi_partno = 0;
-		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
-				bio->bi_iter.bi_sector - p->start_sect);
-	} else {
-		printk("%s: fail for partition %d\n", __func__, bio->bi_partno);
-		ret = -EIO;
-	}
-	rcu_read_unlock();
+	bio->bi_iter.bi_sector += p->start_sect;
+	bio->bi_partno = 0;
+	trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
+			      bio->bi_iter.bi_sector - p->start_sect);
 
+out:
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -2149,15 +2165,19 @@ generic_make_request_checks(struct bio *bio)
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue is not a request based queue.
 	 */
-
 	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
 		goto not_supported;
 
 	if (should_fail_request(&bio->bi_disk->part0, bio->bi_iter.bi_size))
 		goto end_io;
 
-	if (blk_partition_remap(bio))
-		goto end_io;
+	if (!bio->bi_partno) {
+		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
+			goto end_io;
+	} else {
+		if (blk_partition_remap(bio))
+			goto end_io;
+	}
 
 	if (bio_check_eod(bio, nr_sectors))
 		goto end_io;
-- 
2.4.3
