Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk
Cc: michaelcallahan@fb.com,
	newella@fb.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] block: Define and use STAT_READ and STAT_WRITE
Date: Tue,  5 Jun 2018 11:01:17 -0700
Message-Id: <20180605180120.2726113-4-tj@kernel.org>
In-Reply-To: <20180605180120.2726113-1-tj@kernel.org>
References: <20180605180120.2726113-1-tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>

From: Michael Callahan <michaelcallahan@fb.com>

Add defines for STAT_READ and STAT_WRITE for indexing the partition
stat entries. This clarifies some fs/ code which has hardcoded 1 for
STAT_WRITE and will make it easier to extend the stats with additional
fields.

tj: Refreshed on top of v4.17.

Signed-off-by: Michael Callahan <michaelcallahan@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
---
 block/genhd.c             | 16 ++++++++--------
 block/partition-generic.c | 16 ++++++++--------
 fs/ext4/super.c           |  5 +++--
 fs/ext4/sysfs.c           |  6 ++++--
 fs/f2fs/f2fs.h            |  2 +-
 fs/f2fs/super.c           |  3 ++-
 include/linux/blk_types.h |  7 +++++++
 include/linux/genhd.h     | 13 +++++++------
 8 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index f1543a4..0711a80 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1337,14 +1337,14 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			   "%u %lu %lu %lu %u %u %u %u\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
-			   part_stat_read(hd, ios[READ]),
-			   part_stat_read(hd, merges[READ]),
-			   part_stat_read(hd, sectors[READ]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[READ])),
-			   part_stat_read(hd, ios[WRITE]),
-			   part_stat_read(hd, merges[WRITE]),
-			   part_stat_read(hd, sectors[WRITE]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[WRITE])),
+			   part_stat_read(hd, ios[STAT_READ]),
+			   part_stat_read(hd, merges[STAT_READ]),
+			   part_stat_read(hd, sectors[STAT_READ]),
+			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_READ])),
+			   part_stat_read(hd, ios[STAT_WRITE]),
+			   part_stat_read(hd, merges[STAT_WRITE]),
+			   part_stat_read(hd, sectors[STAT_WRITE]),
+			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_WRITE])),
 			   inflight[0],
 			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
 			   jiffies_to_msecs(part_stat_read(hd, time_in_queue))
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 3dcfd4e..0ddb067 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -132,14 +132,14 @@ ssize_t part_stat_show(struct device *dev,
 		"%8lu %8lu %8llu %8u "
 		"%8u %8u %8u"
 		"\n",
-		part_stat_read(p, ios[READ]),
-		part_stat_read(p, merges[READ]),
-		(unsigned long long)part_stat_read(p, sectors[READ]),
-		jiffies_to_msecs(part_stat_read(p, ticks[READ])),
-		part_stat_read(p, ios[WRITE]),
-		part_stat_read(p, merges[WRITE]),
-		(unsigned long long)part_stat_read(p, sectors[WRITE]),
-		jiffies_to_msecs(part_stat_read(p, ticks[WRITE])),
+		part_stat_read(p, ios[STAT_READ]),
+		part_stat_read(p, merges[STAT_READ]),
+		(unsigned long long)part_stat_read(p, sectors[STAT_READ]),
+		jiffies_to_msecs(part_stat_read(p, ticks[STAT_READ])),
+		part_stat_read(p, ios[STAT_WRITE]),
+		part_stat_read(p, merges[STAT_WRITE]),
+		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
+		jiffies_to_msecs(part_stat_read(p, ticks[STAT_WRITE])),
 		inflight[0],
 		jiffies_to_msecs(part_stat_read(p, io_ticks)),
 		jiffies_to_msecs(part_stat_read(p, time_in_queue)));
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index eb104e8..b0bda4d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3445,7 +3445,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_sb_block = sb_block;
 	if (sb->s_bdev->bd_part)
 		sbi->s_sectors_written_start =
-			part_stat_read(sb->s_bdev->bd_part, sectors[1]);
+			part_stat_read(sb->s_bdev->bd_part, sectors[STAT_WRITE]);
 
 	/* Cleanup superblock name */
 	strreplace(sb->s_id, '/', '!');
@@ -4724,7 +4724,8 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 	if (sb->s_bdev->bd_part)
 		es->s_kbytes_written =
 			cpu_to_le64(EXT4_SB(sb)->s_kbytes_written +
-			    ((part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+			    ((part_stat_read(sb->s_bdev->bd_part,
+					     sectors[STAT_WRITE]) -
 			      EXT4_SB(sb)->s_sectors_written_start) >> 1));
 	else
 		es->s_kbytes_written =
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index f34da0b..2be9ad7 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -56,7 +56,8 @@ static ssize_t session_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 	if (!sb->s_bdev->bd_part)
 		return snprintf(buf, PAGE_SIZE, "0\n");
 	return snprintf(buf, PAGE_SIZE, "%lu\n",
-			(part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+			(part_stat_read(sb->s_bdev->bd_part,
+					sectors[STAT_WRITE]) -
 			 sbi->s_sectors_written_start) >> 1);
 }
 
@@ -68,7 +69,8 @@ static ssize_t lifetime_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 		return snprintf(buf, PAGE_SIZE, "0\n");
 	return snprintf(buf, PAGE_SIZE, "%llu\n",
 			(unsigned long long)(sbi->s_kbytes_written +
-			((part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+			((part_stat_read(sb->s_bdev->bd_part,
+					 sectors[STAT_WRITE]) -
 			  EXT4_SB(sb)->s_sectors_written_start) >> 1)));
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1df7f10..43b4a4c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1286,7 +1286,7 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
  * and the return value is in kbytes. s is of struct f2fs_sb_info.
  */
 #define BD_PART_WRITTEN(s)						 \
-(((u64)part_stat_read((s)->sb->s_bdev->bd_part, sectors[1]) -		 \
+(((u64)part_stat_read((s)->sb->s_bdev->bd_part, sectors[STAT_WRITE]) -   \
 		(s)->sectors_written_start) >> 1)
 
 static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42d564c..88d44ca 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2816,7 +2816,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* For write statistics */
 	if (sb->s_bdev->bd_part)
 		sbi->sectors_written_start =
-			(u64)part_stat_read(sb->s_bdev->bd_part, sectors[1]);
+			(u64)part_stat_read(sb->s_bdev->bd_part,
+					    sectors[STAT_WRITE]);
 
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3c4f390..5bdf8c3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -358,6 +358,13 @@ enum req_flag_bits {
 #define REQ_NOMERGE_FLAGS \
 	(REQ_NOMERGE | REQ_PREFLUSH | REQ_FUA)
 
+enum stat_group {
+	STAT_READ,
+	STAT_WRITE,
+
+	NR_STAT_GROUPS
+};
+
 #define bio_op(bio) \
 	((bio)->bi_opf & REQ_OP_MASK)
 #define req_op(req) \
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 19f36fa..a754454 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/uuid.h>
+#include <linux/blk_types.h>
 
 #ifdef CONFIG_BLOCK
 
@@ -82,10 +83,10 @@ struct partition {
 } __attribute__((packed));
 
 struct disk_stats {
-	unsigned long sectors[2];	/* READs and WRITEs */
-	unsigned long ios[2];
-	unsigned long merges[2];
-	unsigned long ticks[2];
+	unsigned long sectors[NR_STAT_GROUPS];
+	unsigned long ios[NR_STAT_GROUPS];
+	unsigned long merges[NR_STAT_GROUPS];
+	unsigned long ticks[NR_STAT_GROUPS];
 	unsigned long io_ticks;
 	unsigned long time_in_queue;
 };
@@ -354,8 +355,8 @@ static inline void free_part_stats(struct hd_struct *part)
 #endif /* CONFIG_SMP */
 
 #define part_stat_read_accum(part, field)				\
-	(part_stat_read(part, field[0]) +				\
-	 part_stat_read(part, field[1]))
+	(part_stat_read(part, field[STAT_READ]) +			\
+	 part_stat_read(part, field[STAT_WRITE]))
 
 #define part_stat_add(cpu, part, field, addnd)	do {			\
 	__part_stat_add((cpu), (part), field, addnd);			\
-- 
2.9.5
