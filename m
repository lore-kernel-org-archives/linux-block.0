Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B0CC433FE
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956436135F
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTOnz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhJTOnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:43:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5BC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZFzyTxhL31rM+CddLYCmyu8tXSw4Y3k90Iix1fq6Wr4=; b=DSMFaCQsJcexmzfjvZOowH84eH
        NCVMO6YiR+c3lFsTYEgtgt67QHXXtFfL3cIuWO0/lwl2S1LC4wpwOv90mCVRui5EgaBC3kxehP9E0
        B++LlOrj6AhNEuF1vXrxlXW8vluU4FVNb5iBTfQ0eEcJXCghKW8vxwKzLlbinQM5KLTo0neKwz8UJ
        zvjIauPOQgqOj+Y6vkhgsdhYq2YLlPlHsf/v2QP3Pwv//ATWXUIEEM5NDsyprd6OLaBdeEdrOJmVW
        OOG+ANgZ2Q8XELWEA1qDM1DRANS+wuxsM1LhEzSqIpfUDpcv3/8ypSKoTt4t4WT/1o1kxCQYKSoc9
        15JVCPzQ==;
Received: from [2001:4bb8:180:8777:a130:d02a:a9b5:7d80] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdCmd-004oHs-8F; Wed, 20 Oct 2021 14:41:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: cleanup the flush plug helpers
Date:   Wed, 20 Oct 2021 16:41:19 +0200
Message-Id: <20211020144119.142582-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020144119.142582-1-hch@lst.de>
References: <20211020144119.142582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Consolidate the various helpers into a single blk_flush_plug helper that
takes a plk_plug and the from_scheduler bool and switch all callsites to
call it directly.  Checks that the plug is non-NULL must be performed by
the caller, something that most already do anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 13 ++++++-------
 fs/fs-writeback.c      |  5 +++--
 include/linux/blkdev.h | 29 ++++-------------------------
 kernel/sched/core.c    |  5 +++--
 4 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 63fee1f82bd7d..bb25934c9408a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1089,7 +1089,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 		return 0;
 
 	if (current->plug)
-		blk_flush_plug_list(current->plug, false);
+		blk_flush_plug(current->plug, false);
 
 	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
 		return 0;
@@ -1637,7 +1637,7 @@ struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug, void *data,
 }
 EXPORT_SYMBOL(blk_check_plugged);
 
-void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
+void blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 {
 	if (!list_empty(&plug->cb_list))
 		flush_plug_callbacks(plug, from_schedule);
@@ -1659,11 +1659,10 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
  */
 void blk_finish_plug(struct blk_plug *plug)
 {
-	if (plug != current->plug)
-		return;
-	blk_flush_plug_list(plug, false);
-
-	current->plug = NULL;
+	if (plug == current->plug) {
+		blk_flush_plug(plug, false);
+		current->plug = NULL;
+	}
 }
 EXPORT_SYMBOL(blk_finish_plug);
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 81ec192ce0673..4124a89a1a5df 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1893,7 +1893,8 @@ static long writeback_sb_inodes(struct super_block *sb,
 			 * unplug, so get our IOs out the door before we
 			 * give up the CPU.
 			 */
-			blk_flush_plug(current);
+			if (current->plug)
+				blk_flush_plug(current->plug, false);
 			cond_resched();
 		}
 
@@ -2291,7 +2292,7 @@ void wakeup_flusher_threads(enum wb_reason reason)
 	 * If we are expecting writeback progress we must submit plugged IO.
 	 */
 	if (blk_needs_flush_plug(current))
-		blk_schedule_flush_plug(current);
+		blk_flush_plug(current->plug, true);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(bdi, &bdi_list, bdi_list)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c95aee920bbb4..16647fbd1c2c4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -708,9 +708,8 @@ extern void blk_set_queue_dying(struct request_queue *);
  * as the lock contention for request_queue lock is reduced.
  *
  * It is ok not to disable preemption when adding the request to the plug list
- * or when attempting a merge, because blk_schedule_flush_list() will only flush
- * the plug list when the task sleeps by itself. For details, please see
- * schedule() where blk_schedule_flush_plug() is called.
+ * or when attempting a merge. For details, please see schedule() where
+ * blk_flush_plug() is called.
  */
 struct blk_plug {
 	struct request *mq_list; /* blk-mq requests */
@@ -740,23 +739,8 @@ extern struct blk_plug_cb *blk_check_plugged(blk_plug_cb_fn unplug,
 extern void blk_start_plug(struct blk_plug *);
 extern void blk_start_plug_nr_ios(struct blk_plug *, unsigned short);
 extern void blk_finish_plug(struct blk_plug *);
-extern void blk_flush_plug_list(struct blk_plug *, bool);
 
-static inline void blk_flush_plug(struct task_struct *tsk)
-{
-	struct blk_plug *plug = tsk->plug;
-
-	if (plug)
-		blk_flush_plug_list(plug, false);
-}
-
-static inline void blk_schedule_flush_plug(struct task_struct *tsk)
-{
-	struct blk_plug *plug = tsk->plug;
-
-	if (plug)
-		blk_flush_plug_list(plug, true);
-}
+void blk_flush_plug(struct blk_plug *plug, bool from_schedule);
 
 static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 {
@@ -785,15 +769,10 @@ static inline void blk_finish_plug(struct blk_plug *plug)
 {
 }
 
-static inline void blk_flush_plug(struct task_struct *task)
-{
-}
-
-static inline void blk_schedule_flush_plug(struct task_struct *task)
+static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 {
 }
 
-
 static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 {
 	return false;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 92ef7b68198c4..34f37502c27e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6343,7 +6343,7 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * make sure to submit it to avoid deadlocks.
 	 */
 	if (blk_needs_flush_plug(tsk))
-		blk_schedule_flush_plug(tsk);
+		blk_flush_plug(tsk->plug, true);
 }
 
 static void sched_update_worker(struct task_struct *tsk)
@@ -8354,7 +8354,8 @@ int io_schedule_prepare(void)
 	int old_iowait = current->in_iowait;
 
 	current->in_iowait = 1;
-	blk_schedule_flush_plug(current);
+	if (current->plug)
+		blk_flush_plug(current->plug, true);
 
 	return old_iowait;
 }
-- 
2.30.2

