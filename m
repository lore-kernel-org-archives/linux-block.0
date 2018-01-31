Return-Path: <prvs=562a2f801=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] block: Add a third argument to blk_alloc_queue_node()
Date: Wed, 31 Jan 2018 15:52:59 -0800
Message-Id: <20180131235300.12773-2-bart.vanassche@wdc.com>
In-Reply-To: <20180131235300.12773-1-bart.vanassche@wdc.com>
References: <20180131235300.12773-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: <stable@vger.kernel.org>
---
 block/blk-core.c              | 7 ++++---
 block/blk-mq.c                | 2 +-
 drivers/block/null_blk.c      | 3 ++-
 drivers/ide/ide-probe.c       | 2 +-
 drivers/lightnvm/core.c       | 2 +-
 drivers/md/dm.c               | 2 +-
 drivers/nvdimm/pmem.c         | 2 +-
 drivers/nvme/host/multipath.c | 2 +-
 drivers/scsi/scsi_lib.c       | 2 +-
 include/linux/blkdev.h        | 3 ++-
 10 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bd43bc50740a..860a039fd1a8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -868,7 +868,7 @@ void blk_exit_rl(struct request_queue *q, struct request_list *rl)
 
 struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 {
-	return blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE);
+	return blk_alloc_queue_node(gfp_mask, NUMA_NO_NODE, NULL);
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
@@ -946,7 +946,8 @@ static void blk_rq_timed_out_timer(struct timer_list *t)
 	kblockd_schedule_work(&q->timeout_work);
 }
 
-struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
+struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
+					   spinlock_t *lock)
 {
 	struct request_queue *q;
 
@@ -1088,7 +1089,7 @@ blk_init_queue_node(request_fn_proc *rfn, spinlock_t *lock, int node_id)
 {
 	struct request_queue *q;
 
-	q = blk_alloc_queue_node(GFP_KERNEL, node_id);
+	q = blk_alloc_queue_node(GFP_KERNEL, node_id, NULL);
 	if (!q)
 		return NULL;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aacc5280e25f..8191391d1a1d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2554,7 +2554,7 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 {
 	struct request_queue *uninit_q, *q;
 
-	uninit_q = blk_alloc_queue_node(GFP_KERNEL, set->numa_node);
+	uninit_q = blk_alloc_queue_node(GFP_KERNEL, set->numa_node, NULL);
 	if (!uninit_q)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index aa1c7d4bcac5..9fe8f2a3ec45 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -1717,7 +1717,8 @@ static int null_add_dev(struct nullb_device *dev)
 		}
 		null_init_queues(nullb);
 	} else if (dev->queue_mode == NULL_Q_BIO) {
-		nullb->q = blk_alloc_queue_node(GFP_KERNEL, dev->home_node);
+		nullb->q = blk_alloc_queue_node(GFP_KERNEL, dev->home_node,
+						NULL);
 		if (!nullb->q) {
 			rv = -ENOMEM;
 			goto out_cleanup_queues;
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 70d6d8ff0fd9..1303d0e31e80 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -766,7 +766,7 @@ static int ide_init_queue(ide_drive_t *drive)
 	 *	limits and LBA48 we could raise it but as yet
 	 *	do not.
 	 */
-	q = blk_alloc_queue_node(GFP_KERNEL, hwif_to_node(hwif));
+	q = blk_alloc_queue_node(GFP_KERNEL, hwif_to_node(hwif), NULL);
 	if (!q)
 		return 1;
 
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index dcc9e621e651..5f1988df1593 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -384,7 +384,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		goto err_dev;
 	}
 
-	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
+	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node, NULL);
 	if (!tqueue) {
 		ret = -ENOMEM;
 		goto err_disk;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 5c478c185041..93f3ef15b4b2 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1731,7 +1731,7 @@ static struct mapped_device *alloc_dev(int minor)
 	INIT_LIST_HEAD(&md->table_devices);
 	spin_lock_init(&md->uevent_lock);
 
-	md->queue = blk_alloc_queue_node(GFP_KERNEL, numa_node_id);
+	md->queue = blk_alloc_queue_node(GFP_KERNEL, numa_node_id, NULL);
 	if (!md->queue)
 		goto bad;
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 49285701fe48..118b4b13592d 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -342,7 +342,7 @@ static int pmem_attach_disk(struct device *dev,
 		return -EBUSY;
 	}
 
-	q = blk_alloc_queue_node(GFP_KERNEL, dev_to_node(dev));
+	q = blk_alloc_queue_node(GFP_KERNEL, dev_to_node(dev), NULL);
 	if (!q)
 		return -ENOMEM;
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 605f53376e94..4e362949721a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -162,7 +162,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
 		return 0;
 
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
 	if (!q)
 		goto out;
 	q->queuedata = head;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3fcf5c7c7917..799d02615e71 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2206,7 +2206,7 @@ struct request_queue *scsi_old_alloc_queue(struct scsi_device *sdev)
 	struct Scsi_Host *shost = sdev->host;
 	struct request_queue *q;
 
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE);
+	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
 	if (!q)
 		return NULL;
 	q->cmd_size = sizeof(struct scsi_cmnd) + shost->hostt->cmd_size;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 781992c4124e..f1f3ad6419f1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1330,7 +1330,8 @@ extern long nr_blockdev_pages(void);
 
 bool __must_check blk_get_queue(struct request_queue *);
 struct request_queue *blk_alloc_queue(gfp_t);
-struct request_queue *blk_alloc_queue_node(gfp_t, int);
+struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
+					   spinlock_t *lock);
 extern void blk_put_queue(struct request_queue *);
 extern void blk_set_queue_dying(struct request_queue *);
 
-- 
2.16.0
