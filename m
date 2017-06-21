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
Date: Tue, 20 Jun 2017 18:21:58 -0600
Message-Id: <1498004526-4543-2-git-send-email-axboe@kernel.dk>
In-Reply-To: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Define a set of write life time hints:

RWH_WRITE_LIFE_NONE	No hints about write life time
RWH_WRITE_LIFE_SHORT	Data written has a short life time
RWH_WRITE_LIFE_MEDIUM	Data written has a medium life time
RWH_WRITE_LIFE_LONG	Data written has a long life time
RWH_WRITE_LIFE_EXTREME	Data written has an extremely long life tim

The intent is for these values to be relative to each other, no
absolute meaning should be attached to these flag names.

Add an fcntl interface for querying these flags, and also for
setting them as well:

F_GET_RW_HINT		Returns the read/write hint set.

F_SET_RW_HINT		Pass one of the above write hints.

The user passes in a 64-bit pointer to get/set these values, and
the interface returns 0/-1 on success/error.

Sample program testing/implementing basic setting/getting of write
hints is below.

Add support for storing the write life time hint in the inode flags
and in struct file as well, and pass them to the kiocb flags. If
both a file and its corresponding inode has a write hint, then we
use the one in the file, if available. The file hint can be used
for sync/direct IO, for buffered writeback only the inode hint
is available.

This is in preparation for utilizing these hints in the block layer,
to guide on-media data placement.

/*
 * writehint.c: check or set a file/inode write hint
 */
 #include <stdio.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdbool.h>
 #include <inttypes.h>

 #ifndef F_RW_GET_HINT
 #define F_LINUX_SPECIFIC_BASE	1024
 #define F_RW_GET_HINT		(F_LINUX_SPECIFIC_BASE + 11)
 #define F_RW_SET_HINT		(F_LINUX_SPECIFIC_BASE + 12)
 #endif

static char *str[] = { "WRITE_LIFE_NOT_SET", "WRITE_LIFE_NONE",
			"WRITE_LIFE_SHORT", "WRITE_LIFE_MEDIUM",
			"WRITE_LIFE_LONG", "WRITE_LIFE_EXTREME" };

int main(int argc, char *argv[])
{
	uint64_t hint;
	int fd, ret;

	if (argc < 2) {
		fprintf(stderr, "%s: file <hint>\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd < 0) {
		perror("open");
		return 2;
	}

	if (argc > 2) {
		hint = atoi(argv[2]);
		ret = fcntl(fd, F_RW_SET_HINT, &hint);
		if (ret < 0) {
			perror("fcntl: F_RW_SET_HINT");
			return 4;
		}
	}

	ret = fcntl(fd, F_RW_GET_HINT, &hint);
	if (ret < 0) {
		perror("fcntl: F_RW_GET_HINT");
		return 3;
	}

	printf("%s: hint %s\n", argv[1], str[hint]);
	close(fd);
	return 0;
}

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/fcntl.c                 | 60 +++++++++++++++++++++++++++++++++++++
 fs/inode.c                 | 11 +++++++
 fs/open.c                  |  1 +
 include/linux/fs.h         | 74 ++++++++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/fcntl.h | 16 ++++++++++
 5 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f4e7267d117f..7037f0560f36 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -243,6 +243,62 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
+static long fcntl_rw_hint(struct file *file, unsigned int cmd,
+			  unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	enum rw_hint hint, old_hint;
+	long ret = 0;
+
+	switch (cmd) {
+	case F_GET_RW_HINT:
+		if (file->f_write_hint != WRITE_LIFE_NOT_SET)
+			hint = file->f_write_hint;
+		else
+			hint = mask_to_write_hint(inode->i_flags,
+							S_WRITE_LIFE_SHIFT);
+		if (put_user(hint, (u64 __user *) arg))
+			ret = -EFAULT;
+		break;
+	case F_SET_RW_HINT:
+		if (get_user(hint, (u64 __user *) arg)) {
+			ret = -EFAULT;
+			break;
+		}
+		switch (hint) {
+		case WRITE_LIFE_NOT_SET:
+		case WRITE_LIFE_NONE:
+		case WRITE_LIFE_SHORT:
+		case WRITE_LIFE_MEDIUM:
+		case WRITE_LIFE_LONG:
+		case WRITE_LIFE_EXTREME:
+			spin_lock(&file->f_lock);
+			file->f_write_hint = hint;
+			spin_unlock(&file->f_lock);
+
+			/*
+			 * Only propagate hint to inode, if no hint is set,
+			 * or if the hint is being cleared
+			 */
+			old_hint = mask_to_write_hint(inode->i_flags,
+							S_WRITE_LIFE_SHIFT);
+			if (old_hint == WRITE_LIFE_NOT_SET ||
+			    hint == WRITE_LIFE_NOT_SET)
+				inode_set_write_hint(inode, hint);
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
@@ -337,6 +393,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
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
index 4574121f4746..9c554a783a6f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -274,6 +274,13 @@ struct writeback_control;
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
 
+/*
+ * Steal 3 bits for stream information, this allows 8 valid streams
+ */
+#define IOCB_WRITE_LIFE_SHIFT	8
+#define IOCB_WRITE_LIFE_MASK	(7 << IOCB_WRITE_LIFE_SHIFT)
+
+
 struct kiocb {
 	struct file		*ki_filp;
 	loff_t			ki_pos;
@@ -297,6 +304,12 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
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
@@ -828,6 +841,20 @@ struct file_ra_state {
 	loff_t prev_pos;		/* Cache last read() position */
 };
 
+#include <linux/fcntl.h>
+
+/*
+ * Write life time hint values.
+ */
+enum rw_hint {
+	WRITE_LIFE_NOT_SET = 0,
+	WRITE_LIFE_NONE = RWH_WRITE_LIFE_NONE,
+	WRITE_LIFE_SHORT = RWH_WRITE_LIFE_SHORT,
+	WRITE_LIFE_MEDIUM = RWH_WRITE_LIFE_MEDIUM,
+	WRITE_LIFE_LONG = RWH_WRITE_LIFE_LONG,
+	WRITE_LIFE_EXTREME = RWH_WRITE_LIFE_EXTREME,
+};
+
 /*
  * Check if @index falls in the readahead windows.
  */
@@ -851,6 +878,7 @@ struct file {
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
+	enum rw_hint		f_write_hint;
 	atomic_long_t		f_count;
 	unsigned int 		f_flags;
 	fmode_t			f_mode;
@@ -1026,8 +1054,6 @@ struct file_lock_context {
 #define OFFT_OFFSET_MAX	INT_LIMIT(off_t)
 #endif
 
-#include <linux/fcntl.h>
-
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
 /*
@@ -1833,6 +1859,14 @@ struct super_operations {
 #endif
 
 /*
+ * Expected life time hint of a write for this inode. This uses the
+ * WRITE_LIFE_* encoding, we just need to define the shift. We need
+ * 3 bits for this. Next S_* value is 131072, bit 17.
+ */
+#define S_WRITE_LIFE_SHIFT	14	/* 16384, next bit */
+#define S_WRITE_LIFE_MASK	(7 << S_WRITE_LIFE_SHIFT)
+
+/*
  * Note that nosuid etc flags are inode-specific: setting some file-system
  * flags just means all the inodes inherit those flags by default. It might be
  * possible to override it selectively if you really wanted to with some
@@ -1878,6 +1912,39 @@ static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
 }
 
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
+static inline enum rw_hint inode_write_hint(struct inode *inode)
+{
+	enum rw_hint ret = WRITE_LIFE_NONE;
+
+	if (inode) {
+		ret = mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
+		if (ret == WRITE_LIFE_NOT_SET)
+			ret = WRITE_LIFE_NONE;
+	}
+
+	return ret;
+}
+
+static inline enum rw_hint file_write_hint(struct file *file)
+{
+	if (file->f_write_hint != WRITE_LIFE_NOT_SET)
+		return file->f_write_hint;
+
+	return inode_write_hint(file_inode(file));
+}
+
 /*
  * Inode state bits.  Protected by inode->i_lock
  *
@@ -2764,6 +2831,7 @@ extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
+extern void inode_set_write_hint(struct inode *inode, enum rw_hint hint);
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
@@ -3060,6 +3128,8 @@ static inline int iocb_flags(struct file *file)
 		res |= IOCB_DSYNC;
 	if (file->f_flags & __O_SYNC)
 		res |= IOCB_SYNC;
+
+	res |= write_hint_to_mask(file->f_write_hint, IOCB_WRITE_LIFE_SHIFT);
 	return res;
 }
 
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 813afd6eee71..defe6e77fc99 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -43,6 +43,22 @@
 /* (1U << 31) is reserved for signed error codes */
 
 /*
+ * Set/Get write life time hints.
+ */
+#define F_GET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 11)
+#define F_SET_RW_HINT		(F_LINUX_SPECIFIC_BASE + 12)
+
+/*
+ * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
+ * used to clear any hints previously set.
+ */
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
2.7.4
