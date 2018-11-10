Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] block: add polled wakeup task helper
Date: Sat, 10 Nov 2018 08:13:17 -0700
Message-Id: <20181110151317.3813-7-axboe@kernel.dk>
In-Reply-To: <20181110151317.3813-1-axboe@kernel.dk>
References: <20181110151317.3813-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

If we're polling for IO on a device that doesn't use interrupts, then
IO completion loop (and wake of task) is done by submitting task itself.
If that is the case, then we don't need to enter the wake_up_process()
function, we can simply mark ourselves as TASK_RUNNING.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c         |  4 ++--
 fs/iomap.c             |  2 +-
 include/linux/blkdev.h | 13 +++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index e7550b1f9670..eea37d801f1c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -181,7 +181,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 	struct task_struct *waiter = bio->bi_private;
 
 	WRITE_ONCE(bio->bi_private, NULL);
-	wake_up_process(waiter);
+	blk_wake_io_task(waiter);
 }
 
 static ssize_t
@@ -316,7 +316,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 			struct task_struct *waiter = dio->waiter;
 
 			WRITE_ONCE(dio->waiter, NULL);
-			wake_up_process(waiter);
+			blk_wake_io_task(waiter);
 		}
 	}
 
diff --git a/fs/iomap.c b/fs/iomap.c
index f61d13dfdf09..b0462b363bad 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1525,7 +1525,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		if (dio->wait_for_completion) {
 			struct task_struct *waiter = dio->submit.waiter;
 			WRITE_ONCE(dio->submit.waiter, NULL);
-			wake_up_process(waiter);
+			blk_wake_io_task(waiter);
 		} else if (dio->flags & IOMAP_DIO_WRITE) {
 			struct inode *inode = file_inode(dio->iocb->ki_filp);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ad8474ec8c58..b0ce931cc734 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1798,4 +1798,17 @@ static inline int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 
 #endif /* CONFIG_BLOCK */
 
+static inline void blk_wake_io_task(struct task_struct *waiter)
+{
+	/*
+	 * If we're polling, the task itself is doing the completions. For
+	 * that case, we don't need to signal a wakeup, it's enough to just
+	 * mark us as RUNNING.
+	 */
+	if (waiter == current)
+		__set_current_state(TASK_RUNNING);
+	else
+		wake_up_process(waiter);
+}
+
 #endif
-- 
2.17.1
