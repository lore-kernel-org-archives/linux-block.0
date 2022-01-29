Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09FDC4332F
	for <linux-block@archiver.kernel.org>; Sat, 29 Jan 2022 07:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350139AbiA2HQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:16:04 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56787 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349353AbiA2HQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jan 2022 02:16:03 -0500
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20T7FXER082110;
        Sat, 29 Jan 2022 16:15:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 29 Jan 2022 16:15:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20T7FSNq082068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Jan 2022 16:15:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 5/7] loop: don't call destroy_workqueue() from lo_release()
Date:   Sat, 29 Jan 2022 16:14:58 +0900
Message-Id: <20220129071500.3566-6-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
is calling destroy_workqueue() with disk->open_mutex held.

But it turned out that there is no need to call flush_workqueue() from
lo_release(), for all pending I/O requests are flushed by the block core
layer before "struct block_device_operations"->release() is called.

In order to silence lockdep warning, defer calling destroy_workqueue()
till loop_remove(). Note that the root cause is that lo_open()/lo_release()
waits for I/O requests with disk->open_mutex held, and we need to avoid
holding lo->lo_mutex from lo_open()/lo_release() paths.

Link: https://syzkaller.appspot.com/bug?extid=643e4ce4b6ad1347d372 [1]
Reported-by: syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b6435f803061..481d2371864a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1003,7 +1003,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
 
-	lo->workqueue = alloc_workqueue("loop%d",
+	if (!lo->workqueue)
+		lo->workqueue = alloc_workqueue("loop%d",
 					WQ_UNBOUND | WQ_FREEZABLE,
 					0,
 					lo->lo_number);
@@ -1108,10 +1109,11 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 		blk_queue_write_cache(lo->lo_queue, false, false);
 
 	/* freeze request queue during the transition */
-	if (!release)
+	if (!release) {
 		blk_mq_freeze_queue(lo->lo_queue);
-
-	destroy_workqueue(lo->workqueue);
+		destroy_workqueue(lo->workqueue);
+		lo->workqueue = NULL;
+	}
 	spin_lock_irq(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
@@ -2050,6 +2052,8 @@ static void loop_remove(struct loop_device *lo)
 	mutex_lock(&loop_ctl_mutex);
 	idr_remove(&loop_index_idr, lo->lo_number);
 	mutex_unlock(&loop_ctl_mutex);
+	if (lo->workqueue)
+		destroy_workqueue(lo->workqueue);
 	/* There is no route which can find this loop device. */
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
-- 
2.32.0

