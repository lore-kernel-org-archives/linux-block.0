Return-Path: <bart@gcc10.fsffrance.org>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org,
	stable@vger.kernel.org
Subject: [PATCH] xen-blkfront: Fix handling of non-supported operations
Date: Fri, 21 Jul 2017 19:11:10 +0200
Message-Id: <20170721171110.824-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

This patch fixes the following sparse warnings:

drivers/block/xen-blkfront.c:916:45: warning: incorrect type in argument 2 (different base types)
drivers/block/xen-blkfront.c:916:45:    expected restricted blk_status_t [usertype] error
drivers/block/xen-blkfront.c:916:45:    got int [signed] error
drivers/block/xen-blkfront.c:1599:47: warning: incorrect type in assignment (different base types)
drivers/block/xen-blkfront.c:1599:47:    expected int [signed] error
drivers/block/xen-blkfront.c:1599:47:    got restricted blk_status_t [usertype] <noident>
drivers/block/xen-blkfront.c:1607:55: warning: incorrect type in assignment (different base types)
drivers/block/xen-blkfront.c:1607:55:    expected int [signed] error
drivers/block/xen-blkfront.c:1607:55:    got restricted blk_status_t [usertype] <noident>
drivers/block/xen-blkfront.c:1625:55: warning: incorrect type in assignment (different base types)
drivers/block/xen-blkfront.c:1625:55:    expected int [signed] error
drivers/block/xen-blkfront.c:1625:55:    got restricted blk_status_t [usertype] <noident>
drivers/block/xen-blkfront.c:1628:62: warning: restricted blk_status_t degrades to integer

Compile-tested only.

Fixes: commit 2a842acab109 ("block: introduce new block status code type")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: <xen-devel@lists.xenproject.org>
Cc: <stable@vger.kernel.org>
---
 drivers/block/xen-blkfront.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index c852ed3c01d5..1799bba74390 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -111,7 +111,7 @@ struct blk_shadow {
 };
 
 struct blkif_req {
-	int	error;
+	blk_status_t	error;
 };
 
 static inline struct blkif_req *blkif_req(struct request *rq)
@@ -1616,7 +1616,7 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 			if (unlikely(bret->status == BLKIF_RSP_EOPNOTSUPP)) {
 				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
 				       info->gd->disk_name, op_name(bret->operation));
-				blkif_req(req)->error = -EOPNOTSUPP;
+				blkif_req(req)->error = BLK_STS_NOTSUPP;
 			}
 			if (unlikely(bret->status == BLKIF_RSP_ERROR &&
 				     rinfo->shadow[id].req.u.rw.nr_segments == 0)) {
-- 
2.13.2
