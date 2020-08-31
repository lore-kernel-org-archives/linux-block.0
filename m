Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B137AC433E2
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CFE2071B
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cNhQn8mF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgHaSR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgHaSR5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:17:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BD0C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X6jKtVps3fzP9dWj973FafGo36ZMWx/QitThzlvSeYg=; b=cNhQn8mFCvyu1oVIdbhZ5NpJCQ
        PtNGT20CWivVI2pvFQTdR0wq5WWEAtuPTLlpHGcEyLdNmVhksO3h8PUJeXa8ds3/P1e0vio25h/lW
        SDOOeVnteOP+2X8YU7NCdYuEQX1AXbs05SkWzPFZxATA/yDgNWm/58bv6wzrpcgjvgtLmdi/W1zXK
        bPKNaExpHrqrAErPkJGxwxu76scWwcMAGi76/dXmoQcJHiJTupEbohr+xGdpFUb9swXOOO4UGl+LD
        Ok3FD0B07vEYvy+gNuhXeh6anvpWEtTSN++mIdLYiHIc232dVN0ci7ObJzn/7mApGyZR+YoHgg8e7
        eGhc6Thg==;
Received: from 213-225-6-196.nat.highway.a1.net ([213.225.6.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCoNQ-0002hh-0C; Mon, 31 Aug 2020 18:17:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6/7] block: remove the disk argument to delete_partition
Date:   Mon, 31 Aug 2020 20:02:38 +0200
Message-Id: <20200831180239.2372776-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831180239.2372776-1-hch@lst.de>
References: <20200831180239.2372776-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can trivially derive the gendisk from the hd_struct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h             | 2 +-
 block/genhd.c           | 2 +-
 block/partitions/core.c | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 49e2928a163299..3e60ffd3f500e5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -350,7 +350,7 @@ char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
-void delete_partition(struct gendisk *disk, struct hd_struct *part);
+void delete_partition(struct hd_struct *part);
 int bdev_add_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int bdev_del_partition(struct block_device *bdev, int partno);
diff --git a/block/genhd.c b/block/genhd.c
index 055ce9cf18358a..2055b5bf637a80 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -913,7 +913,7 @@ void del_gendisk(struct gendisk *disk)
 			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
 	while ((part = disk_part_iter_next(&piter))) {
 		invalidate_partition(disk, part->partno);
-		delete_partition(disk, part);
+		delete_partition(part);
 	}
 	disk_part_iter_exit(&piter);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1150474caca0cf..7af3f8796f0a2c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -316,8 +316,9 @@ int hd_ref_init(struct hd_struct *part)
  * Must be called either with bd_mutex held, before a disk can be opened or
  * after all disk users are gone.
  */
-void delete_partition(struct gendisk *disk, struct hd_struct *part)
+void delete_partition(struct hd_struct *part)
 {
+	struct gendisk *disk = part_to_disk(part);
 	struct disk_part_tbl *ptbl =
 		rcu_dereference_protected(disk->part_tbl, 1);
 
@@ -325,7 +326,7 @@ void delete_partition(struct gendisk *disk, struct hd_struct *part)
 	 * ->part_tbl is referenced in this part's release handler, so
 	 *  we have to hold the disk device
 	 */
-	get_device(disk_to_dev(part_to_disk(part)));
+	get_device(disk_to_dev(disk));
 	rcu_assign_pointer(ptbl->part[part->partno], NULL);
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
@@ -548,7 +549,7 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	invalidate_bdev(bdevp);
 
 	mutex_lock_nested(&bdev->bd_mutex, 1);
-	delete_partition(bdev->bd_disk, part);
+	delete_partition(part);
 	mutex_unlock(&bdev->bd_mutex);
 
 	ret = 0;
@@ -629,7 +630,7 @@ int blk_drop_partitions(struct block_device *bdev)
 
 	disk_part_iter_init(&piter, bdev->bd_disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-		delete_partition(bdev->bd_disk, part);
+		delete_partition(part);
 	disk_part_iter_exit(&piter);
 
 	return 0;
-- 
2.28.0

