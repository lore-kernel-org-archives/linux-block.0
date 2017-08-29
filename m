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
Subject: [PATCH 2/4] fs: support IOCB_NOWAIT in generic_file_buffered_read
Date: Tue, 29 Aug 2017 16:13:19 +0200
Message-Id: <20170829141321.4482-3-hch@lst.de>
In-Reply-To: <20170829141321.4482-1-hch@lst.de>
References: <20170829141321.4482-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Milosz Tanski <milosz@adfin.com>

Allow generic_file_buffered_read to bail out early instead of waiting for
the page lock or reading a page if IOCB_NOWAIT is specified.

Signed-off-by: Milosz Tanski <milosz@adfin.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Acked-by: Sage Weil <sage@redhat.com>
---
 mm/filemap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4bcfa74ad802..eed394fd331c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1937,6 +1937,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
+			if (iocb->ki_flags & IOCB_NOWAIT)
+				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
@@ -1950,6 +1952,11 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					index, last_index - index);
 		}
 		if (!PageUptodate(page)) {
+			if (iocb->ki_flags & IOCB_NOWAIT) {
+				put_page(page);
+				goto would_block;
+			}
+
 			/*
 			 * See comment in do_read_cache_page on why
 			 * wait_on_page_locked is used to avoid unnecessarily
@@ -2131,6 +2138,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		goto readpage;
 	}
 
+would_block:
+	error = -EAGAIN;
 out:
 	ra->prev_pos = prev_index;
 	ra->prev_pos <<= PAGE_SHIFT;
-- 
2.11.0
