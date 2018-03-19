Return-Path: <prvs=609d84ff1=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.com>,
	Ming Lei <ming.lei@redhat.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Tejun Heo <tj@kernel.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Martin Steigerwald <martin@lichtvoll.de>,
	stable@vger.kernel.org
Subject: [PATCH] block: Change a rcu_read_{lock,unlock}_sched() pair into rcu_read_{lock,unlock}()
Date: Mon, 19 Mar 2018 11:01:00 -0700
Message-Id: <20180319180100.7012-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since neither the RCU-protected code in blk_queue_enter() nor
blk_queue_usage_counter_release() sleeps, regular RCU protection
is sufficient. Note: scsi_device_quiesce() does not have to be
modified since it already uses synchronize_rcu().

Reported-by: Tejun Heo <tj@kernel.org>
Fixes: 3a0a529971ec ("block, scsi: Make SCSI quiesce and resume work reliably")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Martin Steigerwald <martin@lichtvoll.de>
Cc: stable@vger.kernel.org # v4.15
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5e88c579e896..a0f675f84f86 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -917,7 +917,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		bool success = false;
 		int ret;
 
-		rcu_read_lock_sched();
+		rcu_read_lock();
 		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
 			/*
 			 * The code that sets the PREEMPT_ONLY flag is
@@ -930,7 +930,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 				percpu_ref_put(&q->q_usage_counter);
 			}
 		}
-		rcu_read_unlock_sched();
+		rcu_read_unlock();
 
 		if (success)
 			return 0;
-- 
2.16.2
