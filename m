Return-Path: <alan.christopher.jenkins@gmail.com>
Return-Path: <alan.christopher.jenkins@gmail.com>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alan Jenkins <alan.christopher.jenkins@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: do not use interruptible wait anywhere
Date: Thu, 12 Apr 2018 17:23:21 +0100
Message-Id: <20180412162321.3671-1-alan.christopher.jenkins@gmail.com>
List-ID: <linux-block@vger.kernel.org>

When blk_queue_enter() waits for a queue to unfreeze, or unset the
PREEMPT_ONLY flag, do not allow it to be interrupted by a signal.

The PREEMPT_ONLY flag was introduced later in commit 3a0a529971ec
("block, scsi: Make SCSI quiesce and resume work reliably").  Note the SCSI
device is resumed asynchronously, i.e. after un-freezing userspace tasks.

So that commit exposed the bug as a regression in v4.15.  A mysterious
SIGBUS (or -EIO) sometimes happened during the time the device was being
resumed.  Most frequently, there was no kernel log message, and we saw Xorg
or Xwayland killed by SIGBUS.[1]

[1] E.g. https://bugzilla.redhat.com/show_bug.cgi?id=1553979

Without this fix, I get an IO error in this test:

# dd if=/dev/sda of=/dev/null iflag=direct & \
  while killall -SIGUSR1 dd; do sleep 0.1; done & \
  echo mem > /sys/power/state ; \
  sleep 5; killall dd  # stop after 5 seconds

The interruptible wait was added to blk_queue_enter in
commit 3ef28e83ab15 ("block: generic request_queue reference counting").
Before then, the interruptible wait was only in blk-mq, but I don't think
it could ever have been correct.

Cc: stable@vger.kernel.org
Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 block/blk-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index abcb8684ba67..5a6d20069364 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -915,7 +915,6 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 
 	while (true) {
 		bool success = false;
-		int ret;
 
 		rcu_read_lock();
 		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
@@ -947,14 +946,12 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		 */
 		smp_rmb();
 
-		ret = wait_event_interruptible(q->mq_freeze_wq,
+		wait_event(q->mq_freeze_wq,
 				(atomic_read(&q->mq_freeze_depth) == 0 &&
 				 (preempt || !blk_queue_preempt_only(q))) ||
 				blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
-		if (ret)
-			return ret;
 	}
 }
 
-- 
2.14.3
