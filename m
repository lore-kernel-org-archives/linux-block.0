Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-ide@vger.kernel.org
Subject: [PATCH 08/12] ide-floppy: Use blk_rq_is_scsi()
Date: Thu, 17 Aug 2017 16:23:07 -0700
Message-Id: <20170817232311.25948-9-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
---
 drivers/ide/ide-floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 627b1f62a749..3ddd88219906 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -72,7 +72,7 @@ static int ide_floppy_callback(ide_drive_t *drive, int dsc)
 		drive->failed_pc = NULL;
 
 	if (pc->c[0] == GPCMD_READ_10 || pc->c[0] == GPCMD_WRITE_10 ||
-	    (req_op(rq) == REQ_OP_SCSI_IN || req_op(rq) == REQ_OP_SCSI_OUT))
+	    blk_rq_is_scsi(rq))
 		uptodate = 1; /* FIXME */
 	else if (pc->c[0] == GPCMD_REQUEST_SENSE) {
 
-- 
2.14.0
