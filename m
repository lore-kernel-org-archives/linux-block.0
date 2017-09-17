Return-Path: <longman@redhat.com>
From: Waiman Long <longman@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v5] blktrace: Fix potentail deadlock between delete & sysfs ops
Date: Sat, 16 Sep 2017 19:37:08 -0700
Message-Id: <1505615828-6623-1-git-send-email-longman@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The lockdep code had reported the following unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(s_active#228);
                               lock(&bdev->bd_mutex/1);
                               lock(s_active#228);
  lock(&bdev->bd_mutex);

 *** DEADLOCK ***

The deadlock may happen when one task (CPU1) is trying to delete a
partition in a block device and another task (CPU0) is accessing
tracing sysfs file (e.g. /sys/block/dm-1/trace/act_mask) in that
partition.

The s_active isn't an actual lock. It is a reference count (kn->count)
on the sysfs (kernfs) file. Removal of a sysfs file, however, require
a wait until all the references are gone. The reference count is
treated like a rwsem using lockdep instrumentation code.

The fact that a thread is in the sysfs callback method or in the
ioctl call means there is a reference to the opended sysfs or device
file. That should prevent the underlying block structure from being
removed.

Instead of using bd_mutex in the block_device structure, the other
bd_fsfreeze_mutex mutex in the block_device structure is now overloaded
to protect against concurrent blktrace data access in the blktrace.c
file. There is no point in adding one more mutex to the block_device
structure just for blktrace.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 v5:
  - Overload the bd_fsfreeze_mutex in block_device structure for
    blktrace protection.

 v4:
  - Use blktrace_mutex in blk_trace_ioctl() as well.

 v3:
  - Use a global blktrace_mutex to serialize sysfs attribute accesses
    instead of the bd_mutex.

 v2:
  - Use READ_ONCE() and smp_store_mb() to read and write bd_deleting.
  - Check for signal in the mutex_trylock loops.
  - Use usleep() instead of schedule() for RT tasks.

 include/linux/fs.h      |  2 +-
 kernel/trace/blktrace.c | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 339e737..330b572 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -448,7 +448,7 @@ struct block_device {
 
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
-	/* Mutex for freeze */
+	/* Mutex for freeze and blktrace */
 	struct mutex		bd_fsfreeze_mutex;
 } __randomize_layout;
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 2a685b4..7cd5d1d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -648,6 +648,20 @@ int blk_trace_startstop(struct request_queue *q, int start)
 }
 EXPORT_SYMBOL_GPL(blk_trace_startstop);
 
+/*
+ * When reading or writing the blktrace sysfs files, the references to the
+ * opened sysfs or device files should prevent the underlying block device
+ * from being removed. So no further delete protection is really needed.
+ *
+ * Protection from multiple readers and writers accessing blktrace data
+ * concurrently is still required. The bd_mutex was used for this purpose.
+ * That could lead to deadlock with concurrent block device deletion and
+ * sysfs access. Instead, the block device bd_fsfreeze_mutex is now
+ * overloaded for blktrace data protection. Like freeze/thaw, blktrace
+ * functionality is not frequently used. There is no point in adding
+ * one more mutex to the block_device structure just for blktrace.
+ */
+
 /**
  * blk_trace_ioctl: - handle the ioctls associated with tracing
  * @bdev:	the block device
@@ -665,7 +679,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	if (!q)
 		return -ENXIO;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&bdev->bd_fsfreeze_mutex);
 
 	switch (cmd) {
 	case BLKTRACESETUP:
@@ -691,7 +705,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 		break;
 	}
 
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	return ret;
 }
 
@@ -1727,7 +1741,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&bdev->bd_fsfreeze_mutex);
 
 	if (attr == &dev_attr_enable) {
 		ret = sprintf(buf, "%u\n", !!q->blk_trace);
@@ -1746,7 +1760,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 		ret = sprintf(buf, "%llu\n", q->blk_trace->end_lba);
 
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 out_bdput:
 	bdput(bdev);
 out:
@@ -1788,7 +1802,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&bdev->bd_fsfreeze_mutex);
 
 	if (attr == &dev_attr_enable) {
 		if (value)
@@ -1814,7 +1828,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	}
 
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 out_bdput:
 	bdput(bdev);
 out:
-- 
1.8.3.1
