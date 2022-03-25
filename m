Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD6DC433FE
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 06:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358476AbiCYGmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 02:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358478AbiCYGmG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 02:42:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C983995A32
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8QLbMSvJb6TB/5jcBDyKBWkOEbvuH4GA++hXSAuN7H8=; b=KhGKYbslFREkMtDq27XE3Tt/X1
        c1Dr8msI9h3r2U0E+SuFzykluG5XgBsoTf8HjTg/1CoU7fz+BB3dZc1KXYwn3eYRHAoWpqQl7h8OC
        fA2l9Y1pzUmuWiohfWzvkCYqpFf7j8CJAhAWeAYzPzWJ1FDcOBqVvf7Mb8QdcvjlFAjS98gwftkPh
        NhpbdUpDTh+T4qUw7wlei+s8AVak5Dd/AlxnUBZvjhS8vXlHVcqRDIwJ0z0vXao0/0PyDH5aBBNfh
        2iOvwyiOoP/8ve3SV1BFsBTN2FQ/2i2GSTwMt+PWKoeZQToPKp3lV/i+vQ4fFwZ7LiuS3QPgXnmln
        GV0x7EQg==;
Received: from 089144194144.atnat0003.highway.a1.net ([89.144.194.144] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXdcU-001HTF-BM; Fri, 25 Mar 2022 06:40:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH 13/14] loop: remove lo_refcount and avoid lo_mutex in ->open / ->release
Date:   Fri, 25 Mar 2022 07:39:28 +0100
Message-Id: <20220325063929.1773899-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325063929.1773899-1-hch@lst.de>
References: <20220325063929.1773899-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

lo_refcount counts how many openers a loop device has, but that count
is already provided by the block layer in the bd_openers field of the
whole-disk block_device.  Remove lo_refcount and allow opens to
succeed even on devices beeing deleted - now that ->free_disk is
implemented we can handle that race gracefull and all I/O on it will
just fail. Similarly there is a small race window now where
loop_control_remove does not synchronize the delete vs the remove
due do bd_openers not being under lo_mutex protection, but we can
handle that just as gracefully.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 37 +++++++------------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bfd21af7aa38b..8ad8cfffdcbdc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1261,7 +1261,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
 	 * command to fail with EBUSY.
 	 */
-	if (atomic_read(&lo->lo_refcnt) > 1) {
+	if (disk_openers(lo->lo_disk) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 		mutex_unlock(&lo->lo_mutex);
 		return 0;
@@ -1741,33 +1741,15 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif
 
-static int lo_open(struct block_device *bdev, fmode_t mode)
-{
-	struct loop_device *lo = bdev->bd_disk->private_data;
-	int err;
-
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
-		return err;
-	if (lo->lo_state == Lo_deleting)
-		err = -ENXIO;
-	else
-		atomic_inc(&lo->lo_refcnt);
-	mutex_unlock(&lo->lo_mutex);
-	return err;
-}
-
 static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
 
-	mutex_lock(&lo->lo_mutex);
-	if (atomic_dec_return(&lo->lo_refcnt))
-		goto out_unlock;
+	if (disk_openers(disk) > 0)
+		return;
 
-	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
-		if (lo->lo_state != Lo_bound)
-			goto out_unlock;
+	mutex_lock(&lo->lo_mutex);
+	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
 		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
 		/*
@@ -1777,8 +1759,6 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		__loop_clr_fd(lo, true);
 		return;
 	}
-
-out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 }
 
@@ -1792,7 +1772,6 @@ static void lo_free_disk(struct gendisk *disk)
 
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
-	.open =		lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
@@ -2046,7 +2025,6 @@ static int loop_add(int i)
 	 */
 	if (!part_shift)
 		disk->flags |= GENHD_FL_NO_PART;
-	atomic_set(&lo->lo_refcnt, 0);
 	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
@@ -2136,13 +2114,12 @@ static int loop_control_remove(int idx)
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
 		goto mark_visible;
-	if (lo->lo_state != Lo_unbound ||
-	    atomic_read(&lo->lo_refcnt) > 0) {
+	if (lo->lo_state != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
 		mutex_unlock(&lo->lo_mutex);
 		ret = -EBUSY;
 		goto mark_visible;
 	}
-	/* Mark this loop device no longer open()-able. */
+	/* Mark this loop device as no more bound, but not quite unbound yet */
 	lo->lo_state = Lo_deleting;
 	mutex_unlock(&lo->lo_mutex);
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 082d4b6bfc6a6..449d562738c52 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -28,7 +28,6 @@ struct loop_func_table;
 
 struct loop_device {
 	int		lo_number;
-	atomic_t	lo_refcnt;
 	loff_t		lo_offset;
 	loff_t		lo_sizelimit;
 	int		lo_flags;
-- 
2.30.2

