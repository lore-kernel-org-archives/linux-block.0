Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>, Adam Manzanares
	<adam.manzanares@wdc.com>
Subject: [PATCH 2/5] null_blk: Use blk_init_request_from_bio() instead of open-coding it
Date: Tue, 18 Apr 2017 16:10:34 -0700
Message-ID: <20170418231037.3968-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170418231037.3968-1-bart.vanassche@sandisk.com>
References: <20170418231037.3968-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

This patch changes the behavior of the null_blk driver for the
LightNVM mode as follows:
* REQ_FAILFAST_MASK is set for read-ahead requests.
* If no I/O priority has been set in the bio, the I/O priority is
  copied from the I/O context.
* The rq_disk member is initialized if bio->bi_bdev != NULL.
* req->errors is initialized to zero.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Matias Bjørling <m@bjorling.me>
Cc: Adam Manzanares <adam.manzanares@wdc.com>
---
 drivers/block/null_blk.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index f93906ff31e8..e79e3d24e229 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -443,14 +443,7 @@ static int null_lnvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	if (IS_ERR(rq))
 		return -ENOMEM;
 
-	rq->__sector = bio->bi_iter.bi_sector;
-	rq->ioprio = bio_prio(bio);
-
-	if (bio_has_data(bio))
-		rq->nr_phys_segments = bio_phys_segments(q, bio);
-
-	rq->__data_len = bio->bi_iter.bi_size;
-	rq->bio = rq->biotail = bio;
+	blk_init_request_from_bio(rq, bio);
 
 	rq->end_io_data = rqd;
 
-- 
2.12.2
