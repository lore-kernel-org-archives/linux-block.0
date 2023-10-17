Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA393CDB474
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 18:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjJQSsl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 14:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjJQSsl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 14:48:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD385B0;
        Tue, 17 Oct 2023 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hXqD6LIJqnzv4QeG9K6m4j/CzLlR3SZlUyktnM/Uae8=; b=wKnMo4DQOLfaZX5Vd185qK/fjc
        1DLQJt9HtwYSDeOF1xp3Gm/EB2falI2mh6j+F0sQ2buS1YUMC5n7/czoutACtJk+wX5a6n4+V0yaZ
        o6ft6KdR1XNOgYPXJi/Mw6ptkzEd9K9/ubxuTC4RhiAVSwKuw/CMVVvALrlUDaZ71kuU3dkQCayab
        3MnVBH7zJPZzpjYeuBK4VUINjgOUYqJC/jy7LTtoCa4yS1lyNCecYJ/zWw8jvXtEMXqgqpe+lBbDP
        9k+7Z29DqcHJ/3jdaCjRg4JDNz2Vc962eMkCJbITk6zXUaVJMsAAbMAToAfLGM9HVtYmwWBrsHFnC
        gXTFxOww==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsp7M-00D0L6-1t;
        Tue, 17 Oct 2023 18:48:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] block: move bdev_mark_dead out of disk_check_media_change
Date:   Tue, 17 Oct 2023 20:48:21 +0200
Message-Id: <20231017184823.1383356-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017184823.1383356-1-hch@lst.de>
References: <20231017184823.1383356-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

disk_check_media_change is mostly called from ->open where it makes
little sense to mark the file system on the device as dead, as we
are just opening it.  So instead of calling bdev_mark_dead from
disk_check_media_change move it into the few callers that are not
in an open instance.  This avoid calling into bdev_mark_dead and
thus taking s_umount with open_mutex held.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/disk-events.c     | 18 +++++++-----------
 drivers/block/ataflop.c |  4 +++-
 drivers/block/floppy.c  |  4 +++-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/disk-events.c b/block/disk-events.c
index 13c3372c465a39..2f697224386aa8 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -266,11 +266,8 @@ static unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask)
  * disk_check_media_change - check if a removable media has been changed
  * @disk: gendisk to check
  *
- * Check whether a removable media has been changed, and attempt to free all
- * dentries and inodes and invalidates all block device page cache entries in
- * that case.
- *
- * Returns %true if the media has changed, or %false if not.
+ * Returns %true and marks the disk for a partition rescan whether a removable
+ * media has been changed, and %false if the media did not change.
  */
 bool disk_check_media_change(struct gendisk *disk)
 {
@@ -278,12 +275,11 @@ bool disk_check_media_change(struct gendisk *disk)
 
 	events = disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
 				   DISK_EVENT_EJECT_REQUEST);
-	if (!(events & DISK_EVENT_MEDIA_CHANGE))
-		return false;
-
-	bdev_mark_dead(disk->part0, true);
-	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	return true;
+	if (events & DISK_EVENT_MEDIA_CHANGE) {
+		set_bit(GD_NEED_PART_SCAN, &disk->state);
+		return true;
+	}
+	return false;
 }
 EXPORT_SYMBOL(disk_check_media_change);
 
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index cd738cab725f39..50949207798d2a 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1760,8 +1760,10 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 		/* invalidate the buffer track to force a reread */
 		BufferDrive = -1;
 		set_bit(drive, &fake_change);
-		if (disk_check_media_change(disk))
+		if (disk_check_media_change(disk)) {
+			bdev_mark_dead(disk->part0, true);
 			floppy_revalidate(disk);
+		}
 		return 0;
 	default:
 		return -EINVAL;
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ea4eb88a2e45f4..11114a5d9e5c46 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3215,8 +3215,10 @@ static int invalidate_drive(struct gendisk *disk)
 	/* invalidate the buffer track to force a reread */
 	set_bit((long)disk->private_data, &fake_change);
 	process_fd_request();
-	if (disk_check_media_change(disk))
+	if (disk_check_media_change(disk)) {
+		bdev_mark_dead(disk->part0, true);
 		floppy_revalidate(disk);
+	}
 	return 0;
 }
 
-- 
2.39.2

