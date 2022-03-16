Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAD5C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 08:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348751AbiCPIrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354624AbiCPIq7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:46:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEBC63BFA
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VytvXi/ofTXtBnUa851r1k2mUlJR5hNmhRa8J5sSdpE=; b=UcI8b2vXWChXCkQyh3fotWCxgu
        NGA1gv3IAmM/dPfG2TeYI7lcsruJ/2VPmb/wXPYi81J2hrcp9IV5n9UNJ6a5o68Zs0TF0KRZoZUWk
        M9Jnv/ajN5se4XC6ZpOxFMqlX1kOmxpgP8EMDFBLgbjVMpNlDuxLR5j8VHIQaZ6rYmBmk+U4LSWgS
        G8QosajCQaD8HztNbz85sbCNyreQ8Mf0xocDXymfllh9izX+xjUA47axpol5XqWsxbhHPH8wFtZMI
        kWivDuVAj6nzxT4/b+9lsYqZwm4FUBxzP9zAs9kK0RNLeBXyBUwUSEXG5hqDnxTyR4im6J17/I3jC
        gZhH4tGA==;
Received: from [46.140.54.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPHq-00CCH8-Dl; Wed, 16 Mar 2022 08:45:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/8] loop: remove lo_refcount and avoid lo_mutex in ->open / ->release
Date:   Wed, 16 Mar 2022 09:45:18 +0100
Message-Id: <20220316084519.2850118-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316084519.2850118-1-hch@lst.de>
References: <20220316084519.2850118-1-hch@lst.de>
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
---
 drivers/block/loop.c | 36 +++++++-----------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cbaa18bcad1fe..c270f3715d829 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1244,7 +1244,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
 	 * command to fail with EBUSY.
 	 */
-	if (atomic_read(&lo->lo_refcnt) > 1) {
+	if (lo->lo_disk->part0->bd_openers > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 		mutex_unlock(&lo->lo_mutex);
 		return 0;
@@ -1724,33 +1724,15 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
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
+	if (disk->part0->bd_openers > 0)
+		return;
 
-	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
-		if (lo->lo_state != Lo_bound)
-			goto out_unlock;
+	mutex_lock(&lo->lo_mutex);
+	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
 		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
 		/*
@@ -1760,8 +1742,6 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		__loop_clr_fd(lo, true);
 		return;
 	}
-
-out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 }
 
@@ -1775,7 +1755,6 @@ static void lo_free_disk(struct gendisk *disk)
 
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
-	.open =		lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
@@ -2029,7 +2008,6 @@ static int loop_add(int i)
 	 */
 	if (!part_shift)
 		disk->flags |= GENHD_FL_NO_PART;
-	atomic_set(&lo->lo_refcnt, 0);
 	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
@@ -2119,12 +2097,12 @@ static int loop_control_remove(int idx)
 	if (ret)
 		goto mark_visible;
 	if (lo->lo_state != Lo_unbound ||
-	    atomic_read(&lo->lo_refcnt) > 0) {
+	    lo->lo_disk->part0->bd_openers > 0) {
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

