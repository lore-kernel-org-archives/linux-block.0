Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C1DC2BA19
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789B72072D
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQgIi2DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390785AbgDNH3P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:29:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgDNH3N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 03:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HG/F2zMaGnKbdffuQY3n4C2KlWHIY28d04qXSSACnyg=; b=UQgIi2DBLkHfbuCwvFxVWt367r
        PwYVepC6IISTSk7EMDAE0vKimAg+kuXoTzQKzyVs5p2Frf1fjutGDQFy7TNfHaTZ771dnnOtulxvv
        u6BOINzFNbdj2+iO58aoVOZnqisCXNDFifPih3UXEwfeC01tqM+EMExMFkEBlgd6MAlRUIQQwSCmF
        Gh0VyrP1+c2U5lVI9dcWEDwvD839w09ieml9DqHk4EAxZfzvE6Y6/jMOqcoGxOsFEQ65hFA066gmT
        Cp21M3nU0LXRjutaz5frpKmBbQwhm2O5K7IHxUS67OFAgBXn4gMwUy3L0vF27QIEwb062ye3UE26N
        KnhBuwhA==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0O-0005Z2-Bb; Tue, 14 Apr 2020 07:29:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/10] block: pass a hd_struct to delete_partition
Date:   Tue, 14 Apr 2020 09:28:54 +0200
Message-Id: <20200414072902.324936-3-hch@lst.de>
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

All callers have the hd_struct at hand, so pass it instead of performing
another lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
index 7e2f40875166..6dc534b502a9 100644
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

