Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A833DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 02:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiDRCaP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Apr 2022 22:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiDRCaO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Apr 2022 22:30:14 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F72F186C9
        for <linux-block@vger.kernel.org>; Sun, 17 Apr 2022 19:27:37 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id q75so1697131qke.6
        for <linux-block@vger.kernel.org>; Sun, 17 Apr 2022 19:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yX7Km7uC+2/I6rFIKqJdrUbEElXhCOJMmE/aqjjxnpk=;
        b=HLzzYkI49LBKZDaVxZ/uFRlwJtQvdKh7QGaVbXVjtfZzKzF2dXhonxVoj0E5jzaKJ3
         1d9HsdtPgLws4R2ZWqLTITFDbDceUVhQZjTL8DeUiG/bQoRLMrwdgdN7bZ/JA/5ootIe
         kYhfKE2WVNBHeHK4XOJum+k/9VtD8h8jOtEsSMUQC6d7OlpNgVqww8BojKzPG0I4glmR
         RkOoGATxHilPH93jm5UN5b3XBanmHyn35ls/3fjzkZcF6Y9EWMHClxFa5ifguZeO8H7b
         TE5vxCxWeTUtztN6Yen+JYci4GJgBWldr5pT5+gUFdDIA71vb30twYSNGefCaEZjrZ1S
         sfCA==
X-Gm-Message-State: AOAM530jFoHWql8aIoVepAGphDR5s7pZiRizAmTkFpQ6c4RXq6P92yhd
        wSKC1GT+DCvln7yajHQiemXyttAJFniV
X-Google-Smtp-Source: ABdhPJxPoascgnCJCRKobr3PSxcoxNZPTdT/3om+1LW64S3EDST2On6NO+3NpR7920B4u9NfRZI7Zg==
X-Received: by 2002:a05:620a:2441:b0:69c:3451:2a60 with SMTP id h1-20020a05620a244100b0069c34512a60mr5270687qkn.181.1650248856091;
        Sun, 17 Apr 2022 19:27:36 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w3-20020a376203000000b0069e9a4568f9sm1109629qkb.125.2022.04.17.19.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 19:27:35 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: [dm-5.19 PATCH 01/21] block: change exported IO accounting interface from gendisk to bdev
Date:   Sun, 17 Apr 2022 22:27:13 -0400
Message-Id: <20220418022733.56168-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220418022733.56168-1-snitzer@kernel.org>
References: <20220418022733.56168-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

Export IO accounting interfaces in terms of block_device now that
gendisk has become more internal to block core.

Rename __part_{start,end}_io_acct's first argument from part to bdev.
Rename __part_{start,end}_io_acct to bdev_{start,end}_io_acct and
export them.  Remove disk_{start,end}_io_acct and update caller (zram)
to use bdev_{start,end}_io_acct.

DM can now be updated to use bdev_{start,end}_io_acct.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 block/blk-core.c              | 52 +++++++++++++++++--------------------------
 drivers/block/zram/zram_drv.c |  5 +++--
 include/linux/blkdev.h        |  7 +++---
 3 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 937bb6b86331..99deb4603be3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1022,21 +1022,22 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	}
 }
 
-static unsigned long __part_start_io_acct(struct block_device *part,
-					  unsigned int sectors, unsigned int op,
-					  unsigned long start_time)
+unsigned long bdev_start_io_acct(struct block_device *bdev,
+				 unsigned int sectors, unsigned int op,
+				 unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
 
 	part_stat_lock();
-	update_io_ticks(part, start_time, false);
-	part_stat_inc(part, ios[sgrp]);
-	part_stat_add(part, sectors[sgrp], sectors);
-	part_stat_local_inc(part, in_flight[op_is_write(op)]);
+	update_io_ticks(bdev, start_time, false);
+	part_stat_inc(bdev, ios[sgrp]);
+	part_stat_add(bdev, sectors[sgrp], sectors);
+	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
 	return start_time;
 }
+EXPORT_SYMBOL(bdev_start_io_acct);
 
 /**
  * bio_start_io_acct_time - start I/O accounting for bio based drivers
@@ -1045,8 +1046,8 @@ static unsigned long __part_start_io_acct(struct block_device *part,
  */
 void bio_start_io_acct_time(struct bio *bio, unsigned long start_time)
 {
-	__part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
-			     bio_op(bio), start_time);
+	bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
+			   bio_op(bio), start_time);
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct_time);
 
@@ -1058,46 +1059,33 @@ EXPORT_SYMBOL_GPL(bio_start_io_acct_time);
  */
 unsigned long bio_start_io_acct(struct bio *bio)
 {
-	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
-				    bio_op(bio), jiffies);
+	return bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
+				  bio_op(bio), jiffies);
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
-unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
-				 unsigned int op)
-{
-	return __part_start_io_acct(disk->part0, sectors, op, jiffies);
-}
-EXPORT_SYMBOL(disk_start_io_acct);
-
-static void __part_end_io_acct(struct block_device *part, unsigned int op,
-			       unsigned long start_time)
+void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
+		      unsigned long start_time)
 {
 	const int sgrp = op_stat_group(op);
 	unsigned long now = READ_ONCE(jiffies);
 	unsigned long duration = now - start_time;
 
 	part_stat_lock();
-	update_io_ticks(part, now, true);
-	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
-	part_stat_local_dec(part, in_flight[op_is_write(op)]);
+	update_io_ticks(bdev, now, true);
+	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
+	part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 }
+EXPORT_SYMBOL(bdev_end_io_acct);
 
 void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
-		struct block_device *orig_bdev)
+			      struct block_device *orig_bdev)
 {
-	__part_end_io_acct(orig_bdev, bio_op(bio), start_time);
+	bdev_end_io_acct(orig_bdev, bio_op(bio), start_time);
 }
 EXPORT_SYMBOL_GPL(bio_end_io_acct_remapped);
 
-void disk_end_io_acct(struct gendisk *disk, unsigned int op,
-		      unsigned long start_time)
-{
-	__part_end_io_acct(disk->part0, op, start_time);
-}
-EXPORT_SYMBOL(disk_end_io_acct);
-
 /**
  * blk_lld_busy - Check if underlying low-level drivers of a device are busy
  * @q : the queue of the device being checked
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e9474b02012d..adb5209a556a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1675,9 +1675,10 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 	bv.bv_len = PAGE_SIZE;
 	bv.bv_offset = 0;
 
-	start_time = disk_start_io_acct(bdev->bd_disk, SECTORS_PER_PAGE, op);
+	start_time = bdev_start_io_acct(bdev->bd_disk->part0,
+			SECTORS_PER_PAGE, op, jiffies);
 	ret = zram_bvec_rw(zram, &bv, index, offset, op, NULL);
-	disk_end_io_acct(bdev->bd_disk, op, start_time);
+	bdev_end_io_acct(bdev->bd_disk->part0, op, start_time);
 out:
 	/*
 	 * If I/O fails, just return error(ie, non-zero) without
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 60d016138997..f680ba6f0ab2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1491,9 +1491,10 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 		wake_up_process(waiter);
 }
 
-unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
-		unsigned int op);
-void disk_end_io_acct(struct gendisk *disk, unsigned int op,
+unsigned long bdev_start_io_acct(struct block_device *bdev,
+				 unsigned int sectors, unsigned int op,
+				 unsigned long start_time);
+void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
 		unsigned long start_time);
 
 void bio_start_io_acct_time(struct bio *bio, unsigned long start_time);
-- 
2.15.0

