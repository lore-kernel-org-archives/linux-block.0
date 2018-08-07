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
Subject: [RFC PATCH 10/14] SCSI: use the dedicated admin queue to send admin commands
Date: Wed,  8 Aug 2018 01:44:29 +0800
Message-Id: <20180807174433.8374-11-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-1-ming.lei@redhat.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Now the per-host dedicated admin queue is ready, so use this queue to
send admin commands only.

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
 drivers/scsi/scsi_lib.c    | 11 ++++++++---
 drivers/scsi/scsi_scan.c   |  1 +
 drivers/scsi/scsi_sysfs.c  |  1 +
 include/scsi/scsi_device.h |  4 ++++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index dbb355e23262..79475a679750 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -278,16 +278,16 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	struct request *req;
 	struct scsi_request *rq;
 	int ret = DRIVER_ERROR << 24;
+	struct request_queue *q = sdev->host->admin_q;
 
-	req = blk_get_request(sdev->request_queue,
+	req = blk_get_request(q,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
 	if (IS_ERR(req))
 		return ret;
 	rq = scsi_req(req);
 
-	if (bufflen &&	blk_rq_map_kern(sdev->request_queue, req,
-					buffer, bufflen, GFP_NOIO))
+	if (bufflen && blk_rq_map_kern(q, req, buffer, bufflen, GFP_NOIO))
 		goto out;
 
 	rq->cmd_len = COMMAND_SIZE(cmd[0]);
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
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 0880d975eed3..b10af1692ddd 100644
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
index 7943b762c12d..7e03a420dfe7 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1377,6 +1377,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
 
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
