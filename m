Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 6/6] nvme: split __nvme_revalidate_disk
Date: Thu,  2 Nov 2017 21:28:56 +0300
Message-Id: <20171102182856.9162-7-hch@lst.de>
In-Reply-To: <20171102182856.9162-1-hch@lst.de>
References: <20171102182856.9162-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Split out the code that applies the calculate value to a given disk/queue
into new helper that can be reused by the multipath code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 49 +++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3758528be0ef..66211617e7e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1157,12 +1157,34 @@ static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 	}
 }
 
+static void nvme_update_disk_info(struct gendisk *disk,
+		struct nvme_ns *ns, struct nvme_id_ns *id)
+{
+	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
+	unsigned stream_alignment = 0;
+
+	if (ns->ctrl->nr_streams && ns->sws && ns->sgs)
+		stream_alignment = ns->sws * ns->sgs;
+
+	blk_mq_freeze_queue(disk->queue);
+	blk_integrity_unregister(disk);
+
+	blk_queue_logical_block_size(disk->queue, 1 << ns->lba_shift);
+	if (ns->ms && !ns->ext &&
+	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+		nvme_init_integrity(disk, ns->ms, ns->pi_type);
+	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
+		capacity = 0;
+	set_capacity(disk, capacity);
+
+	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
+		nvme_config_discard(ns->ctrl, stream_alignment, disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
+}
+
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
-	struct nvme_ctrl *ctrl = ns->ctrl;
-	unsigned stream_alignment = 0;
-	u16 bs;
 
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
@@ -1171,7 +1193,6 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
-	bs = 1 << ns->lba_shift;
 	ns->noiob = le16_to_cpu(id->noiob);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
@@ -1181,27 +1202,9 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	else
 		ns->pi_type = 0;
 
-	if (ctrl->nr_streams && ns->sws && ns->sgs)
-		stream_alignment = ns->sws * ns->sgs;
-
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
-
-	blk_mq_freeze_queue(disk->queue);
-	blk_integrity_unregister(disk);
-
-	blk_queue_logical_block_size(ns->queue, bs);
-	if (ns->ms && !ns->ext &&
-	    (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
-		set_capacity(disk, 0);
-	else
-		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
-
-	if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
-		nvme_config_discard(ctrl, stream_alignment, disk->queue);
-	blk_mq_unfreeze_queue(disk->queue);
+	nvme_update_disk_info(disk, ns, id);
 }
 
 static int nvme_revalidate_disk(struct gendisk *disk)
-- 
2.14.2
