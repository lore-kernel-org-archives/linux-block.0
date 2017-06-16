Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] fs: add fcntl() interface for setting/getting write life time hints
Date: Fri, 16 Jun 2017 11:24:37 -0600
Message-Id: <1497633883-21230-6-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We have a pwritev2(2) interface based on passing in flags. Add an
fcntl interface for querying these flags, and also for setting them
as well:

F_GET_RW_HINT		Returns the read/write hint set. Right now it
			will be one of the WRITE_LIFE_* values.

F_SET_RW_HINT		Pass in rw_hint type to set the read/write hint.
			Only WRITE_LIFE_* hints are currently supported.
			Returns 0 on succes, -1 otherwise.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/fcntl.c                 | 38 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fcntl.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f4e7267d117f..417ce336c875 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -243,6 +243,40 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
+long fcntl_rw_hint(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	long ret;
+
+	switch (cmd) {
+	case F_GET_RW_HINT:
+		ret = mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
+		break;
+	case F_SET_RW_HINT: {
+		enum rw_hint hint = arg;
+
+		switch (hint) {
+		case WRITE_LIFE_NONE:
+		case WRITE_LIFE_SHORT:
+		case WRITE_LIFE_MEDIUM:
+		case WRITE_LIFE_LONG:
+		case WRITE_LIFE_EXTREME:
+			inode_set_write_hint(inode, hint);
+			ret = 0;
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
+		}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -337,6 +371,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_GET_SEALS:
 		err = shmem_fcntl(filp, cmd, arg);
 		break;
+	case F_GET_RW_HINT:
+	case F_SET_RW_HINT:
+		err = fcntl_rw_hint(filp, cmd, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 813afd6eee71..bd24c9b48bd0 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,12 @@
 /* (1U << 31) is reserved for signed error codes */
 
 /*
+ * Set/Get write life time hints
+ */
+#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
+#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 20)
+
+/*
  * Types of directory notifications that may be requested.
  */
 #define DN_ACCESS	0x00000001	/* File accessed */
-- 
2.7.4
