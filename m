Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14298 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966239AbdIYU3q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Sep 2017 16:29:46 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        =Oleksandr Natalenko <oleksandr@natalenko.name>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 6/7] scsi: Set QUEUE_FLAG_PREEMPT_ONLY while quiesced
Date: Mon, 25 Sep 2017 13:29:23 -0700
Message-Id: <20170925202924.16603-7-bart.vanassche@wdc.com>
In-Reply-To: <20170925202924.16603-1-bart.vanassche@wdc.com>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make the quiesce state visible to the block layer for the next
patch in this series.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/scsi_lib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c261498606c4..309369d8fe01 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2932,6 +2932,8 @@ scsi_device_quiesce(struct scsi_device *sdev)
 
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
+	if (err == 0)
+		blk_set_preempt_only(q, true);
 	mutex_unlock(&sdev->state_mutex);
 
 	if (err)
@@ -2960,8 +2962,10 @@ void scsi_device_resume(struct scsi_device *sdev)
 	 */
 	mutex_lock(&sdev->state_mutex);
 	if (sdev->sdev_state == SDEV_QUIESCE &&
-	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0)
+	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0) {
+		blk_set_preempt_only(sdev->request_queue, false);
 		scsi_run_queue(sdev->request_queue);
+	}
 	mutex_unlock(&sdev->state_mutex);
 }
 EXPORT_SYMBOL(scsi_device_resume);
-- 
2.14.1
