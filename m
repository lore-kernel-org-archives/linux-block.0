Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 3/3] block: kill BLK_MQ_F_SG_MERGE
Date: Tue, 31 Jul 2018 18:49:14 +0800
Message-Id: <20180731104914.17249-4-ming.lei@redhat.com>
In-Reply-To: <20180731104914.17249-1-ming.lei@redhat.com>
References: <20180731104914.17249-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

QUEUE_FLAG_NO_SG_MERGE has been killed, so kill BLK_MQ_F_SG_MERGE too.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c       | 1 -
 drivers/block/loop.c         | 2 +-
 drivers/block/nbd.c          | 2 +-
 drivers/block/rbd.c          | 2 +-
 drivers/block/skd_main.c     | 1 -
 drivers/block/xen-blkfront.c | 2 +-
 drivers/md/dm-rq.c           | 2 +-
 drivers/mmc/core/queue.c     | 3 +--
 drivers/scsi/scsi_lib.c      | 2 +-
 include/linux/blk-mq.h       | 1 -
 10 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index e590f9495d25..cf1b83b4b737 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -243,7 +243,6 @@ static const char *const alloc_policy_name[] = {
 static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(SHOULD_MERGE),
 	HCTX_FLAG_NAME(TAG_SHARED),
-	HCTX_FLAG_NAME(SG_MERGE),
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(NO_SCHED),
 };
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ea9debf59b22..50769942f38e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1846,7 +1846,7 @@ static int loop_add(struct loop_device **l, int i)
 	lo->tag_set.queue_depth = 128;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 74a05561b620..71a66894b941 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1506,7 +1506,7 @@ static int nbd_dev_add(int index)
 	nbd->tag_set.numa_node = NUMA_NO_NODE;
 	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
 	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
-		BLK_MQ_F_SG_MERGE | BLK_MQ_F_BLOCKING;
+		BLK_MQ_F_BLOCKING;
 	nbd->tag_set.driver_data = nbd;
 
 	err = blk_mq_alloc_tag_set(&nbd->tag_set);
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fa0729c1e776..0bd0b2e7db75 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3964,7 +3964,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	rbd_dev->tag_set.ops = &rbd_mq_ops;
 	rbd_dev->tag_set.queue_depth = rbd_dev->opts->queue_depth;
 	rbd_dev->tag_set.numa_node = NUMA_NO_NODE;
-	rbd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	rbd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	rbd_dev->tag_set.nr_hw_queues = 1;
 	rbd_dev->tag_set.cmd_size = sizeof(struct work_struct);
 
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 87b9e7fbf062..91ba954fcbd3 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2834,7 +2834,6 @@ static int skd_cons_disk(struct skd_device *skdev)
 		skdev->sgs_per_request * sizeof(struct scatterlist);
 	skdev->tag_set.numa_node = NUMA_NO_NODE;
 	skdev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
-		BLK_MQ_F_SG_MERGE |
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(BLK_TAG_ALLOC_FIFO);
 	skdev->tag_set.driver_data = skdev;
 	rc = blk_mq_alloc_tag_set(&skdev->tag_set);
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 94300dbe358b..e0723c63fe6a 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -973,7 +973,7 @@ static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
 	} else
 		info->tag_set.queue_depth = BLK_RING_SIZE(info);
 	info->tag_set.numa_node = NUMA_NO_NODE;
-	info->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	info->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	info->tag_set.cmd_size = sizeof(struct blkif_req);
 	info->tag_set.driver_data = info;
 
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 6e547b8dd298..5d45adb81d0e 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -802,7 +802,7 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
 	md->tag_set->ops = &dm_mq_ops;
 	md->tag_set->queue_depth = dm_get_blk_mq_queue_depth();
 	md->tag_set->numa_node = md->numa_node_id;
-	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
 	md->tag_set->nr_hw_queues = dm_get_blk_mq_nr_hw_queues();
 	md->tag_set->driver_data = md;
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 648eb6743ed5..b38ef099e19f 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -385,8 +385,7 @@ static int mmc_mq_init_queue(struct mmc_queue *mq, int q_depth,
 	mq->tag_set.ops = mq_ops;
 	mq->tag_set.queue_depth = q_depth;
 	mq->tag_set.numa_node = NUMA_NO_NODE;
-	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE |
-			    BLK_MQ_F_BLOCKING;
+	mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
 	mq->tag_set.nr_hw_queues = 1;
 	mq->tag_set.cmd_size = sizeof(struct mmc_queue_req);
 	mq->tag_set.driver_data = mq;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 41e9ac9fc138..0759ead2683d 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2306,7 +2306,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	shost->tag_set.queue_depth = shost->can_queue;
 	shost->tag_set.cmd_size = cmd_size;
 	shost->tag_set.numa_node = NUMA_NO_NODE;
-	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	shost->tag_set.flags |=
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 	shost->tag_set.driver_data = shost;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d710e92874cc..98f3b239c561 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -179,7 +179,6 @@ struct blk_mq_ops {
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
-	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
-- 
2.9.5
