Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9933EC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 08:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E39611C9
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 08:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbhHFIES (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242111AbhHFIEN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Aug 2021 04:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628237036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKkkgyyJ9FlWswCcobhQDqjk2MzdbDCVzoEDmhlDUV8=;
        b=MalOg4sepHwgukKT+5I8waHXlKPmYWR0xGfaB2K3Kqrh/+NYDCLpj3HUiBARHvywvK1r28
        AcPUT47o88Kt3titQQF0CUc2mzyJILc7jLtRcwtd8cIVo2fQeYk/hYoKvPeXXoMgof5zwx
        LZ1hLOOrjic7rQE82u6Alfza2D0LKn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-r_s9X_ebM-aM__PChYrJpg-1; Fri, 06 Aug 2021 04:03:53 -0400
X-MC-Unique: r_s9X_ebM-aM__PChYrJpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDCCB107ACF5;
        Fri,  6 Aug 2021 08:03:51 +0000 (UTC)
Received: from localhost (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F43E1B5C0;
        Fri,  6 Aug 2021 08:03:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/7] loop: conver timer for monitoring idle worker into dwork
Date:   Fri,  6 Aug 2021 16:02:58 +0800
Message-Id: <20210806080302.298297-4-ming.lei@redhat.com>
In-Reply-To: <20210806080302.298297-1-ming.lei@redhat.com>
References: <20210806080302.298297-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not necessary to use a timer to do that, and dwork is just fine,
then we don't need to always disable interrupt when acquiring
->loop_work_lock.

Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 75 ++++++++++++++++++++++----------------------
 drivers/block/loop.h |  2 +-
 2 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0df2a6add598..6e65e46553f6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -982,7 +982,6 @@ struct loop_worker {
 
 static void loop_workfn(struct work_struct *work);
 static void loop_rootcg_workfn(struct work_struct *work);
-static void loop_free_idle_workers(struct timer_list *timer);
 
 #ifdef CONFIG_BLK_CGROUP
 static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
@@ -1026,7 +1025,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	struct list_head *cmd_list;
 	struct cgroup_subsys_state *blkcg_css = loop_rq_blkcg_css(cmd);
 
-	spin_lock_irq(&lo->lo_work_lock);
+	spin_lock(&lo->lo_work_lock);
 
 	if (queue_on_root_worker(blkcg_css))
 		goto queue_work;
@@ -1081,7 +1080,7 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	}
 	list_add_tail(&cmd->list_entry, cmd_list);
 	queue_work(lo->workqueue, work);
-	spin_unlock_irq(&lo->lo_work_lock);
+	spin_unlock(&lo->lo_work_lock);
 }
 
 static void loop_update_rotational(struct loop_device *lo)
@@ -1203,6 +1202,33 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
+static void loop_set_timer(struct loop_device *lo)
+{
+	schedule_delayed_work(&lo->idle_work, LOOP_IDLE_WORKER_TIMEOUT);
+}
+
+static void loop_free_idle_workers(struct work_struct *work)
+{
+	struct loop_device *lo = container_of(work, struct loop_device,
+			idle_work.work);
+	struct loop_worker *pos, *worker;
+
+	spin_lock(&lo->lo_work_lock);
+	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
+				idle_list) {
+		if (time_is_after_jiffies(worker->last_ran_at +
+						LOOP_IDLE_WORKER_TIMEOUT))
+			break;
+		list_del(&worker->idle_list);
+		rb_erase(&worker->rb_node, &lo->worker_tree);
+		css_put(worker->blkcg_css);
+		kfree(worker);
+	}
+	if (!list_empty(&lo->idle_worker_list))
+		loop_set_timer(lo);
+	spin_unlock(&lo->lo_work_lock);
+}
+
 static int loop_configure(struct loop_device *lo, fmode_t mode,
 			  struct block_device *bdev,
 			  const struct loop_config *config)
@@ -1283,8 +1309,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	INIT_LIST_HEAD(&lo->idle_worker_list);
 	lo->worker_tree = RB_ROOT;
-	timer_setup(&lo->timer, loop_free_idle_workers,
-		TIMER_DEFERRABLE);
+	INIT_DELAYED_WORK(&lo->idle_work, loop_free_idle_workers);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
 	lo->lo_backing_file = file;
@@ -1384,7 +1409,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	destroy_workqueue(lo->workqueue);
-	spin_lock_irq(&lo->lo_work_lock);
+	spin_lock(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
 		list_del(&worker->idle_list);
@@ -1392,8 +1417,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
-	spin_unlock_irq(&lo->lo_work_lock);
-	del_timer_sync(&lo->timer);
+	spin_unlock(&lo->lo_work_lock);
+	cancel_delayed_work_sync(&lo->idle_work);
 
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_backing_file = NULL;
@@ -2211,11 +2236,6 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
@@ -2223,17 +2243,17 @@ static void loop_process_work(struct loop_worker *worker,
 	struct loop_cmd *cmd;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
-	spin_lock_irq(&lo->lo_work_lock);
+	spin_lock(&lo->lo_work_lock);
 	while (!list_empty(cmd_list)) {
 		cmd = container_of(
 			cmd_list->next, struct loop_cmd, list_entry);
 		list_del(cmd_list->next);
-		spin_unlock_irq(&lo->lo_work_lock);
+		spin_unlock(&lo->lo_work_lock);
 
 		loop_handle_cmd(cmd);
 		cond_resched();
 
-		spin_lock_irq(&lo->lo_work_lock);
+		spin_lock(&lo->lo_work_lock);
 	}
 
 	/*
@@ -2246,7 +2266,7 @@ static void loop_process_work(struct loop_worker *worker,
 		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
 		loop_set_timer(lo);
 	}
-	spin_unlock_irq(&lo->lo_work_lock);
+	spin_unlock(&lo->lo_work_lock);
 	current->flags = orig_flags;
 }
 
@@ -2278,27 +2298,6 @@ static void loop_rootcg_workfn(struct work_struct *work)
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
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index a52a3fd89457..9df889af1bcf 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -60,7 +60,7 @@ struct loop_device {
 	struct list_head        rootcg_cmd_list;
 	struct list_head        idle_worker_list;
 	struct rb_root          worker_tree;
-	struct timer_list       timer;
+	struct delayed_work	idle_work;
 	bool			use_dio;
 	bool			sysfs_inited;
 
-- 
2.31.1

