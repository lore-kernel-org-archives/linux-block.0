Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54294 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBHOg7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Feb 2018 09:36:59 -0500
From: Nitesh Shetty <nj.shetty@samsung.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc: linux-block@vger.kernel.org, axboe@fb.com,
        linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
        joshi.k@samsung.com
Subject: [PATCH] blk: optimization for classic polling
Date: Sun, 30 May 2083 09:51:06 +0530
Message-id: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This removes the dependency on interrupts to wake up task. Set task
state as TASK_RUNNING, if need_resched() returns true,
while polling for IO completion.
Earlier, polling task used to sleep, relying on interrupt to wake it up.
This made some IO take very long when interrupt-coalescing is enabled in
NVMe.

Reference:
http://lists.infradead.org/pipermail/linux-nvme/2018-February/015435.html
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/block_dev.c | 16 ++++++++++++----
 fs/direct-io.c |  8 ++++++--
 fs/iomap.c     | 10 +++++++---
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4a181fc..a87d8b7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -236,9 +236,13 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!READ_ONCE(bio.bi_private))
 			break;
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc))
+		if (!(iocb->ki_flags & IOCB_HIPRI))
 			io_schedule();
+		else if (!blk_poll(bdev_get_queue(bdev), qc)) {
+			if (need_resched())
+				set_current_state(TASK_RUNNING);
+			io_schedule();
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 
@@ -401,9 +405,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc))
+		if (!(iocb->ki_flags & IOCB_HIPRI))
 			io_schedule();
+		else if (!blk_poll(bdev_get_queue(bdev), qc)) {
+			if (need_resched())
+				set_current_state(TASK_RUNNING);
+			io_schedule();
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index a0ca9e4..c815ac9 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -518,9 +518,13 @@ static struct bio *dio_await_one(struct dio *dio)
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		dio->waiter = current;
 		spin_unlock_irqrestore(&dio->bio_lock, flags);
-		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie))
+		if (!(dio->iocb->ki_flags & IOCB_HIPRI))
 			io_schedule();
+		else if (!blk_poll(dio->bio_disk->queue, dio->bio_cookie)) {
+			if (need_resched())
+				__set_current_state(TASK_RUNNING);
+			io_schedule();
+		}
 		/* wake up sets us TASK_RUNNING */
 		spin_lock_irqsave(&dio->bio_lock, flags);
 		dio->waiter = NULL;
diff --git a/fs/iomap.c b/fs/iomap.c
index afd1635..b51569d 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1072,10 +1072,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 				break;
 
 			if (!(iocb->ki_flags & IOCB_HIPRI) ||
-			    !dio->submit.last_queue ||
-			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie))
+			    !dio->submit.last_queue)
 				io_schedule();
+			else if (!blk_poll(dio->submit.last_queue,
+					 dio->submit.cookie)) {
+				if (need_resched())
+					set_current_state(TASK_RUNNING);
+				io_schedule();
+			}
 		}
 		__set_current_state(TASK_RUNNING);
 	}
-- 
2.7.4
