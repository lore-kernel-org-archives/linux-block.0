Return-Path: <prvs=430e6b2f0=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	=Oleksandr Natalenko <oleksandr@natalenko.name>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 3/4] block, scsi: Make SCSI device suspend and resume work reliably
Date: Thu, 21 Sep 2017 14:22:54 -0700
Message-Id: <20170921212255.12788-4-bart.vanassche@wdc.com>
In-Reply-To: <20170921212255.12788-1-bart.vanassche@wdc.com>
References: <20170921212255.12788-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

It is essential during suspend and resume that neither the filesystem
state nor the filesystem metadata in RAM changes. This is why while
the hibernation image is being written or restored that SCSI devices
are quiesced. The SCSI core quiesces devices through scsi_device_quiesce()
and scsi_device_resume(). In the SDEV_QUIESCE state execution of
non-preempt requests is deferred. This is realized by returning
BLKPREP_DEFER from inside scsi_prep_state_check() for quiesced SCSI
devices. Avoid that a full queue prevents power management requests
to be submitted by slowing down allocation of non-preempt requests for
devices in the quiesced state. This patch has been tested by running
the following commands and by verifying that after resume the fio job
is still running:

for d in /sys/class/block/sd*[a-z]; do
  hcil=$(readlink "$d/device")
  hcil=${hcil#../../../}
  echo 4 > "$d"
  echo 1 > "/sys/class/scsi_device/$hcil/device/queue_depth"
done
bdev=$(readlink /dev/disk/by-uuid/5217d83f-213e-4b42-b86e-20013325ba6c)
bdev=${bdev#../../}
hcil=$(readlink "/sys/block/$bdev/device")
hcil=${hcil#../../../}
fio --name="$bdev" --filename="/dev/$bdev" --buffered=0 --bs=512 --rw=randread \
  --ioengine=psync --numjobs=4 --iodepth=16 --iodepth_batch=1 --thread \
  --loops=$((2**31)) &
pid=$!
sleep 1
systemctl hibernate
sleep 10
kill $pid

Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
References: "I/O hangs after resuming from suspend-to-ram" (https://marc.info/?l=linux-block&m=150340235201348).
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-core.c        | 13 ++++++++++---
 drivers/scsi/scsi_lib.c | 11 ++++++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1ac337712bbd..6a190dd998aa 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1429,11 +1429,18 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 				gfp_t gfp_mask)
 {
 	struct request *req;
+	const bool may_sleep = gfp_mask & __GFP_DIRECT_RECLAIM;
+
+	if (unlikely(blk_queue_preempt_only(q) && !(op & REQ_PREEMPT))) {
+		if (may_sleep)
+			msleep(100);
+		else
+			return ERR_PTR(-EBUSY);
+	}
 
 	if (q->mq_ops) {
-		req = blk_mq_alloc_request(q, op,
-			(gfp_mask & __GFP_DIRECT_RECLAIM) ?
-				0 : BLK_MQ_REQ_NOWAIT);
+		req = blk_mq_alloc_request(q, op, may_sleep ?
+					   0 : BLK_MQ_REQ_NOWAIT);
 		if (!IS_ERR(req) && q->mq_ops->initialize_rq_fn)
 			q->mq_ops->initialize_rq_fn(req);
 	} else {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6db8247577a0..e76fd6e89a81 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2889,19 +2889,22 @@ static void scsi_wait_for_queuecommand(struct scsi_device *sdev)
 int
 scsi_device_quiesce(struct scsi_device *sdev)
 {
+	struct request_queue *q = sdev->request_queue;
 	int err;
 
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
+	if (err == 0)
+		blk_set_preempt_only(q, true);
 	mutex_unlock(&sdev->state_mutex);
 
 	if (err)
 		return err;
 
-	scsi_run_queue(sdev->request_queue);
+	scsi_run_queue(q);
 	while (atomic_read(&sdev->device_busy)) {
 		msleep_interruptible(200);
-		scsi_run_queue(sdev->request_queue);
+		scsi_run_queue(q);
 	}
 	return 0;
 }
@@ -2924,8 +2927,10 @@ void scsi_device_resume(struct scsi_device *sdev)
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
