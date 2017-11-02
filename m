Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/6] nvme: don't pass struct nvme_ns to nvme_config_discard
Date: Thu,  2 Nov 2017 21:28:54 +0300
Message-Id: <20171102182856.9162-5-hch@lst.de>
In-Reply-To: <20171102182856.9162-1-hch@lst.de>
References: <20171102182856.9162-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

To allow reusing this function for the multipath node.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8702e49c5c45..bfdbecdc307a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1118,29 +1118,26 @@ static void nvme_set_chunk_size(struct nvme_ns *ns)
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
-static void nvme_config_discard(struct nvme_ns *ns)
+static void nvme_config_discard(struct nvme_ctrl *ctrl,
+		unsigned stream_alignment, struct request_queue *queue)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
-	u32 logical_block_size = queue_logical_block_size(ns->queue);
+	u32 size = queue_logical_block_size(queue);
+
+	if (stream_alignment)
+		size *= stream_alignment;
 
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
 
-	if (ctrl->nr_streams && ns->sws && ns->sgs) {
-		unsigned int sz = logical_block_size * ns->sws * ns->sgs;
+	queue->limits.discard_alignment = size;
+	queue->limits.discard_granularity = size;
 
-		ns->queue->limits.discard_alignment = sz;
-		ns->queue->limits.discard_granularity = sz;
-	} else {
-		ns->queue->limits.discard_alignment = logical_block_size;
-		ns->queue->limits.discard_granularity = logical_block_size;
-	}
-	blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
-	blk_queue_max_discard_segments(ns->queue, NVME_DSM_MAX_RANGES);
-	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
+	blk_queue_max_discard_sectors(queue, UINT_MAX);
+	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
+	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, queue);
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
-		blk_queue_max_write_zeroes_sectors(ns->queue, UINT_MAX);
+		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
 static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
@@ -1164,6 +1161,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_ctrl *ctrl = ns->ctrl;
+	unsigned stream_alignment = 0;
 	u16 bs;
 
 	/*
@@ -1183,6 +1181,9 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	else
 		ns->pi_type = 0;
 
+	if (ctrl->nr_streams && ns->sws && ns->sgs)
+		stream_alignment = ns->sws * ns->sgs;
+
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
 
@@ -1198,7 +1199,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
 
 	if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
-		nvme_config_discard(ns);
+		nvme_config_discard(ctrl, stream_alignment, disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
-- 
2.14.2
