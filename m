Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/6] pd: replace ->special use with private data in the request
Date: Fri,  9 Nov 2018 19:32:07 +0100
Message-Id: <20181109183208.19879-6-hch@lst.de>
In-Reply-To: <20181109183208.19879-1-hch@lst.de>
References: <20181109183208.19879-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/paride/pd.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index ae4971e5d9a8..0ff9b12d0e35 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -242,6 +242,11 @@ struct pd_unit {
 
 static struct pd_unit pd[PD_UNITS];
 
+struct pd_req {
+	/* for REQ_OP_DRV_IN: */
+	enum action (*func)(struct pd_unit *disk);
+};
+
 static char pd_scratch[512];	/* scratch block buffer */
 
 static char *pd_errs[17] = { "ERR", "INDEX", "ECC", "DRQ", "SEEK", "WRERR",
@@ -502,8 +507,9 @@ static enum action do_pd_io_start(void)
 
 static enum action pd_special(void)
 {
-	enum action (*func)(struct pd_unit *) = pd_req->special;
-	return func(pd_current);
+	struct pd_req *req = blk_mq_rq_to_pdu(pd_req);
+
+	return req->func(pd_current);
 }
 
 static int pd_next_buf(void)
@@ -767,12 +773,14 @@ static int pd_special_command(struct pd_unit *disk,
 		      enum action (*func)(struct pd_unit *disk))
 {
 	struct request *rq;
+	struct pd_req *req;
 
 	rq = blk_get_request(disk->gd->queue, REQ_OP_DRV_IN, 0);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
+	req = blk_mq_rq_to_pdu(rq);
 
-	rq->special = func;
+	req->func = func;
 	blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
 	blk_put_request(rq);
 	return 0;
@@ -892,9 +900,21 @@ static void pd_probe_drive(struct pd_unit *disk)
 	disk->gd = p;
 	p->private_data = disk;
 
-	p->queue = blk_mq_init_sq_queue(&disk->tag_set, &pd_mq_ops, 2,
-				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING);
+	memset(&disk->tag_set, 0, sizeof(disk->tag_set));
+	disk->tag_set.ops = &pd_mq_ops;
+	disk->tag_set.cmd_size = sizeof(struct pd_req);
+	disk->tag_set.nr_hw_queues = 1;
+	disk->tag_set.nr_maps = 1;
+	disk->tag_set.queue_depth = 2;
+	disk->tag_set.numa_node = NUMA_NO_NODE;
+	disk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+
+	if (blk_mq_alloc_tag_set(&disk->tag_set))
+		return;
+
+	p->queue = blk_mq_init_queue(&disk->tag_set);
 	if (IS_ERR(p->queue)) {
+		blk_mq_free_tag_set(&disk->tag_set);
 		p->queue = NULL;
 		return;
 	}
-- 
2.19.1
