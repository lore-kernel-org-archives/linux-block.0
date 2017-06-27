Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/9] fs: add fcntl() interface for setting/getting write
 life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
 martin.petersen@oracle.com
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
 <1498491480-16306-2-git-send-email-axboe@kernel.dk>
 <20170627144255.GB2541@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ec6ab0fa-60d7-3aa5-aa7c-81c105bdd488@kernel.dk>
Date: Tue, 27 Jun 2017 09:09:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170627144255.GB2541@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/27/2017 08:42 AM, Christoph Hellwig wrote:
> The API looks ok, but the code could use some cleanups.  What do
> you think about the incremental patch below:
> 
> It refactors various manipulations, and stores the write hint right
> in the iocb as there is a 4 byte hole (this will need some minor
> adjustments in the next patches):

How's this? Fixes for compile, and also squeeze an enum rw_hint into
a hole in the inode structure.

I'll refactor around this and squeeze into bio/rq holes as well, then
re-test it.

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f4e7267d117f..25f96a101f1a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -243,6 +243,62 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
+static bool rw_hint_valid(enum rw_hint hint)
+{
+	switch (hint) {
+	case RWF_WRITE_LIFE_NOT_SET:
+	case RWH_WRITE_LIFE_NONE:
+	case RWH_WRITE_LIFE_SHORT:
+	case RWH_WRITE_LIFE_MEDIUM:
+	case RWH_WRITE_LIFE_LONG:
+	case RWH_WRITE_LIFE_EXTREME:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static long fcntl_rw_hint(struct file *file, unsigned int cmd,
+			  unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	u64 *argp = (u64 __user *)arg;
+	enum rw_hint hint;
+
+	switch (cmd) {
+	case F_GET_FILE_RW_HINT:
+		if (put_user(__file_write_hint(file), argp))
+			return -EFAULT;
+		return 0;
+	case F_SET_FILE_RW_HINT:
+		if (get_user(hint, argp))
+			return -EFAULT;
+		if (!rw_hint_valid(hint))
+			return -EINVAL;
+
+		spin_lock(&file->f_lock);
+		file->f_write_hint = hint;
+		spin_unlock(&file->f_lock);
+		return 0;
+	case F_GET_RW_HINT:
+		if (put_user(__inode_write_hint(inode), argp))
+			return -EFAULT;
+		return 0;
+	case F_SET_RW_HINT:
+		if (get_user(hint, argp))
+			return -EFAULT;
+		if (!rw_hint_valid(hint))
+			return -EINVAL;
+
+		inode_lock(inode);
+		inode->i_write_hint = hint;
+		inode_unlock(inode);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -337,6 +393,12 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_GET_SEALS:
 		err = shmem_fcntl(filp, cmd, arg);
 		break;
+	case F_GET_RW_HINT:
+	case F_SET_RW_HINT:
+	case F_GET_FILE_RW_HINT:
+	case F_SET_FILE_RW_HINT:
+		err = fcntl_rw_hint(filp, cmd, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/inode.c b/fs/inode.c
index db5914783a71..f0e5fc77e6a4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -146,6 +146,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	i_gid_write(inode, 0);
 	atomic_set(&inode->i_writecount, 0);
 	inode->i_size = 0;
+	inode->i_write_hint = WRITE_LIFE_NOT_SET;
 	inode->i_blocks = 0;
 	inode->i_bytes = 0;
 	inode->i_generation = 0;
diff --git a/fs/open.c b/fs/open.c
index cd0c5be8d012..3fe0c4aa7d27 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -759,6 +759,7 @@ static int do_dentry_open(struct file *f,
 	     likely(f->f_op->write || f->f_op->write_iter))
 		f->f_mode |= FMODE_CAN_WRITE;
 
+	f->f_write_hint = WRITE_LIFE_NOT_SET;
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4574121f4746..4587a181162e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -265,6 +265,20 @@ struct page;
 struct address_space;
 struct writeback_control;
 
+#include <linux/fcntl.h>
+
+/*
+ * Write life time hint values.
+ */
+enum rw_hint {
+	WRITE_LIFE_NOT_SET	= 0,
+	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
+	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
+	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
+	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
+	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
+};
+
 #define IOCB_EVENTFD		(1 << 0)
 #define IOCB_APPEND		(1 << 1)
 #define IOCB_DIRECT		(1 << 2)
@@ -280,6 +294,7 @@ struct kiocb {
 	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
 	void			*private;
 	int			ki_flags;
+	enum rw_hint		ki_hint;
 };
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -597,6 +612,7 @@ struct inode {
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
 	unsigned int		i_blkbits;
+	enum rw_hint		i_write_hint;
 	blkcnt_t		i_blocks;
 
 #ifdef __NEED_I_SIZE_ORDERED
@@ -851,6 +867,7 @@ struct file {
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
+	enum rw_hint		f_write_hint;
 	atomic_long_t		f_count;
 	unsigned int 		f_flags;
 	fmode_t			f_mode;
@@ -1026,8 +1043,6 @@ struct file_lock_context {
 #define OFFT_OFFSET_MAX	INT_LIMIT(off_t)
 #endif
 
-#include <linux/fcntl.h>
-
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
 /*
@@ -1878,6 +1893,35 @@ static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
 }
 
+static inline enum rw_hint __inode_write_hint(struct inode *inode)
+{
+	return inode->i_write_hint;
+}
+
+static inline enum rw_hint inode_write_hint(struct inode *inode)
+{
+	enum rw_hint ret = __inode_write_hint(inode);
+	if (ret != WRITE_LIFE_NOT_SET)
+		return ret;
+	return WRITE_LIFE_NONE;
+}
+
+static inline enum rw_hint __file_write_hint(struct file *file)
+{
+	if (file->f_write_hint != WRITE_LIFE_NOT_SET)
+		return file->f_write_hint;
+
+	return __inode_write_hint(file_inode(file));
+}
+
+static inline enum rw_hint file_write_hint(struct file *file)
+{
+	enum rw_hint ret = __file_write_hint(file);
+	if (ret != WRITE_LIFE_NOT_SET)
+		return ret;
+	return WRITE_LIFE_NONE;
+}
+
 /*
  * Inode state bits.  Protected by inode->i_lock
  *
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 813afd6eee71..ec69d55bcec7 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,27 @@
 /* (1U << 31) is reserved for signed error codes */
 
 /*
+ * Set/Get write life time hints. {GET,SET}_RW_HINT operate on the
+ * underlying inode, while {GET,SET}_FILE_RW_HINT operate only on
+ * the specific file.
+ */
+#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
+#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
+#define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
+#define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
+
+/*
+ * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
+ * used to clear any hints previously set.
+ */
+#define RWF_WRITE_LIFE_NOT_SET	0
+#define RWH_WRITE_LIFE_NONE	1
+#define RWH_WRITE_LIFE_SHORT	2
+#define RWH_WRITE_LIFE_MEDIUM	3
+#define RWH_WRITE_LIFE_LONG	4
+#define RWH_WRITE_LIFE_EXTREME	5
+
+/*
  * Types of directory notifications that may be requested.
  */
 #define DN_ACCESS	0x00000001	/* File accessed */

-- 
Jens Axboe
