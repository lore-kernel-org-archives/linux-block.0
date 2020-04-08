Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BD1C2BA1A
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 19:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217A220769
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 19:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n3g19FCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDHTos (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:44:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgDHTor (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 15:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eMgjMncEKgAqWJyPyH1vyyn2QVvReCcuhgzuxnNDQW0=; b=n3g19FCcdIpv/YytL0yLLzLPUe
        pe2LGDmDj4ZcIuHqHbC+VDAPsVjc0hRJCBegrKVCd3bA3dOn4mCQgqw2IGiu8P4VBwg38Lc+oYUtn
        sAWXKQjEBiaN87RZasDq3vzV3GlkdOpLaXM0KlvFTKVz7vKc5b4wZy5VmJfH8bWKS4VPm0ikDqN++
        7ZKTOmPYoHANtanYglOWrBM0hXmNHkF5012Eodxm2X/bq5Cim3AGAVpcNvyiQk6ps2qcKdHCD35Pv
        Tw3M1Xo+YXmiC6GUu0ZHotlKvuWJH2Sv5KrPKX4HUOezav9f/DGITBtVDFKFgJFeecbrEdE2ze/4G
        JAoK6/ZA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMGcw-0004Gu-E4; Wed, 08 Apr 2020 19:44:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 02/10] block: pass a hd_struct to delete_partition
Date:   Wed,  8 Apr 2020 21:44:31 +0200
Message-Id: <20200408194439.1580699-3-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408194439.1580699-1-hch@lst.de>
References: <20200408194439.1580699-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All callers have the hd_strut at hand, so pass it instead of doing
another lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h             |  2 +-
 block/genhd.c           |  2 +-
 block/partitions/core.c | 22 ++++++++--------------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 305e0ac22bf7..0cbf64108922 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -390,7 +390,7 @@ char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
 void __delete_partition(struct percpu_ref *ref);
-void delete_partition(struct gendisk *disk, int partno);
+void delete_partition(struct gendisk *disk, struct hd_struct *part);
 int bdev_add_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int bdev_del_partition(struct block_device *bdev, int partno);
diff --git a/block/genhd.c b/block/genhd.c
index 06b642b23a07..1cc50ad5b191 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -897,7 +897,7 @@ void del_gendisk(struct gendisk *disk)
 	while ((part = disk_part_iter_next(&piter))) {
 		invalidate_partition(disk, part->partno);
 		bdev_unhash_inode(part_devt(part));
-		delete_partition(disk, part->partno);
+		delete_partition(disk, part);
 	}
 	disk_part_iter_exit(&piter);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 7577bdba3b2b..0b1b67f50652 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -296,20 +296,12 @@ void __delete_partition(struct percpu_ref *ref)
  * Must be called either with bd_mutex held, before a disk can be opened or
  * after all disk users are gone.
  */
-void delete_partition(struct gendisk *disk, int partno)
+void delete_partition(struct gendisk *disk, struct hd_struct *part)
 {
 	struct disk_part_tbl *ptbl =
 		rcu_dereference_protected(disk->part_tbl, 1);
-	struct hd_struct *part;
-
-	if (partno >= ptbl->len)
-		return;
 
-	part = rcu_dereference_protected(ptbl->part[partno], 1);
-	if (!part)
-		return;
-
-	rcu_assign_pointer(ptbl->part[partno], NULL);
+	rcu_assign_pointer(ptbl->part[part->partno], NULL);
 	rcu_assign_pointer(ptbl->last_lookup, NULL);
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
@@ -520,10 +512,10 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	if (!part)
 		return -ENXIO;
 
+	ret = -ENOMEM;
 	bdevp = bdget(part_devt(part));
-	disk_put_part(part);
 	if (!bdevp)
-		return -ENOMEM;
+		goto out_put_part;
 
 	mutex_lock(&bdevp->bd_mutex);
 
@@ -535,13 +527,15 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	invalidate_bdev(bdevp);
 
 	mutex_lock_nested(&bdev->bd_mutex, 1);
-	delete_partition(bdev->bd_disk, partno);
+	delete_partition(bdev->bd_disk, part);
 	mutex_unlock(&bdev->bd_mutex);
 
 	ret = 0;
 out_unlock:
 	mutex_unlock(&bdevp->bd_mutex);
 	bdput(bdevp);
+out_put_part:
+	disk_put_part(part);
 	return ret;
 }
 
@@ -617,7 +611,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-		delete_partition(disk, part->partno);
+		delete_partition(disk, part);
 	disk_part_iter_exit(&piter);
 
 	return 0;
-- 
2.25.1

