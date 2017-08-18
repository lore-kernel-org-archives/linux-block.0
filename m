Return-Path: <longman@redhat.com>
From: Waiman Long <longman@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4] blktrace: Fix potentail deadlock between delete & sysfs ops
Date: Fri, 18 Aug 2017 16:01:14 -0400
Message-Id: <1503086474-20187-1-git-send-email-longman@redhat.com>
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

Instead of using bd_mutex, a new global blktrace mutex is now used
to protect against concurrent access, creation and destruction of the
blk_trace structure that is used only in the blktrace.c file. As
blktrace files will not be frequently accessed, using a global mutex
should not cause any performance problem.

Signed-off-by: Waiman Long <longman@redhat.com>
---

 v4:
  - Use blktrace_mutex in blk_trace_ioctl() as well.

 v3:
  - Use a global blktrace_mutex to serialize sysfs attribute accesses
    instead of the bd_mutex. 

 v2:
  - Use READ_ONCE() and smp_store_mb() to read and write bd_deleting.
  - Check for signal in the mutex_trylock loops.
  - Use usleep() instead of schedule() for RT tasks.

 kernel/trace/blktrace.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index bc364f8..ec5a919 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -624,6 +624,17 @@ int blk_trace_startstop(struct request_queue *q, int start)
 }
 EXPORT_SYMBOL_GPL(blk_trace_startstop);
 
+/*
+ * The bd_mutex was used previously for protecting blk_trace structure.
+ * That could lead to deadlock with concurrent block device deletion and
+ * sysfs access. So a global blktrace_mutex is now used instead for
+ * protecting the blk_trace structure.
+ *
+ * The references to the opened sysfs or device files should prevent the
+ * underlying block device from being removed.
+ */
+static DEFINE_MUTEX(blktrace_mutex);
+
 /**
  * blk_trace_ioctl: - handle the ioctls associated with tracing
  * @bdev:	the block device
@@ -641,7 +652,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	if (!q)
 		return -ENXIO;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&blktrace_mutex);
 
 	switch (cmd) {
 	case BLKTRACESETUP:
@@ -667,7 +678,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 		break;
 	}
 
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&blktrace_mutex);
 	return ret;
 }
 
@@ -1622,7 +1633,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&blktrace_mutex);
 
 	if (attr == &dev_attr_enable) {
 		ret = sprintf(buf, "%u\n", !!q->blk_trace);
@@ -1641,7 +1652,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 		ret = sprintf(buf, "%llu\n", q->blk_trace->end_lba);
 
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&blktrace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
@@ -1683,7 +1694,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&blktrace_mutex);
 
 	if (attr == &dev_attr_enable) {
 		if (value)
@@ -1709,7 +1720,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	}
 
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&blktrace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
-- 
1.8.3.1
