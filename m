Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34767 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbdBVKOW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 05:14:22 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@osandov.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 1/4] blk-mq: initialize mq kobjects in blk_mq_init_allocated_queue()
Date: Wed, 22 Feb 2017 18:13:59 +0800
Message-Id: <1487758442-5855-2-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
References: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Both q->mq_kobj and sw queues' kobjects should have been initialized
once, instead of doing that each add_disk context.

Also this patch removes clearing of ctx in blk_mq_init_cpu_queues()
because percpu allocator fills zero to allocated variable.

This patch fixes one issue[1] reported from Omar.

[1] kernel wearning when doing unbind/bind on one scsi-mq device

[   19.347924] kobject (ffff8800791ea0b8): tried to init an initialized object, something is seriously wrong.
[   19.349781] CPU: 1 PID: 84 Comm: kworker/u8:1 Not tainted 4.10.0-rc7-00210-g53f39eeaa263 #34
[   19.350686] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.1-20161122_114906-anatol 04/01/2014
[   19.350920] Workqueue: events_unbound async_run_entry_fn
[   19.350920] Call Trace:
[   19.350920]  dump_stack+0x63/0x83
[   19.350920]  kobject_init+0x77/0x90
[   19.350920]  blk_mq_register_dev+0x40/0x130
[   19.350920]  blk_register_queue+0xb6/0x190
[   19.350920]  device_add_disk+0x1ec/0x4b0
[   19.350920]  sd_probe_async+0x10d/0x1c0 [sd_mod]
[   19.350920]  async_run_entry_fn+0x48/0x150
[   19.350920]  process_one_work+0x1d0/0x480
[   19.350920]  worker_thread+0x48/0x4e0
[   19.350920]  kthread+0x101/0x140
[   19.350920]  ? process_one_work+0x480/0x480
[   19.350920]  ? kthread_create_on_node+0x60/0x60
[   19.350920]  ret_from_fork+0x2c/0x40

Cc: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-mq-sysfs.c | 4 +---
 block/blk-mq.c       | 4 +++-
 block/blk-mq.h       | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 295e69670c39..124305407c80 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -277,7 +277,7 @@ void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
 	kobject_init(&hctx->kobj, &blk_mq_hw_ktype);
 }
 
-static void blk_mq_sysfs_init(struct request_queue *q)
+void blk_mq_sysfs_init(struct request_queue *q)
 {
 	struct blk_mq_ctx *ctx;
 	int cpu;
@@ -297,8 +297,6 @@ int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	blk_mq_disable_hotplug();
 
-	blk_mq_sysfs_init(q);
-
 	ret = kobject_add(&q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
 	if (ret < 0)
 		goto out;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b29e7dc7b309..ade1d7cde37e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1941,7 +1941,6 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		struct blk_mq_ctx *__ctx = per_cpu_ptr(q->queue_ctx, i);
 		struct blk_mq_hw_ctx *hctx;
 
-		memset(__ctx, 0, sizeof(*__ctx));
 		__ctx->cpu = i;
 		spin_lock_init(&__ctx->lock);
 		INIT_LIST_HEAD(&__ctx->rq_list);
@@ -2248,6 +2247,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_ctx)
 		goto err_exit;
 
+	/* init q->mq_kobj and sw queues' kobjects */
+	blk_mq_sysfs_init(q);
+
 	q->queue_hw_ctx = kzalloc_node(nr_cpu_ids * sizeof(*(q->queue_hw_ctx)),
 						GFP_KERNEL, set->numa_node);
 	if (!q->queue_hw_ctx)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 24b2256186f3..445343425f6d 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -77,6 +77,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 /*
  * sysfs helpers
  */
+extern void blk_mq_sysfs_init(struct request_queue *q);
 extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
-- 
2.7.4
