Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB317C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 08:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354621AbiCPIqr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiCPIqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:46:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F2763BFA
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WlHTgA/IPa/9lZDoaOPinCl4gzMoMfO9tBqmnB3Opms=; b=32y2/0sOdYsEZn8WCBNEodIbqF
        54uetPuO7XotiJSQKpjyJyw0wp4/vpkkjcJSN8SfY+SW7p/2/oVrw6toloqhbulvPRdww8DPXFr+O
        E6TGC45mmWnql6nzDs8PZRoRbIHotHoClYCr90B/ZxuGsRGZDe7QNhRhFLSGAtpIiHBTtzgISNyzb
        uTGqWQT4k+xoAuRu1+u2nG4Yie7NDLYKxr2aUCzjugZdrDj93rPhZHbUNzEDLn/Lm8EfVZ6S+jQhD
        ZHwxyULtkijpi48nZFwwBryRJeoBrK+qQ0h+494girHt99PITCovoUVQqb9shSjCWl9kjuwzen336
        hyRTsQpA==;
Received: from [46.140.54.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPHY-00CC8V-UL; Wed, 16 Mar 2022 08:45:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/8] loop: de-duplicate the idle worker freeing code
Date:   Wed, 16 Mar 2022 09:45:12 +0100
Message-Id: <20220316084519.2850118-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316084519.2850118-1-hch@lst.de>
References: <20220316084519.2850118-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a common helper for both timer based and uncoditional freeing of idle
workers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/block/loop.c | 73 +++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 08f7772bb5261..64227e659efc4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -809,7 +809,6 @@ struct loop_worker {
 
 static void loop_workfn(struct work_struct *work);
 static void loop_rootcg_workfn(struct work_struct *work);
-static void loop_free_idle_workers(struct timer_list *timer);
 
 #ifdef CONFIG_BLK_CGROUP
 static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
@@ -893,6 +892,39 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	spin_unlock_irq(&lo->lo_work_lock);
 }
 
+static void loop_set_timer(struct loop_device *lo)
+{
+	timer_reduce(&lo->timer, jiffies + LOOP_IDLE_WORKER_TIMEOUT);
+}
+
+static void loop_free_idle_workers(struct loop_device *lo, bool delete_all)
+{
+	struct loop_worker *pos, *worker;
+
+	spin_lock_irq(&lo->lo_work_lock);
+	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
+				idle_list) {
+		if (!delete_all &&
+		    time_is_after_jiffies(worker->last_ran_at +
+					  LOOP_IDLE_WORKER_TIMEOUT))
+			break;
+		list_del(&worker->idle_list);
+		rb_erase(&worker->rb_node, &lo->worker_tree);
+		css_put(worker->blkcg_css);
+		kfree(worker);
+	}
+	if (!list_empty(&lo->idle_worker_list))
+		loop_set_timer(lo);
+	spin_unlock_irq(&lo->lo_work_lock);
+}
+
+static void loop_free_idle_workers_timer(struct timer_list *timer)
+{
+	struct loop_device *lo = container_of(timer, struct loop_device, timer);
+
+	return loop_free_idle_workers(lo, false);
+}
+
 static void loop_update_rotational(struct loop_device *lo)
 {
 	struct file *file = lo->lo_backing_file;
@@ -1027,7 +1059,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	INIT_LIST_HEAD(&lo->idle_worker_list);
 	lo->worker_tree = RB_ROOT;
-	timer_setup(&lo->timer, loop_free_idle_workers,
+	timer_setup(&lo->timer, loop_free_idle_workers_timer,
 		TIMER_DEFERRABLE);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
@@ -1091,7 +1123,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
-	struct loop_worker *pos, *worker;
 
 	/*
 	 * Flush loop_configure() and loop_change_fd(). It is acceptable for
@@ -1121,15 +1152,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	destroy_workqueue(lo->workqueue);
-	spin_lock_irq(&lo->lo_work_lock);
-	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
-				idle_list) {
-		list_del(&worker->idle_list);
-		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->blkcg_css);
-		kfree(worker);
-	}
-	spin_unlock_irq(&lo->lo_work_lock);
+	loop_free_idle_workers(lo, true);
 	del_timer_sync(&lo->timer);
 
 	spin_lock_irq(&lo->lo_lock);
@@ -1887,11 +1910,6 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	}
 }
 
-static void loop_set_timer(struct loop_device *lo)
-{
-	timer_reduce(&lo->timer, jiffies + LOOP_IDLE_WORKER_TIMEOUT);
-}
-
 static void loop_process_work(struct loop_worker *worker,
 			struct list_head *cmd_list, struct loop_device *lo)
 {
@@ -1940,27 +1958,6 @@ static void loop_rootcg_workfn(struct work_struct *work)
 	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
 }
 
-static void loop_free_idle_workers(struct timer_list *timer)
-{
-	struct loop_device *lo = container_of(timer, struct loop_device, timer);
-	struct loop_worker *pos, *worker;
-
-	spin_lock_irq(&lo->lo_work_lock);
-	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
-				idle_list) {
-		if (time_is_after_jiffies(worker->last_ran_at +
-						LOOP_IDLE_WORKER_TIMEOUT))
-			break;
-		list_del(&worker->idle_list);
-		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->blkcg_css);
-		kfree(worker);
-	}
-	if (!list_empty(&lo->idle_worker_list))
-		loop_set_timer(lo);
-	spin_unlock_irq(&lo->lo_work_lock);
-}
-
 static const struct blk_mq_ops loop_mq_ops = {
 	.queue_rq       = loop_queue_rq,
 	.complete	= lo_complete_rq,
-- 
2.30.2

