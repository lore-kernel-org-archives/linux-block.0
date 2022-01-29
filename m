Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDC6C433F5
	for <linux-block@archiver.kernel.org>; Sat, 29 Jan 2022 07:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349502AbiA2HQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:16:03 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56748 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349216AbiA2HQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jan 2022 02:16:03 -0500
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20T7FXxe082101;
        Sat, 29 Jan 2022 16:15:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 29 Jan 2022 16:15:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20T7FSNn082068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Jan 2022 16:15:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 2/7] loop: clarify __module_get()/module_put() usage
Date:   Sat, 29 Jan 2022 16:14:55 +0900
Message-Id: <20220129071500.3566-3-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These are used in order to block loop_exit() while holding backing files.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 150012ffb387..3a87c33df2ec 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -959,9 +959,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		return -EBADF;
 	is_loop = is_loop_device(file);
 
-	/* This is safe, since we have a reference from open(). */
-	__module_get(THIS_MODULE);
-
 	/*
 	 * If we don't hold exclusive handle for the device, upgrade to it
 	 * here to avoid changing device under exclusive owner.
@@ -1027,6 +1024,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
 	lo->lo_backing_file = file;
+	/* Block loop_exit() while holding backing file. */
+	__module_get(THIS_MODULE);
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
@@ -1077,8 +1076,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		bd_abort_claiming(bdev, loop_configure);
 out_putf:
 	fput(file);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	return error;
 }
 
@@ -1144,8 +1141,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
@@ -1185,12 +1180,9 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 
-	/*
-	 * Need not hold lo_mutex to fput backing file. Calling fput holding
-	 * lo_mutex triggers a circular lock dependency possibility warning as
-	 * fput can take open_mutex which is usually taken before lo_mutex.
-	 */
+	/* Release backing file and unblock loop_exit(). */
 	fput(filp);
+	module_put(THIS_MODULE);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
-- 
2.32.0

