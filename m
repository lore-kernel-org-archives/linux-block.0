Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 04/12] blk-mq: Make blk_mq_reinit_tagset() calls easier to read
Date: Thu, 17 Aug 2017 16:23:03 -0700
Message-Id: <20170817232311.25948-5-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since blk_mq_ops.reinit_request is only called from inside
blk_mq_reinit_tagset(), make this function pointer an argument of
blk_mq_reinit_tagset() instead of a member of struct blk_mq_ops.
This patch does not change any functionality but makes
blk_mq_reinit_tagset() calls easier to read and to analyze.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq-tag.c       |  9 +++++----
 drivers/nvme/host/fc.c   |  4 +---
 drivers/nvme/host/rdma.c | 11 ++++++-----
 include/linux/blk-mq.h   |  5 ++---
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index dc9e6dac5a2a..6714507aa6c7 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -298,11 +298,12 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
-int blk_mq_reinit_tagset(struct blk_mq_tag_set *set)
+int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
+			 int (reinit_request)(void *, struct request *))
 {
 	int i, j, ret = 0;
 
-	if (!set->ops->reinit_request)
+	if (WARN_ON_ONCE(!reinit_request))
 		goto out;
 
 	for (i = 0; i < set->nr_hw_queues; i++) {
@@ -315,8 +316,8 @@ int blk_mq_reinit_tagset(struct blk_mq_tag_set *set)
 			if (!tags->static_rqs[j])
 				continue;
 
-			ret = set->ops->reinit_request(set->driver_data,
-						tags->static_rqs[j]);
+			ret = reinit_request(set->driver_data,
+					     tags->static_rqs[j]);
 			if (ret)
 				goto out;
 		}
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5c2a08ef08ba..1438be649866 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2168,7 +2168,6 @@ static const struct blk_mq_ops nvme_fc_mq_ops = {
 	.complete	= nvme_fc_complete_rq,
 	.init_request	= nvme_fc_init_request,
 	.exit_request	= nvme_fc_exit_request,
-	.reinit_request	= nvme_fc_reinit_request,
 	.init_hctx	= nvme_fc_init_hctx,
 	.poll		= nvme_fc_poll,
 	.timeout	= nvme_fc_timeout,
@@ -2269,7 +2268,7 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 
 	nvme_fc_init_io_queues(ctrl);
 
-	ret = blk_mq_reinit_tagset(&ctrl->tag_set);
+	ret = blk_mq_reinit_tagset(&ctrl->tag_set, nvme_fc_reinit_request);
 	if (ret)
 		goto out_free_io_queues;
 
@@ -2655,7 +2654,6 @@ static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
 	.complete	= nvme_fc_complete_rq,
 	.init_request	= nvme_fc_init_request,
 	.exit_request	= nvme_fc_exit_request,
-	.reinit_request	= nvme_fc_reinit_request,
 	.init_hctx	= nvme_fc_init_admin_hctx,
 	.timeout	= nvme_fc_timeout,
 };
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index da04df1af231..9ff0eb3a625e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -704,14 +704,16 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_rdma_free_io_queues(ctrl);
 
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
+		ret = blk_mq_reinit_tagset(&ctrl->tag_set,
+					   nvme_rdma_reinit_request);
 		if (ret)
 			goto requeue;
 	}
 
 	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
 
-	ret = blk_mq_reinit_tagset(&ctrl->admin_tag_set);
+	ret = blk_mq_reinit_tagset(&ctrl->admin_tag_set,
+				   nvme_rdma_reinit_request);
 	if (ret)
 		goto requeue;
 
@@ -1503,7 +1505,6 @@ static const struct blk_mq_ops nvme_rdma_mq_ops = {
 	.complete	= nvme_rdma_complete_rq,
 	.init_request	= nvme_rdma_init_request,
 	.exit_request	= nvme_rdma_exit_request,
-	.reinit_request	= nvme_rdma_reinit_request,
 	.init_hctx	= nvme_rdma_init_hctx,
 	.poll		= nvme_rdma_poll,
 	.timeout	= nvme_rdma_timeout,
@@ -1514,7 +1515,6 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.complete	= nvme_rdma_complete_rq,
 	.init_request	= nvme_rdma_init_request,
 	.exit_request	= nvme_rdma_exit_request,
-	.reinit_request	= nvme_rdma_reinit_request,
 	.init_hctx	= nvme_rdma_init_admin_hctx,
 	.timeout	= nvme_rdma_timeout,
 };
@@ -1712,7 +1712,8 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	}
 
 	if (ctrl->ctrl.queue_count > 1) {
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
+		ret = blk_mq_reinit_tagset(&ctrl->tag_set,
+					   nvme_rdma_reinit_request);
 		if (ret)
 			goto del_dead_ctrl;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 14542308d25b..50c6485cb04f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -97,7 +97,6 @@ typedef int (init_request_fn)(struct blk_mq_tag_set *set, struct request *,
 		unsigned int, unsigned int);
 typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
 		unsigned int);
-typedef int (reinit_request_fn)(void *, struct request *);
 
 typedef void (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
@@ -143,7 +142,6 @@ struct blk_mq_ops {
 	 */
 	init_request_fn		*init_request;
 	exit_request_fn		*exit_request;
-	reinit_request_fn	*reinit_request;
 	/* Called from inside blk_get_request() */
 	void (*initialize_rq_fn)(struct request *rq);
 
@@ -261,7 +259,8 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
-int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
+int blk_mq_reinit_tagset(struct blk_mq_tag_set *set,
+			 int (reinit_request)(void *, struct request *));
 
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.14.0
