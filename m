Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/8] blk-mq: don't keep offline CPUs mapped to hctx 0
Date: Sun,  8 Apr 2018 17:48:08 +0800
Message-Id: <20180408094814.28953-3-ming.lei@redhat.com>
In-Reply-To: <20180408094814.28953-1-ming.lei@redhat.com>
References: <20180408094814.28953-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

>From commit 4b855ad37194 ("blk-mq: Create hctx for each present CPU),
blk-mq doesn't remap queue after CPU topo is changed, that said when
some of these offline CPUs become online, they are still mapped to
hctx 0, then hctx 0 may become the bottleneck of IO dispatch and
completion.

This patch sets up the mapping from the beginning, and aligns to
queue mapping for PCI device (blk_mq_pci_map_queues()).

Fixes: 4b855ad37194 ("blk-mq: Create hctx for each present CPU)
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-cpumap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9f8cffc8a701..3eb169f15842 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -16,11 +16,6 @@
 
 static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
 {
-	/*
-	 * Non present CPU will be mapped to queue index 0.
-	 */
-	if (!cpu_present(cpu))
-		return 0;
 	return cpu % nr_queues;
 }
 
-- 
2.9.5
