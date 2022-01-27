Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DC8C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 07:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiA0HF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiA0HF4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 02:05:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771BC061714
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 23:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6AgNmxXDe5la/g665/TycFCtkAx0McwZScEYN9Qhmg4=; b=LRZvMp5MPxl7+n2geQtC8IJf4c
        YFidRhwzac8ZPnSXcEqEXv5Wb3QY5aSiHU6eKc2UQYbXgnO1/wXuSOekQ+/l1BgBxF9IgITtoA7YC
        0Kxj1dxBa2McpRnr9JTdk9qBIWL+mu/e/jH+/hqA1XMyE7clZIcJeME+z0dUHmVD7Cf2Vunei0Pke
        YsBQ/xydjoix9NJ8nrtTz9dCtiiz9lDYV3isb6esLej6YYSWKhxLFunvbLCvCSR0CvM5y2A47o5MY
        grGP/jjt8j+FA5e9Da22rTvdfAJfUsUy+anCXOSpmeubKuFdPhFfP17ezxSDrs5Zu3DBjLxrBldA2
        Uso1V6WQ==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyqx-00Ebe1-1C; Thu, 27 Jan 2022 07:05:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: check that there is a plug in blk_flush_plug
Date:   Thu, 27 Jan 2022 08:05:49 +0100
Message-Id: <20220127070549.1377856-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127070549.1377856-1-hch@lst.de>
References: <20220127070549.1377856-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename blk_flush_plug to __blk_flush_plug and add a wrapper that includes
the NULL check instead of open coding that check everywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 7 +++----
 fs/fs-writeback.c      | 6 ++----
 include/linux/blkdev.h | 7 ++++++-
 kernel/sched/core.c    | 7 ++-----
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 97f8bc8d3a791..f5f0d45841a47 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -991,8 +991,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
-	if (current->plug)
-		blk_flush_plug(current->plug, false);
+	blk_flush_plug(current->plug, false);
 
 	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
 		return 0;
@@ -1261,7 +1260,7 @@ struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug, void *data,
 }
 EXPORT_SYMBOL(blk_check_plugged);
 
-void blk_flush_plug(struct blk_plug *plug, bool from_schedule)
+void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 {
 	if (!list_empty(&plug->cb_list))
 		flush_plug_callbacks(plug, from_schedule);
@@ -1290,7 +1289,7 @@ void blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 void blk_finish_plug(struct blk_plug *plug)
 {
 	if (plug == current->plug) {
-		blk_flush_plug(plug, false);
+		__blk_flush_plug(plug, false);
 		current->plug = NULL;
 	}
 }
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f4ce38f6fc31c..33d54c9fbefc0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1903,8 +1903,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 			 * unplug, so get our IOs out the door before we
 			 * give up the CPU.
 			 */
-			if (current->plug)
-				blk_flush_plug(current->plug, false);
+			blk_flush_plug(current->plug, false);
 			cond_resched();
 		}
 
@@ -2301,8 +2300,7 @@ void wakeup_flusher_threads(enum wb_reason reason)
 	/*
 	 * If we are expecting writeback progress we must submit plugged IO.
 	 */
-	if (current->plug)
-		blk_flush_plug(current->plug, true);
+	blk_flush_plug(current->plug, true);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(bdi, &bdi_list, bdi_list)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 95176802ccc92..3020f3c3683df 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1053,7 +1053,12 @@ extern void blk_start_plug(struct blk_plug *);
 extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned short);
 extern void blk_finish_plug(struct blk_plug *);
 
-void blk_flush_plug(struct blk_plug *plug, bool from_schedule);
+void __blk_flush_plug(struct blk_plug *plug, bool from_schedule);
+static inline void blk_flush_plug(struct blk_plug *plug, bool async)
+{
+	if (plug)
+		__blk_flush_plug(plug, async);
+}
 
 int blkdev_issue_flush(struct block_device *bdev);
 long nr_blockdev_pages(void);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ccaa17e5a8306..cc3b665bd3582 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6345,8 +6345,7 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
 	 */
-	if (tsk->plug)
-		blk_flush_plug(tsk->plug, true);
+	blk_flush_plug(tsk->plug, true);
 }
 
 static void sched_update_worker(struct task_struct *tsk)
@@ -8378,9 +8377,7 @@ int io_schedule_prepare(void)
 	int old_iowait = current->in_iowait;
 
 	current->in_iowait = 1;
-	if (current->plug)
-		blk_flush_plug(current->plug, true);
-
+	blk_flush_plug(current->plug, true);
 	return old_iowait;
 }
 
-- 
2.30.2

