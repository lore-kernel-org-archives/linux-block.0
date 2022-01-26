Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECECC2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 15:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiAZPvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiAZPvF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 10:51:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E06C06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/ovXyGPyYL+tni9kFvm8/WI/y+NFRHMTenONhgCdT3c=; b=ZxX05cfQ6MT3e8z+RAQRojhgpj
        jc/uy3TCTYwTQJcdQAdmy2HooWpAQL3ReQNOYb3dFe10qJrusuDAt7YlbRSdZHoyuMSgOJzwNptiZ
        VGzD006VmC88uARxsePqKZU3QCv2DDiUGWNxIkZ3EMDCe8YEuAtW7sB0+czOfxn/+oYSGOQSVF9hI
        Eo1lahu7qQs1GWAqRLg+bfL8S4KxT9MAPdxPLk4hyLITBdsDtIOE6IcNHdC93T5rvLRkNui2wcnHF
        gE4UCo+wPDFIcDUxFt5kTla5O/DcARG1FH5WoHtmEY8IM6+sqV9+Cd/6dHXt9Qq/VRCJcdGP+/tZM
        /coSsVDA==;
Received: from [2001:4bb8:180:4c4c:c422:bb0a:5a5f:dce0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkZa-00CQCp-0t; Wed, 26 Jan 2022 15:51:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/8] loop: only freeze the queue in __loop_clr_fd when needed
Date:   Wed, 26 Jan 2022 16:50:39 +0100
Message-Id: <20220126155040.1190842-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126155040.1190842-1-hch@lst.de>
References: <20220126155040.1190842-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

->release is only called after all outstanding I/O has completed, so only
freeze the queue when clearing the backing file of a live loop device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d9a0e2205762f..fc0cdd1612b1d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1110,7 +1110,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo)
+static void __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
@@ -1139,8 +1139,13 @@ static void __loop_clr_fd(struct loop_device *lo)
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
 
-	/* freeze request queue during the transition */
-	blk_mq_freeze_queue(lo->lo_queue);
+	/*
+	 * Freeze the request queue when unbinding on a live file descriptor and
+	 * thus an open device.  When called from ->release we are guaranteed
+	 * that there is no I/O in progress already.
+	 */
+	if (!release)
+		blk_mq_freeze_queue(lo->lo_queue);
 
 	destroy_workqueue(lo->workqueue);
 	loop_free_idle_workers(lo, true);
@@ -1163,7 +1168,8 @@ static void __loop_clr_fd(struct loop_device *lo)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	if (!release)
+		blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 
@@ -1201,7 +1207,7 @@ static void loop_rundown_workfn(struct work_struct *work)
 	struct block_device *bdev = lo->lo_device;
 	struct gendisk *disk = lo->lo_disk;
 
-	__loop_clr_fd(lo);
+	__loop_clr_fd(lo, true);
 	kobject_put(&bdev->bd_device.kobj);
 	module_put(disk->fops->owner);
 	loop_rundown_completed(lo);
@@ -1247,7 +1253,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo);
+	__loop_clr_fd(lo, false);
 	loop_rundown_completed(lo);
 	return 0;
 }
-- 
2.30.2

