Return-Path: <mwilck@suse.com>
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v4 4/4] blkdev: __blkdev_direct_IO_simple: make sure to fill up the bio
Date: Fri, 20 Jul 2018 15:05:52 +0200
Message-Id: <20180720130552.21432-5-mwilck@suse.com>
In-Reply-To: <20180720130552.21432-1-mwilck@suse.com>
References: <20180720130552.21432-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

bio_iov_iter_get_pages() returns only pages for a single non-empty
segment of the input iov_iter's iovec. This may be less than the
number of pages __blkdev_direct_IO_simple() is supposed to process.
Call the new bio_iov_iter_get_all_pages() helper instead to avoid
short reads or writes. Otherwise, __generic_file_write_iter() falls
back to buffered writes, which has been observed to cause data
corruption in certain workloads.

Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for
 simplified bdev direct-io")
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fs/block_dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index aba2541..010708a 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -219,9 +219,16 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio.bi_end_io = blkdev_bio_end_io_simple;
 	bio.bi_ioprio = iocb->ki_ioprio;
 
-	ret = bio_iov_iter_get_pages(&bio, iter);
+	ret = bio_iov_iter_get_all_pages(&bio, iter);
 	if (unlikely(ret))
 		goto out;
+
+	/*
+	 * Our bi_io_vec should be big enough to hold all data from the
+	 * iov_iter, as this has been checked before calling this function.
+	 */
+	WARN_ON_ONCE(iov_iter_count(iter));
+
 	ret = bio.bi_iter.bi_size;
 
 	if (iov_iter_rw(iter) == READ) {
-- 
2.17.1
