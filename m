Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA31C4332F
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 10:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353059AbiDLKMJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357625AbiDLJtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 05:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 344EC1010
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649753808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BT3Nti0YqatvyA1jxYeKFfPceVnAp8CsaiEiSG8zOk=;
        b=dMJC/5l7fU/DjCYAEhrCWWVnLiDdiMXQwyT8CgzIhqqmoaQixTUX5r+1kToTqVul3c2WB1
        WPng/z1+g0qZcGudeQIXAGxA9AopIaYBx26Muj2b88A7OJ5a78EUkyGNkx6cuyrZqRjMHW
        QhzA2YNaGRsXr6m4JPv9jKRD/UBqRCA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-DIyOoR9qM3mmwliKrwo6Ww-1; Tue, 12 Apr 2022 04:56:37 -0400
X-MC-Unique: DIyOoR9qM3mmwliKrwo6Ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69B3F85A5BC;
        Tue, 12 Apr 2022 08:56:37 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E23C40CFD1D;
        Tue, 12 Apr 2022 08:56:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/8] block: replace disk based account with bdev's
Date:   Tue, 12 Apr 2022 16:56:09 +0800
Message-Id: <20220412085616.1409626-2-ming.lei@redhat.com>
In-Reply-To: <20220412085616.1409626-1-ming.lei@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'block device' is generic type for interface, and gendisk becomes more
one block layer internal type, so replace disk based account interface
with bdec's.

Also add 'start_time' parameter to bdev_start_io_acct() so that we
can cover device mapper's io accounting by the two bdev based interface.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c              | 15 ++++++++-------
 drivers/block/zram/zram_drv.c |  5 +++--
 include/linux/blkdev.h        |  7 ++++---
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 937bb6b86331..a3ae13b129ff 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1063,12 +1063,13 @@ unsigned long bio_start_io_acct(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(bio_start_io_acct);
 
-unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
-				 unsigned int op)
+unsigned long bdev_start_io_acct(struct block_device *bdev,
+				 unsigned int sectors, unsigned int op,
+				 unsigned long start_time)
 {
-	return __part_start_io_acct(disk->part0, sectors, op, jiffies);
+	return __part_start_io_acct(bdev, sectors, op, start_time);
 }
-EXPORT_SYMBOL(disk_start_io_acct);
+EXPORT_SYMBOL(bdev_start_io_acct);
 
 static void __part_end_io_acct(struct block_device *part, unsigned int op,
 			       unsigned long start_time)
@@ -1091,12 +1092,12 @@ void bio_end_io_acct_remapped(struct bio *bio, unsigned long start_time,
 }
 EXPORT_SYMBOL_GPL(bio_end_io_acct_remapped);
 
-void disk_end_io_acct(struct gendisk *disk, unsigned int op,
+void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
 		      unsigned long start_time)
 {
-	__part_end_io_acct(disk->part0, op, start_time);
+	__part_end_io_acct(bdev, op, start_time);
 }
-EXPORT_SYMBOL(disk_end_io_acct);
+EXPORT_SYMBOL(bdev_end_io_acct);
 
 /**
  * blk_lld_busy - Check if underlying low-level drivers of a device are busy
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
2.31.1

