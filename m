Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH V3 02/17] blk-mq: convert BLK_MQ_F_NO_SCHED into per-queue flag
Date: Thu, 13 Sep 2018 20:15:31 +0800
Message-Id: <20180913121546.5710-3-ming.lei@redhat.com>
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
References: <20180913121546.5710-1-ming.lei@redhat.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

We need to support admin queue for scsi host, and not like NVMe,
this support is only from logic view, and the admin queue still has
to share same tags with IO queues.

Convert BLK_MQ_F_NO_SCHED into per-queue flag so that we can support
admin queue for SCSI.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c        | 2 +-
 block/blk-mq.c                | 2 +-
 block/elevator.c              | 3 +--
 drivers/block/null_blk_main.c | 7 ++++---
 drivers/nvme/host/fc.c        | 4 ++--
 drivers/nvme/host/pci.c       | 4 ++--
 drivers/nvme/host/rdma.c      | 4 ++--
 drivers/nvme/target/loop.c    | 4 ++--
 include/linux/blk-mq.h        | 1 -
 include/linux/blkdev.h        | 5 +++++
 10 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cb1e6cf7ac48..246c9afb6f5d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -133,6 +133,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(PREEMPT_ONLY),
+	QUEUE_FLAG_NAME(NO_SCHED),
 };
 #undef QUEUE_FLAG_NAME
 
@@ -246,7 +247,6 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(TAG_SHARED),
 	HCTX_FLAG_NAME(SG_MERGE),
 	HCTX_FLAG_NAME(BLOCKING),
-	HCTX_FLAG_NAME(NO_SCHED),
 };
 #undef HCTX_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d524efc5d1bc..5b56ed306cd9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2633,7 +2633,7 @@ struct request_queue *__blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
 
-	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
+	if (!blk_queue_no_sched(q)) {
 		int ret;
 
 		ret = elevator_init_mq(q);
diff --git a/block/elevator.c b/block/elevator.c
index 6a06b5d040e5..8fb8754222fa 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1111,8 +1111,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 
 static inline bool elv_support_iosched(struct request_queue *q)
 {
-	if (q->mq_ops && q->tag_set && (q->tag_set->flags &
-				BLK_MQ_F_NO_SCHED))
+	if (q->mq_ops && blk_queue_no_sched(q))
 		return false;
 	return true;
 }
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 6127e3ff7b4b..5d9504e65725 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1617,8 +1617,6 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;
 	set->cmd_size	= sizeof(struct nullb_cmd);
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	if (g_no_sched)
-		set->flags |= BLK_MQ_F_NO_SCHED;
 	set->driver_data = NULL;
 
 	if ((nullb && nullb->dev->blocking) || g_blocking)
@@ -1703,6 +1701,9 @@ static int null_add_dev(struct nullb_device *dev)
 		goto out_free_nullb;
 
 	if (dev->queue_mode == NULL_Q_MQ) {
+		unsigned long q_flags = g_no_sched ?
+			QUEUE_FLAG_MQ_NO_SCHED_DEFAULT : QUEUE_FLAG_MQ_DEFAULT;
+
 		if (shared_tags) {
 			nullb->tag_set = &tag_set;
 			rv = 0;
@@ -1718,7 +1719,7 @@ static int null_add_dev(struct nullb_device *dev)
 			goto out_cleanup_queues;
 
 		nullb->tag_set->timeout = 5 * HZ;
-		nullb->q = blk_mq_init_queue(nullb->tag_set);
+		nullb->q = __blk_mq_init_queue(nullb->tag_set, q_flags);
 		if (IS_ERR(nullb->q)) {
 			rv = -ENOMEM;
 			goto out_cleanup_tags;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 611e70cae754..7048e1444210 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3034,14 +3034,14 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->admin_tag_set.driver_data = ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
 	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
-	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ret = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
 	if (ret)
 		goto out_free_queues;
 	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
 
-	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+	ctrl->ctrl.admin_q = __blk_mq_init_queue(&ctrl->admin_tag_set,
+			QUEUE_FLAG_MQ_NO_SCHED_DEFAULT);
 	if (IS_ERR(ctrl->ctrl.admin_q)) {
 		ret = PTR_ERR(ctrl->ctrl.admin_q);
 		goto out_free_admin_tag_set;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682f91df..73a3bd980fc9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1492,14 +1492,14 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_pci_cmd_size(dev, false);
-		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
 		dev->admin_tagset.driver_data = dev;
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
 			return -ENOMEM;
 		dev->ctrl.admin_tagset = &dev->admin_tagset;
 
-		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
+		dev->ctrl.admin_q = __blk_mq_init_queue(&dev->admin_tagset,
+				QUEUE_FLAG_MQ_NO_SCHED_DEFAULT);
 		if (IS_ERR(dev->ctrl.admin_q)) {
 			blk_mq_free_tag_set(&dev->admin_tagset);
 			return -ENOMEM;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dc042017c293..d61c057c0a71 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -692,7 +692,6 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
 		set->timeout = ADMIN_TIMEOUT;
-		set->flags = BLK_MQ_F_NO_SCHED;
 	} else {
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
@@ -770,7 +769,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 			goto out_free_async_qe;
 		}
 
-		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+		ctrl->ctrl.admin_q = __blk_mq_init_queue(&ctrl->admin_tag_set,
+				QUEUE_FLAG_MQ_NO_SCHED_DEFAULT);
 		if (IS_ERR(ctrl->ctrl.admin_q)) {
 			error = PTR_ERR(ctrl->ctrl.admin_q);
 			goto out_free_tagset;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9908082b32c4..c689621c2187 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -368,7 +368,6 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->admin_tag_set.driver_data = ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
 	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
-	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ctrl->queues[0].ctrl = ctrl;
 	error = nvmet_sq_init(&ctrl->queues[0].nvme_sq);
@@ -381,7 +380,8 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 		goto out_free_sq;
 	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
 
-	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+	ctrl->ctrl.admin_q = __blk_mq_init_queue(&ctrl->admin_tag_set,
+			QUEUE_FLAG_MQ_NO_SCHED_DEFAULT);
 	if (IS_ERR(ctrl->ctrl.admin_q)) {
 		error = PTR_ERR(ctrl->ctrl.admin_q);
 		goto out_free_tagset;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7f6ecd7b35ce..afde18ac5b31 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -181,7 +181,6 @@ enum {
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
-	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0e2b64..a2b110ec422d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -699,6 +699,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
 #define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
+#define QUEUE_FLAG_NO_SCHED	30	/* no scheduler allowed */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -708,6 +709,9 @@ struct request_queue {
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
 				 (1 << QUEUE_FLAG_POLL))
 
+#define QUEUE_FLAG_MQ_NO_SCHED_DEFAULT	 (QUEUE_FLAG_MQ_DEFAULT |	\
+					  (1 << QUEUE_FLAG_NO_SCHED))
+
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
@@ -739,6 +743,7 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_preempt_only(q)				\
 	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
+#define blk_queue_no_sched(q)	test_bit(QUEUE_FLAG_NO_SCHED, &(q)->queue_flags)
 
 extern int blk_set_preempt_only(struct request_queue *q);
 extern void blk_clear_preempt_only(struct request_queue *q);
-- 
2.9.5
