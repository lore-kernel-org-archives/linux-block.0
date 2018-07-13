Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH RFC V2 1/3] block: put runtime PM code into common helpers
Date: Fri, 13 Jul 2018 16:06:00 +0800
Message-Id: <20180713080602.31602-2-ming.lei@redhat.com>
In-Reply-To: <20180713080602.31602-1-ming.lei@redhat.com>
References: <20180713080602.31602-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

So that the following patch can reuse these helpers for supporting
runtime PM on blk-mq.

No function change.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 71 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c4b57d8806fe..1087a58590f1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3746,6 +3746,50 @@ void blk_finish_plug(struct blk_plug *plug)
 EXPORT_SYMBOL(blk_finish_plug);
 
 #ifdef CONFIG_PM
+static int __blk_pre_runtime_suspend(struct request_queue *q, bool active)
+{
+	int ret;
+
+	if (active) {
+		ret = -EBUSY;
+		pm_runtime_mark_last_busy(q->dev);
+	} else {
+		ret = 0;
+		q->rpm_status = RPM_SUSPENDING;
+	}
+
+	return ret;
+}
+
+static void __blk_post_runtime_suspend(struct request_queue *q, int err)
+{
+	if (!err) {
+		q->rpm_status = RPM_SUSPENDED;
+	} else {
+		q->rpm_status = RPM_ACTIVE;
+		pm_runtime_mark_last_busy(q->dev);
+	}
+}
+
+static void __blk_post_runtime_resume(struct request_queue *q, int err)
+{
+	if (!err) {
+		q->rpm_status = RPM_ACTIVE;
+		__blk_run_queue(q);
+		pm_runtime_mark_last_busy(q->dev);
+		pm_request_autosuspend(q->dev);
+	} else {
+		q->rpm_status = RPM_SUSPENDED;
+	}
+}
+
+static void __blk_set_runtime_active(struct request_queue *q)
+{
+	q->rpm_status = RPM_ACTIVE;
+	pm_runtime_mark_last_busy(q->dev);
+	pm_request_autosuspend(q->dev);
+}
+
 /**
  * blk_pm_runtime_init - Block layer runtime PM initialization routine
  * @q: the queue of the device
@@ -3809,12 +3853,7 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 		return ret;
 
 	spin_lock_irq(q->queue_lock);
-	if (q->nr_pending) {
-		ret = -EBUSY;
-		pm_runtime_mark_last_busy(q->dev);
-	} else {
-		q->rpm_status = RPM_SUSPENDING;
-	}
+	ret = __blk_pre_runtime_suspend(q, q->nr_pending);
 	spin_unlock_irq(q->queue_lock);
 	return ret;
 }
@@ -3839,12 +3878,7 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
 		return;
 
 	spin_lock_irq(q->queue_lock);
-	if (!err) {
-		q->rpm_status = RPM_SUSPENDED;
-	} else {
-		q->rpm_status = RPM_ACTIVE;
-		pm_runtime_mark_last_busy(q->dev);
-	}
+	__blk_post_runtime_suspend(q, err);
 	spin_unlock_irq(q->queue_lock);
 }
 EXPORT_SYMBOL(blk_post_runtime_suspend);
@@ -3891,14 +3925,7 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
 		return;
 
 	spin_lock_irq(q->queue_lock);
-	if (!err) {
-		q->rpm_status = RPM_ACTIVE;
-		__blk_run_queue(q);
-		pm_runtime_mark_last_busy(q->dev);
-		pm_request_autosuspend(q->dev);
-	} else {
-		q->rpm_status = RPM_SUSPENDED;
-	}
+	__blk_post_runtime_resume(q, err);
 	spin_unlock_irq(q->queue_lock);
 }
 EXPORT_SYMBOL(blk_post_runtime_resume);
@@ -3920,9 +3947,7 @@ EXPORT_SYMBOL(blk_post_runtime_resume);
 void blk_set_runtime_active(struct request_queue *q)
 {
 	spin_lock_irq(q->queue_lock);
-	q->rpm_status = RPM_ACTIVE;
-	pm_runtime_mark_last_busy(q->dev);
-	pm_request_autosuspend(q->dev);
+	__blk_set_runtime_active(q);
 	spin_unlock_irq(q->queue_lock);
 }
 EXPORT_SYMBOL(blk_set_runtime_active);
-- 
2.9.5
