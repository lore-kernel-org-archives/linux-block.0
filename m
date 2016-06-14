Return-Path: <BATV+1815987b1c14acf14571+4678+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com,
	ooo@electrozaur.com,
	nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/7] memstick: don't allow REQ_TYPE_BLOCK_PC requests
Date: Tue, 14 Jun 2016 19:15:58 +0200
Message-Id: <1465924564-14503-2-git-send-email-hch@lst.de>
In-Reply-To: <1465924564-14503-1-git-send-email-hch@lst.de>
References: <1465924564-14503-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

There is no code to issue or handle REQ_TYPE_BLOCK_PC request in the
memstick drivers, so remove the bogus conditional.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/memstick/core/ms_block.c    | 3 +--
 drivers/memstick/core/mspro_block.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 3cd6815..21cc231 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2002,8 +2002,7 @@ static int msb_bd_getgeo(struct block_device *bdev,
 
 static int msb_prepare_req(struct request_queue *q, struct request *req)
 {
-	if (req->cmd_type != REQ_TYPE_FS &&
-				req->cmd_type != REQ_TYPE_BLOCK_PC) {
+	if (req->cmd_type != REQ_TYPE_FS) {
 		blk_dump_rq_flags(req, "MS unsupported request");
 		return BLKPREP_KILL;
 	}
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 0fb27d3..586fb8d 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -829,8 +829,7 @@ static void mspro_block_start(struct memstick_dev *card)
 
 static int mspro_block_prepare_req(struct request_queue *q, struct request *req)
 {
-	if (req->cmd_type != REQ_TYPE_FS &&
-	    req->cmd_type != REQ_TYPE_BLOCK_PC) {
+	if (req->cmd_type != REQ_TYPE_FS) {
 		blk_dump_rq_flags(req, "MSPro unsupported request");
 		return BLKPREP_KILL;
 	}
-- 
2.1.4
