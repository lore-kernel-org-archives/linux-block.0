Return-Path: <mwilck@suse.com>
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.com>,
	Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>
Subject: [RFC PATCH] blkdev: __blkdev_direct_IO: collect async writes in error case
Date: Wed, 25 Jul 2018 23:26:44 +0200
Message-Id: <20180725212644.13902-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

Hi Christoph, Jens, Jan, all,

while pondering over blkdev_direct_IO(), I found the following semantic change
introduced by 542ff7b in the "normal" (i.e. not "simple") path, and came up
with this patch. Please tell me what you think.

Thanks
Martin

For the blkdev_direc_IO() path, the call to do_blockdev_direct_IO() has been
replaced by __blkdev_direct_IO() in 542ff7bf18c6.

do_blockdev_direct_IO() takes care not to leave async bios in flight for
partial writes if an error occurs. Implement the same semantics for
__blkdev_direct_IO().

Signed-off-by: Martin Wilck <mwilck@suse.com>
Fixes: 542ff7bf18c6 ("block: new direct I/O implementation")
---
 fs/block_dev.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index aba2541..9d17260 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -363,7 +363,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
 			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
+			if (!dio->multi_bio || is_sync || is_read)
+				bio_endio(bio);
 			break;
 		}
 
@@ -397,8 +398,29 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	}
 	blk_finish_plug(&plug);
 
-	if (!is_sync)
-		return -EIOCBQUEUED;
+	if (!is_sync) {
+		if (!ret || is_read)
+			return -EIOCBQUEUED;
+
+		else if (dio->multi_bio) {
+			/*
+			 * Special case: async, WRITE, page-pinning error,
+			 * and at least one bio submitted already.
+			 * In this case we return an error. We need to wait
+			 * for already-submitted bios to finish.
+			 */
+			for (;;) {
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				if (atomic_read(&dio->ref) == 1)
+					break;
+				/* Nothing to poll for here */
+				io_schedule();
+			}
+			__set_current_state(TASK_RUNNING);
+			bio_endio(bio);
+		}
+		return ret;
+	}
 
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-- 
2.17.1
