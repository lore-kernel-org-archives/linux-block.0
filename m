Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6E9C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 02:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4231060F35
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 02:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbhHFCfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 22:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242500AbhHFCfd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Aug 2021 22:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628217318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SsP+ZmHnzBeh7NrDt4Jog1WJqfpH7N2C4lAmZhgbVNw=;
        b=ekH+p/0qHD/vL7YiH3NjnxwntV1xwn3Kz89+aaI8xpr5aen/xNEhbMMSBhbtb29lvPxHlm
        /tWu1bW88AU1X6IbQh4o82IK8o2sn7sDvD05FB700X/ekn0CTrhbXthnaj07fxIwXOPVEh
        2fZzRSm/WA4aCy5hfZz1L3CF08ravcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-I4KyquAnNW-DHSD4mPj05w-1; Thu, 05 Aug 2021 22:35:15 -0400
X-MC-Unique: I4KyquAnNW-DHSD4mPj05w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7FBEA0C0D;
        Fri,  6 Aug 2021 02:35:13 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73A585D6B1;
        Fri,  6 Aug 2021 02:35:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 6/7] loop: use xarray to store workers
Date:   Fri,  6 Aug 2021 10:34:22 +0800
Message-Id: <20210806023423.131060-7-ming.lei@redhat.com>
In-Reply-To: <20210806023423.131060-1-ming.lei@redhat.com>
References: <20210806023423.131060-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

css->id is unique in io controller wide, so replace rbtree with xarray
for querying/storing 'blkcg_css' by using css->id as key, then code is
simplified a lot.

Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 36 ++++++++++++++----------------------
 drivers/block/loop.h |  3 ++-
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c9a28483433b..fd07481058e5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -971,7 +971,6 @@ static void loop_config_discard(struct loop_device *lo)
 }
 
 struct loop_worker {
-	struct rb_node rb_node;
 	struct work_struct work;
 	struct list_head cmd_list;
 	struct list_head idle_list;
@@ -1019,35 +1018,23 @@ static struct cgroup_subsys_state *loop_rq_get_memcg_css(
 
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
-	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
-	struct loop_worker *cur_worker, *worker = NULL;
+	struct loop_worker *worker = NULL;
 	struct work_struct *work;
 	struct list_head *cmd_list;
 	struct cgroup_subsys_state *blkcg_css = loop_rq_blkcg_css(cmd);
+	gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
 
 	spin_lock(&lo->lo_work_lock);
 
 	if (queue_on_root_worker(blkcg_css))
 		goto queue_work;
 
-	node = &lo->worker_tree.rb_node;
-
-	while (*node) {
-		parent = *node;
-		cur_worker = container_of(*node, struct loop_worker, rb_node);
-		if (cur_worker->blkcg_css == blkcg_css) {
-			worker = cur_worker;
-			break;
-		} else if ((long)cur_worker->blkcg_css < (long)blkcg_css) {
-			node = &(*node)->rb_left;
-		} else {
-			node = &(*node)->rb_right;
-		}
-	}
+	/* css->id is unique in each cgroup subsystem */
+	worker = xa_load(&lo->workers, blkcg_css->id);
 	if (worker)
 		goto queue_work;
 
-	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
+	worker = kzalloc(sizeof(*worker), gfp);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
 	 * rootcg worker and issue the I/O as the rootcg
@@ -1061,8 +1048,12 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	INIT_LIST_HEAD(&worker->cmd_list);
 	INIT_LIST_HEAD(&worker->idle_list);
 	worker->lo = lo;
-	rb_link_node(&worker->rb_node, parent, node);
-	rb_insert_color(&worker->rb_node, &lo->worker_tree);
+
+	if (xa_err(xa_store(&lo->workers, blkcg_css->id, worker, gfp))) {
+		kfree(worker);
+		worker = NULL;
+	}
+
 queue_work:
 	if (worker) {
 		/*
@@ -1218,7 +1209,7 @@ static void __loop_free_idle_workers(struct loop_device *lo, bool force)
 						LOOP_IDLE_WORKER_TIMEOUT))
 			break;
 		list_del(&worker->idle_list);
-		rb_erase(&worker->rb_node, &lo->worker_tree);
+		xa_erase(&lo->workers, worker->blkcg_css->id);
 		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
@@ -1314,7 +1305,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	INIT_LIST_HEAD(&lo->idle_worker_list);
-	lo->worker_tree = RB_ROOT;
+	xa_init(&lo->workers);
 	INIT_DELAYED_WORK(&lo->idle_work, loop_free_idle_workers);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
@@ -1416,6 +1407,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	destroy_workqueue(lo->workqueue);
 	__loop_free_idle_workers(lo, true);
 	cancel_delayed_work_sync(&lo->idle_work);
+	xa_destroy(&lo->workers);
 
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_backing_file = NULL;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 9df889af1bcf..cab34da1e1bb 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -14,6 +14,7 @@
 #include <linux/blk-mq.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/xarray.h>
 #include <uapi/linux/loop.h>
 
 /* Possible states of device */
@@ -59,7 +60,7 @@ struct loop_device {
 	struct work_struct      rootcg_work;
 	struct list_head        rootcg_cmd_list;
 	struct list_head        idle_worker_list;
-	struct rb_root          worker_tree;
+	struct xarray		workers;
 	struct delayed_work	idle_work;
 	bool			use_dio;
 	bool			sysfs_inited;
-- 
2.31.1

