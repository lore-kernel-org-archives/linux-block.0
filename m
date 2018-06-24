Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751876AbeFXOE2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jun 2018 10:04:28 -0400
From: Ming Lei <ming.lei@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH V2 2/2] scsi: avoid to hold host-wide counter of host_busy for scsi_mq
Date: Sun, 24 Jun 2018 22:03:27 +0800
Message-Id: <20180624140327.28146-3-ming.lei@redhat.com>
In-Reply-To: <20180624140327.28146-1-ming.lei@redhat.com>
References: <20180624140327.28146-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

It isn't necessary to check the host depth in scsi_queue_rq() any more
since it has been respected by blk-mq before calling scsi_queue_rq() via
getting driver tag.

Lots of LUNs may attach to same host, and per-host IOPS may reach millions
level, so we should avoid to this expensive atomic operations on the
hostwide counter in IO path.

This patch implemens scsi_host_busy() via blk_mq_tagset_busy_iter() for
reading the count of busy IOs for scsi_mq.

It is observed that IOPS is increased by 15% in IO test on scsi_debug
(32 LUNs, 32 submit queues, 1024 can_queue, libaio/dio) in one
dual-socket system.

Cc: Omar Sandoval <osandov@fb.com>,
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: Don Brace <don.brace@microsemi.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/hosts.c    | 24 +++++++++++++++++++++++-
 drivers/scsi/scsi_lib.c | 23 +++++++++++++++++------
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index ea4b0bb0c1cd..f02dcc875a09 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -563,13 +563,35 @@ struct Scsi_Host *scsi_host_get(struct Scsi_Host *shost)
 }
 EXPORT_SYMBOL(scsi_host_get);
 
+struct scsi_host_mq_in_flight {
+	int cnt;
+};
+
+static void scsi_host_check_in_flight(struct request *rq, void *data,
+		bool reserved)
+{
+	struct scsi_host_mq_in_flight *in_flight = data;
+
+	if (blk_mq_request_started(rq))
+		in_flight->cnt++;
+}
+
 /**
  * scsi_host_busy - Return the host busy counter
  * @shost:	Pointer to Scsi_Host to inc.
  **/
 int scsi_host_busy(struct Scsi_Host *shost)
 {
-	return atomic_read(&shost->host_busy);
+	struct scsi_host_mq_in_flight in_flight = {
+		.cnt = 0,
+	};
+
+	if (!shost->use_blk_mq)
+		return atomic_read(&shost->host_busy);
+
+	blk_mq_tagset_busy_iter(&shost->tag_set, scsi_host_check_in_flight,
+			&in_flight);
+	return in_flight.cnt;
 }
 EXPORT_SYMBOL(scsi_host_busy);
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 41e9ac9fc138..1c79c86184b1 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -345,7 +345,8 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost)
 	unsigned long flags;
 
 	rcu_read_lock();
-	atomic_dec(&shost->host_busy);
+	if (!shost->use_blk_mq)
+		atomic_dec(&shost->host_busy);
 	if (unlikely(scsi_host_in_recovery(shost))) {
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (shost->host_failed || shost->host_eh_scheduled)
@@ -444,7 +445,12 @@ static inline bool scsi_target_is_busy(struct scsi_target *starget)
 
 static inline bool scsi_host_is_busy(struct Scsi_Host *shost)
 {
-	if (shost->can_queue > 0 &&
+	/*
+	 * blk-mq can handle host queue busy efficiently via host-wide driver
+	 * tag allocation
+	 */
+
+	if (!shost->use_blk_mq && shost->can_queue > 0 &&
 	    atomic_read(&shost->host_busy) >= shost->can_queue)
 		return true;
 	if (atomic_read(&shost->host_blocked) > 0)
@@ -1550,9 +1556,12 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
 	if (scsi_host_in_recovery(shost))
 		return 0;
 
-	busy = atomic_inc_return(&shost->host_busy) - 1;
+	if (!shost->use_blk_mq)
+		busy = atomic_inc_return(&shost->host_busy) - 1;
+	else
+		busy = 0;
 	if (atomic_read(&shost->host_blocked) > 0) {
-		if (busy)
+		if (busy || scsi_host_busy(shost))
 			goto starved;
 
 		/*
@@ -1566,7 +1575,7 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
 				     "unblocking host at zero depth\n"));
 	}
 
-	if (shost->can_queue > 0 && busy >= shost->can_queue)
+	if (!shost->use_blk_mq && shost->can_queue > 0 && busy >= shost->can_queue)
 		goto starved;
 	if (shost->host_self_blocked)
 		goto starved;
@@ -1652,7 +1661,9 @@ static void scsi_kill_request(struct request *req, struct request_queue *q)
 	 * with the locks as normal issue path does.
 	 */
 	atomic_inc(&sdev->device_busy);
-	atomic_inc(&shost->host_busy);
+
+	if (!shost->use_blk_mq)
+		atomic_inc(&shost->host_busy);
 	if (starget->can_queue > 0)
 		atomic_inc(&starget->target_busy);
 
-- 
2.9.5
