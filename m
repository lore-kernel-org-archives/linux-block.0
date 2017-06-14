Return-Path: <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v2 1/6] block: Avoid that blk_exit_rl() triggers a
 use-after-free
To: Ross Zwisler <zwisler@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Jan Kara <jack@suse.cz>, <stable@vger.kernel.org>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
 <20170531214350.31157-2-bart.vanassche@sandisk.com>
 <CAOxpaSVwuO6kRQN4aNELVTzfWbJORUNZh=E5xBRgvuC0wajptA@mail.gmail.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <3eef2937-86bc-958a-99b5-96a67836d3d3@sandisk.com>
Date: Wed, 14 Jun 2017 08:19:14 -0700
MIME-Version: 1.0
In-Reply-To: <CAOxpaSVwuO6kRQN4aNELVTzfWbJORUNZh=E5xBRgvuC0wajptA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 06/13/17 10:54, Ross Zwisler wrote:
> This commit is causing the following kernel BUG for me when I shut
> down my systems:
> 
>   BUG: sleeping function called from invalid context at kernel/workqueue.c:2790
>   in_atomic(): 1, irqs_disabled(): 0, pid: 41, name: rcuop/3

Thanks Ross for the testing and for the report. Can you check whether
the patch below is sufficient to fix this?


Subject: [PATCH] block: Fix a blk_exit_rl() regression

Avoid that the following complaint is reported:

 BUG: sleeping function called from invalid context at kernel/workqueue.c:2790
 in_atomic(): 1, irqs_disabled(): 0, pid: 41, name: rcuop/3
 1 lock held by rcuop/3/41:
  #0:  (rcu_callback){......}, at: [<ffffffff8111f9a2>] rcu_nocb_kthread+0x282/0x500
 Call Trace:
  dump_stack+0x86/0xcf
  ___might_sleep+0x174/0x260
  __might_sleep+0x4a/0x80
  flush_work+0x7e/0x2e0
  __cancel_work_timer+0x143/0x1c0
  cancel_work_sync+0x10/0x20
  blk_throtl_exit+0x25/0x60
  blkcg_exit_queue+0x35/0x40
  blk_release_queue+0x42/0x130
  kobject_put+0xa9/0x190

Reported-by: Ross Zwisler <zwisler@gmail.com>
Fixes: commit b425e5049258 ("block: Avoid that blk_exit_rl() triggers a use-after-free")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Ross Zwisler <zwisler@gmail.com>
---
 block/blk-sysfs.c      | 34 ++++++++++++++++++++++------------
 include/linux/blkdev.h |  2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 283da7fbe034..27aceab1cc31 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -777,24 +777,25 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 }
 
 /**
- * blk_release_queue: - release a &struct request_queue when it is no longer needed
- * @kobj:    the kobj belonging to the request queue to be released
+ * __blk_release_queue - release a request queue when it is no longer needed
+ * @work: pointer to the release_work member of the request queue to be released
  *
  * Description:
- *     blk_release_queue is the pair to blk_init_queue() or
- *     blk_queue_make_request().  It should be called when a request queue is
- *     being released; typically when a block device is being de-registered.
- *     Currently, its primary task it to free all the &struct request
- *     structures that were allocated to the queue and the queue itself.
+ *     blk_release_queue is the counterpart of blk_init_queue(). It should be
+ *     called when a request queue is being released; typically when a block
+ *     device is being de-registered. Its primary task it to free the queue
+ *     itself.
  *
- * Note:
+ * Notes:
  *     The low level driver must have finished any outstanding requests first
  *     via blk_cleanup_queue().
- **/
-static void blk_release_queue(struct kobject *kobj)
+ *
+ *     Although blk_release_queue() may be called with preemption disabled,
+ *     __blk_release_queue() may sleep.
+ */
+static void __blk_release_queue(struct work_struct *work)
 {
-	struct request_queue *q =
-		container_of(kobj, struct request_queue, kobj);
+	struct request_queue *q = container_of(work, typeof(*q), release_work);
 
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
@@ -834,6 +835,15 @@ static void blk_release_queue(struct kobject *kobj)
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
+static void blk_release_queue(struct kobject *kobj)
+{
+	struct request_queue *q =
+		container_of(kobj, struct request_queue, kobj);
+
+	INIT_WORK(&q->release_work, __blk_release_queue);
+	schedule_work(&q->release_work);
+}
+
 static const struct sysfs_ops queue_sysfs_ops = {
 	.show	= queue_attr_show,
 	.store	= queue_attr_store,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cc75407881e4..07a26414fdfc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -590,6 +590,8 @@ struct request_queue {
 
 	size_t			cmd_size;
 	void			*rq_alloc_data;
+
+	struct work_struct	release_work;
 };
 
 #define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
-- 
2.12.2
