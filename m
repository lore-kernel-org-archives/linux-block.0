Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62772 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751194AbcFHUvk (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 8 Jun 2016 16:51:40 -0400
From: Michael Callahan <michaelcallahan@fb.com>
To: <linux-block@vger.kernel.org>
CC: Michael Callahan <michaelcallahan@fb.com>, <axboe@fb.com>,
	<coder.callahan@gmail.com>, <kernel-team@fb.com>
Subject: [PATCH 2/4] block: Define and use STAT_READ and STAT_WRITE
Date: Wed, 8 Jun 2016 16:50:53 -0400
Message-ID: <d9d9f4839c80054e67141f46184dd0ea351dd7fe.1464912896.git.michaelcallahan@fb.com>
In-Reply-To: <cover.1464912896.git.michaelcallahan@fb.com>
References: <cover.1464912896.git.michaelcallahan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add defines for STAT_READ and STAT_WRITE for indexing the partition stat
entries. This clarifies some fs/ code which has hardcoded 1 for
STAT_WRITE and will make it easier to extend the stats with additional
fields.

Signed-off-by: Michael Callahan <michaelcallahan@fb.com>
---
 block/genhd.c             | 16 ++++++++--------
 block/partition-generic.c | 16 ++++++++--------
 fs/ext4/super.c           |  5 +++--
 fs/ext4/sysfs.c           |  6 ++++--
 fs/f2fs/f2fs.h            |  2 +-
 fs/f2fs/super.c           |  3 ++-
 include/linux/genhd.h     |  9 ++++++---
 7 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f42526..b6f1dee 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1199,14 +1199,14 @@ static int diskstats_show(struct seq_file *seqf, void *v)
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
 			   part_in_flight(hd),
 			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
 			   jiffies_to_msecs(part_stat_read(hd, time_in_queue))
diff --git a/block/partition-generic.c b/block/partition-generic.c
index d7eb77e..15bf298 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -123,14 +123,14 @@ ssize_t part_stat_show(struct device *dev,
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
 		part_in_flight(p),
 		jiffies_to_msecs(part_stat_read(p, io_ticks)),
 		jiffies_to_msecs(part_stat_read(p, time_in_queue)));
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3822a5a..47ef2da 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3183,7 +3183,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_sb_block = sb_block;
 	if (sb->s_bdev->bd_part)
 		sbi->s_sectors_written_start =
-			part_stat_read(sb->s_bdev->bd_part, sectors[1]);
+			part_stat_read(sb->s_bdev->bd_part, sectors[STAT_WRITE]);
 
 	/* Cleanup superblock name */
 	strreplace(sb->s_id, '/', '!');
@@ -4356,7 +4356,8 @@ static int ext4_commit_super(struct super_block *sb, int sync)
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
index 1420a3c..10ad87e 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -55,7 +55,8 @@ static ssize_t session_write_kbytes_show(struct ext4_attr *a,
 	if (!sb->s_bdev->bd_part)
 		return snprintf(buf, PAGE_SIZE, "0\n");
 	return snprintf(buf, PAGE_SIZE, "%lu\n",
-			(part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+			(part_stat_read(sb->s_bdev->bd_part,
+					sectors[STAT_WRITE]) -
 			 sbi->s_sectors_written_start) >> 1);
 }
 
@@ -68,7 +69,8 @@ static ssize_t lifetime_write_kbytes_show(struct ext4_attr *a,
 		return snprintf(buf, PAGE_SIZE, "0\n");
 	return snprintf(buf, PAGE_SIZE, "%llu\n",
 			(unsigned long long)(sbi->s_kbytes_written +
-			((part_stat_read(sb->s_bdev->bd_part, sectors[1]) -
+			((part_stat_read(sb->s_bdev->bd_part,
+					 sectors[STAT_WRITE]) -
 			  EXT4_SB(sb)->s_sectors_written_start) >> 1)));
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 916e7c2..f313944 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -873,7 +873,7 @@ struct f2fs_sb_info {
  * and the return value is in kbytes. s is of struct f2fs_sb_info.
  */
 #define BD_PART_WRITTEN(s)						 \
-(((u64)part_stat_read(s->sb->s_bdev->bd_part, sectors[1]) -		 \
+(((u64)part_stat_read(s->sb->s_bdev->bd_part, sectors[STAT_WRITE]) -	 \
 		s->sectors_written_start) >> 1)
 
 static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 74cc852..d4001a3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1636,7 +1636,8 @@ try_onemore:
 	/* For write statistics */
 	if (sb->s_bdev->bd_part)
 		sbi->sectors_written_start =
-			(u64)part_stat_read(sb->s_bdev->bd_part, sectors[1]);
+			(u64)part_stat_read(sb->s_bdev->bd_part,
+					    sectors[STAT_WRITE]);
 
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6ab71b6..17f1c09 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -60,6 +60,9 @@ enum {
 #define DISK_MAX_PARTS			256
 #define DISK_NAME_LEN			32
 
+#define STAT_READ			0
+#define STAT_WRITE			1
+
 #include <linux/major.h>
 #include <linux/device.h>
 #include <linux/smp.h>
@@ -81,7 +84,7 @@ struct partition {
 } __attribute__((packed));
 
 struct disk_stats {
-	unsigned long sectors[2];	/* READs and WRITEs */
+	unsigned long sectors[2];	/* STAT_READs and STAT_WRITEs */
 	unsigned long ios[2];
 	unsigned long merges[2];
 	unsigned long ticks[2];
@@ -365,8 +368,8 @@ static inline void free_part_stats(struct hd_struct *part)
 #endif /* CONFIG_SMP */
 
 #define part_stat_read_accum(part, field)				\
-	(part_stat_read(part, field[0]) +				\
-	 part_stat_read(part, field[1]))
+	(part_stat_read(part, field[STAT_READ]) +			\
+	 part_stat_read(part, field[STAT_WRITE]))
 
 #define part_stat_add(cpu, part, field, addnd)	do {			\
 	__part_stat_add((cpu), (part), field, addnd);			\
-- 
1.9.3

