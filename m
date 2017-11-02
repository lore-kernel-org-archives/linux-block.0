Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/6] nvme: always unregister the integrity profile in __nvme_revalidate_disk
Date: Thu,  2 Nov 2017 21:28:52 +0300
Message-Id: <20171102182856.9162-3-hch@lst.de>
In-Reply-To: <20171102182856.9162-1-hch@lst.de>
References: <20171102182856.9162-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This is safe because the queue is always frozen when we revalidate, and
it simplifies both the existing code as well as the multipath
implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1c2686d4eaf3..bc27f6603861 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1081,29 +1081,6 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
-		u16 bs)
-{
-	struct nvme_ns *ns = disk->private_data;
-	u16 old_ms = ns->ms;
-	u8 pi_type = 0;
-
-	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
-
-	/* PI implementation requires metadata equal t10 pi tuple size */
-	if (ns->ms == sizeof(struct t10_pi_tuple))
-		pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-
-	if (blk_get_integrity(disk) &&
-	    (ns->pi_type != pi_type || ns->ms != old_ms ||
-	     bs != queue_logical_block_size(disk->queue) ||
-	     (ns->ms && ns->ext)))
-		blk_integrity_unregister(disk);
-
-	ns->pi_type = pi_type;
-}
-
 static void nvme_init_integrity(struct nvme_ns *ns)
 {
 	struct blk_integrity integrity;
@@ -1130,10 +1107,6 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 	blk_queue_max_integrity_segments(ns->queue, 1);
 }
 #else
-static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
-		u16 bs)
-{
-}
 static void nvme_init_integrity(struct nvme_ns *ns)
 {
 }
@@ -1202,15 +1175,22 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		ns->lba_shift = 9;
 	bs = 1 << ns->lba_shift;
 	ns->noiob = le16_to_cpu(id->noiob);
+	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
+	/* the PI implementation requires metadata equal t10 pi tuple size */
+	if (ns->ms == sizeof(struct t10_pi_tuple))
+		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+	else
+		ns->pi_type = 0;
 
 	blk_mq_freeze_queue(disk->queue);
+	blk_integrity_unregister(disk);
 
-	if (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
-		nvme_prep_integrity(disk, id, bs);
 	blk_queue_logical_block_size(ns->queue, bs);
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
-	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
+	if (ns->ms && !ns->ext &&
+	    (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(ns);
 	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
 		set_capacity(disk, 0);
-- 
2.14.2
