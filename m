Return-Path: <BATV+10e0b2ba6b8830823af0+4672+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: keith.busch@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@lightbits.io,
	ming.l@ssi.samsung.com
Subject: [PATCH 04/11] nvmet: update for req_op changes
Date: Wed,  8 Jun 2016 14:30:59 +0200
Message-Id: <1465389066-19119-5-git-send-email-hch@lst.de>
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/io-cmd.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 76dbf73..4cfd481 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -49,7 +49,7 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	struct bio *bio;
 	sector_t sector;
 	blk_qc_t cookie;
-	int rw, i;
+	int op, op_flags = 0, i;
 
 	if (!req->sg_cnt) {
 		nvmet_req_complete(req, 0);
@@ -57,12 +57,11 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	}
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
+		op = REQ_OP_WRITE;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
-			rw = WRITE_FUA;
-		else
-			rw = WRITE;
+			op_flags |= REQ_FUA;
 	} else {
-		rw = READ;
+		op = REQ_OP_READ;
 	}
 
 	sector = le64_to_cpu(req->cmd->rw.slba);
@@ -83,16 +82,17 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
 			bio->bi_bdev = req->ns->bdev;
 			bio->bi_iter.bi_sector = sector;
+			bio_set_op_attrs(bio, op, op_flags);
 
 			bio_chain(bio, prev);
-			cookie = submit_bio(rw, prev);
+			cookie = submit_bio(prev);
 		}
 
 		sector += sg->length >> 9;
 		sg_cnt--;
 	}
 
-	cookie = submit_bio(rw, bio);
+	cookie = submit_bio(bio);
 
 	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
 }
@@ -107,17 +107,18 @@ static void nvmet_execute_flush(struct nvmet_req *req)
 	bio->bi_bdev = req->ns->bdev;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
+	bio->bi_rw = WRITE_FLUSH;
 
-	submit_bio(WRITE_FLUSH, bio);
+	submit_bio(bio);
 }
 
 static u16 nvmet_discard_range(struct nvmet_ns *ns,
-		struct nvme_dsm_range *range, int type, struct bio **bio)
+		struct nvme_dsm_range *range, struct bio **bio)
 {
 	if (__blkdev_issue_discard(ns->bdev,
 			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
-			GFP_KERNEL, type, bio))
+			GFP_KERNEL, 0, bio))
 		return NVME_SC_INTERNAL | NVME_SC_DNR;
 	return 0;
 }
@@ -126,7 +127,7 @@ static void nvmet_execute_discard(struct nvmet_req *req)
 {
 	struct nvme_dsm_range range;
 	struct bio *bio = NULL;
-	int type = REQ_WRITE | REQ_DISCARD, i;
+	int i;
 	u16 status;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
@@ -135,7 +136,7 @@ static void nvmet_execute_discard(struct nvmet_req *req)
 		if (status)
 			break;
 
-		status = nvmet_discard_range(req->ns, &range, type, &bio);
+		status = nvmet_discard_range(req->ns, &range, &bio);
 		if (status)
 			break;
 	}
@@ -147,7 +148,7 @@ static void nvmet_execute_discard(struct nvmet_req *req)
 			bio->bi_error = -EIO;
 			bio_endio(bio);
 		} else {
-			submit_bio(type, bio);
+			submit_bio(bio);
 		}
 	} else {
 		nvmet_req_complete(req, status);
-- 
2.1.4
