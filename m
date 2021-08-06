Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C1CC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 08:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D340C61181
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 08:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhHFIEh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243277AbhHFIE2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Aug 2021 04:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628237052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJ/287+cz7FbkrHzW9Ru00SXMahzC2apWvaMtTMs7jE=;
        b=dGGr4KFlVxRGAxN5oN7TKiwtIUG9QHmGwGoi1+Or8hJE9JilojaH7/lVGSNzfuhQrodL34
        YJw3CIR9p5dbKDj9x7OgAAWEU9Ifwr7c+P579U6DWyvqqCD9LQtnrQCJFTXFQCcNIVwm4S
        ggup5kJOv28nfkLd857alxwASk7KPsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-C70LbvYtNf6N1RFzsUqlmg-1; Fri, 06 Aug 2021 04:04:11 -0400
X-MC-Unique: C70LbvYtNf6N1RFzsUqlmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2680C801AEB;
        Fri,  6 Aug 2021 08:04:10 +0000 (UTC)
Received: from localhost (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC3735D6A1;
        Fri,  6 Aug 2021 08:04:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 6/7] loop: use xarray to store workers
Date:   Fri,  6 Aug 2021 16:03:01 +0800
Message-Id: <20210806080302.298297-7-ming.lei@redhat.com>
In-Reply-To: <20210806080302.298297-1-ming.lei@redhat.com>
References: <20210806080302.298297-1-ming.lei@redhat.com>
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
 drivers/block/loop.c | 45 ++++++++++++++++++++++----------------------
 drivers/block/loop.h |  3 ++-
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c322d6468ee7..f77fa9e5eb49 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -971,7 +971,6 @@ static void loop_config_discard(struct loop_device *lo)
 }
 
 struct loop_worker {
-	struct rb_node rb_node;
 	struct work_struct work;
 	struct list_head cmd_list;
 	struct list_head idle_list;
@@ -998,6 +997,10 @@ static struct cgroup_subsys_state *loop_rq_blkcg_css(struct loop_cmd *cmd)
 		return &blkcg->css;
 	return NULL;
 }
+static int loop_blkcg_css_id(struct cgroup_subsys_state *css)
+{
+	return css->id;
+}
 #else
 static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 {
@@ -1007,6 +1010,10 @@ static struct cgroup_subsys_state *loop_rq_blkcg_css(struct loop_cmd *cmd)
 {
 	return NULL;
 }
+static int loop_blkcg_css_id(struct cgroup_subsys_state *css)
+{
+	return 0;
+}
 #endif
 
 static struct cgroup_subsys_state *loop_rq_get_memcg_css(
@@ -1019,35 +1026,23 @@ static struct cgroup_subsys_state *loop_rq_get_memcg_css(
 
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
+	worker = xa_load(&lo->workers, loop_blkcg_css_id(blkcg_css));
 	if (worker)
 		goto queue_work;
 
-	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
+	worker = kzalloc(sizeof(*worker), gfp);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
 	 * rootcg worker and issue the I/O as the rootcg
@@ -1061,8 +1056,13 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	INIT_LIST_HEAD(&worker->cmd_list);
 	INIT_LIST_HEAD(&worker->idle_list);
 	worker->lo = lo;
-	rb_link_node(&worker->rb_node, parent, node);
-	rb_insert_color(&worker->rb_node, &lo->worker_tree);
+
+	if (xa_err(xa_store(&lo->workers, loop_blkcg_css_id(blkcg_css),
+			    worker, gfp))) {
+		kfree(worker);
+		worker = NULL;
+	}
+
 queue_work:
 	if (worker) {
 		/*
@@ -1218,7 +1218,7 @@ static void __loop_free_idle_workers(struct loop_device *lo, bool force)
 						LOOP_IDLE_WORKER_TIMEOUT))
 			break;
 		list_del(&worker->idle_list);
-		rb_erase(&worker->rb_node, &lo->worker_tree);
+		xa_erase(&lo->workers, loop_blkcg_css_id(worker->blkcg_css));
 		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
@@ -1314,7 +1314,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	INIT_LIST_HEAD(&lo->idle_worker_list);
-	lo->worker_tree = RB_ROOT;
+	xa_init(&lo->workers);
 	INIT_DELAYED_WORK(&lo->idle_work, loop_free_idle_workers);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
@@ -1416,6 +1416,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
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

