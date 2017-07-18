Return-Path: <BATV+c9bd8cbfed8c34842ba8+5077+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: maxg@mellanox.com,
	linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: map queues to all present CPUs
Date: Tue, 18 Jul 2017 17:04:40 +0200
Message-Id: <20170718150440.27360-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We already do this for PCI mappings, and the higher level code now
expects that CPU on/offlining doesn't have an affect on the queue
mappings.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 block/blk-mq-cpumap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 4891f042a22f..9f8cffc8a701 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -17,9 +17,9 @@
 static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
 {
 	/*
-	 * Non online CPU will be mapped to queue index 0.
+	 * Non present CPU will be mapped to queue index 0.
 	 */
-	if (!cpu_online(cpu))
+	if (!cpu_present(cpu))
 		return 0;
 	return cpu % nr_queues;
 }
-- 
2.11.0
