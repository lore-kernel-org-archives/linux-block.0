Return-Path: <prvs=431df6ef2=bart.vanassche@wdc.com>
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
Subject: [PATCH v3 5/6] block: Make SCSI device suspend and resume work reliably
Date: Fri, 22 Sep 2017 15:14:04 -0700
Message-Id: <20170922221405.22091-6-bart.vanassche@wdc.com>
In-Reply-To: <20170922221405.22091-1-bart.vanassche@wdc.com>
References: <20170922221405.22091-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

It is essential during suspend and resume that neither the filesystem
state nor the filesystem metadata in RAM changes. This is why while
the hibernation image is being written or restored that SCSI devices
are quiesced. The SCSI core quiesces devices through scsi_device_quiesce()
and scsi_device_resume(). In the SDEV_QUIESCE state execution of
non-preempt requests is deferred. This is realized by returning
BLKPREP_DEFER from inside scsi_prep_state_check() for quiesced SCSI
devices. Avoid that a full queue prevents power management requests
to be submitted by deferring allocation of non-preempt requests for
devices in the quiesced state. This patch has been tested by running
the following commands and by verifying that after resume the fio job
is still running:

for d in /sys/class/block/sd*[a-z]; do
  hcil=$(readlink "$d/device")
  hcil=${hcil#../../../}
  echo 4 > "$d/queue/nr_requests"
  echo 1 > "/sys/class/scsi_device/$hcil/device/queue_depth"
done
bdev=$(readlink /dev/disk/by-uuid/5217d83f-213e-4b42-b86e-20013325ba6c)
bdev=${bdev#../../}
hcil=$(readlink "/sys/block/$bdev/device")
hcil=${hcil#../../../}
fio --name="$bdev" --filename="/dev/$bdev" --buffered=0 --bs=512 --rw=randread \
  --ioengine=libaio --numjobs=4 --iodepth=16 --iodepth_batch=1 --thread \
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
 block/blk-core.c       | 37 ++++++++++++++++++++++++++++---------
 block/blk-mq.c         |  4 ++--
 block/blk-timeout.c    |  2 +-
 fs/block_dev.c         |  4 ++--
 include/linux/blkdev.h |  2 +-
 5 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 45cf3f56a730..971825bd4462 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -351,10 +351,12 @@ void blk_set_preempt_only(struct request_queue *q, bool preempt_only)
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	if (preempt_only)
+	if (preempt_only) {
 		queue_flag_set(QUEUE_FLAG_PREEMPT_ONLY, q);
-	else
+	} else {
 		queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
+		wake_up_all(&q->mq_freeze_wq);
+	}
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 EXPORT_SYMBOL(blk_set_preempt_only);
@@ -773,13 +775,29 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
-int blk_queue_enter(struct request_queue *q, bool nowait)
+/**
+ * blk_queue_enter() - try to increase q->q_usage_counter
+ * @q: request queue pointer
+ * @nowait: if the queue is frozen, do not wait until it is unfrozen
+ * @preempt: if QUEUE_FLAG_PREEMPT_ONLY has been set, do not wait until that
+ *	flag has been cleared
+ */
+int blk_queue_enter(struct request_queue *q, bool nowait, bool preempt)
 {
 	while (true) {
 		int ret;
 
-		if (percpu_ref_tryget_live(&q->q_usage_counter))
-			return 0;
+		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
+			/*
+			 * Ensure read order of q_usage_counter and the
+			 * PREEMPT_ONLY queue flag.
+			 */
+			smp_rmb();
+			if (preempt || !blk_queue_preempt_only(q))
+				return 0;
+			else
+				percpu_ref_put(&q->q_usage_counter);
+		}
 
 		if (nowait)
 			return -EBUSY;
@@ -794,7 +812,8 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
 		smp_rmb();
 
 		ret = wait_event_interruptible(q->mq_freeze_wq,
-				!atomic_read(&q->mq_freeze_depth) ||
+				(atomic_read(&q->mq_freeze_depth) == 0 &&
+				 (preempt || !blk_queue_preempt_only(q))) ||
 				blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
@@ -2172,6 +2191,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 	 */
 	struct bio_list bio_list_on_stack[2];
 	blk_qc_t ret = BLK_QC_T_NONE;
+	const bool nowait = bio->bi_opf & REQ_NOWAIT;
 
 	if (!generic_make_request_checks(bio))
 		goto out;
@@ -2211,7 +2231,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 	do {
 		struct request_queue *q = bio->bi_disk->queue;
 
-		if (likely(blk_queue_enter(q, bio->bi_opf & REQ_NOWAIT) == 0)) {
+		if (likely(blk_queue_enter(q, nowait, false) == 0)) {
 			struct bio_list lower, same;
 
 			/* Create a fresh bio_list for all subordinate requests */
@@ -2236,8 +2256,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 			bio_list_merge(&bio_list_on_stack[0], &same);
 			bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
 		} else {
-			if (unlikely(!blk_queue_dying(q) &&
-					(bio->bi_opf & REQ_NOWAIT)))
+			if (unlikely(!blk_queue_dying(q) && nowait))
 				bio_wouldblock_error(bio);
 			else
 				bio_io_error(bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98a18609755e..ddaa0b444652 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -390,7 +390,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	struct request *rq;
 	int ret;
 
-	ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
+	ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT, op & REQ_PREEMPT);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -429,7 +429,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	if (hctx_idx >= q->nr_hw_queues)
 		return ERR_PTR(-EIO);
 
-	ret = blk_queue_enter(q, true);
+	ret = blk_queue_enter(q, true, op & REQ_PREEMPT);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 17ec83bb0900..0dfdc975473a 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -134,7 +134,7 @@ void blk_timeout_work(struct work_struct *work)
 	struct request *rq, *tmp;
 	int next_set = 0;
 
-	if (blk_queue_enter(q, true))
+	if (blk_queue_enter(q, true, true))
 		return;
 	spin_lock_irqsave(q->queue_lock, flags);
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 93d088ffc05c..e9ca45087a40 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -674,7 +674,7 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
 	if (!ops->rw_page || bdev_get_integrity(bdev))
 		return result;
 
-	result = blk_queue_enter(bdev->bd_queue, false);
+	result = blk_queue_enter(bdev->bd_queue, false, false);
 	if (result)
 		return result;
 	result = ops->rw_page(bdev, sector + get_start_sect(bdev), page, false);
@@ -710,7 +710,7 @@ int bdev_write_page(struct block_device *bdev, sector_t sector,
 
 	if (!ops->rw_page || bdev_get_integrity(bdev))
 		return -EOPNOTSUPP;
-	result = blk_queue_enter(bdev->bd_queue, false);
+	result = blk_queue_enter(bdev->bd_queue, false, false);
 	if (result)
 		return result;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5bd87599eed0..a025597c378a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -964,7 +964,7 @@ extern int scsi_cmd_ioctl(struct request_queue *, struct gendisk *, fmode_t,
 extern int sg_scsi_ioctl(struct request_queue *, struct gendisk *, fmode_t,
 			 struct scsi_ioctl_command __user *);
 
-extern int blk_queue_enter(struct request_queue *q, bool nowait);
+extern int blk_queue_enter(struct request_queue *q, bool nowait, bool preempt);
 extern void blk_queue_exit(struct request_queue *q);
 extern void blk_start_queue(struct request_queue *q);
 extern void blk_start_queue_async(struct request_queue *q);
-- 
2.14.1
