Return-Path: <BATV+adf086a54a2d754d8a83+5184+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/6] nvme: don't pass struct nvme_ns to nvme_init_integrity
Date: Thu,  2 Nov 2017 21:28:53 +0300
Message-Id: <20171102182856.9162-4-hch@lst.de>
In-Reply-To: <20171102182856.9162-1-hch@lst.de>
References: <20171102182856.9162-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

To allow reusing this function for the multipath node.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bc27f6603861..8702e49c5c45 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1081,12 +1081,12 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct nvme_ns *ns)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 {
 	struct blk_integrity integrity;
 
 	memset(&integrity, 0, sizeof(integrity));
-	switch (ns->pi_type) {
+	switch (pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
 		integrity.profile = &t10_pi_type3_crc;
 		integrity.tag_size = sizeof(u16) + sizeof(u32);
@@ -1102,12 +1102,12 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 		integrity.profile = NULL;
 		break;
 	}
-	integrity.tuple_size = ns->ms;
-	blk_integrity_register(ns->disk, &integrity);
-	blk_queue_max_integrity_segments(ns->queue, 1);
+	integrity.tuple_size = ms;
+	blk_integrity_register(disk, &integrity);
+	blk_queue_max_integrity_segments(disk->queue, 1);
 }
 #else
-static void nvme_init_integrity(struct nvme_ns *ns)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 {
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
@@ -1191,7 +1191,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		nvme_set_chunk_size(ns);
 	if (ns->ms && !ns->ext &&
 	    (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		nvme_init_integrity(ns);
+		nvme_init_integrity(disk, ns->ms, ns->pi_type);
 	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
 		set_capacity(disk, 0);
 	else
-- 
2.14.2
