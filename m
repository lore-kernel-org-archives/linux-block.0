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
Subject: [PATCH v3 2/3] blkdev: __blkdev_direct_IO_simple: fix leak in error case
Date: Thu, 19 Jul 2018 23:01:57 +0200
Message-Id: <20180719210158.25923-3-mwilck@suse.com>
In-Reply-To: <20180719210158.25923-1-mwilck@suse.com>
References: <20180719210158.25923-1-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for simplified bdev direct-io")
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
