Return-Path: <BATV+67dfbb8f664e29ec4bbc+5394+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <damien.lemoal@wdc.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/6] block: move initialization of elevator-related fields to blk_alloc_queue_node
Date: Thu, 31 May 2018 19:11:36 +0200
Message-Id: <20180531171141.18478-2-hch@lst.de>
In-Reply-To: <20180531171141.18478-1-hch@lst.de>
References: <20180531171141.18478-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

No point in doing this in elevator_init.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Damien Le Moal <Damien.LeMoal@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c | 5 +++++
 block/elevator.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a295b3c159b2..b00e7e6340ca 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -999,6 +999,11 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 	if (!q)
 		return NULL;
 
+	INIT_LIST_HEAD(&q->queue_head);
+	q->last_merge = NULL;
+	q->end_sector = 0;
+	q->boundary_rq = NULL;
+
 	q->id = ida_simple_get(&blk_queue_ida, 0, 0, gfp_mask);
 	if (q->id < 0)
 		goto fail_q;
diff --git a/block/elevator.c b/block/elevator.c
index e87e9b43aba0..8b64f92e029a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -213,11 +213,6 @@ int elevator_init(struct request_queue *q, char *name)
 	if (unlikely(q->elevator))
 		return 0;
 
-	INIT_LIST_HEAD(&q->queue_head);
-	q->last_merge = NULL;
-	q->end_sector = 0;
-	q->boundary_rq = NULL;
-
 	if (name) {
 		e = elevator_get(q, name, true);
 		if (!e)
-- 
2.17.0
