Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
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
Subject: [RFC PATCH V2 03/17] block: rename QUEUE_FLAG_NO_SCHED as QUEUE_FLAG_ADMIN
Date: Sat, 11 Aug 2018 15:12:06 +0800
Message-Id: <20180811071220.357-4-ming.lei@redhat.com>
In-Reply-To: <20180811071220.357-1-ming.lei@redhat.com>
References: <20180811071220.357-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Now all users of QUEUE_FLAG_NO_SCHED is for admin queue only, and not
see any drivers need this flag for IO queue.

So rename it as QUEUE_FLAG_ADMIN, which looks more straightforward.

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
 block/elevator.c              | 2 +-
 drivers/block/null_blk_main.c | 2 +-
 drivers/nvme/host/fc.c        | 2 +-
 drivers/nvme/host/pci.c       | 2 +-
 drivers/nvme/host/rdma.c      | 2 +-
 drivers/nvme/target/loop.c    | 2 +-
 include/linux/blkdev.h        | 8 ++++----
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 246c9afb6f5d..8df013e9f242 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -133,7 +133,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(PREEMPT_ONLY),
-	QUEUE_FLAG_NAME(NO_SCHED),
+	QUEUE_FLAG_NAME(ADMIN),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 53ae14fc5f3e..5226fcf92cbe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2640,7 +2640,7 @@ struct request_queue *__blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
 
-	if (!blk_queue_no_sched(q)) {
+	if (!blk_queue_admin(q)) {
 		int ret;
 
 		ret = elevator_init_mq(q);
diff --git a/block/elevator.c b/block/elevator.c
index a34fecbe7e81..7438cf285907 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1108,7 +1108,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 
 static inline bool elv_support_iosched(struct request_queue *q)
 {
-	if (q->mq_ops && blk_queue_no_sched(q))
+	if (q->mq_ops && blk_queue_admin(q))
 		return false;
 	return true;
 }
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 5d9504e65725..9fb358007e43 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1702,7 +1702,7 @@ static int null_add_dev(struct nullb_device *dev)
 
 	if (dev->queue_mode == NULL_Q_MQ) {
 		unsigned long q_flags = g_no_sched ?
-			QUEUE_FLAG_MQ_NO_SCHED_DEFAULT : QUEUE_FLAG_MQ_DEFAULT;
+			QUEUE_FLAG_MQ_ADMIN_DEFAULT : QUEUE_FLAG_MQ_DEFAULT;
 
 		if (shared_tags) {
 			nullb->tag_set = &tag_set;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7048e1444210..a920d13c3538 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3041,7 +3041,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
 
 	ctrl->ctrl.admin_q = __blk_mq_init_queue(&ctrl->admin_tag_set,
-			QUEUE_FLAG_MQ_NO_SCHED_DEFAULT);
+			QUEUE_FLAG_MQ_ADMIN_DEFAULT);
 	if (IS_ERR(ctrl->ctrl.admin_q)) {
 		ret = PTR_ERR(ctrl->ctrl.admin_q);
 		goto out_free_admin_tag_set;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7aabd87d57e..ba1de5c44e83 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1491,7 +1491,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->ctrl.admin_tagset = &dev->admin_tagset;
 
 		dev->ctrl.admin_q = __blk_mq_init_queue(&dev->admin_tagset,
-				QUEUE_FLAG_MQ_NO_SCHED_DEFAULT);
+				QUEUE_FLAG_MQ_ADMIN_DEFAULT);
 		if (IS_ERR(dev->ctrl.admin_q)) {
 			blk_mq_free_tag_set(&dev->admin_tagset);
 			return -ENOMEM;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 447c6d5c55d5..b8efd4ab7a60 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -770,7 +770,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		}
 
 		ctrl->ctrl.admin_q = __blk_mq_init_queue(&ctrl->admin_tag_set,
-				QUEUE_FLAG_MQ_NO_SCHED_DEFAULT);
+				QUEUE_FLAG_MQ_ADMIN_DEFAULT);
 		if (IS_ERR(ctrl->ctrl.admin_q)) {
 			error = PTR_ERR(ctrl->ctrl.admin_q);
 			goto out_free_tagset;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index c689621c2187..8fca59e6b3c3 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -381,7 +381,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
 
 	ctrl->ctrl.admin_q = __blk_mq_init_queue(&ctrl->admin_tag_set,
-			QUEUE_FLAG_MQ_NO_SCHED_DEFAULT);
+			QUEUE_FLAG_MQ_ADMIN_DEFAULT);
 	if (IS_ERR(ctrl->ctrl.admin_q)) {
 		error = PTR_ERR(ctrl->ctrl.admin_q);
 		goto out_free_tagset;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a2b110ec422d..2dbc7524a169 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -699,7 +699,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
 #define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
-#define QUEUE_FLAG_NO_SCHED	30	/* no scheduler allowed */
+#define QUEUE_FLAG_ADMIN	30	/* admin queue */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -709,8 +709,8 @@ struct request_queue {
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
 				 (1 << QUEUE_FLAG_POLL))
 
-#define QUEUE_FLAG_MQ_NO_SCHED_DEFAULT	 (QUEUE_FLAG_MQ_DEFAULT |	\
-					  (1 << QUEUE_FLAG_NO_SCHED))
+#define QUEUE_FLAG_MQ_ADMIN_DEFAULT	 (QUEUE_FLAG_MQ_DEFAULT |	\
+					  (1 << QUEUE_FLAG_ADMIN))
 
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
@@ -743,7 +743,7 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_preempt_only(q)				\
 	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
-#define blk_queue_no_sched(q)	test_bit(QUEUE_FLAG_NO_SCHED, &(q)->queue_flags)
+#define blk_queue_admin(q)	test_bit(QUEUE_FLAG_ADMIN, &(q)->queue_flags)
 
 extern int blk_set_preempt_only(struct request_queue *q);
 extern void blk_clear_preempt_only(struct request_queue *q);
-- 
2.9.5
