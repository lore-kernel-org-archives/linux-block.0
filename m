Return-Path: <gunthorp@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@poochiereds.net>,
	"J. Bruce Fields" <bfields@fieldses.org>
Date: Fri, 16 Jun 2017 17:48:21 -0600
Message-Id: <20170616234821.11888-1-logang@deltatee.com>
Subject: [PATCH 3/3] block: order /proc/devices by major number
List-ID: <linux-block@vger.kernel.org>

Presently, the order of the block devices listed in /proc/devices is not
entirely sequential. If a block device has a major number greater than
BLKDEV_MAJOR_HASH_SIZE (255), it will be ordered as if its major were
module 255. For example, 511 appears after 1.

This patch cleans that up and prints each major number in the correct
order, regardless of where they are stored in the hash table.

In order to do this, we introduce BLKDEV_MAJOR_MAX as an artificial
limit (chosen to be 512). It will then print all devices in major
order number from 0 to the maximum.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jeff Layton <jlayton@poochiereds.net>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
---

This is a patch Greg requested after I proposed[1] the same to char devs.
It is based on the chardev patch I sent so it should be merged after it (to
avoid conflicts). If there are any changes requested I'll resend the
entire set as a whole.

[1] https://patchwork.kernel.org/patch/9790093/

 block/genhd.c      | 18 +++++++++++++-----
 fs/proc/devices.c  |  4 ++--
 include/linux/fs.h |  4 ++--
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index d252d29fe837..1fc734b1a0e4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -242,6 +242,7 @@ EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
  * Can be deleted altogether. Later.
  *
  */
+#define BLKDEV_MAJOR_HASH_SIZE 255
 static struct blk_major_name {
 	struct blk_major_name *next;
 	int major;
@@ -259,12 +260,11 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
 {
 	struct blk_major_name *dp;

-	if (offset < BLKDEV_MAJOR_HASH_SIZE) {
-		mutex_lock(&block_class_lock);
-		for (dp = major_names[offset]; dp; dp = dp->next)
+	mutex_lock(&block_class_lock);
+	for (dp = major_names[major_to_index(offset)]; dp; dp = dp->next)
+		if (dp->major == offset)
 			seq_printf(seqf, "%3d %s\n", dp->major, dp->name);
-		mutex_unlock(&block_class_lock);
-	}
+	mutex_unlock(&block_class_lock);
 }
 #endif /* CONFIG_PROC_FS */

@@ -309,6 +309,14 @@ int register_blkdev(unsigned int major, const char *name)
 		ret = major;
 	}

+	if (major >= BLKDEV_MAJOR_MAX) {
+		pr_err("register_blkdev: major requested (%d) is greater than the maximum (%d) for %s\n",
+		       major, BLKDEV_MAJOR_MAX, name);
+
+		ret = -EINVAL;
+		goto out;
+	}
+
 	p = kmalloc(sizeof(struct blk_major_name), GFP_KERNEL);
 	if (p == NULL) {
 		ret = -ENOMEM;
diff --git a/fs/proc/devices.c b/fs/proc/devices.c
index d196e22c4f1c..e5709343feb7 100644
--- a/fs/proc/devices.c
+++ b/fs/proc/devices.c
@@ -25,7 +25,7 @@ static int devinfo_show(struct seq_file *f, void *v)

 static void *devinfo_start(struct seq_file *f, loff_t *pos)
 {
-	if (*pos < (BLKDEV_MAJOR_HASH_SIZE + CHRDEV_MAJOR_MAX))
+	if (*pos < (BLKDEV_MAJOR_MAX + CHRDEV_MAJOR_MAX))
 		return pos;
 	return NULL;
 }
@@ -33,7 +33,7 @@ static void *devinfo_start(struct seq_file *f, loff_t *pos)
 static void *devinfo_next(struct seq_file *f, void *v, loff_t *pos)
 {
 	(*pos)++;
-	if (*pos >= (BLKDEV_MAJOR_HASH_SIZE + CHRDEV_MAJOR_MAX))
+	if (*pos >= (BLKDEV_MAJOR_MAX + CHRDEV_MAJOR_MAX))
 		return NULL;
 	return pos;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f1347c2ca3e9..8cc651807ea4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2478,14 +2478,14 @@ static inline void unregister_chrdev(unsigned int major, const char *name)
 #define BDEVT_SIZE	10	/* Largest string for MAJ:MIN for blkdev */

 #ifdef CONFIG_BLOCK
-#define BLKDEV_MAJOR_HASH_SIZE	255
+#define BLKDEV_MAJOR_MAX	512
 extern const char *__bdevname(dev_t, char *buffer);
 extern const char *bdevname(struct block_device *bdev, char *buffer);
 extern struct block_device *lookup_bdev(const char *);
 extern void blkdev_show(struct seq_file *,off_t);

 #else
-#define BLKDEV_MAJOR_HASH_SIZE	0
+#define BLKDEV_MAJOR_MAX	0
 #endif

 extern void init_special_inode(struct inode *, umode_t, dev_t);
--
2.11.0
