Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9451FC433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEAD64E6F
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBXEAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:00:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231830AbhBXEAa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 23:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614139143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHBknFIt+0/1Hpcw0tAEzIAQQFK/DWozhqXdCgJetS8=;
        b=Le61oUkou88eMTfWEg7J+SVv77r/3DQCmaWLq+Xhr4zkJz5B1qFg96//nvE9y3eb85Azlm
        ZOhKcFOBa5zy65ZtqFifXp2rqfXV1lGSwPrX6UgXJDUjYDj0wgXTO2PePECof+RDlxQMiF
        1zVz20weELZE7/HR7iz3rPFAmCZ6grA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-E5Xjj68rNKyfkVeAxQ-P5A-1; Tue, 23 Feb 2021 22:59:01 -0500
X-MC-Unique: E5Xjj68rNKyfkVeAxQ-P5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DF6B8799EB;
        Wed, 24 Feb 2021 03:59:00 +0000 (UTC)
Received: from localhost (ovpn-13-84.pek2.redhat.com [10.72.13.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 371D57095A;
        Wed, 24 Feb 2021 03:58:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH V2 4/4] block: avoid to drop & re-add partitions if partitions aren't changed
Date:   Wed, 24 Feb 2021 11:58:30 +0800
Message-Id: <20210224035830.990123-5-ming.lei@redhat.com>
In-Reply-To: <20210224035830.990123-1-ming.lei@redhat.com>
References: <20210224035830.990123-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block ioctl(BLKRRPART) always drops current partitions and adds
partitions again, even though there isn't any change in partitions table.

ioctl(BLKRRPART) is called by systemd-udevd and some disk utilities not
unusually. When it is run, partitions disk node are dropped and added back,
this way may confuse userspace or users, for example, one normal workable
partition device node may disappear any time.

Fix this issue by checking if there is real change in partitions, and only
drop & re-add them when partitions state is really changed.

Cc: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/partitions/core.c | 76 ++++++++++++++++++++++++++++++++++++++---
 fs/block_dev.c          | 30 ++++++++--------
 include/linux/genhd.h   |  1 +
 3 files changed, 88 insertions(+), 19 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 288ca362ccbd..901a00fed3c9 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -123,7 +123,7 @@ static void free_partitions(struct parsed_partitions *state)
 }
 
 static struct parsed_partitions *check_partition(struct gendisk *hd,
-		struct block_device *bdev)
+		struct block_device *bdev, bool show_part)
 {
 	struct parsed_partitions *state;
 	int i, res, err;
@@ -159,7 +159,8 @@ static struct parsed_partitions *check_partition(struct gendisk *hd,
 
 	}
 	if (res > 0) {
-		printk(KERN_INFO "%s", state->pp_buf);
+		if (show_part)
+			printk(KERN_INFO "%s", state->pp_buf);
 
 		free_page((unsigned long)state->pp_buf);
 		return state;
@@ -604,7 +605,8 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 }
 
 static int __blk_check_partitions(struct gendisk *disk,
-		struct block_device *bdev, struct parsed_partitions **s)
+		struct block_device *bdev, struct parsed_partitions **s,
+		bool show_part)
 {
 	struct parsed_partitions *state = NULL;
 	int ret = -EAGAIN;
@@ -612,7 +614,7 @@ static int __blk_check_partitions(struct gendisk *disk,
 	if (!disk_part_scan_enabled(disk))
 		goto out;
 
-	state = check_partition(disk, bdev);
+	state = check_partition(disk, bdev, show_part);
 	if (!state)
 		goto out;
 
@@ -679,12 +681,76 @@ static int __blk_add_partitions(struct gendisk *disk,
 	return 0;
 }
 
+static bool partition_changed(struct block_device *part,
+		struct parsed_partitions *state)
+{
+	int p = part->bd_partno;
+
+	if (part->bd_start_sect != state->parts[p].from)
+		return true;
+
+	if (bdev_nr_sectors(part) != state->parts[p].size)
+		return true;
+
+	if (part->bd_part_flags != state->parts[p].flags)
+		return true;
+
+	if (bcmp(part->bd_meta_info, &state->parts[p].info,
+				sizeof(struct partition_meta_info)))
+		return true;
+
+	return false;
+}
+
+static int partition_count(struct parsed_partitions *state)
+{
+	int p;
+	int cnt = 0;
+
+	for (p = 1; p < state->limit; p++) {
+		if (state->parts[p].size || state->parts[p].from)
+			cnt++;
+	}
+	return cnt;
+}
+
+bool blk_partition_changed(struct gendisk *disk, struct block_device *bdev)
+{
+	struct disk_part_iter piter;
+	struct block_device *part;
+	struct parsed_partitions *state = NULL;
+	bool changed = true;
+	int nr_parts = 0;
+
+	if (!get_capacity(disk))
+		goto out;
+
+	if (__blk_check_partitions(disk, bdev, &state, false) != 0 || !state)
+		goto out;
+
+	changed = false;
+	disk_part_iter_init(&piter, disk, 0);
+	while ((part = disk_part_iter_next(&piter))) {
+		if (partition_changed(part, state))
+			changed = true;
+		nr_parts++;
+	}
+	disk_part_iter_exit(&piter);
+
+	if (nr_parts != partition_count(state))
+		changed = true;
+ out:
+	if (state)
+		free_partitions(state);
+	return changed;
+}
+
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
 	int ret;
 
-	ret = __blk_check_partitions(disk, bdev, &state);
+	ret = __blk_check_partitions(disk, bdev, &state, true);
 	if (ret != 0)
 		return ret;
 	if (!state)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index ec26179c8062..b279649ba532 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1234,10 +1234,6 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	clear_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 
 rescan:
-	ret = blk_drop_partitions(bdev);
-	if (ret)
-		return ret;
-
 	/*
 	 * Historically we only set the capacity to zero for devices that
 	 * support partitions (independ of actually having partitions created).
@@ -1255,16 +1251,22 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 			disk->fops->revalidate_disk(disk);
 	}
 
-	if (get_capacity(disk)) {
-		ret = blk_add_partitions(disk, bdev);
-		if (ret == -EAGAIN)
-			goto rescan;
-	} else if (invalidate) {
-		/*
-		 * Tell userspace that the media / partition table may have
-		 * changed.
-		 */
-		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
+	if (blk_partition_changed(disk, bdev)) {
+		ret = blk_drop_partitions(bdev);
+		if (ret)
+			return ret;
+
+		if (get_capacity(disk)) {
+			ret = blk_add_partitions(disk, bdev);
+			if (ret == -EAGAIN)
+				goto rescan;
+		} else if (invalidate) {
+			/*
+			 * Tell userspace that the media / partition table may have
+			 * changed.
+			 */
+			kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
+		}
 	}
 
 	return ret;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f364619092cc..ae9ebfb9a8e1 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -274,6 +274,7 @@ static inline sector_t get_capacity(struct gendisk *disk)
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 int blk_drop_partitions(struct block_device *bdev);
+bool blk_partition_changed(struct gendisk *disk, struct block_device *bdev);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
 extern void put_disk(struct gendisk *disk);
-- 
2.29.2

