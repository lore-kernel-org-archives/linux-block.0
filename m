Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBB8C433E9
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 02:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAB064FC0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 02:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBECTH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 21:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhBECS7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 21:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612491452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CUrbnd7t+K/GQ3ih0khyeNIK9XqhZh7wgoHBefpU0s=;
        b=de7/i634kKt55TQPHi9Sq8svlA0Efcy03gqZ6McECkb3fmrBt/oq8wHiZ3PCP/U2mtOVJY
        4//Pp3+oDBvjQkqpb7VE9I+lslDkQKNmsylVYSnNNn3ohzyhkvxO6PCmN/+ib+9VolposT
        gPd81ozdSB+aWdTerJX23kSxkC9+Qcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-P7uiLOBcOiaERBIcGB3CTg-1; Thu, 04 Feb 2021 21:17:31 -0500
X-MC-Unique: P7uiLOBcOiaERBIcGB3CTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B691E91270;
        Fri,  5 Feb 2021 02:17:29 +0000 (UTC)
Received: from localhost (ovpn-13-14.pek2.redhat.com [10.72.13.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AF2B5D9D2;
        Fri,  5 Feb 2021 02:17:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH 2/2] block: avoid to drop & re-add partitions if partitions aren't changed
Date:   Fri,  5 Feb 2021 10:17:08 +0800
Message-Id: <20210205021708.1498711-3-ming.lei@redhat.com>
In-Reply-To: <20210205021708.1498711-1-ming.lei@redhat.com>
References: <20210205021708.1498711-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block ioctl(BLKRRPART) always drops current partitions and adds
partitions again, even though there isn't any change in partitions table.

ioctl(BLKRRPART) may be called by systemd-udevd and some disk utilities
frequently. When it is run, partitions disk node are dropped and added
back, this way may confuse userspace or users, for example, one normal
workable partition device node may disappear any time.

Fix this issue by checking if there is real change in partitions state,
and only drop & re-add them when partitions state is really changed.

Cc: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c            |  2 ++
 block/partitions/check.h |  2 ++
 block/partitions/core.c  | 76 ++++++++++++++++++++++++++++++++--------
 fs/block_dev.c           | 28 +++++++++++++--
 include/linux/genhd.h    |  4 +++
 5 files changed, 94 insertions(+), 18 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 304f8dcc9a9b..fbc8961c0a72 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -26,6 +26,7 @@
 #include <linux/badblocks.h>
 
 #include "blk.h"
+#include "partitions/check.h"
 
 static struct kobject *block_depr;
 
@@ -1215,6 +1216,7 @@ static void disk_release(struct device *dev)
 	bdput(disk->part0);
 	if (disk->queue)
 		blk_put_queue(disk->queue);
+	blk_free_partitions(disk);
 	kfree(disk);
 }
 struct class block_class = {
diff --git a/block/partitions/check.h b/block/partitions/check.h
index c577e9ee67f0..fc2ec2acddd2 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -68,3 +68,5 @@ int sgi_partition(struct parsed_partitions *state);
 int sun_partition(struct parsed_partitions *state);
 int sysv68_partition(struct parsed_partitions *state);
 int ultrix_partition(struct parsed_partitions *state);
+
+void blk_free_partitions(struct gendisk *hd);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 154013ea8623..277367b275ab 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -116,8 +116,15 @@ static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
 
 static void free_partitions(struct parsed_partitions *state)
 {
-	vfree(state->parts);
-	kfree(state);
+	if (state) {
+		vfree(state->parts);
+		kfree(state);
+	}
+}
+
+void blk_free_partitions(struct gendisk *hd)
+{
+	free_partitions(hd->parts_state);
 }
 
 static struct parsed_partitions *check_partition(struct gendisk *hd,
@@ -655,32 +662,71 @@ static int blk_check_partitions(struct gendisk *disk,
 	return ret;
 }
 
+static bool partitions_changed(const struct parsed_partitions *old,
+		const struct parsed_partitions *new)
+{
+	if (old == new)	/* both are NULL */
+		return false;
+	if (!old || !new)
+		return true;
+
+	if (memcmp(old->name, new->name, BDEVNAME_SIZE))
+		return true;
+	if (old->limit != new->limit)
+		return true;
+	if (memcmp(old->parts, new->parts, old->limit * sizeof(old->parts[0])))
+		return true;
+	return old->next != new->next;
+}
+
+/* Return true if partitions state is changed */
+bool blk_update_partitions(struct gendisk *disk, struct block_device *bdev,
+		int *retval)
+{
+	struct parsed_partitions *state;
+
+	lockdep_assert_held(&bdev->bd_mutex);
+
+	*retval = -EAGAIN;
+	if (!get_capacity(disk))
+		return true;
+
+	*retval = blk_check_partitions(disk, bdev, &state);
+	if (*retval)
+		return true;
+
+	if (partitions_changed(disk->parts_state, state)) {
+		/* update to new partitions state */
+		free_partitions(disk->parts_state);
+		disk->parts_state = state;
+		return true;
+	}
+
+	free_partitions(state);
+	return false;
+}
+
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
-	int ret, p;
+	int p;
 
 	if (!disk_part_scan_enabled(disk))
 		return 0;
 
-	ret = blk_check_partitions(disk, bdev, &state);
-	if (ret != 0)
-		return ret;
+	/* tell userspace that the media / partition table may have changed */
+	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 
+	state = disk->parts_state;
 	if (!state)
 		return 0;
 
-	/* tell userspace that the media / partition table may have changed */
-	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
-
 	for (p = 1; p < state->limit; p++) {
-		if (!blk_add_partition(disk, bdev, state, p)) {
-			ret = -EAGAIN;
-			break;
-		}
+		if (!blk_add_partition(disk, bdev, state, p))
+			return -EAGAIN;
 	}
-	free_partitions(state);
-	return ret;
+
+	return 0;
 }
 
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9d4b1a884d76..6d9a832f4e71 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1220,11 +1220,28 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 {
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
+	bool parts_valid = false;
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
 	clear_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 
+	if (!invalidate) {
+		sync_blockdev(bdev);
+		invalidate_bdev(bdev);
+		if (disk->fops->revalidate_disk)
+			disk->fops->revalidate_disk(disk);
+		/*
+		 * Return immediately if partitions state aren't changed,
+		 * then we can avoid partition removal & readd, which may
+		 * confuse userspace.
+		 */
+		if (!blk_update_partitions(disk, bdev, &ret))
+			return 0;
+		if (!ret)
+			parts_valid = true;
+	}
+
 rescan:
 	ret = blk_drop_partitions(bdev);
 	if (ret)
@@ -1243,14 +1260,19 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 		    !(disk->flags & GENHD_FL_REMOVABLE))
 			set_capacity(disk, 0);
 	} else {
-		if (disk->fops->revalidate_disk)
+		if (!parts_valid && disk->fops->revalidate_disk)
 			disk->fops->revalidate_disk(disk);
 	}
 
 	if (get_capacity(disk)) {
-		ret = blk_add_partitions(disk, bdev);
-		if (ret == -EAGAIN)
+		if (!parts_valid)
+			blk_update_partitions(disk, bdev, &ret);
+		if (!ret)
+			ret = blk_add_partitions(disk, bdev);
+		if (ret == -EAGAIN) {
+			parts_valid = false;
 			goto rescan;
+		}
 	} else if (invalidate) {
 		/*
 		 * Tell userspace that the media / partition table may have
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f364619092cc..4f517305f81f 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -119,6 +119,7 @@ enum {
 
 struct disk_events;
 struct badblocks;
+struct parsed_partitions;
 
 struct blk_integrity {
 	const struct blk_integrity_profile	*profile;
@@ -166,6 +167,7 @@ struct gendisk {
 #endif
 	int node_id;
 	struct badblocks *bb;
+	struct parsed_partitions *parts_state;
 	struct lockdep_map lockdep_map;
 };
 
@@ -274,6 +276,8 @@ static inline sector_t get_capacity(struct gendisk *disk)
 int bdev_disk_changed(struct block_device *bdev, bool invalidate);
 int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
 int blk_drop_partitions(struct block_device *bdev);
+bool blk_update_partitions(struct gendisk *disk, struct block_device *bdev,
+		int *retval);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
 extern void put_disk(struct gendisk *disk);
-- 
2.29.2

