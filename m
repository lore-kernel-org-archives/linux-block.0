Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC7C07E9D
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 08:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiI0IER (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 04:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiI0IDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 04:03:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FEBAE9F3
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=SlCJTIzDUQmwhx+nDadYLXYbVIH4wGfX2kYwblB33hE=; b=etn4XEgxeTfrO6TjZ7AaYKvq4o
        9l4lSRJWBe5UUj1T4knt/ukfBWa1Fw8fjEkuC283woEUUDEiPf51estx+BydvoGVAHXOeeRZ6IWcN
        l1mKco9ubHkOqa/dzJGPPj/P9I2D3EpTR0ssrOUV/j5Ff7o+YeG6CbkJwGZszNaR80/69ROn1oZbO
        HyF2JBmBGwXIDDBEWiQukkJx5CMlig9lrGxARaplPe67zY4VnGzsZgiGHjj5I/j2IZI65FCzL82xr
        ve+L/JzH5+UaWh5t85UWPi76YI+tbm/EEYTJDmxWQq3RPummcZWpqQnnzuYgctarLQdpmWBrrsoxj
        Lu6Wiy8Q==;
Received: from [2001:4bb8:180:b903:a982:5e85:edf4:3fb5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od5Tt-008wIX-R4; Tue, 27 Sep 2022 07:58:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: replace blk_queue_nowait with bdev_nowait
Date:   Tue, 27 Sep 2022 09:58:15 +0200
Message-Id: <20220927075815.269694-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace blk_queue_nowait with a bdev_nowait helpers that takes the
block_device given that the I/O submission path should not have to
look into the request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 2 +-
 drivers/md/dm-table.c  | 4 +---
 drivers/md/md.c        | 4 ++--
 include/linux/blkdev.h | 6 +++++-
 io_uring/io_uring.c    | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 052444c9b5948..dc1fa454ae301 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -713,7 +713,7 @@ void submit_bio_noacct(struct bio *bio)
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue does not support NOWAIT.
 	 */
-	if ((bio->bi_opf & REQ_NOWAIT) && !blk_queue_nowait(q))
+	if ((bio->bi_opf & REQ_NOWAIT) && !bdev_nowait(bdev))
 		goto not_supported;
 
 	if (should_fail_bio(bio))
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 332f96b582529..d8034ff0cb241 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1856,9 +1856,7 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
 static int device_not_nowait_capable(struct dm_target *ti, struct dm_dev *dev,
 				     sector_t start, sector_t len, void *data)
 {
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-
-	return !blk_queue_nowait(q);
+	return !bdev_nowait(dev->bdev);
 }
 
 static bool dm_table_supports_nowait(struct dm_table *t)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9dc0175280b46..3e9a1a00776bd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5844,7 +5844,7 @@ int md_run(struct mddev *mddev)
 			}
 		}
 		sysfs_notify_dirent_safe(rdev->sysfs_state);
-		nowait = nowait && blk_queue_nowait(bdev_get_queue(rdev->bdev));
+		nowait = nowait && bdev_nowait(rdev->bdev);
 	}
 
 	if (!bioset_initialized(&mddev->bio_set)) {
@@ -6980,7 +6980,7 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
 	 * If the new disk does not support REQ_NOWAIT,
 	 * disable on the whole MD.
 	 */
-	if (!blk_queue_nowait(bdev_get_queue(rdev->bdev))) {
+	if (!bdev_nowait(rdev->bdev)) {
 		pr_info("%s: Disabling nowait because %pg does not support nowait\n",
 			mdname(mddev), rdev->bdev);
 		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, mddev->queue);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 84b13fdd34a71..4750772ef2289 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -618,7 +618,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
-#define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
@@ -1280,6 +1279,11 @@ static inline bool bdev_fua(struct block_device *bdev)
 	return test_bit(QUEUE_FLAG_FUA, &bdev_get_queue(bdev)->queue_flags);
 }
 
+static inline bool bdev_nowait(struct block_device *bdev)
+{
+	return test_bit(QUEUE_FLAG_NOWAIT, &bdev_get_queue(bdev)->queue_flags);
+}
+
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ebfdb2212ec25..b2c80c2aa4317 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1377,7 +1377,7 @@ static void io_iopoll_req_issued(struct io_kiocb *req, unsigned int issue_flags)
 
 static bool io_bdev_nowait(struct block_device *bdev)
 {
-	return !bdev || blk_queue_nowait(bdev_get_queue(bdev));
+	return !bdev || bdev_nowait(bdev);
 }
 
 /*
-- 
2.30.2

