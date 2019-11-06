Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA274C5DF63
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 15:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774A9217F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 15:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8SvEVV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfKFPOp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:14:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfKFPOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 10:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1TR8fOyLK6054BAWeCEtHw8wa/69JfcUxN2U43v+EkM=; b=s8SvEVV4Of4jB6Kbezi8I1xmPc
        zef7fzuzWfEa0AF3V5yGVCTemJAbNVg7pHwKGQc4WV2MevotgZ/BeBDGWg67js4ySOrbJeTLBevvA
        UmEUDiUmEQo25W4HoNDjc8ybBw/RpQD0gqdfffDgEXVU/clOZQRGrwjgUC5SbuNKswwrCeBboyjn4
        NWE8xnkF91fDsiednV+0JglK7KXVzZ5gtfKPXb9Qb+hWz5Gj3gjDDA/BCsdxUSoqTypwr+EoTm93j
        bd3R7vRvkOjmc3Gm7EdO7JsPtu7zpnBArmtdlvaBKevdSp8vrtLYsb6xhVuLiQLfAArkVZePp/fon
        sDuwHOKw==;
Received: from [88.128.80.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSN1A-0005Dt-0c; Wed, 06 Nov 2019 15:14:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/5] block: refactor rescan_partitions
Date:   Wed,  6 Nov 2019 16:14:35 +0100
Message-Id: <20191106151439.30056-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106151439.30056-1-hch@lst.de>
References: <20191106151439.30056-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split out a helper that adds one single partition, and another one
calling that dealing with the parsed_partitions state.  This makes
it much more obvious how we clean up all state and start again when
using the rescan label.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partition-generic.c | 176 +++++++++++++++++++++-----------------
 1 file changed, 96 insertions(+), 80 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index aee643ce13d1..f113be069b40 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -509,26 +509,77 @@ static bool part_zone_aligned(struct gendisk *disk,
 	return true;
 }
 
-int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
+static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
+		struct parsed_partitions *state, int p)
 {
-	struct parsed_partitions *state = NULL;
+	sector_t size = state->parts[p].size;
+	sector_t from = state->parts[p].from;
 	struct hd_struct *part;
-	int p, highest, res;
-rescan:
-	if (state && !IS_ERR(state)) {
-		free_partitions(state);
-		state = NULL;
+
+	if (!size)
+		return true;
+
+	if (from >= get_capacity(disk)) {
+		printk(KERN_WARNING
+		       "%s: p%d start %llu is beyond EOD, ",
+		       disk->disk_name, p, (unsigned long long) from);
+		if (disk_unlock_native_capacity(disk))
+			return false;
+		return true;
 	}
 
-	res = drop_partitions(disk, bdev);
-	if (res)
-		return res;
+	if (from + size > get_capacity(disk)) {
+		printk(KERN_WARNING
+		       "%s: p%d size %llu extends beyond EOD, ",
+		       disk->disk_name, p, (unsigned long long) size);
 
-	if (disk->fops->revalidate_disk)
-		disk->fops->revalidate_disk(disk);
-	check_disk_size_change(disk, bdev, true);
-	bdev->bd_invalidated = 0;
-	if (!get_capacity(disk) || !(state = check_partition(disk, bdev)))
+		if (disk_unlock_native_capacity(disk))
+			return false;
+
+		/*
+		 * We can not ignore partitions of broken tables created by for
+		 * example camera firmware, but we limit them to the end of the
+		 * disk to avoid creating invalid block devices.
+		 */
+		size = get_capacity(disk) - from;
+	}
+
+	/*
+	 * On a zoned block device, partitions should be aligned on the device
+	 * zone size (i.e. zone boundary crossing not allowed).  Otherwise,
+	 * resetting the write pointer of the last zone of one partition may
+	 * impact the following partition.
+	 */
+	if (bdev_is_zoned(bdev) && !part_zone_aligned(disk, bdev, from, size)) {
+		printk(KERN_WARNING
+		       "%s: p%d start %llu+%llu is not zone aligned\n",
+		       disk->disk_name, p, (unsigned long long) from,
+		       (unsigned long long) size);
+		return true;
+	}
+
+	part = add_partition(disk, p, from, size, state->parts[p].flags,
+			     &state->parts[p].info);
+	if (IS_ERR(part)) {
+		printk(KERN_ERR " %s: p%d could not be added: %ld\n",
+		       disk->disk_name, p, -PTR_ERR(part));
+		return true;
+	}
+
+#ifdef CONFIG_BLK_DEV_MD
+	if (state->parts[p].flags & ADDPART_FLAG_RAID)
+		md_autodetect_dev(part_to_dev(part)->devt);
+#endif
+	return true;
+}
+
+static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+{
+	struct parsed_partitions *state;
+	int ret = -EAGAIN, p, highest;
+
+	state = check_partition(disk, bdev);
+	if (!state)
 		return 0;
 	if (IS_ERR(state)) {
 		/*
@@ -540,7 +591,7 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 			printk(KERN_WARNING "%s: partition table beyond EOD, ",
 			       disk->disk_name);
 			if (disk_unlock_native_capacity(disk))
-				goto rescan;
+				return -EAGAIN;
 		}
 		return -EIO;
 	}
@@ -554,7 +605,7 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 		       "%s: partition table partially beyond EOD, ",
 		       disk->disk_name);
 		if (disk_unlock_native_capacity(disk))
-			goto rescan;
+			goto out_free_state;
 	}
 
 	/* tell userspace that the media / partition table may have changed */
@@ -571,72 +622,37 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
 	disk_expand_part_tbl(disk, highest);
 
 	/* add partitions */
-	for (p = 1; p < state->limit; p++) {
-		sector_t size, from;
-
-		size = state->parts[p].size;
-		if (!size)
-			continue;
-
-		from = state->parts[p].from;
-		if (from >= get_capacity(disk)) {
-			printk(KERN_WARNING
-			       "%s: p%d start %llu is beyond EOD, ",
-			       disk->disk_name, p, (unsigned long long) from);
-			if (disk_unlock_native_capacity(disk))
-				goto rescan;
-			continue;
-		}
+	for (p = 1; p < state->limit; p++)
+		if (!blk_add_partition(disk, bdev, state, p))
+			goto out_free_state;
 
-		if (from + size > get_capacity(disk)) {
-			printk(KERN_WARNING
-			       "%s: p%d size %llu extends beyond EOD, ",
-			       disk->disk_name, p, (unsigned long long) size);
-
-			if (disk_unlock_native_capacity(disk)) {
-				/* free state and restart */
-				goto rescan;
-			} else {
-				/*
-				 * we can not ignore partitions of broken tables
-				 * created by for example camera firmware, but
-				 * we limit them to the end of the disk to avoid
-				 * creating invalid block devices
-				 */
-				size = get_capacity(disk) - from;
-			}
-		}
+	ret = 0;
+out_free_state:
+	free_partitions(state);
+	return ret;
+}
 
-		/*
-		 * On a zoned block device, partitions should be aligned on the
-		 * device zone size (i.e. zone boundary crossing not allowed).
-		 * Otherwise, resetting the write pointer of the last zone of
-		 * one partition may impact the following partition.
-		 */
-		if (bdev_is_zoned(bdev) &&
-		    !part_zone_aligned(disk, bdev, from, size)) {
-			printk(KERN_WARNING
-			       "%s: p%d start %llu+%llu is not zone aligned\n",
-			       disk->disk_name, p, (unsigned long long) from,
-			       (unsigned long long) size);
-			continue;
-		}
+int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
+{
+	int ret;
 
-		part = add_partition(disk, p, from, size,
-				     state->parts[p].flags,
-				     &state->parts[p].info);
-		if (IS_ERR(part)) {
-			printk(KERN_ERR " %s: p%d could not be added: %ld\n",
-			       disk->disk_name, p, -PTR_ERR(part));
-			continue;
-		}
-#ifdef CONFIG_BLK_DEV_MD
-		if (state->parts[p].flags & ADDPART_FLAG_RAID)
-			md_autodetect_dev(part_to_dev(part)->devt);
-#endif
-	}
-	free_partitions(state);
-	return 0;
+rescan:
+	ret = drop_partitions(disk, bdev);
+	if (ret)
+		return ret;
+
+	if (disk->fops->revalidate_disk)
+		disk->fops->revalidate_disk(disk);
+	check_disk_size_change(disk, bdev, true);
+	bdev->bd_invalidated = 0;
+
+	if (!get_capacity(disk))
+		return 0;
+	
+	ret = blk_add_partitions(disk, bdev);
+	if (ret == -EAGAIN)
+		goto rescan;
+	return ret;
 }
 
 int invalidate_partitions(struct gendisk *disk, struct block_device *bdev)
-- 
2.20.1

