Return-Path: <BATV+f649350760d99b9783a0+4916+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme: support ranged discard requests
Date: Tue,  7 Feb 2017 17:46:58 +0100
Message-Id: <20170207164658.32449-5-hch@lst.de>
In-Reply-To: <20170207164658.32449-1-hch@lst.de>
References: <20170207164658.32449-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efe8ec300126..ae9254fcd9c5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -238,26 +238,36 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
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
+	if (WARN_ON_ONCE(n != segments))
+		return BLK_MQ_RQ_QUEUE_ERROR;
 
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
@@ -1233,6 +1243,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
 	blk_queue_write_cache(q, vwc, vwc);
+	blk_queue_max_discard_segments(q,
+			PAGE_SIZE / sizeof(struct nvme_dsm_range));
 }
 
 /*
-- 
2.11.0
