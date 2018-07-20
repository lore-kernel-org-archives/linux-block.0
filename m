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
Subject: [PATCH v4 2/4] blkdev: __blkdev_direct_IO_simple: fix leak in error case
Date: Fri, 20 Jul 2018 15:05:50 +0200
Message-Id: <20180720130552.21432-3-mwilck@suse.com>
In-Reply-To: <20180720130552.21432-1-mwilck@suse.com>
References: <20180720130552.21432-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for
 simplified bdev direct-io")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 fs/block_dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0dd87aa..aba2541 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -221,7 +221,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
-		return ret;
+		goto out;
 	ret = bio.bi_iter.bi_size;
 
 	if (iov_iter_rw(iter) == READ) {
@@ -250,12 +250,13 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		put_page(bvec->bv_page);
 	}
 
-	if (vecs != inline_vecs)
-		kfree(vecs);
-
 	if (unlikely(bio.bi_status))
 		ret = blk_status_to_errno(bio.bi_status);
 
+out:
+	if (vecs != inline_vecs)
+		kfree(vecs);
+
 	bio_uninit(&bio);
 
 	return ret;
-- 
2.17.1
