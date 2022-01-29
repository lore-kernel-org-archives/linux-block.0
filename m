Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604B8C433EF
	for <linux-block@archiver.kernel.org>; Sat, 29 Jan 2022 07:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350621AbiA2HRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:17:10 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57973 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350164AbiA2HRI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jan 2022 02:17:08 -0500
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20T7FX2m082104;
        Sat, 29 Jan 2022 16:15:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 29 Jan 2022 16:15:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20T7FSNo082068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Jan 2022 16:15:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 3/7] loop: don't hold lo->lo_mutex from __loop_clr_fd()
Date:   Sat, 29 Jan 2022 16:14:56 +0900
Message-Id: <20220129071500.3566-4-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As a preparation for not holding lo->lo_mutex from lo_open()/lo_release()
paths, move the updating of lo->lo_state in __loop_clr_fd() to callers.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3a87c33df2ec..14b6f862531b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1100,11 +1100,9 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	/*
 	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
 	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
-	 * lo->lo_state has changed while waiting for lo->lo_mutex.
+	 * lo->lo_state has changed.
 	 */
-	mutex_lock(&lo->lo_mutex);
 	BUG_ON(lo->lo_state != Lo_rundown);
-	mutex_unlock(&lo->lo_mutex);
 
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
@@ -1167,18 +1165,9 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 		/* Device is gone, no point in returning error */
 	}
 
-	/*
-	 * lo->lo_state is set to Lo_unbound here after above partscan has
-	 * finished. There cannot be anybody else entering __loop_clr_fd() as
-	 * Lo_rundown state protects us from all the other places trying to
-	 * change the 'lo' device.
-	 */
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
-	mutex_lock(&lo->lo_mutex);
-	lo->lo_state = Lo_unbound;
-	mutex_unlock(&lo->lo_mutex);
 
 	/* Release backing file and unblock loop_exit(). */
 	fput(filp);
@@ -1215,6 +1204,10 @@ static int loop_clr_fd(struct loop_device *lo)
 	mutex_unlock(&lo->lo_mutex);
 
 	__loop_clr_fd(lo, false);
+	/* Allow loop_configure() to reuse this device. */
+	mutex_lock(&lo->lo_mutex);
+	lo->lo_state = Lo_unbound;
+	mutex_unlock(&lo->lo_mutex);
 	return 0;
 }
 
@@ -1740,6 +1733,9 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * and remove configuration after last close.
 		 */
 		__loop_clr_fd(lo, true);
+		mutex_lock(&lo->lo_mutex);
+		lo->lo_state = Lo_unbound;
+		mutex_unlock(&lo->lo_mutex);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
-- 
2.32.0

