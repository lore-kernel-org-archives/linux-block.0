Return-Path: <BATV+a67a43e55467fd1c3dfd+4677+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	bhalevy@primarydata.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/7] virtio_blk: use blk_rq_map_kern
Date: Mon, 13 Jun 2016 17:21:13 +0200
Message-Id: <1465831278-23653-3-git-send-email-hch@lst.de>
In-Reply-To: <1465831278-23653-1-git-send-email-hch@lst.de>
References: <1465831278-23653-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Similar to how SCSI and NVMe prepare passthrough requests.  This avoids
poking into request internals too much.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 18e4069..963a130 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -236,25 +236,23 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 static int virtblk_get_id(struct gendisk *disk, char *id_str)
 {
 	struct virtio_blk *vblk = disk->private_data;
+	struct request_queue *q = vblk->disk->queue;
 	struct request *req;
-	struct bio *bio;
 	int err;
 
-	bio = bio_map_kern(vblk->disk->queue, id_str, VIRTIO_BLK_ID_BYTES,
-			   GFP_KERNEL);
-	if (IS_ERR(bio))
-		return PTR_ERR(bio);
-
-	req = blk_make_request(vblk->disk->queue, bio, GFP_KERNEL);
-	if (IS_ERR(req)) {
-		bio_put(bio);
+	req = blk_get_request(q, READ, GFP_KERNEL);
+	if (IS_ERR(req))
 		return PTR_ERR(req);
-	}
-
+	blk_rq_set_block_pc(req);
 	req->cmd_type = REQ_TYPE_DRV_PRIV;
+
+	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
+	if (err)
+		goto out;
+
 	err = blk_execute_rq(vblk->disk->queue, vblk->disk, req, false);
+out:
 	blk_put_request(req);
-
 	return err;
 }
 
-- 
2.1.4
