Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: axboe@kernel.dk
Cc: viro@ZenIV.linux.org.uk,
	hch@lst.de,
	jack@suse.cz,
	akpm@linux-foundation.org,
	linux-block@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 01/10] fs: Separate out kiocb flags setup based on RWF_* flags
Date: Mon, 19 Jun 2017 11:33:39 -0500
Message-Id: <20170619163348.15542-2-rgoldwyn@suse.de>
In-Reply-To: <20170619163348.15542-1-rgoldwyn@suse.de>
References: <20170619163348.15542-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Also added RWF_SUPPORTED to encompass all flags.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/read_write.c         | 12 +++---------
 include/linux/fs.h      | 14 ++++++++++++++
 include/uapi/linux/fs.h |  2 ++
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 47c1d4484df9..53c816c61122 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -678,16 +678,10 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	struct kiocb kiocb;
 	ssize_t ret;
 
-	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC))
-		return -EOPNOTSUPP;
-
 	init_sync_kiocb(&kiocb, filp);
-	if (flags & RWF_HIPRI)
-		kiocb.ki_flags |= IOCB_HIPRI;
-	if (flags & RWF_DSYNC)
-		kiocb.ki_flags |= IOCB_DSYNC;
-	if (flags & RWF_SYNC)
-		kiocb.ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
+	ret = kiocb_set_rw_flags(&kiocb, flags);
+	if (ret)
+		return ret;
 	kiocb.ki_pos = *ppos;
 
 	if (type == READ)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 023f0324762b..96a1a1fa54a9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3057,6 +3057,20 @@ static inline int iocb_flags(struct file *file)
 	return res;
 }
 
+static inline int kiocb_set_rw_flags(struct kiocb *ki, int flags)
+{
+	if (unlikely(flags & ~RWF_SUPPORTED))
+		return -EOPNOTSUPP;
+
+	if (flags & RWF_HIPRI)
+		ki->ki_flags |= IOCB_HIPRI;
+	if (flags & RWF_DSYNC)
+		ki->ki_flags |= IOCB_DSYNC;
+	if (flags & RWF_SYNC)
+		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
+	return 0;
+}
+
 static inline ino_t parent_ino(struct dentry *dentry)
 {
 	ino_t res;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 24e61a54feaa..937c3e39650a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -361,4 +361,6 @@ struct fscrypt_key {
 #define RWF_DSYNC			0x00000002 /* per-IO O_DSYNC */
 #define RWF_SYNC			0x00000004 /* per-IO O_SYNC */
 
+#define RWF_SUPPORTED			(RWF_HIPRI | RWF_DSYNC | RWF_SYNC)
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.12.0
