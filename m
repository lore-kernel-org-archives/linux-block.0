Return-Path: <BATV+e0efdd19ce80d487e3da+5372+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>,
	Geoff Levand <geoff@infradead.org>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	linux-block@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 4/7] mtd_blkdevs: handle highmem pages
Date: Wed,  9 May 2018 15:59:45 +0200
Message-Id: <20180509135948.20329-5-hch@lst.de>
In-Reply-To: <20180509135948.20329-1-hch@lst.de>
References: <20180509135948.20329-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Just kmap the single payload page before passing it on to the FTL.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/mtd_blkdevs.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 16ae4ae8e8f9..29c0bfd74e8a 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -82,7 +82,6 @@ static blk_status_t do_blktrans_request(struct mtd_blktrans_ops *tr,
 
 	block = blk_rq_pos(req) << 9 >> tr->blkshift;
 	nsect = blk_rq_cur_bytes(req) >> tr->blkshift;
-	buf = bio_data(req->bio);
 
 	if (req_op(req) == REQ_OP_FLUSH) {
 		if (tr->flush(dev))
@@ -100,9 +99,14 @@ static blk_status_t do_blktrans_request(struct mtd_blktrans_ops *tr,
 			return BLK_STS_IOERR;
 		return BLK_STS_OK;
 	case REQ_OP_READ:
-		for (; nsect > 0; nsect--, block++, buf += tr->blksize)
-			if (tr->readsect(dev, block, buf))
+		buf = kmap(bio_page(req->bio)) + bio_offset(req->bio);
+		for (; nsect > 0; nsect--, block++, buf += tr->blksize) {
+			if (tr->readsect(dev, block, buf)) {
+				kunmap(bio_page(req->bio));
 				return BLK_STS_IOERR;
+			}
+		}
+		kunmap(bio_page(req->bio));
 		rq_flush_dcache_pages(req);
 		return BLK_STS_OK;
 	case REQ_OP_WRITE:
@@ -110,9 +114,14 @@ static blk_status_t do_blktrans_request(struct mtd_blktrans_ops *tr,
 			return BLK_STS_IOERR;
 
 		rq_flush_dcache_pages(req);
-		for (; nsect > 0; nsect--, block++, buf += tr->blksize)
-			if (tr->writesect(dev, block, buf))
+		buf = kmap(bio_page(req->bio)) + bio_offset(req->bio);
+		for (; nsect > 0; nsect--, block++, buf += tr->blksize) {
+			if (tr->writesect(dev, block, buf)) {
+				kunmap(bio_page(req->bio));
 				return BLK_STS_IOERR;
+			}
+		}
+		kunmap(bio_page(req->bio));
 		return BLK_STS_OK;
 	default:
 		return BLK_STS_IOERR;
@@ -418,7 +427,6 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	new->rq->queuedata = new;
 	blk_queue_logical_block_size(new->rq, tr->blksize);
 
-	blk_queue_bounce_limit(new->rq, BLK_BOUNCE_HIGH);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, new->rq);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, new->rq);
 
-- 
2.17.0
