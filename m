Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] fs: add support for allowing applications to pass in write life time hints
Date: Fri, 16 Jun 2017 11:24:36 -0600
Message-Id: <1497633883-21230-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Add four flags for the pwritev2(2) system call, allowing an application
to give the kernel a hint about what on-media life times can be
expected from a given write.

The intent is for these values to be relative to each other, no
absolute meaning should be attached to these flag names.

Set aside 3 bits in the iocb flags structure to carry this information
over from the pwritev2 RWF_WRITE_LIFE_* flags.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/read_write.c         | 12 +++++++++++-
 include/linux/fs.h      | 12 ++++++++++++
 include/uapi/linux/fs.h | 10 ++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 19d4d88fa285..975fe1d46a59 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -675,10 +675,11 @@ EXPORT_SYMBOL(iov_shorten);
 static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 		loff_t *ppos, int type, int flags)
 {
+	struct inode *inode = file_inode(filp);
 	struct kiocb kiocb;
 	ssize_t ret;
 
-	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC))
+	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_WRITE_LIFE_MASK))
 		return -EOPNOTSUPP;
 
 	init_sync_kiocb(&kiocb, filp);
@@ -688,6 +689,15 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 		kiocb.ki_flags |= IOCB_DSYNC;
 	if (flags & RWF_SYNC)
 		kiocb.ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
+	if ((flags & RWF_WRITE_LIFE_MASK) ||
+	    mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT)) {
+		enum rw_hint hint;
+
+		hint = mask_to_write_hint(flags, RWF_WRITE_LIFE_SHIFT);
+
+		inode_set_write_hint(inode, hint);
+		kiocb.ki_flags |= write_hint_to_mask(hint, IOCB_WRITE_LIFE_SHIFT);
+	}
 	kiocb.ki_pos = *ppos;
 
 	if (type == READ)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 472c83156606..a024b32259bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -269,6 +269,12 @@ struct writeback_control;
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 
+/*
+ * Steal 3 bits for stream information, this allows 8 valid streams
+ */
+#define IOCB_WRITE_LIFE_SHIFT	7
+#define IOCB_WRITE_LIFE_MASK	(BIT(7) | BIT(8) | BIT(9))
+
 struct kiocb {
 	struct file		*ki_filp;
 	loff_t			ki_pos;
@@ -292,6 +298,12 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 	};
 }
 
+static inline int iocb_write_hint(const struct kiocb *iocb)
+{
+	return (iocb->ki_flags & IOCB_WRITE_LIFE_MASK) >>
+			IOCB_WRITE_LIFE_SHIFT;
+}
+
 /*
  * "descriptor" for what we're up to with a read.
  * This allows us to use the same read code yet
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 8fb3b5a6e1ec..0d9d331d3b61 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -374,4 +374,14 @@ enum rw_hint {
 #define RWF_DSYNC			0x00000002 /* per-IO O_DSYNC */
 #define RWF_SYNC			0x00000004 /* per-IO O_SYNC */
 
+/*
+ * Data life time write flags, steal 3 bits for that
+ */
+#define RWF_WRITE_LIFE_SHIFT		4
+#define RWF_WRITE_LIFE_MASK		0x00000070 /* 3 bits of write hints */
+#define RWF_WRITE_LIFE_SHORT		(WRITE_LIFE_SHORT << RWF_WRITE_LIFE_SHIFT)
+#define RWF_WRITE_LIFE_MEDIUM		(WRITE_LIFE_MEDIUM << RWF_WRITE_LIFE_SHIFT)
+#define RWF_WRITE_LIFE_LONG		(WRITE_LIFE_LONG << RWF_WRITE_LIFE_SHIFT)
+#define RWF_WRITE_LIFE_EXTREME		(WRITE_LIFE_EXTREME << RWF_WRITE_LIFE_SHIFT)
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.7.4
