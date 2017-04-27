Return-Path: <BATV+d57f7b82a529b7e9747b+4995+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 5/5] nvme-loop: merge init_request methods
Date: Thu, 27 Apr 2017 19:45:01 +0200
Message-Id: <20170427174501.18965-6-hch@lst.de>
In-Reply-To: <20170427174501.18965-1-hch@lst.de>
References: <20170427174501.18965-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Now that we get the tagset passed we can have a single implementation for
the I/O and admin queues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/loop.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index feb497134aee..420bde8ed488 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -234,15 +234,10 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
 		struct request *req, unsigned int hctx_idx,
 		unsigned int numa_node)
 {
-	return nvme_loop_init_iod(set->driver_data, blk_mq_rq_to_pdu(req),
-			hctx_idx + 1);
-}
+	struct nvme_loop_ctrl *ctrl = set->driver_data;
 
-static int nvme_loop_init_admin_request(struct blk_mq_tag_set *set,
-		struct request *req, unsigned int hctx_idx,
-		unsigned int numa_node)
-{
-	return nvme_loop_init_iod(set->driver_data, blk_mq_rq_to_pdu(req), 0);
+	return nvme_loop_init_iod(ctrl, blk_mq_rq_to_pdu(req),
+			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
 }
 
 static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -280,7 +275,7 @@ static const struct blk_mq_ops nvme_loop_mq_ops = {
 static const struct blk_mq_ops nvme_loop_admin_mq_ops = {
 	.queue_rq	= nvme_loop_queue_rq,
 	.complete	= nvme_loop_complete_rq,
-	.init_request	= nvme_loop_init_admin_request,
+	.init_request	= nvme_loop_init_request,
 	.init_hctx	= nvme_loop_init_admin_hctx,
 	.timeout	= nvme_loop_timeout,
 };
-- 
2.11.0
