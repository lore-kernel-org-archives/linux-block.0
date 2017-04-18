Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>, Adam Manzanares
	<adam.manzanares@wdc.com>
Subject: [PATCH 3/5] lightnvm: Use blk_init_request_from_bio() instead of open-coding it
Date: Tue, 18 Apr 2017 16:10:35 -0700
Message-ID: <20170418231037.3968-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170418231037.3968-1-bart.vanassche@sandisk.com>
References: <20170418231037.3968-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

This patch changes the behavior of the lightnvm driver as follows:
* REQ_FAILFAST_MASK is set for read-ahead requests.
* If no I/O priority has been set in the bio, the I/O priority is
  copied from the I/O context.
* The rq_disk member is initialized if bio->bi_bdev != NULL.
* The bio sector offset is copied into req->__sector instead of
  retaining the value -1 set by blk_mq_alloc_request().
* req->errors is initialized to zero.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Matias Bjørling <m@bjorling.me>
Cc: Adam Manzanares <adam.manzanares@wdc.com>
---
 drivers/nvme/host/lightnvm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 4b78090518e1..b76e2e36fef4 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -511,11 +511,7 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	rq->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
 	if (bio) {
-		rq->ioprio = bio_prio(bio);
-		rq->__data_len = bio->bi_iter.bi_size;
-		rq->bio = rq->biotail = bio;
-		if (bio_has_data(bio))
-			rq->nr_phys_segments = bio_phys_segments(q, bio);
+		blk_init_request_from_bio(rq, bio);
 	} else {
 		rq->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
 		rq->__data_len = 0;
-- 
2.12.2
