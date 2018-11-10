Return-Path: <BATV+3de936c6eedb3fd3a39f+5557+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/6] aoe: replace ->special use with private data in the request
Date: Sat, 10 Nov 2018 09:30:47 +0100
Message-Id: <20181110083049.17475-5-hch@lst.de>
In-Reply-To: <20181110083049.17475-1-hch@lst.de>
References: <20181110083049.17475-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Makes the code a whole lot better to read..

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/aoe/aoe.h    |  4 ++++
 drivers/block/aoe/aoeblk.c |  1 +
 drivers/block/aoe/aoecmd.c | 27 +++++++++------------------
 drivers/block/aoe/aoedev.c | 11 ++++++-----
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 7ca76ed2e71a..84d0fcebd6af 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -100,6 +100,10 @@ enum {
 	MAX_TAINT = 1000,	/* cap on aoetgt taint */
 };
 
+struct aoe_req {
+	unsigned long nr_bios;
+};
+
 struct buf {
 	ulong nframesout;
 	struct bio *bio;
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index ed26b7287256..e2c6aae2d636 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -387,6 +387,7 @@ aoeblk_gdalloc(void *vp)
 
 	set = &d->tag_set;
 	set->ops = &aoeblk_mq_ops;
+	set->cmd_size = sizeof(struct aoe_req);
 	set->nr_hw_queues = 1;
 	set->queue_depth = 128;
 	set->numa_node = NUMA_NO_NODE;
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index bb2fba651bd2..3cf9bc5d8d95 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -822,17 +822,6 @@ rexmit_timer(struct timer_list *timer)
 	spin_unlock_irqrestore(&d->lock, flags);
 }
 
-static unsigned long
-rqbiocnt(struct request *r)
-{
-	struct bio *bio;
-	unsigned long n = 0;
-
-	__rq_for_each_bio(bio, r)
-		n++;
-	return n;
-}
-
 static void
 bufinit(struct buf *buf, struct request *rq, struct bio *bio)
 {
@@ -847,6 +836,7 @@ nextbuf(struct aoedev *d)
 {
 	struct request *rq;
 	struct request_queue *q;
+	struct aoe_req *req;
 	struct buf *buf;
 	struct bio *bio;
 
@@ -865,7 +855,11 @@ nextbuf(struct aoedev *d)
 		blk_mq_start_request(rq);
 		d->ip.rq = rq;
 		d->ip.nxbio = rq->bio;
-		rq->special = (void *) rqbiocnt(rq);
+
+		req = blk_mq_rq_to_pdu(rq);
+		req->nr_bios = 0;
+		__rq_for_each_bio(bio, rq)
+			req->nr_bios++;
 	}
 	buf = mempool_alloc(d->bufpool, GFP_ATOMIC);
 	if (buf == NULL) {
@@ -1069,16 +1063,13 @@ aoe_end_request(struct aoedev *d, struct request *rq, int fastfail)
 static void
 aoe_end_buf(struct aoedev *d, struct buf *buf)
 {
-	struct request *rq;
-	unsigned long n;
+	struct request *rq = buf->rq;
+	struct aoe_req *req = blk_mq_rq_to_pdu(rq);
 
 	if (buf == d->ip.buf)
 		d->ip.buf = NULL;
-	rq = buf->rq;
 	mempool_free(buf, d->bufpool);
-	n = (unsigned long) rq->special;
-	rq->special = (void *) --n;
-	if (n == 0)
+	if (--req->nr_bios == 0)
 		aoe_end_request(d, rq, 0);
 }
 
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 9063f8efbd3b..5b49f1b33ebe 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -160,21 +160,22 @@ static void
 aoe_failip(struct aoedev *d)
 {
 	struct request *rq;
+	struct aoe_req *req;
 	struct bio *bio;
-	unsigned long n;
 
 	aoe_failbuf(d, d->ip.buf);
-
 	rq = d->ip.rq;
 	if (rq == NULL)
 		return;
+
+	req = blk_mq_rq_to_pdu(rq);
 	while ((bio = d->ip.nxbio)) {
 		bio->bi_status = BLK_STS_IOERR;
 		d->ip.nxbio = bio->bi_next;
-		n = (unsigned long) rq->special;
-		rq->special = (void *) --n;
+		req->nr_bios--;
 	}
-	if ((unsigned long) rq->special == 0)
+
+	if (!req->nr_bios)
 		aoe_end_request(d, rq, 0);
 }
 
-- 
2.19.1
