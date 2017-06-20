Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: axboe@kernel.dk
Cc: viro@ZenIV.linux.org.uk,
	hch@lst.de,
	jack@suse.cz,
	akpm@linux-foundation.org,
	linux-block@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 05/10] fs: return if direct I/O will trigger writeback
Date: Tue, 20 Jun 2017 07:05:44 -0500
Message-Id: <20170620120549.23147-6-rgoldwyn@suse.de>
In-Reply-To: <20170620120549.23147-1-rgoldwyn@suse.de>
References: <20170620120549.23147-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Find out if the I/O will trigger a wait due to writeback. If yes,
return -EAGAIN.

Return -EINVAL for buffered AIO: there are multiple causes of
delay such as page locks, dirty throttling logic, page loading
from disk etc. which cannot be taken care of.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 mm/filemap.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9b39a2390b9e..742034e56100 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2070,10 +2070,17 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		loff_t size;
 
 		size = i_size_read(inode);
-		retval = filemap_write_and_wait_range(mapping, iocb->ki_pos,
-					iocb->ki_pos + count - 1);
-		if (retval < 0)
-			goto out;
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (filemap_range_has_page(mapping, iocb->ki_pos,
+						   iocb->ki_pos + count - 1))
+				return -EAGAIN;
+		} else {
+			retval = filemap_write_and_wait_range(mapping,
+						iocb->ki_pos,
+					        iocb->ki_pos + count - 1);
+			if (retval < 0)
+				goto out;
+		}
 
 		file_accessed(file);
 
@@ -2674,6 +2681,9 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 
 	pos = iocb->ki_pos;
 
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
+		return -EINVAL;
+
 	if (limit != RLIM_INFINITY) {
 		if (iocb->ki_pos >= limit) {
 			send_sig(SIGXFSZ, current, 0);
@@ -2742,9 +2752,17 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	write_len = iov_iter_count(from);
 	end = (pos + write_len - 1) >> PAGE_SHIFT;
 
-	written = filemap_write_and_wait_range(mapping, pos, pos + write_len - 1);
-	if (written)
-		goto out;
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		/* If there are pages to writeback, return */
+		if (filemap_range_has_page(inode->i_mapping, pos,
+					   pos + iov_iter_count(from)))
+			return -EAGAIN;
+	} else {
+		written = filemap_write_and_wait_range(mapping, pos,
+							pos + write_len - 1);
+		if (written)
+			goto out;
+	}
 
 	/*
 	 * After a write we want buffered reads to be sure to go to disk to get
-- 
2.12.0
