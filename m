Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/12] fs: add support for an inode to carry write hint related data
Date: Thu, 15 Jun 2017 10:42:01 -0600
Message-Id: <1497544930-19174-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No functional changes in this patch, just in preparation for
allowing applications to pass in hints about data life times
for writes. Set aside 3 bits for carrying hint information
in the inode flags.

Adds the public hints as well, which are:

WRITE_HINT_NONE		No hints about write life time
WRITE_HINT_SHORT	Data written has a short life time
WRITE_HINT_MEDIUM	Data written has a medium life time
WRITE_HINT_LONG		Data written has a long life time
WRITE_HINT_EXTREME	Data written has an extremely long life tim

Helpers are defined to store these values in flags, by passing in
the shift that's appropriate for the given use case.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/inode.c              | 11 +++++++++++
 include/linux/fs.h      | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/fs.h | 13 +++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index db5914783a71..cc8a05c4c1be 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2120,3 +2120,14 @@ struct timespec current_time(struct inode *inode)
 	return timespec_trunc(now, inode->i_sb->s_time_gran);
 }
 EXPORT_SYMBOL(current_time);
+
+void inode_set_write_hint(struct inode *inode, enum write_hint hint)
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
index 803e5a9b2654..bef0b350f890 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1828,6 +1828,14 @@ struct super_operations {
 #endif
 
 /*
+ * Expected life time hint of a write for this inode. This uses the
+ * WRITE_HINT_* encoding, we just need to define the shift. We need
+ * 3 bits for this. Next S_* value is 131072, bit 17.
+ */
+#define S_WRITE_LIFE_MASK	0x1c000	/* bits 14..16 */
+#define S_WRITE_LIFE_SHIFT	14	/* 16384, next bit */
+
+/*
  * Note that nosuid etc flags are inode-specific: setting some file-system
  * flags just means all the inodes inherit those flags by default. It might be
  * possible to override it selectively if you really wanted to with some
@@ -1873,6 +1881,26 @@ static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
 }
 
+static inline unsigned int write_hint_to_mask(enum write_hint hint,
+					      unsigned int shift)
+{
+	return hint << shift;
+}
+
+static inline enum write_hint mask_to_write_hint(unsigned int mask,
+						 unsigned int shift)
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
 /*
  * Inode state bits.  Protected by inode->i_lock
  *
@@ -2757,6 +2785,7 @@ extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
+extern void inode_set_write_hint(struct inode *inode, enum write_hint hint);
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 24e61a54feaa..58fbe0903016 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -356,6 +356,19 @@ struct fscrypt_key {
 #define SYNC_FILE_RANGE_WRITE		2
 #define SYNC_FILE_RANGE_WAIT_AFTER	4
 
+/*
+ * Write life time hint values.
+ */
+enum write_hint {
+	WRITE_HINT_NONE = 0,
+	WRITE_HINT_SHORT,
+	WRITE_HINT_MEDIUM,
+	WRITE_HINT_LONG,
+	WRITE_HINT_EXTREME,
+};
+
+#define WRITE_HINT_MASK		0x7	/* 3 bits */
+
 /* flags for preadv2/pwritev2: */
 #define RWF_HIPRI			0x00000001 /* high priority request, poll if possible */
 #define RWF_DSYNC			0x00000002 /* per-IO O_DSYNC */
-- 
2.7.4
