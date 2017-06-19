Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/9] fs: add fcntl() interface for setting/getting write life time hints
Date: Mon, 19 Jun 2017 11:04:54 -0600
Message-Id: <1497891902-25737-2-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
References: <1497891902-25737-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Define a set of write life time hints:

and add an fcntl interface for querying these flags, and also for
setting them as well:

F_GET_RW_HINT		Returns the read/write hint set.

F_SET_RW_HINT		Pass one of the above write hints.

The user passes in a 64-bit pointer to get/set these values, and
the interface returns 0/-1 on success/error.

Sample program testing/implementing basic setting/getting of write
hints is below.

Add support for storing the write life time hint in the inode flags,
and pass them to the kiocb flags as well. This is in preparation
for utilizing these hints in the block layer, to guide on-media
data placement.

/*
 * writehint.c: check or set a file/inode write hint
 */

static char *str[] = { "WRITE_LIFE_NONE", "WRITE_LIFE_SHORT",
			"WRITE_LIFE_MEDIUM", "WRITE_LIFE_LONG",
			"WRITE_LIFE_EXTREME" };

int main(int argc, char *argv[])
{
	uint64_t hint = -1ULL;
	int fd, ret;

	if (argc < 2) {
		fprintf(stderr, "%s: dev <hint>\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd < 0) {
		perror("open");
		return 2;
	}

	if (argc > 2)
		hint = atoi(argv[2]);

	if (hint == -1ULL) {
		ret = fcntl(fd, F_RW_GET_HINT, &hint);
		if (ret < 0) {
			perror("fcntl: F_RW_GET_HINT");
			return 3;
		}
	} else {
		ret = fcntl(fd, F_RW_SET_HINT, &hint);
		if (ret < 0) {
			perror("fcntl: F_RW_SET_HINT");
			return 4;
		}
	}

	printf("%s: %shint %s\n", argv[1], hint != -1ULL ? "set " : "", str[hint]);
	close(fd);
	return 0;
}

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/fcntl.c                 | 43 ++++++++++++++++++++++++++++++++
 fs/inode.c                 | 11 +++++++++
 include/linux/fs.h         | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fcntl.h | 15 ++++++++++++
 4 files changed, 130 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f4e7267d117f..113b78c11631 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -243,6 +243,45 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
+static long fcntl_rw_hint(struct file *file, unsigned int cmd,
+			  u64 __user *ptr)
+{
+	struct inode *inode = file_inode(file);
+	long ret = 0;
+	u64 hint;
+
+	switch (cmd) {
+	case F_GET_RW_HINT:
+		hint = mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
+		if (put_user(hint, ptr))
+			ret = -EFAULT;
+		break;
+	case F_SET_RW_HINT:
+		if (get_user(hint, ptr)) {
+			ret = -EFAULT;
+			break;
+		}
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
@@ -337,6 +376,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_GET_SEALS:
 		err = shmem_fcntl(filp, cmd, arg);
 		break;
+	case F_GET_RW_HINT:
+	case F_SET_RW_HINT:
+		err = fcntl_rw_hint(filp, cmd, (u64 __user *) arg);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/inode.c b/fs/inode.c
index db5914783a71..defb015a2c6d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2120,3 +2120,14 @@ struct timespec current_time(struct inode *inode)
 	return timespec_trunc(now, inode->i_sb->s_time_gran);
 }
 EXPORT_SYMBOL(current_time);
+
+void inode_set_write_hint(struct inode *inode, enum rw_hint hint)
+{
+	unsigned int flags = write_hint_to_mask(hint, S_WRITE_LIFE_SHIFT);
+
+	if (flags != mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT)) {
+		inode_lock(inode);
+		inode_set_flags(inode, flags, S_WRITE_LIFE_MASK);
+		inode_unlock(inode);
+	}
+}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 023f0324762b..8720251cc153 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -270,6 +270,12 @@ struct writeback_control;
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
@@ -293,6 +299,12 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
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
@@ -1829,6 +1841,14 @@ struct super_operations {
 #endif
 
 /*
+ * Expected life time hint of a write for this inode. This uses the
+ * WRITE_LIFE_* encoding, we just need to define the shift. We need
+ * 3 bits for this. Next S_* value is 131072, bit 17.
+ */
+#define S_WRITE_LIFE_MASK	0x1c000	/* bits 14..16 */
+#define S_WRITE_LIFE_SHIFT	14	/* 16384, next bit */
+
+/*
  * Note that nosuid etc flags are inode-specific: setting some file-system
  * flags just means all the inodes inherit those flags by default. It might be
  * possible to override it selectively if you really wanted to with some
@@ -1875,6 +1895,37 @@ static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 }
 
 /*
+ * Write life time hint values.
+ */
+enum rw_hint {
+	WRITE_LIFE_NONE = RWH_WRITE_LIFE_NONE,
+	WRITE_LIFE_SHORT = RWH_WRITE_LIFE_SHORT,
+	WRITE_LIFE_MEDIUM = RWH_WRITE_LIFE_MEDIUM,
+	WRITE_LIFE_LONG = RWH_WRITE_LIFE_LONG,
+	WRITE_LIFE_EXTREME = RWH_WRITE_LIFE_EXTREME
+};
+
+static inline unsigned int write_hint_to_mask(enum rw_hint hint,
+					      unsigned int shift)
+{
+	return hint << shift;
+}
+
+static inline enum rw_hint mask_to_write_hint(unsigned int mask,
+					      unsigned int shift)
+{
+	return (mask >> shift) & 0x7;
+}
+
+static inline unsigned int inode_write_hint(struct inode *inode)
+{
+	if (inode)
+		return mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
+
+	return 0;
+}
+
+/*
  * Inode state bits.  Protected by inode->i_lock
  *
  * Three bits determine the dirty state of the inode, I_DIRTY_SYNC,
@@ -2758,6 +2809,7 @@ extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
+extern void inode_set_write_hint(struct inode *inode, enum rw_hint hint);
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
@@ -3045,7 +3097,9 @@ static inline bool io_is_direct(struct file *filp)
 
 static inline int iocb_flags(struct file *file)
 {
+	struct inode *inode = file_inode(file);
 	int res = 0;
+
 	if (file->f_flags & O_APPEND)
 		res |= IOCB_APPEND;
 	if (io_is_direct(file))
@@ -3054,6 +3108,13 @@ static inline int iocb_flags(struct file *file)
 		res |= IOCB_DSYNC;
 	if (file->f_flags & __O_SYNC)
 		res |= IOCB_SYNC;
+	if (mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT)) {
+		enum rw_hint hint;
+
+		hint = mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
+		res |= write_hint_to_mask(hint, IOCB_WRITE_LIFE_SHIFT);
+	}
+
 	return res;
 }
 
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 813afd6eee71..def8f70e8bae 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,21 @@
 /* (1U << 31) is reserved for signed error codes */
 
 /*
+ * Set/Get write life time hints.
+ */
+#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
+#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
+
+/*
+ * Valid hint values for F_{GET,SET}_RW_HINT
+ */
+#define RWH_WRITE_LIFE_NONE	0
+#define RWH_WRITE_LIFE_SHORT	1
+#define RWH_WRITE_LIFE_MEDIUM	2
+#define RWH_WRITE_LIFE_LONG	3
+#define RWH_WRITE_LIFE_EXTREME	4
+
+/*
  * Types of directory notifications that may be requested.
  */
 #define DN_ACCESS	0x00000001	/* File accessed */
-- 
2.7.4
