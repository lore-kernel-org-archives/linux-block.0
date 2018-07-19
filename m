Return-Path: <mwilck@suse.com>
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Jan Kara <jack@suse.com>
Cc: Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v3 3/3] blkdev: __blkdev_direct_IO_simple: make sure to fill up the bio
Date: Thu, 19 Jul 2018 23:01:58 +0200
Message-Id: <20180719210158.25923-4-mwilck@suse.com>
In-Reply-To: <20180719210158.25923-1-mwilck@suse.com>
References: <20180719210158.25923-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

When bio_iov_iter_get_pages() is called from  __blkdev_direct_IO_simple(),
we already know that the content of the input iov_iter fits into a single
bio, so we expect iov_iter_count(iter) to drop to 0. But in a single invocation,
bio_iov_iter_get_pages() may add less bytes then we expect. For iov_iters with
multiple segments (generated e.g. by writev()), it behaves like an iterator's
next() function, taking only one step (segment) at a time. Furthermore, MM may
fail or refuse to pin all requested pages. The latter may signify an error condition
(in which case eventually an error code will be returned), the former does not. 

Call bio_iov_iter_get_pages() repeatedly to avoid short reads or writes.
Otherwise, __generic_file_write_iter() falls back to buffered writes, which
has been observed to cause data corruption in certain workloads.

Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for simplified bdev direct-io")
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fs/block_dev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index aba2541..561c34e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -222,6 +222,24 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
 		goto out;
+
+	/*
+	 * bio_iov_iter_get_pages() may add less bytes than we expect:
+	 * - for multi-segment iov_iters, as it only adds one segment at a time
+	 * - if MM refuses or fails to pin all requested pages. In this case,
+	 *   an error is returned eventually if no progress can be made.
+	 */
+	while (iov_iter_count(iter) > 0 && bio.bi_vcnt < bio.bi_max_vecs) {
+		ret = bio_iov_iter_get_pages(&bio, iter);
+		if (unlikely(ret))
+			goto out;
+	}
+	/*
+	 * Our bi_io_vec should be big enough to hold all data from the
+	 * iov_iter, as this has been checked before calling this function.
+	 */
+	WARN_ON_ONCE(iov_iter_count(iter) > 0);
+
 	ret = bio.bi_iter.bi_size;
 
 	if (iov_iter_rw(iter) == READ) {
-- 
2.17.1
