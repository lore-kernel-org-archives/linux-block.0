Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: axboe@kernel.dk
Cc: viro@ZenIV.linux.org.uk,
	hch@lst.de,
	jack@suse.cz,
	akpm@linux-foundation.org,
	linux-block@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 06/10] fs: Introduce IOMAP_NOWAIT
Date: Tue, 20 Jun 2017 07:05:45 -0500
Message-Id: <20170620120549.23147-7-rgoldwyn@suse.de>
In-Reply-To: <20170620120549.23147-1-rgoldwyn@suse.de>
References: <20170620120549.23147-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

IOCB_NOWAIT translates to IOMAP_NOWAIT for iomaps.
This is used by XFS in the XFS patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap.c            | 8 ++++++++
 include/linux/iomap.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index 18f2f2b8ba2c..c71a64b97fba 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -881,6 +881,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		flags |= IOMAP_WRITE;
 	}
 
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (filemap_range_has_page(mapping, start, end)) {
+			ret = -EAGAIN;
+			goto out_free_dio;
+		}
+		flags |= IOMAP_NOWAIT;
+	}
+
 	ret = filemap_write_and_wait_range(mapping, start, end);
 	if (ret)
 		goto out_free_dio;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f753e788da31..69f4e9470084 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -52,6 +52,7 @@ struct iomap {
 #define IOMAP_REPORT		(1 << 2) /* report extent status, e.g. FIEMAP */
 #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
 #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
+#define IOMAP_NOWAIT		(1 << 5) /* Don't wait for writeback */
 
 struct iomap_ops {
 	/*
-- 
2.12.0
