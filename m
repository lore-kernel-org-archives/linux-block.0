Return-Path: <BATV+add76be85c7e68b62602+4917+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme: support ranged discard requests
Date: Wed,  8 Feb 2017 14:46:50 +0100
Message-Id: <20170208134650.5380-5-hch@lst.de>
In-Reply-To: <20170208134650.5380-1-hch@lst.de>
References: <20170208134650.5380-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

NVMe supports up to 256 ranges per DSM command, so wire up support
for ranged discards up to that limit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 30 +++++++++++++++++++++++-------
 include/linux/nvme.h     |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efe8ec300126..d9f49036819c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -238,26 +238,38 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
+	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
 	struct nvme_dsm_range *range;
-	unsigned int nr_bytes = blk_rq_bytes(req);
+	struct bio *bio;
 
-	range = kmalloc(sizeof(*range), GFP_ATOMIC);
+	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
 	if (!range)
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
-	range->cattr = cpu_to_le32(0);
-	range->nlb = cpu_to_le32(nr_bytes >> ns->lba_shift);
-	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	__rq_for_each_bio(bio, req) {
+		u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
+		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
+
+		range[n].cattr = cpu_to_le32(0);
+		range[n].nlb = cpu_to_le32(nlb);
+		range[n].slba = cpu_to_le64(slba);
+		n++;
+	}
+
+	if (WARN_ON_ONCE(n != segments)) {
+		kfree(range);
+		return BLK_MQ_RQ_QUEUE_ERROR;
+	}
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
 	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
-	cmnd->dsm.nr = 0;
+	cmnd->dsm.nr = segments - 1;
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
 
 	req->special_vec.bv_page = virt_to_page(range);
 	req->special_vec.bv_offset = offset_in_page(range);
-	req->special_vec.bv_len = sizeof(*range);
+	req->special_vec.bv_len = sizeof(*range) * segments;
 	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
 
 	return BLK_MQ_RQ_QUEUE_OK;
@@ -877,6 +889,9 @@ static void nvme_config_discard(struct nvme_ns *ns)
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 logical_block_size = queue_logical_block_size(ns->queue);
 
+	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
+			NVME_DSM_MAX_RANGES);
+
 	if (ctrl->quirks & NVME_QUIRK_DISCARD_ZEROES)
 		ns->queue->limits.discard_zeroes_data = 1;
 	else
@@ -885,6 +900,7 @@ static void nvme_config_discard(struct nvme_ns *ns)
 	ns->queue->limits.discard_alignment = logical_block_size;
 	ns->queue->limits.discard_granularity = logical_block_size;
 	blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
+	blk_queue_max_discard_segments(ns->queue, NVME_DSM_MAX_RANGES);
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d1c6f1b15c9..3e2ed49c3ad8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -553,6 +553,8 @@ enum {
 	NVME_DSMGMT_AD		= 1 << 2,
 };
 
+#define NVME_DSM_MAX_RANGES	256
+
 struct nvme_dsm_range {
 	__le32			cattr;
 	__le32			nlb;
-- 
2.11.0
