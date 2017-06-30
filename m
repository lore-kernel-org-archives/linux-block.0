Return-Path: <BATV+65e7e9a0a5a64ea7fcea+5059+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	mgorman@suse.de,
	Volker.Lendecke@sernet.de,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/3] fs: pass iocb to do_generic_file_read
Date: Fri, 30 Jun 2017 11:15:19 -0700
Message-Id: <20170630181521.29148-2-hch@lst.de>
In-Reply-To: <20170630181521.29148-1-hch@lst.de>
References: <20170630181521.29148-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

And rename it to the more descriptive generic_file_buffered_read while
at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 742034e56100..3df0a57cd48e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1792,9 +1792,8 @@ static void shrink_readahead_size_eio(struct file *filp,
 }
 
 /**
- * do_generic_file_read - generic file read routine
- * @filp:	the file to read
- * @ppos:	current file position
+ * generic_file_buffered_read - generic file read routine
+ * @iocb:	the iocb to read
  * @iter:	data destination
  * @written:	already copied
  *
@@ -1804,12 +1803,14 @@ static void shrink_readahead_size_eio(struct file *filp,
  * This is really ugly. But the goto's actually try to clarify some
  * of the logic when it comes to error handling etc.
  */
-static ssize_t do_generic_file_read(struct file *filp, loff_t *ppos,
+static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		struct iov_iter *iter, ssize_t written)
 {
+	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
 	struct file_ra_state *ra = &filp->f_ra;
+	loff_t *ppos = &iocb->ki_pos;
 	pgoff_t index;
 	pgoff_t last_index;
 	pgoff_t prev_index;
@@ -2057,14 +2058,14 @@ static ssize_t do_generic_file_read(struct file *filp, loff_t *ppos,
 ssize_t
 generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct file *file = iocb->ki_filp;
-	ssize_t retval = 0;
 	size_t count = iov_iter_count(iter);
+	ssize_t retval = 0;
 
 	if (!count)
 		goto out; /* skip atime */
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
+		struct file *file = iocb->ki_filp;
 		struct address_space *mapping = file->f_mapping;
 		struct inode *inode = mapping->host;
 		loff_t size;
@@ -2105,7 +2106,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto out;
 	}
 
-	retval = do_generic_file_read(file, &iocb->ki_pos, iter, retval);
+	retval = generic_file_buffered_read(iocb, iter, retval);
 out:
 	return retval;
 }
-- 
2.11.0
