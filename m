Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470DBC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DF861185
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 07:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhIPHwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 03:52:25 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:33238 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234791AbhIPHwZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 03:52:25 -0400
Received: from localhost.localdomain (unknown [124.16.141.243])
        by APP-03 (Coremail) with SMTP id rQCowAC3v3tP90JhWN6aAA--.476S2;
        Thu, 16 Sep 2021 15:50:40 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     axboe@kernel.dk, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: Remove needless request_queue NULL pointer checks
Date:   Thu, 16 Sep 2021 07:50:36 +0000
Message-Id: <20210916075036.61159-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowAC3v3tP90JhWN6aAA--.476S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4kWryrXr43Wry3WF1rZwb_yoWrAry3pF
        W3JFyfA3y8KF4kXaykArnrWF9a934akry7Ja9xW3sYkrW8tr4qgFn5Zry0qrWFyrWkGFWU
        JF4xXFZ09r129FDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ec7CjxVAajcxG14v26r
        1j6r4UMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY
        0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUyb
        yZUUUUU
X-Originating-IP: [124.16.141.243]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcGA10TflKa6AAAsU
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The request_queue pointer returned from bdev_get_queue() shall
never be NULL, so the NULL checks are unnecessary, just remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 block/blk-lib.c         | 14 --------------
 include/linux/blkdev.h  | 32 +++++++-------------------------
 kernel/trace/blktrace.c |  6 +-----
 3 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9f09beadcbe3..e6e854936ef6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -32,9 +32,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	unsigned int op;
 	sector_t bs_mask, part_offset = 0;
 
-	if (!q)
-		return -ENXIO;
-
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
@@ -172,9 +169,6 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	struct bio *bio = *biop;
 	sector_t bs_mask;
 
-	if (!q)
-		return -ENXIO;
-
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
@@ -250,10 +244,6 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 {
 	struct bio *bio = *biop;
 	unsigned int max_write_zeroes_sectors;
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (!q)
-		return -ENXIO;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
@@ -304,14 +294,10 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
 	int bi_size = 0;
 	unsigned int sz;
 
-	if (!q)
-		return -ENXIO;
-
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 12b9dbcc980e..9ab84ba1d7da 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1529,67 +1529,49 @@ static inline unsigned int bdev_write_same(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
-		return q->limits.max_write_same_sectors;
-
-	return 0;
+	return q->limits.max_write_same_sectors;
 }
 
 static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
-		return q->limits.max_write_zeroes_sectors;
-
-	return 0;
+	return q->limits.max_write_zeroes_sectors;
 }
 
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
-		return blk_queue_zoned_model(q);
-
-	return BLK_ZONED_NONE;
+	return blk_queue_zoned_model(q);
 }
 
 static inline bool bdev_is_zoned(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
-		return blk_queue_is_zoned(q);
-
-	return false;
+	return blk_queue_is_zoned(q);
 }
 
 static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
-		return blk_queue_zone_sectors(q);
-	return 0;
+	return blk_queue_zone_sectors(q);
 }
 
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
-		return queue_max_open_zones(q);
-	return 0;
+	return queue_max_open_zones(q);
 }
 
 static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
-		return queue_max_active_zones(q);
-	return 0;
+	return queue_max_active_zones(q);
 }
 
 static inline int queue_dma_alignment(const struct request_queue *q)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c221e4c3f625..2fe970d896b3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -714,14 +714,10 @@ EXPORT_SYMBOL_GPL(blk_trace_startstop);
  **/
 int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 {
-	struct request_queue *q;
+	struct request_queue *q = bdev_get_queue(bdev);
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
-	q = bdev_get_queue(bdev);
-	if (!q)
-		return -ENXIO;
-
 	mutex_lock(&q->debugfs_mutex);
 
 	switch (cmd) {
-- 
2.17.1

