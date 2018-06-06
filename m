Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: always set partition number to '0' in blk_partition_remap()
Date: Wed,  6 Jun 2018 16:22:18 +0200
Message-Id: <20180606142218.64220-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

blk_partition_remap() will only clear bi_partno if an actual remapping
has happened. But flush request et al don't have an actual size, so
the remapping doesn't happen and bi_partno is never cleared.
So for stacked devices blk_partition_remap() will be called on each level.
If (as is the case for native nvme multipathing) one of the lower-level
devices do _not_support partitioning a spurious I/O error is generated.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cee03cad99f2..8a2c3a474234 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2225,7 +2225,10 @@ static inline int blk_partition_remap(struct bio *bio)
 		bio->bi_partno = 0;
 		trace_block_bio_remap(bio->bi_disk->queue, bio, part_devt(p),
 				      bio->bi_iter.bi_sector - p->start_sect);
-	}
+	} else
+		/* Set partition number to '0' to avoid repetitive calls */
+		bio->bi_partno = 0;
+
 	ret = 0;
 out:
 	rcu_read_unlock();
-- 
2.12.3
