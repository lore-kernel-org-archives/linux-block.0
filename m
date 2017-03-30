Return-Path: <ebiggers3@gmail.com>
Return-Path: <ebiggers3@gmail.com>
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH] blk-mq: constify struct blk_mq_ops
Date: Thu, 30 Mar 2017 13:39:16 -0700
Message-Id: <20170330203916.122167-1-ebiggers3@gmail.com>
List-ID: <linux-block@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Constify all instances of blk_mq_ops, as they are never modified.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/block/loop.c              | 2 +-
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 drivers/block/nbd.c               | 2 +-
 drivers/block/null_blk.c          | 2 +-
 drivers/block/rbd.c               | 2 +-
 drivers/block/virtio_blk.c        | 2 +-
 drivers/block/xen-blkfront.c      | 2 +-
 drivers/md/dm-rq.c                | 2 +-
 drivers/mtd/ubi/block.c           | 2 +-
 drivers/nvme/host/fc.c            | 4 ++--
 drivers/nvme/host/pci.c           | 4 ++--
 drivers/nvme/host/rdma.c          | 4 ++--
 drivers/nvme/target/loop.c        | 4 ++--
 drivers/scsi/scsi_lib.c           | 2 +-
 14 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0ecb6461ed81..cc981f34e017 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1710,7 +1710,7 @@ static int loop_init_request(void *data, struct request *rq,
 	return 0;
 }
 
-static struct blk_mq_ops loop_mq_ops = {
+static const struct blk_mq_ops loop_mq_ops = {
 	.queue_rq       = loop_queue_rq,
 	.init_request	= loop_init_request,
 };
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c96c35ab39df..30076e7753bc 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3889,7 +3889,7 @@ static enum blk_eh_timer_return mtip_cmd_timeout(struct request *req,
 	return BLK_EH_RESET_TIMER;
 }
 
-static struct blk_mq_ops mtip_mq_ops = {
+static const struct blk_mq_ops mtip_mq_ops = {
 	.queue_rq	= mtip_queue_rq,
 	.init_request	= mtip_init_cmd,
 	.exit_request	= mtip_free_cmd,
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7e4287bc19e5..d3be8ea2f80d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -965,7 +965,7 @@ static int nbd_init_request(void *data, struct request *rq,
 	return 0;
 }
 
-static struct blk_mq_ops nbd_mq_ops = {
+static const struct blk_mq_ops nbd_mq_ops = {
 	.queue_rq	= nbd_queue_rq,
 	.init_request	= nbd_init_request,
 	.timeout	= nbd_xmit_timeout,
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 6f2e565bccc5..81e4ed314e35 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -392,7 +392,7 @@ static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
-static struct blk_mq_ops null_mq_ops = {
+static const struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
 	.init_hctx	= null_init_hctx,
 	.complete	= null_softirq_done_fn,
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 517838b65964..f24ade333e0c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4317,7 +4317,7 @@ static int rbd_init_request(void *data, struct request *rq,
 	return 0;
 }
 
-static struct blk_mq_ops rbd_mq_ops = {
+static const struct blk_mq_ops rbd_mq_ops = {
 	.queue_rq	= rbd_queue_rq,
 	.init_request	= rbd_init_request,
 };
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 1d4c9f8bc1e1..2d8290169271 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -597,7 +597,7 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
 	return blk_mq_virtio_map_queues(set, vblk->vdev, 0);
 }
 
-static struct blk_mq_ops virtio_mq_ops = {
+static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 5067a0a952cb..d137ef8a72be 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -907,7 +907,7 @@ static int blkif_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_MQ_RQ_QUEUE_BUSY;
 }
 
-static struct blk_mq_ops blkfront_mq_ops = {
+static const struct blk_mq_ops blkfront_mq_ops = {
 	.queue_rq = blkif_queue_rq,
 };
 
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 28955b94d2b2..6886bf160fb2 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -761,7 +761,7 @@ static int dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_MQ_RQ_QUEUE_OK;
 }
 
-static struct blk_mq_ops dm_mq_ops = {
+static const struct blk_mq_ops dm_mq_ops = {
 	.queue_rq = dm_mq_queue_rq,
 	.complete = dm_softirq_done,
 	.init_request = dm_mq_init_request,
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index c80869e60909..51f2be8889b5 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -347,7 +347,7 @@ static int ubiblock_init_request(void *data, struct request *req,
 	return 0;
 }
 
-static struct blk_mq_ops ubiblock_mq_ops = {
+static const struct blk_mq_ops ubiblock_mq_ops = {
 	.queue_rq       = ubiblock_queue_rq,
 	.init_request	= ubiblock_init_request,
 };
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9690beb15e69..5939a0a4f7a5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1948,7 +1948,7 @@ nvme_fc_complete_rq(struct request *rq)
 	blk_mq_end_request(rq, error);
 }
 
-static struct blk_mq_ops nvme_fc_mq_ops = {
+static const struct blk_mq_ops nvme_fc_mq_ops = {
 	.queue_rq	= nvme_fc_queue_rq,
 	.complete	= nvme_fc_complete_rq,
 	.init_request	= nvme_fc_init_request,
@@ -1959,7 +1959,7 @@ static struct blk_mq_ops nvme_fc_mq_ops = {
 	.timeout	= nvme_fc_timeout,
 };
 
-static struct blk_mq_ops nvme_fc_admin_mq_ops = {
+static const struct blk_mq_ops nvme_fc_admin_mq_ops = {
 	.queue_rq	= nvme_fc_queue_rq,
 	.complete	= nvme_fc_complete_rq,
 	.init_request	= nvme_fc_init_admin_request,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd05fe88..095b061416bf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1129,7 +1129,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	return result;
 }
 
-static struct blk_mq_ops nvme_mq_admin_ops = {
+static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_complete_rq,
 	.init_hctx	= nvme_admin_init_hctx,
@@ -1138,7 +1138,7 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 	.timeout	= nvme_timeout,
 };
 
-static struct blk_mq_ops nvme_mq_ops = {
+static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_complete_rq,
 	.init_hctx	= nvme_init_hctx,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 47a479f26e5d..25d4eeaeca60 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1529,7 +1529,7 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	blk_mq_end_request(rq, error);
 }
 
-static struct blk_mq_ops nvme_rdma_mq_ops = {
+static const struct blk_mq_ops nvme_rdma_mq_ops = {
 	.queue_rq	= nvme_rdma_queue_rq,
 	.complete	= nvme_rdma_complete_rq,
 	.init_request	= nvme_rdma_init_request,
@@ -1540,7 +1540,7 @@ static struct blk_mq_ops nvme_rdma_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static struct blk_mq_ops nvme_rdma_admin_mq_ops = {
+static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.queue_rq	= nvme_rdma_queue_rq,
 	.complete	= nvme_rdma_complete_rq,
 	.init_request	= nvme_rdma_init_admin_request,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 22f7bc6bac7f..e5e11fef7c04 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -268,7 +268,7 @@ static int nvme_loop_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
-static struct blk_mq_ops nvme_loop_mq_ops = {
+static const struct blk_mq_ops nvme_loop_mq_ops = {
 	.queue_rq	= nvme_loop_queue_rq,
 	.complete	= nvme_loop_complete_rq,
 	.init_request	= nvme_loop_init_request,
@@ -276,7 +276,7 @@ static struct blk_mq_ops nvme_loop_mq_ops = {
 	.timeout	= nvme_loop_timeout,
 };
 
-static struct blk_mq_ops nvme_loop_admin_mq_ops = {
+static const struct blk_mq_ops nvme_loop_admin_mq_ops = {
 	.queue_rq	= nvme_loop_queue_rq,
 	.complete	= nvme_loop_complete_rq,
 	.init_request	= nvme_loop_init_admin_request,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 19125d72f322..c1519660824b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2154,7 +2154,7 @@ struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
 	return q;
 }
 
-static struct blk_mq_ops scsi_mq_ops = {
+static const struct blk_mq_ops scsi_mq_ops = {
 	.queue_rq	= scsi_queue_rq,
 	.complete	= scsi_softirq_done,
 	.timeout	= scsi_timeout,
-- 
2.12.2.564.g063fe858b8-goog
