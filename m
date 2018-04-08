Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/8] blk-mq: make sure that correct hctx->next_cpu is set
Date: Sun,  8 Apr 2018 17:48:07 +0800
Message-Id: <20180408094814.28953-2-ming.lei@redhat.com>
In-Reply-To: <20180408094814.28953-1-ming.lei@redhat.com>
References: <20180408094814.28953-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

>From commit 20e4d81393196 (blk-mq: simplify queue mapping & schedule
with each possisble CPU), one hctx can be mapped from all offline CPUs,
then hctx->next_cpu can be set as wrong.

This patch fixes this issue by making hctx->next_cpu pointing to the
first CPU in hctx->cpumask if all CPUs in hctx->cpumask are offline.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
Fixes: 20e4d81393196 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f5c7dbcb954f..9b220dc415ac 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2432,6 +2432,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		 */
 		hctx->next_cpu = cpumask_first_and(hctx->cpumask,
 				cpu_online_mask);
+		if (hctx->next_cpu >= nr_cpu_ids)
+			hctx->next_cpu = cpumask_first(hctx->cpumask);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
 }
-- 
2.9.5
