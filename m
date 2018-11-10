Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] block: avoid ordered task state change for polled IO
Date: Sat, 10 Nov 2018 08:13:15 -0700
Message-Id: <20181110151317.3813-5-axboe@kernel.dk>
In-Reply-To: <20181110151317.3813-1-axboe@kernel.dk>
References: <20181110151317.3813-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We only really need the barrier if we're going to be sleeping,
if we're just polling we're fine with the __set_current_state()
variant.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index c039abfb2052..e7550b1f9670 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -237,12 +237,23 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	qc = submit_bio(&bio);
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		/*
+		 * Using non-atomic task state for polling
+		 */
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
 		if (!READ_ONCE(bio.bi_private))
 			break;
+
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc))
+		    !blk_poll(bdev_get_queue(bdev), qc)) {
+			/*
+			 * If we're scheduling, ensure that task state
+			 * change is ordered and seen.
+			 */
+			smp_mb();
 			io_schedule();
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 
@@ -403,13 +414,19 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		return -EIOCBQUEUED;
 
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		/*
+		 * See __blkdev_direct_IO_simple() loop
+		 */
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
 		if (!READ_ONCE(dio->waiter))
 			break;
 
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc))
+		    !blk_poll(bdev_get_queue(bdev), qc)) {
+			smp_mb();
 			io_schedule();
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1
