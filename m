Return-Path: <prvs=550bc9d12=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 3/3] block: Remove kblockd_schedule_delayed_work{,_on}()
Date: Fri, 19 Jan 2018 08:58:56 -0800
Message-Id: <20180119165856.17677-4-bart.vanassche@wdc.com>
In-Reply-To: <20180119165856.17677-1-bart.vanassche@wdc.com>
References: <20180119165856.17677-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The previous patch removed all users of these two functions. Hence
also remove the functions themselves.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/blk-core.c       | 14 --------------
 include/linux/blkdev.h |  2 --
 2 files changed, 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5c21d6b97985..a2005a485335 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3446,20 +3446,6 @@ int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 
-int kblockd_schedule_delayed_work(struct delayed_work *dwork,
-				  unsigned long delay)
-{
-	return queue_delayed_work(kblockd_workqueue, dwork, delay);
-}
-EXPORT_SYMBOL(kblockd_schedule_delayed_work);
-
-int kblockd_schedule_delayed_work_on(int cpu, struct delayed_work *dwork,
-				     unsigned long delay)
-{
-	return queue_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
-}
-EXPORT_SYMBOL(kblockd_schedule_delayed_work_on);
-
 /**
  * blk_start_plug - initialize blk_plug and track it inside the task_struct
  * @plug:	The &struct blk_plug that needs to be initialized
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a4c7aafb686d..4f3df807cf8f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1817,8 +1817,6 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
 
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_schedule_work_on(int cpu, struct work_struct *work);
-int kblockd_schedule_delayed_work(struct delayed_work *dwork, unsigned long delay);
-int kblockd_schedule_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
 #ifdef CONFIG_BLK_CGROUP
-- 
2.15.1
