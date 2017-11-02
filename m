Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 5/6] nvme: set the chunk size before freezing the queue
Date: Thu,  2 Nov 2017 21:28:55 +0300
Message-Id: <20171102182856.9162-6-hch@lst.de>
In-Reply-To: <20171102182856.9162-1-hch@lst.de>
References: <20171102182856.9162-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

We don't need a frozen queue to update the chunk_size, which just is a
hint, and moving it a little earlier will allow for some better code
reuse with the multipath code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bfdbecdc307a..3758528be0ef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1184,12 +1184,13 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ctrl->nr_streams && ns->sws && ns->sgs)
 		stream_alignment = ns->sws * ns->sgs;
 
+	if (ns->noiob)
+		nvme_set_chunk_size(ns);
+
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
 
 	blk_queue_logical_block_size(ns->queue, bs);
-	if (ns->noiob)
-		nvme_set_chunk_size(ns);
 	if (ns->ms && !ns->ext &&
 	    (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-- 
2.14.2
