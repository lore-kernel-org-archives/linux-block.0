Return-Path: <BATV+2972572aac770b70d036+5119+infradead.org+hch@bombadil.srs.infradead.org>
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
Date: Tue, 29 Aug 2017 16:13:21 +0200
Message-Id: <20170829141321.4482-5-hch@lst.de>
In-Reply-To: <20170829141321.4482-1-hch@lst.de>
References: <20170829141321.4482-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

All support is already there in the generic code, we just need to wire
it up.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9941dc8342df..ea21d18d8e79 100644
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
@@ -1891,6 +1893,9 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos >= size)
 		return -ENOSPC;
 
+	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
+		return -EOPNOTSUPP;
+
 	iov_iter_truncate(from, size - iocb->ki_pos);
 
 	blk_start_plug(&plug);
-- 
2.11.0
