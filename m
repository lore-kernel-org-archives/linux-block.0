Return-Path: <BATV+d57f7b82a529b7e9747b+4995+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/5] blk-mq: update ->init_request and ->exit_request prototypes
Date: Thu, 27 Apr 2017 19:44:57 +0200
Message-Id: <20170427174501.18965-2-hch@lst.de>
In-Reply-To: <20170427174501.18965-1-hch@lst.de>
References: <20170427174501.18965-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Remove the request_idx parameter, which can't be used safely now that we
support I/O schedulers with blk-mq.  Except for a superflous check in
mtip32xx it was unused anyway.

Also pass the tag_set instead of just the driver data - this allows drivers
to avoid some code duplication in a follow on cleanup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c                    | 18 +++++-------------
 drivers/block/loop.c              |  5 ++---
 drivers/block/mtip32xx/mtip32xx.c | 20 ++++++--------------
 drivers/block/nbd.c               |  7 +++----
 drivers/block/rbd.c               |  5 ++---
 drivers/block/virtio_blk.c        |  7 +++----
 drivers/md/dm-rq.c                |  7 +++----
 drivers/mtd/ubi/block.c           |  7 +++----
 drivers/nvme/host/fc.c            | 20 +++++++++-----------
 drivers/nvme/host/pci.c           | 15 +++++++--------
 drivers/nvme/host/rdma.c          | 28 ++++++++++++++--------------
 drivers/nvme/target/loop.c        | 17 +++++++++--------
 drivers/scsi/scsi_lib.c           | 13 ++++++-------
 include/linux/blk-mq.h            |  4 ++--
 14 files changed, 74 insertions(+), 99 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b75ef2392db7..c4493e012a0c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1658,8 +1658,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 			if (!rq)
 				continue;
-			set->ops->exit_request(set->driver_data, rq,
-						hctx_idx, i);
+			set->ops->exit_request(set, rq, hctx_idx);
 			tags->static_rqs[i] = NULL;
 		}
 	}
@@ -1790,8 +1789,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 			tags->static_rqs[i] = rq;
 			if (set->ops->init_request) {
-				if (set->ops->init_request(set->driver_data,
-						rq, hctx_idx, i,
+				if (set->ops->init_request(set, rq, hctx_idx,
 						node)) {
 					tags->static_rqs[i] = NULL;
 					goto fail;
@@ -1852,14 +1850,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
-	unsigned flush_start_tag = set->queue_depth;
-
 	blk_mq_tag_idle(hctx);
 
 	if (set->ops->exit_request)
-		set->ops->exit_request(set->driver_data,
-				       hctx->fq->flush_rq, hctx_idx,
-				       flush_start_tag + hctx_idx);
+		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
 
 	blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
 
@@ -1892,7 +1886,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
 	int node;
-	unsigned flush_start_tag = set->queue_depth;
 
 	node = hctx->numa_node;
 	if (node == NUMA_NO_NODE)
@@ -1938,9 +1931,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		goto sched_exit_hctx;
 
 	if (set->ops->init_request &&
-	    set->ops->init_request(set->driver_data,
-				   hctx->fq->flush_rq, hctx_idx,
-				   flush_start_tag + hctx_idx, node))
+	    set->ops->init_request(set, hctx->fq->flush_rq, hctx_idx,
+				   node))
 		goto free_fq;
 
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 994403efee19..28d932906f24 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1697,9 +1697,8 @@ static void loop_queue_work(struct kthread_work *work)
 	loop_handle_cmd(cmd);
 }
 
-static int loop_init_request(void *data, struct request *rq,
-		unsigned int hctx_idx, unsigned int request_idx,
-		unsigned int numa_node)
+static int loop_init_request(struct blk_mq_tag_set *set, struct request *rq,
+		unsigned int hctx_idx, unsigned int numa_node)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index eba8bcd677fa..75e3f91de199 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3821,10 +3821,10 @@ static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_MQ_RQ_QUEUE_ERROR;
 }
 
-static void mtip_free_cmd(void *data, struct request *rq,
-			  unsigned int hctx_idx, unsigned int request_idx)
+static void mtip_free_cmd(struct blk_mq_tag_set *set, struct request *rq,
+			  unsigned int hctx_idx)
 {
-	struct driver_data *dd = data;
+	struct driver_data *dd = set->driver_data;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
 	if (!cmd->command)
@@ -3834,21 +3834,13 @@ static void mtip_free_cmd(void *data, struct request *rq,
 				cmd->command, cmd->command_dma);
 }
 
-static int mtip_init_cmd(void *data, struct request *rq, unsigned int hctx_idx,
-			 unsigned int request_idx, unsigned int numa_node)
+static int mtip_init_cmd(struct blk_mq_tag_set *set, struct request *rq,
+			 unsigned int hctx_idx, unsigned int numa_node)
 {
-	struct driver_data *dd = data;
+	struct driver_data *dd = set->driver_data;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
 
-	/*
-	 * For flush requests, request_idx starts at the end of the
-	 * tag space.  Since we don't support FLUSH/FUA, simply return
-	 * 0 as there's nothing to be done.
-	 */
-	if (request_idx >= MTIP_MAX_COMMAND_SLOTS)
-		return 0;
-
 	cmd->command = dmam_alloc_coherent(&dd->pdev->dev, CMD_DMA_ALLOC_SZ,
 			&cmd->command_dma, GFP_KERNEL);
 	if (!cmd->command)
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5583dc4ff941..42c0825367e6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1396,12 +1396,11 @@ static void nbd_dbg_close(void)
 
 #endif
 
-static int nbd_init_request(void *data, struct request *rq,
-			    unsigned int hctx_idx, unsigned int request_idx,
-			    unsigned int numa_node)
+static int nbd_init_request(struct blk_mq_tag_set *set, struct request *rq,
+			    unsigned int hctx_idx, unsigned int numa_node)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(rq);
-	cmd->nbd = data;
+	cmd->nbd = set->driver_data;
 	return 0;
 }
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 089ac4179919..3670e8dd03fe 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4307,9 +4307,8 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	return ret;
 }
 
-static int rbd_init_request(void *data, struct request *rq,
-		unsigned int hctx_idx, unsigned int request_idx,
-		unsigned int numa_node)
+static int rbd_init_request(struct blk_mq_tag_set *set, struct request *rq,
+		unsigned int hctx_idx, unsigned int numa_node)
 {
 	struct work_struct *work = blk_mq_rq_to_pdu(rq);
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index f94614257462..94173de1efaa 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -573,11 +573,10 @@ static const struct device_attribute dev_attr_cache_type_rw =
 	__ATTR(cache_type, S_IRUGO|S_IWUSR,
 	       virtblk_cache_type_show, virtblk_cache_type_store);
 
-static int virtblk_init_request(void *data, struct request *rq,
-		unsigned int hctx_idx, unsigned int request_idx,
-		unsigned int numa_node)
+static int virtblk_init_request(struct blk_mq_tag_set *set, struct request *rq,
+		unsigned int hctx_idx, unsigned int numa_node)
 {
-	struct virtio_blk *vblk = data;
+	struct virtio_blk *vblk = set->driver_data;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
 
 #ifdef CONFIG_VIRTIO_BLK_SCSI
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index bff7e3bdb4ed..522d4fa8db64 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -719,11 +719,10 @@ int dm_old_init_request_queue(struct mapped_device *md, struct dm_table *t)
 	return 0;
 }
 
-static int dm_mq_init_request(void *data, struct request *rq,
-		       unsigned int hctx_idx, unsigned int request_idx,
-		       unsigned int numa_node)
+static int dm_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
+		unsigned int hctx_idx, unsigned int numa_node)
 {
-	return __dm_rq_init_rq(data, rq);
+	return __dm_rq_init_rq(set->driver_data, rq);
 }
 
 static int dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 51f2be8889b5..5497e65439df 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -334,10 +334,9 @@ static int ubiblock_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 }
 
-static int ubiblock_init_request(void *data, struct request *req,
-				 unsigned int hctx_idx,
-				 unsigned int request_idx,
-				 unsigned int numa_node)
+static int ubiblock_init_request(struct blk_mq_tag_set *set,
+		struct request *req, unsigned int hctx_idx,
+		unsigned int numa_node)
 {
 	struct ubiblock_pdu *pdu = blk_mq_rq_to_pdu(req);
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 4976db56e351..70e689bf1cad 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1172,12 +1172,12 @@ __nvme_fc_exit_request(struct nvme_fc_ctrl *ctrl,
 }
 
 static void
-nvme_fc_exit_request(void *data, struct request *rq,
-				unsigned int hctx_idx, unsigned int rq_idx)
+nvme_fc_exit_request(struct blk_mq_tag_set *set, struct request *rq,
+		unsigned int hctx_idx)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 
-	return __nvme_fc_exit_request(data, op);
+	return __nvme_fc_exit_request(set->driver_data, op);
 }
 
 static int
@@ -1434,11 +1434,10 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 }
 
 static int
-nvme_fc_init_request(void *data, struct request *rq,
-				unsigned int hctx_idx, unsigned int rq_idx,
-				unsigned int numa_node)
+nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
+		unsigned int hctx_idx, unsigned int numa_node)
 {
-	struct nvme_fc_ctrl *ctrl = data;
+	struct nvme_fc_ctrl *ctrl = set->driver_data;
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 	struct nvme_fc_queue *queue = &ctrl->queues[hctx_idx+1];
 
@@ -1446,11 +1445,10 @@ nvme_fc_init_request(void *data, struct request *rq,
 }
 
 static int
-nvme_fc_init_admin_request(void *data, struct request *rq,
-				unsigned int hctx_idx, unsigned int rq_idx,
-				unsigned int numa_node)
+nvme_fc_init_admin_request(struct blk_mq_tag_set *set, struct request *rq,
+		unsigned int hctx_idx, unsigned int numa_node)
 {
-	struct nvme_fc_ctrl *ctrl = data;
+	struct nvme_fc_ctrl *ctrl = set->driver_data;
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 	struct nvme_fc_queue *queue = &ctrl->queues[0];
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c8541c3dcd19..56a315bd4d96 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -356,11 +356,11 @@ static void nvme_admin_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_i
 	nvmeq->tags = NULL;
 }
 
-static int nvme_admin_init_request(void *data, struct request *req,
-				unsigned int hctx_idx, unsigned int rq_idx,
-				unsigned int numa_node)
+static int nvme_admin_init_request(struct blk_mq_tag_set *set,
+		struct request *req, unsigned int hctx_idx,
+		unsigned int numa_node)
 {
-	struct nvme_dev *dev = data;
+	struct nvme_dev *dev = set->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = dev->queues[0];
 
@@ -383,11 +383,10 @@ static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
-static int nvme_init_request(void *data, struct request *req,
-				unsigned int hctx_idx, unsigned int rq_idx,
-				unsigned int numa_node)
+static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
+		unsigned int hctx_idx, unsigned int numa_node)
 {
-	struct nvme_dev *dev = data;
+	struct nvme_dev *dev = set->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 29cf88ac3f61..dd1c6deef82f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -315,16 +315,16 @@ static void __nvme_rdma_exit_request(struct nvme_rdma_ctrl *ctrl,
 			DMA_TO_DEVICE);
 }
 
-static void nvme_rdma_exit_request(void *data, struct request *rq,
-				unsigned int hctx_idx, unsigned int rq_idx)
+static void nvme_rdma_exit_request(struct blk_mq_tag_set *set,
+		struct request *rq, unsigned int hctx_idx)
 {
-	return __nvme_rdma_exit_request(data, rq, hctx_idx + 1);
+	return __nvme_rdma_exit_request(set->driver_data, rq, hctx_idx + 1);
 }
 
-static void nvme_rdma_exit_admin_request(void *data, struct request *rq,
-				unsigned int hctx_idx, unsigned int rq_idx)
+static void nvme_rdma_exit_admin_request(struct blk_mq_tag_set *set,
+		struct request *rq, unsigned int hctx_idx)
 {
-	return __nvme_rdma_exit_request(data, rq, 0);
+	return __nvme_rdma_exit_request(set->driver_data, rq, 0);
 }
 
 static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
@@ -358,18 +358,18 @@ static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
 	return -ENOMEM;
 }
 
-static int nvme_rdma_init_request(void *data, struct request *rq,
-				unsigned int hctx_idx, unsigned int rq_idx,
-				unsigned int numa_node)
+static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
+		struct request *rq, unsigned int hctx_idx,
+		unsigned int numa_node)
 {
-	return __nvme_rdma_init_request(data, rq, hctx_idx + 1);
+	return __nvme_rdma_init_request(set->driver_data, rq, hctx_idx + 1);
 }
 
-static int nvme_rdma_init_admin_request(void *data, struct request *rq,
-				unsigned int hctx_idx, unsigned int rq_idx,
-				unsigned int numa_node)
+static int nvme_rdma_init_admin_request(struct blk_mq_tag_set *set,
+		struct request *rq, unsigned int hctx_idx,
+		unsigned int numa_node)
 {
-	return __nvme_rdma_init_request(data, rq, 0);
+	return __nvme_rdma_init_request(set->driver_data, rq, 0);
 }
 
 static int nvme_rdma_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 304f1c87c160..feb497134aee 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -230,18 +230,19 @@ static int nvme_loop_init_iod(struct nvme_loop_ctrl *ctrl,
 	return 0;
 }
 
-static int nvme_loop_init_request(void *data, struct request *req,
-				unsigned int hctx_idx, unsigned int rq_idx,
-				unsigned int numa_node)
+static int nvme_loop_init_request(struct blk_mq_tag_set *set,
+		struct request *req, unsigned int hctx_idx,
+		unsigned int numa_node)
 {
-	return nvme_loop_init_iod(data, blk_mq_rq_to_pdu(req), hctx_idx + 1);
+	return nvme_loop_init_iod(set->driver_data, blk_mq_rq_to_pdu(req),
+			hctx_idx + 1);
 }
 
-static int nvme_loop_init_admin_request(void *data, struct request *req,
-				unsigned int hctx_idx, unsigned int rq_idx,
-				unsigned int numa_node)
+static int nvme_loop_init_admin_request(struct blk_mq_tag_set *set,
+		struct request *req, unsigned int hctx_idx,
+		unsigned int numa_node)
 {
-	return nvme_loop_init_iod(data, blk_mq_rq_to_pdu(req), 0);
+	return nvme_loop_init_iod(set->driver_data, blk_mq_rq_to_pdu(req), 0);
 }
 
 static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index abc391e00f7d..049242b3f5bc 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1998,11 +1998,10 @@ static enum blk_eh_timer_return scsi_timeout(struct request *req,
 	return scsi_times_out(req);
 }
 
-static int scsi_init_request(void *data, struct request *rq,
-		unsigned int hctx_idx, unsigned int request_idx,
-		unsigned int numa_node)
+static int scsi_init_request(struct blk_mq_tag_set *set, struct request *rq,
+		unsigned int hctx_idx, unsigned int numa_node)
 {
-	struct Scsi_Host *shost = data;
+	struct Scsi_Host *shost = set->driver_data;
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
 
 	cmd->sense_buffer =
@@ -2013,10 +2012,10 @@ static int scsi_init_request(void *data, struct request *rq,
 	return 0;
 }
 
-static void scsi_exit_request(void *data, struct request *rq,
-		unsigned int hctx_idx, unsigned int request_idx)
+static void scsi_exit_request(struct blk_mq_tag_set *set, struct request *rq,
+		unsigned int hctx_idx)
 {
-	struct Scsi_Host *shost = data;
+	struct Scsi_Host *shost = set->driver_data;
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
 
 	scsi_free_sense_buffer(shost, cmd->sense_buffer);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0c4dadb85f62..1e84dffa4341 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -89,9 +89,9 @@ typedef int (queue_rq_fn)(struct blk_mq_hw_ctx *, const struct blk_mq_queue_data
 typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
 typedef int (init_hctx_fn)(struct blk_mq_hw_ctx *, void *, unsigned int);
 typedef void (exit_hctx_fn)(struct blk_mq_hw_ctx *, unsigned int);
-typedef int (init_request_fn)(void *, struct request *, unsigned int,
+typedef int (init_request_fn)(struct blk_mq_tag_set *set, struct request *,
 		unsigned int, unsigned int);
-typedef void (exit_request_fn)(void *, struct request *, unsigned int,
+typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
 		unsigned int);
 typedef int (reinit_request_fn)(void *, struct request *);
 
-- 
2.11.0
