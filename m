Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] fs: add support for allowing applications to pass in write life time hints
Date: Tue, 13 Jun 2017 11:15:17 -0600
Message-Id: <1497374123-15286-6-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Add four flags for the pwritev2(2) system call, allowing an application
to give the kernel a hint about what on-media life times can be
expected from a given write.

The intent is for these values to be relative to each other, no
absolute meaning should be attached to these flag names.

Define IOCB flags to carry this information over, and finally
transform them into the block defined stream values.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/read_write.c         | 17 ++++++++++++++++-
 include/linux/fs.h      | 18 ++++++++++++++++++
 include/uapi/linux/fs.h |  4 ++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 47c1d4484df9..1734728aa48b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -678,7 +678,9 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	struct kiocb kiocb;
 	ssize_t ret;
 
-	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC))
+	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_WRITE_LIFE_SHORT |
+			RWF_WRITE_LIFE_MEDIUM | RWF_WRITE_LIFE_LONG |
+			RWF_WRITE_LIFE_EXTREME))
 		return -EOPNOTSUPP;
 
 	init_sync_kiocb(&kiocb, filp);
@@ -688,6 +690,19 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 		kiocb.ki_flags |= IOCB_DSYNC;
 	if (flags & RWF_SYNC)
 		kiocb.ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
+	if (flags & RWF_WRITE_LIFE_SHORT) {
+		kiocb.ki_flags |= IOCB_WRITE_LIFE_SHORT;
+		file_inode(filp)->i_stream = WRITE_LIFE_SHORT;
+	} else if (flags & RWF_WRITE_LIFE_MEDIUM) {
+		kiocb.ki_flags |= IOCB_WRITE_LIFE_MEDIUM;
+		file_inode(filp)->i_stream = WRITE_LIFE_MEDIUM;
+	} else if (flags & RWF_WRITE_LIFE_LONG) {
+		kiocb.ki_flags |= IOCB_WRITE_LIFE_LONG;
+		file_inode(filp)->i_stream = WRITE_LIFE_LONG;
+	} else if (flags & RWF_WRITE_LIFE_EXTREME) {
+		kiocb.ki_flags |= IOCB_WRITE_LIFE_EXTREME;
+		file_inode(filp)->i_stream = WRITE_LIFE_EXTREME;
+	}
 	kiocb.ki_pos = *ppos;
 
 	if (type == READ)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bb8c246eeda8..7f542e0b0e17 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -269,6 +269,10 @@ struct writeback_control;
 #define IOCB_DSYNC		(1 << 4)
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
+#define IOCB_WRITE_LIFE_SHORT	(1 << 7)
+#define IOCB_WRITE_LIFE_MEDIUM	(1 << 8)
+#define IOCB_WRITE_LIFE_LONG	(1 << 9)
+#define IOCB_WRITE_LIFE_EXTREME	(1 << 10)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -293,6 +297,20 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 	};
 }
 
+static inline int iocb_streamid(const struct kiocb *iocb)
+{
+	if (iocb->ki_flags & IOCB_WRITE_LIFE_SHORT)
+		return WRITE_LIFE_SHORT;
+	else if (iocb->ki_flags & IOCB_WRITE_LIFE_MEDIUM)
+		return WRITE_LIFE_MEDIUM;
+	else if (iocb->ki_flags & IOCB_WRITE_LIFE_LONG)
+		return WRITE_LIFE_LONG;
+	else if (iocb->ki_flags & IOCB_WRITE_LIFE_EXTREME)
+		return WRITE_LIFE_EXTREME;
+
+	return WRITE_LIFE_UNKNOWN;
+}
+
 /*
  * "descriptor" for what we're up to with a read.
  * This allows us to use the same read code yet
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 24e61a54feaa..34145b29657e 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -360,5 +360,9 @@ struct fscrypt_key {
 #define RWF_HIPRI			0x00000001 /* high priority request, poll if possible */
 #define RWF_DSYNC			0x00000002 /* per-IO O_DSYNC */
 #define RWF_SYNC			0x00000004 /* per-IO O_SYNC */
+#define RWF_WRITE_LIFE_SHORT		0x00000008 /* short life time write */
+#define RWF_WRITE_LIFE_MEDIUM		0x00000010 /* medium life time write */
+#define RWF_WRITE_LIFE_LONG		0x00000020 /* long life time write */
+#define RWF_WRITE_LIFE_EXTREME		0x00000040 /* extremely long life time write */
 
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.7.4
