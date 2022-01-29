Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0795C433F5
	for <linux-block@archiver.kernel.org>; Sat, 29 Jan 2022 07:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiA2HQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:16:16 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56862 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350164AbiA2HQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jan 2022 02:16:16 -0500
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20T7FXLc082107;
        Sat, 29 Jan 2022 16:15:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 29 Jan 2022 16:15:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20T7FSNp082068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Jan 2022 16:15:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 4/7] loop: don't call blk_mq_freeze_queue()/blk_mq_unfreeze_queue() from lo_release()
Date:   Sat, 29 Jan 2022 16:14:57 +0900
Message-Id: <20220129071500.3566-5-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It turned out that there is no need to call blk_mq_freeze_queue() from
lo_release(), for all pending I/O requests are flushed by the block core
layer before "struct block_device_operations"->release() is called.

As a preparation for not holding lo->lo_mutex from lo_open()/lo_release()
paths, remove blk_mq_freeze_queue()/blk_mq_unfreeze_queue() from
lo_release().

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 14b6f862531b..b6435f803061 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1108,7 +1108,8 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 		blk_queue_write_cache(lo->lo_queue, false, false);
 
 	/* freeze request queue during the transition */
-	blk_mq_freeze_queue(lo->lo_queue);
+	if (!release)
+		blk_mq_freeze_queue(lo->lo_queue);
 
 	destroy_workqueue(lo->workqueue);
 	spin_lock_irq(&lo->lo_work_lock);
@@ -1139,7 +1140,8 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	if (!release)
+		blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 
@@ -1728,22 +1730,11 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 			goto out_unlock;
 		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
-		/*
-		 * In autoclear mode, stop the loop thread
-		 * and remove configuration after last close.
-		 */
 		__loop_clr_fd(lo, true);
 		mutex_lock(&lo->lo_mutex);
 		lo->lo_state = Lo_unbound;
 		mutex_unlock(&lo->lo_mutex);
 		return;
-	} else if (lo->lo_state == Lo_bound) {
-		/*
-		 * Otherwise keep thread (if running) and config,
-		 * but flush possible ongoing bios in thread.
-		 */
-		blk_mq_freeze_queue(lo->lo_queue);
-		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
 
 out_unlock:
-- 
2.32.0

