Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1352 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIWI3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Aug 2018 18:08:29 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 03/12] scsi: Only set RQF_DV for requests used for domain validation
Date: Thu,  9 Aug 2018 12:41:40 -0700
Message-Id: <20180809194149.15285-4-bart.vanassche@wdc.com>
In-Reply-To: <20180809194149.15285-1-bart.vanassche@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Instead of setting RQF_DV for all requests submitted by scsi_execute(),
only set that flag for requests that are used for domain validation.
Move the SCSI Parallel Interface (SPI) domain validation status from
the transport data to struct scsi_target such that this status
information can be accessed easily from inside scsi_execute(). This
patch prevents that e.g. event checking can occur during domain
validation.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/scsi/scsi_lib.c           | 6 ++++--
 drivers/scsi/scsi_transport_spi.c | 9 +++------
 include/scsi/scsi_device.h        | 1 +
 include/scsi/scsi_transport_spi.h | 1 -
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8685704f6c8b..4d7411a7985f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -268,8 +268,10 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 
 	if (rq_flags & RQF_PM)
 		blk_mq_req_flags |= BLK_MQ_REQ_PM;
-	rq_flags |= RQF_DV;
-	blk_mq_req_flags |= BLK_MQ_REQ_DV;
+	if (scsi_target(sdev)->spi_dv_context == current) {
+		rq_flags |= RQF_DV;
+		blk_mq_req_flags |= BLK_MQ_REQ_DV;
+	}
 	req = blk_get_request(sdev->request_queue,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, blk_mq_req_flags);
diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index 2ca150b16764..bf6b18768e79 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -66,7 +66,6 @@ static struct {
 };
 
 /* Private data accessors (keep these out of the header file) */
-#define spi_dv_in_progress(x) (((struct spi_transport_attrs *)&(x)->starget_data)->dv_in_progress)
 #define spi_dv_mutex(x) (((struct spi_transport_attrs *)&(x)->starget_data)->dv_mutex)
 
 struct spi_internal {
@@ -268,7 +267,6 @@ static int spi_setup_transport_attrs(struct transport_container *tc,
 	spi_pcomp_en(starget) = 0;
 	spi_hold_mcs(starget) = 0;
 	spi_dv_pending(starget) = 0;
-	spi_dv_in_progress(starget) = 0;
 	spi_initial_dv(starget) = 0;
 	mutex_init(&spi_dv_mutex(starget));
 
@@ -1018,14 +1016,12 @@ spi_dv_device(struct scsi_device *sdev)
 	 */
 	lock_system_sleep();
 
-	if (unlikely(spi_dv_in_progress(starget)))
+	if (unlikely(starget->spi_dv_context))
 		goto unlock;
 
 	if (unlikely(scsi_device_get(sdev)))
 		goto unlock;
 
-	spi_dv_in_progress(starget) = 1;
-
 	buffer = kzalloc(len, GFP_KERNEL);
 
 	if (unlikely(!buffer))
@@ -1043,7 +1039,9 @@ spi_dv_device(struct scsi_device *sdev)
 
 	starget_printk(KERN_INFO, starget, "Beginning Domain Validation\n");
 
+	starget->spi_dv_context = current;
 	spi_dv_device_internal(sdev, buffer);
+	starget->spi_dv_context = NULL;
 
 	starget_printk(KERN_INFO, starget, "Ending Domain Validation\n");
 
@@ -1057,7 +1055,6 @@ spi_dv_device(struct scsi_device *sdev)
  out_free:
 	kfree(buffer);
  out_put:
-	spi_dv_in_progress(starget) = 0;
 	scsi_device_put(sdev);
 unlock:
 	unlock_system_sleep();
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 202f4d6a4342..440834f4252e 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -310,6 +310,7 @@ struct scsi_target {
 
 	char			scsi_level;
 	enum scsi_target_state	state;
+	struct task_struct	*spi_dv_context;
 	void 			*hostdata; /* available to low-level driver */
 	unsigned long		starget_data[0]; /* for the transport */
 	/* starget_data must be the last element!!!! */
diff --git a/include/scsi/scsi_transport_spi.h b/include/scsi/scsi_transport_spi.h
index a4fa52b4d5c5..36934ac0a5ca 100644
--- a/include/scsi/scsi_transport_spi.h
+++ b/include/scsi/scsi_transport_spi.h
@@ -56,7 +56,6 @@ struct spi_transport_attrs {
 	unsigned int support_qas; /* supports quick arbitration and selection */
 	/* Private Fields */
 	unsigned int dv_pending:1; /* Internal flag: DV Requested */
-	unsigned int dv_in_progress:1;	/* Internal: DV started */
 	struct mutex dv_mutex; /* semaphore to serialise dv */
 };
 
-- 
2.18.0
