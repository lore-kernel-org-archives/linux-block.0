Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH V3 11/17] SCSI: track pending admin commands
Date: Thu, 13 Sep 2018 20:15:40 +0800
Message-Id: <20180913121546.5710-12-ming.lei@redhat.com>
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
References: <20180913121546.5710-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Firstly we have to make sure that all pending admin commands to
one same scsi_device are completed before removing the scsi_device.

Secondly scsi_internal_device_block() needs this too.

So introduce one waitqueue and atomic counter for this purpose.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c    | 6 ++++++
 drivers/scsi/scsi_scan.c   | 1 +
 drivers/scsi/scsi_sysfs.c  | 1 +
 include/scsi/scsi_device.h | 4 ++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8d129b601cc5..4db08458a127 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -299,6 +299,8 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	req->cmd_flags |= flags;
 	req->rq_flags |= rq_flags | RQF_QUIET;
 
+	atomic_inc(&sdev->nr_admin_pending);
+
 	/*
 	 * head injection *required* here otherwise quiesce won't work
 	 */
@@ -323,6 +325,9 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
  out:
 	blk_put_request(req);
 
+	atomic_dec(&sdev->nr_admin_pending);
+	wake_up_all(&sdev->admin_wq);
+
 	return ret;
 }
 EXPORT_SYMBOL(__scsi_execute);
@@ -3246,6 +3251,7 @@ static int scsi_internal_device_block(struct scsi_device *sdev)
 		else
 			scsi_wait_for_queuecommand(sdev);
 	}
+	wait_event(sdev->admin_wq, !atomic_read(&sdev->nr_admin_pending));
 	mutex_unlock(&sdev->state_mutex);
 
 	return err;
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 78ca63dfba4a..b83ad0dc8890 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -243,6 +243,7 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	mutex_init(&sdev->inquiry_mutex);
 	INIT_WORK(&sdev->event_work, scsi_evt_thread);
 	INIT_WORK(&sdev->requeue_work, scsi_requeue_run_queue);
+	init_waitqueue_head(&sdev->admin_wq);
 
 	sdev->sdev_gendev.parent = get_device(&starget->dev);
 	sdev->sdev_target = starget;
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 3aee9464a7bf..8bcb7ecc0c06 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1393,6 +1393,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
 
 	blk_cleanup_queue(sdev->request_queue);
 	cancel_work_sync(&sdev->requeue_work);
+	wait_event(sdev->admin_wq, !atomic_read(&sdev->nr_admin_pending));
 
 	if (sdev->host->hostt->slave_destroy)
 		sdev->host->hostt->slave_destroy(sdev);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 202f4d6a4342..f6820da1dc37 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -227,6 +227,10 @@ struct scsi_device {
 	struct mutex		state_mutex;
 	enum scsi_device_state sdev_state;
 	struct task_struct	*quiesced_by;
+
+	atomic_t		nr_admin_pending;
+	wait_queue_head_t       admin_wq;
+
 	unsigned long		sdev_data[0];
 } __attribute__((aligned(sizeof(unsigned long))));
 
-- 
2.9.5
