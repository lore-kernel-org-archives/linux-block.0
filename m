Return-Path: <prvs=4710b8301=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>, Hongxu Jia <hongxu.jia@windriver.com>
Subject: [PATCH] ide: Make ide_cdrom_prep_fs() initialize the sense buffer pointer
Date: Wed, 1 Nov 2017 15:31:49 -0700
Message-ID: <20171101223149.27593-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

The changes introduced through commit 82ed4db499b8 assume that the
sense buffer pointer in struct scsi_request is initialized for all
requests - passthrough and filesystem requests. Hence make sure
that that pointer is initialized for filesystem requests. Remove
the memset() call that clears .cmd because the scsi_req_init()
call in ide_initialize_rq() already initializes the .cmd.

Fixes: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hongxu Jia <hongxu.jia@windriver.com>
---
 drivers/ide/ide-cd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index a7355ab3bb22..09b5bdb1af64 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1328,8 +1328,7 @@ static int ide_cdrom_prep_fs(struct request_queue *q, struct request *rq)
 	unsigned long blocks = blk_rq_sectors(rq) / (hard_sect >> 9);
 	struct scsi_request *req = scsi_req(rq);
 
-	scsi_req_init(req);
-	memset(req->cmd, 0, BLK_MAX_CDB);
+	q->initialize_rq_fn(rq);
 
 	if (rq_data_dir(rq) == READ)
 		req->cmd[0] = GPCMD_READ_10;
-- 
2.14.3
