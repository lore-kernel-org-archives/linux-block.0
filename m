Return-Path: <BATV+49f9428214963ec94ced+5065+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	mgorman@suse.de,
	Volker.Lendecke@sernet.de,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] block_dev: support RFW_NOWAIT on block device nodes
Date: Thu,  6 Jul 2017 08:30:19 -0700
Message-Id: <20170706153019.11645-5-hch@lst.de>
In-Reply-To: <20170706153019.11645-1-hch@lst.de>
References: <20170706153019.11645-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

All support is already there in the generic code, we just need to wire it
up.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index a7df151f8aba..f50026ec00c7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1739,6 +1739,8 @@ static int blkdev_open(struct inode * inode, struct file * filp)
 	 */
 	filp->f_flags |= O_LARGEFILE;
 
+	filp->f_mode |= FMODE_NOWAIT;
+
 	if (filp->f_flags & O_NDELAY)
 		filp->f_mode |= FMODE_NDELAY;
 	if (filp->f_flags & O_EXCL)
@@ -1890,6 +1892,9 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos >= size)
 		return -ENOSPC;
 
+	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT) == IOCB_NOWAIT)
+		return -EOPNOTSUPP;
+
 	iov_iter_truncate(from, size - iocb->ki_pos);
 
 	blk_start_plug(&plug);
-- 
2.11.0
