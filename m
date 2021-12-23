Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B7AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 11:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347858AbhLWLZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 06:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbhLWLZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 06:25:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B63C061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 03:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IsZwaMpL0qvjGKJExi+u4MfskNlt0dBC3G8kcJcf5+M=; b=03tzaan4vRiAIqCh7imxapGTbK
        CgjnXoUlA4Jdo0fOXnRHOfCZJ/oBJxl+caD3NTKslo7Qwwdo3fN+Zi6F55lu01wM48Od+kJZZ69n1
        /4HPYzRi+wSSYxDjTj4SWzqQ9s2rI4To9hPiQA7Hw197bHgzLi7rF4V0RhuxwEnLs6VN67+7l6BbV
        tgbpD87gJdzQzzgJAjfD1WLAdGXztO7J6SvpUrcC46eV+yRZ/K0/zd+zLJJRWaaN9177kiMpJB/52
        wMBU+6nFqJF2lrn4xFx/DbYJBwSz627abj91ouSnBfuUxJ3K+7fgBbVtpCnotI1ILdpB29UXfeu1b
        PLn+KyOw==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0MDj-00CZtV-KT; Thu, 23 Dec 2021 11:25:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/2] loop: use a global workqueue
Date:   Thu, 23 Dec 2021 12:25:08 +0100
Message-Id: <20211223112509.1116461-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211223112509.1116461-1-hch@lst.de>
References: <20211223112509.1116461-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Using a per-device unbound workqueue is a bit of an anti-pattern and
in this case also creates lock ordering problems.  Just use a global
concurrencymanaged workqueue instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 36 +++++++++++++++---------------------
 drivers/block/loop.h |  1 -
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7f4ea06534c2d..573f0d83fe80a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -89,6 +89,7 @@
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
+static struct workqueue_struct *loop_workqueue;
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -884,7 +885,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 		cmd_list = &lo->rootcg_cmd_list;
 	}
 	list_add_tail(&cmd->list_entry, cmd_list);
-	queue_work(lo->workqueue, work);
+	queue_work(loop_workqueue, work);
 	spin_unlock_irq(&lo->lo_work_lock);
 }
 
@@ -1006,15 +1007,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
 
-	lo->workqueue = alloc_workqueue("loop%d",
-					WQ_UNBOUND | WQ_FREEZABLE,
-					0,
-					lo->lo_number);
-	if (!lo->workqueue) {
-		error = -ENOMEM;
-		goto out_unlock;
-	}
-
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
@@ -1115,7 +1107,6 @@ static void __loop_clr_fd(struct loop_device *lo)
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-	destroy_workqueue(lo->workqueue);
 	spin_lock_irq(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
@@ -2212,15 +2203,11 @@ static int __init loop_init(void)
 		max_part = (1UL << part_shift) - 1;
 	}
 
-	if ((1UL << part_shift) > DISK_MAX_PARTS) {
-		err = -EINVAL;
-		goto err_out;
-	}
+	if ((1UL << part_shift) > DISK_MAX_PARTS)
+		return -EINVAL;
 
-	if (max_loop > 1UL << (MINORBITS - part_shift)) {
-		err = -EINVAL;
-		goto err_out;
-	}
+	if (max_loop > 1UL << (MINORBITS - part_shift))
+		return -EINVAL;
 
 	/*
 	 * If max_loop is specified, create that many devices upfront.
@@ -2235,9 +2222,14 @@ static int __init loop_init(void)
 	else
 		nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
 
+	loop_workqueue = alloc_workqueue("loop", WQ_MEM_RECLAIM | WQ_FREEZABLE,
+					 0);
+	if (!loop_workqueue)
+		return -ENOMEM;
+
 	err = misc_register(&loop_misc);
 	if (err < 0)
-		goto err_out;
+		goto destroy_workqueue;
 
 
 	if (__register_blkdev(LOOP_MAJOR, "loop", loop_probe)) {
@@ -2254,7 +2246,8 @@ static int __init loop_init(void)
 
 misc_out:
 	misc_deregister(&loop_misc);
-err_out:
+destroy_workqueue:
+	destroy_workqueue(loop_workqueue);
 	return err;
 }
 
@@ -2276,6 +2269,7 @@ static void __exit loop_exit(void)
 		loop_remove(lo);
 
 	idr_destroy(&loop_index_idr);
+	destroy_workqueue(loop_workqueue);
 }
 
 module_init(loop_init);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc0259..885c83b4417e1 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -42,7 +42,6 @@ struct loop_device {
 	spinlock_t		lo_lock;
 	int			lo_state;
 	spinlock_t              lo_work_lock;
-	struct workqueue_struct *workqueue;
 	struct work_struct      rootcg_work;
 	struct list_head        rootcg_cmd_list;
 	struct list_head        idle_worker_list;
-- 
2.30.2

