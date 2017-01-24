Return-Path: <BATV+aedd8ced9e3963eed800+4902+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: m@bjorling.me,
	linux-block@vger.kernel.org
Subject: [PATCH] block: fix use after free in __blkdev_direct_IO
Date: Tue, 24 Jan 2017 14:50:19 +0100
Message-Id: <1485265819-2403-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

We can't dereference the dio structure after submitting the last bio for
this request, as I/O completion might have happened before the code is
run. Introduce a local is_sync variable instead.

Fixes: 542ff7bf ("block: new direct I/O implementation")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Matias Bjørling <m@bjorling.me>
Tested-by: Matias Bjørling <m@bjorling.me>
---
 fs/block_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 5db5d13..3c47614 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -331,7 +331,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_read = (iov_iter_rw(iter) == READ);
+	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
 	int ret;
@@ -344,7 +344,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	bio_get(bio); /* extra ref for the completion handler */
 
 	dio = container_of(bio, struct blkdev_dio, bio);
-	dio->is_sync = is_sync_kiocb(iocb);
+	dio->is_sync = is_sync = is_sync_kiocb(iocb);
 	if (dio->is_sync)
 		dio->waiter = current;
 	else
@@ -398,7 +398,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	}
 	blk_finish_plug(&plug);
 
-	if (!dio->is_sync)
+	if (!is_sync)
 		return -EIOCBQUEUED;
 
 	for (;;) {
-- 
2.1.4
