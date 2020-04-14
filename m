Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4AAC2BB85
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A30B206E9
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fJgDsxNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390787AbgDNH33 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:29:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390790AbgDNH31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 03:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xIIzEL7AERXGJPAonGkcU1sk1zfK7+Zd8o6cYDgPUaQ=; b=fJgDsxNpfoBUUFo+riM2BISEXT
        7yrLZIh3PFV2dBcE3F10DL49boSZnyC7d9GSB23JoODhWyJ2RUOkifm4u1UMq9RiIUJuttFPXHg3g
        69dweULt20u7g/mWOnyzaNROVy17xtXA4UVWmiEnpDKA3bepncRtyumRncG9hg0flPrTfOhd9EsFG
        GGvc7VwCHqSOadiiNc/DQWJuodfCaIJi3N6iG0ETK6m0iiA6apH6FkU007nfw9+z6QmZdruSb10jW
        2Dqeu6bfNpLZnmA4s+W7UD1r5LmSrQkWK7pbEUabacKxhPrfEpMTq4Ir+XnRPj5ing2gwtg10uO7S
        i5AeMQ+w==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0X-0005Zt-6a; Tue, 14 Apr 2020 07:29:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/10] block: remove the disk argument from blk_drop_partitions
Date:   Tue, 14 Apr 2020 09:28:57 +0200
Message-Id: <20200414072902.324936-6-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The gendisk can be trivially deducted from the block_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/partitions/core.c | 10 +++++-----
 fs/block_dev.c          |  2 +-
 include/linux/genhd.h   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 7d062599aa33..deccc3fbcd37 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -603,23 +603,23 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 	}
 }
 
-int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
+int blk_drop_partitions(struct block_device *bdev)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 	int res;
 
-	if (!disk_part_scan_enabled(disk))
+	if (!disk_part_scan_enabled(bdev->bd_disk))
 		return 0;
 	if (bdev->bd_part_count || bdev->bd_openers > 1)
 		return -EBUSY;
-	res = invalidate_partition(disk, 0);
+	res = invalidate_partition(bdev->bd_disk, 0);
 	if (res)
 		return res;
 
-	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
+	disk_part_iter_init(&piter, bdev->bd_disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-		delete_partition(disk, part);
+		delete_partition(bdev->bd_disk, part);
 	disk_part_iter_exit(&piter);
 
 	return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 52b6f646cdbd..9c8de54fa0c9 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1517,7 +1517,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	lockdep_assert_held(&bdev->bd_mutex);
 
 rescan:
-	ret = blk_drop_partitions(disk, bdev);
+	ret = blk_drop_partitions(bdev);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 9b3fffdf4011..058d895544c7 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -339,7 +339,7 @@ extern dev_t blk_lookup_devt(const char *name, int partno);
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
-int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev);
+int blk_drop_partitions(struct block_device *bdev);
 extern void printk_all_partitions(void);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
-- 
2.25.1

