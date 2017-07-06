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
Subject: [PATCH 2/4] fs: support IOCB_NOWAIT in generic_file_buffered_read
Date: Thu,  6 Jul 2017 08:30:17 -0700
Message-Id: <20170706153019.11645-3-hch@lst.de>
In-Reply-To: <20170706153019.11645-1-hch@lst.de>
References: <20170706153019.11645-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Milosz Tanski <milosz@adfin.com>

Allow generic_file_buffered_read to bail out early instead of waiting for
the page lock or reading a page if IOCB_NOWAIT is specified.

Signed-off-by: Milosz Tanski <milosz@adfin.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Acked-by: Sage Weil <sage@redhat.com>
---
 mm/filemap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9865350d6b89..bb70b64ffb48 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1843,6 +1843,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
+			if (iocb->ki_flags & IOCB_NOWAIT)
+				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
@@ -1948,6 +1950,11 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		continue;
 
 page_not_up_to_date:
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			put_page(page);
+			goto would_block;
+		}
+
 		/* Get exclusive access to the page ... */
 		error = lock_page_killable(page);
 		if (unlikely(error))
@@ -1967,6 +1974,12 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			goto page_ok;
 		}
 
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			unlock_page(page);
+			put_page(page);
+			goto would_block;
+		}
+
 readpage:
 		/*
 		 * A previous I/O error may have been due to temporary
@@ -2037,6 +2050,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		goto readpage;
 	}
 
+would_block:
+	error = -EAGAIN;
 out:
 	ra->prev_pos = prev_index;
 	ra->prev_pos <<= PAGE_SHIFT;
-- 
2.11.0
