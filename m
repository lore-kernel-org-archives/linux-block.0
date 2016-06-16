Return-Path: <BATV+d68c80116f0bf241093e+4680+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/7] block: ensure bios return from blk_get_request are properly initialized
Date: Thu, 16 Jun 2016 11:14:27 +0200
Message-Id: <1466068471-15746-4-git-send-email-hch@lst.de>
In-Reply-To: <1466068471-15746-1-git-send-email-hch@lst.de>
References: <1466068471-15746-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

blk_get_request is used for BLOCK_PC and similar passthrough requests.
Currently we always need to call blk_rq_set_block_pc or an open coded
version of it to allow appending bios using the request mapping helpers
later on, which is a somewhat awkward API.  Instead move the
initialization part of blk_rq_set_block_pc into blk_get_request, so that
we always have a safe to use request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c           | 12 +++++++-----
 block/blk-mq.c             |  4 ++++
 drivers/block/virtio_blk.c |  1 -
 drivers/nvme/host/core.c   |  4 ----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c94c7ad..8416c4a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1294,10 +1294,15 @@ static struct request *blk_old_get_request(struct request_queue *q, int rw,
 
 	spin_lock_irq(q->queue_lock);
 	rq = get_request(q, rw, 0, NULL, gfp_mask);
-	if (IS_ERR(rq))
+	if (IS_ERR(rq)) {
 		spin_unlock_irq(q->queue_lock);
-	/* q->queue_lock is unlocked at this point */
+		return rq;
+	}
 
+	/* q->queue_lock is unlocked at this point */
+	rq->__data_len = 0;
+	rq->__sector = (sector_t) -1;
+	rq->bio = rq->biotail = NULL;
 	return rq;
 }
 
@@ -1377,9 +1382,6 @@ EXPORT_SYMBOL(blk_make_request);
 void blk_rq_set_block_pc(struct request *rq)
 {
 	rq->cmd_type = REQ_TYPE_BLOCK_PC;
-	rq->__data_len = 0;
-	rq->__sector = (sector_t) -1;
-	rq->bio = rq->biotail = NULL;
 	memset(rq->__cmd, 0, sizeof(rq->__cmd));
 }
 EXPORT_SYMBOL(blk_rq_set_block_pc);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc7166d..b5606dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -263,6 +263,10 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
 	}
+
+	rq->__data_len = 0;
+	rq->__sector = (sector_t) -1;
+	rq->bio = rq->biotail = NULL;
 	return rq;
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 963a130..0be7dd6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -243,7 +243,6 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	req = blk_get_request(q, READ, GFP_KERNEL);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	blk_rq_set_block_pc(req);
 	req->cmd_type = REQ_TYPE_DRV_PRIV;
 
 	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9d7cee4..cb8ca1b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -201,10 +201,6 @@ struct request *nvme_alloc_request(struct request_queue *q,
 
 	req->cmd_type = REQ_TYPE_DRV_PRIV;
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
-	req->__data_len = 0;
-	req->__sector = (sector_t) -1;
-	req->bio = req->biotail = NULL;
-
 	req->cmd = (unsigned char *)cmd;
 	req->cmd_len = sizeof(struct nvme_command);
 
-- 
2.1.4
