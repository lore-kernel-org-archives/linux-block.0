Return-Path: <BATV+d57f7b82a529b7e9747b+4995+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/5] nvme-rdma: merge init_request and exit_request methods
Date: Thu, 27 Apr 2017 19:44:59 +0200
Message-Id: <20170427174501.18965-4-hch@lst.de>
In-Reply-To: <20170427174501.18965-1-hch@lst.de>
References: <20170427174501.18965-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now that we get the tagset passed we can have a single implementation for
the I/O and admin queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/rdma.c | 43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dd1c6deef82f..960b171218c5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -301,10 +301,12 @@ static int nvme_rdma_reinit_request(void *data, struct request *rq)
 	return ret;
 }
 
-static void __nvme_rdma_exit_request(struct nvme_rdma_ctrl *ctrl,
-		struct request *rq, unsigned int queue_idx)
+static void nvme_rdma_exit_request(struct blk_mq_tag_set *set,
+		struct request *rq, unsigned int hctx_idx)
 {
+	struct nvme_rdma_ctrl *ctrl = set->driver_data;
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 	struct nvme_rdma_queue *queue = &ctrl->queues[queue_idx];
 	struct nvme_rdma_device *dev = queue->device;
 
@@ -315,22 +317,13 @@ static void __nvme_rdma_exit_request(struct nvme_rdma_ctrl *ctrl,
 			DMA_TO_DEVICE);
 }
 
-static void nvme_rdma_exit_request(struct blk_mq_tag_set *set,
-		struct request *rq, unsigned int hctx_idx)
-{
-	return __nvme_rdma_exit_request(set->driver_data, rq, hctx_idx + 1);
-}
-
-static void nvme_rdma_exit_admin_request(struct blk_mq_tag_set *set,
-		struct request *rq, unsigned int hctx_idx)
-{
-	return __nvme_rdma_exit_request(set->driver_data, rq, 0);
-}
-
-static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
-		struct request *rq, unsigned int queue_idx)
+static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
+		struct request *rq, unsigned int hctx_idx,
+		unsigned int numa_node)
 {
+	struct nvme_rdma_ctrl *ctrl = set->driver_data;
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 	struct nvme_rdma_queue *queue = &ctrl->queues[queue_idx];
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
@@ -358,20 +351,6 @@ static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
 	return -ENOMEM;
 }
 
-static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
-		struct request *rq, unsigned int hctx_idx,
-		unsigned int numa_node)
-{
-	return __nvme_rdma_init_request(set->driver_data, rq, hctx_idx + 1);
-}
-
-static int nvme_rdma_init_admin_request(struct blk_mq_tag_set *set,
-		struct request *rq, unsigned int hctx_idx,
-		unsigned int numa_node)
-{
-	return __nvme_rdma_init_request(set->driver_data, rq, 0);
-}
-
 static int nvme_rdma_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
@@ -1536,8 +1515,8 @@ static const struct blk_mq_ops nvme_rdma_mq_ops = {
 static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.queue_rq	= nvme_rdma_queue_rq,
 	.complete	= nvme_rdma_complete_rq,
-	.init_request	= nvme_rdma_init_admin_request,
-	.exit_request	= nvme_rdma_exit_admin_request,
+	.init_request	= nvme_rdma_init_request,
+	.exit_request	= nvme_rdma_exit_request,
 	.reinit_request	= nvme_rdma_reinit_request,
 	.init_hctx	= nvme_rdma_init_admin_hctx,
 	.timeout	= nvme_rdma_timeout,
-- 
2.11.0
