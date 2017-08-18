Return-Path: <longman@redhat.com>
From: Waiman Long <longman@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3] blktrace: Fix potentail deadlock between delete & sysfs ops
Date: Fri, 18 Aug 2017 13:54:08 -0400
Message-Id: <1503078848-15779-1-git-send-email-longman@redhat.com>
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

The fact that a thread is in the sysfs callback method will guarantee
that the underlying block device structure won't go away as device
deletion requires all the sysfs references to be gone. Therefore,
there is no need to take the bd_mutex. Instead, a global blktrace
mutex will be used to serialize the read/write of the blktrace sysfs
attributes.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 v3:
  - Use a global blktrace_mutex to serialize sysfs attribute accesses
    instead of the bd_mutex. 

 v2:
  - Use READ_ONCE() and smp_store_mb() to read and write bd_deleting.
  - Check for signal in the mutex_trylock loops.
  - Use usleep() instead of schedule() for RT tasks.

 kernel/trace/blktrace.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index bc364f8..e5901c6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1605,6 +1605,15 @@ static struct request_queue *blk_trace_get_queue(struct block_device *bdev)
 	return bdev_get_queue(bdev);
 }
 
+/*
+ * Read/write to the blk_trace sysfs files requires taking references to
+ * the underlying kernfs_node structure which will guarantee that the block
+ * device won't go away as the device deletion code will wait until all the
+ * sysfs references are gone. For serialization of read/write accesses to
+ * the sysfs attributes, a global blk_trace mutex is used.
+ */
+static DEFINE_MUTEX(blktrace_mutex);
+
 static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -1622,7 +1631,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&blktrace_mutex);
 
 	if (attr == &dev_attr_enable) {
 		ret = sprintf(buf, "%u\n", !!q->blk_trace);
@@ -1641,7 +1650,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 		ret = sprintf(buf, "%llu\n", q->blk_trace->end_lba);
 
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&blktrace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
@@ -1683,7 +1692,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&blktrace_mutex);
 
 	if (attr == &dev_attr_enable) {
 		if (value)
@@ -1709,7 +1718,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	}
 
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&blktrace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
-- 
1.8.3.1
