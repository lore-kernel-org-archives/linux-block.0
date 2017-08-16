Return-Path: <longman@redhat.com>
From: Waiman Long <longman@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@poochiereds.net>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] blktrace: Fix potentail deadlock between delete & sysfs ops
Date: Wed, 16 Aug 2017 16:40:40 -0400
Message-Id: <1502916040-18067-1-git-send-email-longman@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The lockdep code had reported the following unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(s_active#228);
                               lock(&bdev->bd_mutex/1);
                               lock(s_active#228);
  lock(&bdev->bd_mutex);

 *** DEADLOCK ***

The deadlock may happen when one task (CPU1) is trying to delete
a partition in a block device and another task (CPU0) is accessing
tracing sysfs file in that partition.

To avoid that, accessing tracing sysfs file will now use a mutex
trylock loop and the operation will fail if a delete operation is
in progress.

Signed-off-by: Waiman Long <longman@redhat.com>
---

 v2:
   - Use READ_ONCE() and smp_store_mb() to read and write bd_deleting.
   - Check for signal in the mutex_trylock loops.
   - Use usleep() instead of schedule() for RT tasks.

 block/ioctl.c           |  3 +++
 include/linux/fs.h      |  1 +
 kernel/trace/blktrace.c | 39 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 0de02ee..b920329 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -86,12 +86,15 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 				return -EBUSY;
 			}
 			/* all seems OK */
+			smp_store_mb(bdev->bd_deleting, 1);
 			fsync_bdev(bdevp);
 			invalidate_bdev(bdevp);
 
 			mutex_lock_nested(&bdev->bd_mutex, 1);
 			delete_partition(disk, partno);
 			mutex_unlock(&bdev->bd_mutex);
+			smp_store_mb(bdev->bd_deleting, 0);
+
 			mutex_unlock(&bdevp->bd_mutex);
 			bdput(bdevp);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6e1fd5d..c2ba35e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -427,6 +427,7 @@ struct block_device {
 #endif
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
+	int			bd_deleting;
 	struct hd_struct *	bd_part;
 	/* number of times partitions within this device have been opened. */
 	unsigned		bd_part_count;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index bc364f8..b2dffa9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -27,6 +27,8 @@
 #include <linux/time.h>
 #include <linux/uaccess.h>
 #include <linux/list.h>
+#include <linux/delay.h>
+#include <linux/sched/rt.h>
 
 #include "../../block/blk.h"
 
@@ -1605,6 +1607,23 @@ static struct request_queue *blk_trace_get_queue(struct block_device *bdev)
 	return bdev_get_queue(bdev);
 }
 
+/*
+ * Read/write to the tracing sysfs file requires taking references to the
+ * sysfs file and then acquiring the bd_mutex. Deleting a block device
+ * requires acquiring the bd_mutex and then waiting for all the sysfs
+ * references to be gone. This can lead to deadlock if both operations
+ * happen simultaneously. To avoid this problem, read/write to the
+ * the tracing sysfs files can now fail if the bd_mutex cannot be
+ * acquired while a deletion operation is in progress.
+ *
+ * A mutex trylock loop is used assuming that tracing sysfs operations
+ * aren't frequently enough to cause any contention problem.
+ *
+ * For RT tasks, a running high priority task will prevent any lower
+ * priority RT tasks from being run. So they do need to actually sleep
+ * when the trylock fails to allow lower priority tasks to make forward
+ * progress.
+ */
 static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -1622,7 +1641,15 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	while (!mutex_trylock(&bdev->bd_mutex)) {
+		if (READ_ONCE(bdev->bd_deleting))
+			goto out_bdput;
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			goto out_bdput;
+		}
+		rt_task(current) ? usleep_range(10, 10) : schedule();
+	}
 
 	if (attr == &dev_attr_enable) {
 		ret = sprintf(buf, "%u\n", !!q->blk_trace);
@@ -1683,7 +1710,15 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	while (!mutex_trylock(&bdev->bd_mutex)) {
+		if (READ_ONCE(bdev->bd_deleting))
+			goto out_bdput;
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			goto out_bdput;
+		}
+		rt_task(current) ? usleep_range(10, 10) : schedule();
+	}
 
 	if (attr == &dev_attr_enable) {
 		if (value)
-- 
1.8.3.1
