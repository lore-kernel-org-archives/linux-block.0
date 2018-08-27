Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	Don Brace <don.brace@microsemi.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Laurence Oberman <loberman@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] Revert "scsi: core: avoid host-wide host_busy counter for scsi_mq"
Date: Mon, 27 Aug 2018 15:24:43 +0800
Message-Id: <20180827072443.26920-3-ming.lei@redhat.com>
In-Reply-To: <20180827072443.26920-1-ming.lei@redhat.com>
References: <20180827072443.26920-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This reverts commit 328728630d9f2bf14b82ca30b5e47489beefe361.

There is fundamental issue in commit 328728630d9f2bf1 (scsi: core: avoid
host-wide host_busy counter for scsi_mq) because SCSI's host busy counter
may not be same with counter of blk-mq's inflight tags, especially in case
of none io scheduler.

We may switch to other approach for addressing this scsi_mq's performance issue,
such as percpu counter or kind of ways, so revert this commit first for fixing this
kind of issue in EH path, as reported by Jens.

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
Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/hosts.c    | 24 +-----------------------
 drivers/scsi/scsi_lib.c | 23 ++++++-----------------
 2 files changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index f02dcc875a09..ea4b0bb0c1cd 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -563,35 +563,13 @@ struct Scsi_Host *scsi_host_get(struct Scsi_Host *shost)
 }
 EXPORT_SYMBOL(scsi_host_get);
 
-struct scsi_host_mq_in_flight {
-	int cnt;
-};
-
-static void scsi_host_check_in_flight(struct request *rq, void *data,
-		bool reserved)
-{
-	struct scsi_host_mq_in_flight *in_flight = data;
-
-	if (blk_mq_request_started(rq))
-		in_flight->cnt++;
-}
-
 /**
  * scsi_host_busy - Return the host busy counter
  * @shost:	Pointer to Scsi_Host to inc.
  **/
 int scsi_host_busy(struct Scsi_Host *shost)
 {
-	struct scsi_host_mq_in_flight in_flight = {
-		.cnt = 0,
-	};
-
-	if (!shost->use_blk_mq)
-		return atomic_read(&shost->host_busy);
-
-	blk_mq_tagset_busy_iter(&shost->tag_set, scsi_host_check_in_flight,
-			&in_flight);
-	return in_flight.cnt;
+	return atomic_read(&shost->host_busy);
 }
 EXPORT_SYMBOL(scsi_host_busy);
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1046679f5473..eb97d2dd3651 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -345,8 +345,7 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost)
 	unsigned long flags;
 
 	rcu_read_lock();
-	if (!shost->use_blk_mq)
-		atomic_dec(&shost->host_busy);
+	atomic_dec(&shost->host_busy);
 	if (unlikely(scsi_host_in_recovery(shost))) {
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (shost->host_failed || shost->host_eh_scheduled)
@@ -445,12 +444,7 @@ static inline bool scsi_target_is_busy(struct scsi_target *starget)
 
 static inline bool scsi_host_is_busy(struct Scsi_Host *shost)
 {
-	/*
-	 * blk-mq can handle host queue busy efficiently via host-wide driver
-	 * tag allocation
-	 */
-
-	if (!shost->use_blk_mq && shost->can_queue > 0 &&
+	if (shost->can_queue > 0 &&
 	    atomic_read(&shost->host_busy) >= shost->can_queue)
 		return true;
 	if (atomic_read(&shost->host_blocked) > 0)
@@ -1606,12 +1600,9 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
 	if (scsi_host_in_recovery(shost))
 		return 0;
 
-	if (!shost->use_blk_mq)
-		busy = atomic_inc_return(&shost->host_busy) - 1;
-	else
-		busy = 0;
+	busy = atomic_inc_return(&shost->host_busy) - 1;
 	if (atomic_read(&shost->host_blocked) > 0) {
-		if (busy || scsi_host_busy(shost))
+		if (busy)
 			goto starved;
 
 		/*
@@ -1625,7 +1616,7 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
 				     "unblocking host at zero depth\n"));
 	}
 
-	if (!shost->use_blk_mq && shost->can_queue > 0 && busy >= shost->can_queue)
+	if (shost->can_queue > 0 && busy >= shost->can_queue)
 		goto starved;
 	if (shost->host_self_blocked)
 		goto starved;
@@ -1711,9 +1702,7 @@ static void scsi_kill_request(struct request *req, struct request_queue *q)
 	 * with the locks as normal issue path does.
 	 */
 	atomic_inc(&sdev->device_busy);
-
-	if (!shost->use_blk_mq)
-		atomic_inc(&shost->host_busy);
+	atomic_inc(&shost->host_busy);
 	if (starget->can_queue > 0)
 		atomic_inc(&starget->target_busy);
 
-- 
2.9.5
