Return-Path: <prvs=41667da50=damien.lemoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: [PATCH V2 10/12] scsi: sd_zbc: Disable zone write locking with scsi-mq
Date: Fri,  8 Sep 2017 01:16:38 +0900
Message-Id: <20170907161640.30465-11-damien.lemoal@wdc.com>
In-Reply-To: <20170907161640.30465-1-damien.lemoal@wdc.com>
References: <20170907161640.30465-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

In the case of a ZBC disk used with scsi-mq, zone write locking does
not prevent write reordering in sequential zones. Unlike the legacy
case, zone locking can only be done after the command request is
removed from the scheduler dispatch queue. That is, at the time of
zone locking, the write command may already be out of order.

Disable zone write locking in sd_zbc_write_lock_zone() if the disk is
used with scsi-mq. Write order guarantees can be provided by an
adapted I/O scheduler.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Bart Van Assche <Bart.VanAssche@wdc.com>
---
 drivers/scsi/sd_zbc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index bcece82a1d8d..6b1a7f9c1e90 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -264,6 +264,10 @@ int sd_zbc_write_lock_zone(struct scsi_cmnd *cmd)
 	    (sector & (zone_sectors - 1)) + blk_rq_sectors(rq) > zone_sectors)
 		return BLKPREP_KILL;
 
+	/* No write locking with scsi-mq */
+	if (rq->q->mq_ops)
+		return BLKPREP_OK;
+
 	/*
 	 * There is no write constraint on conventional zones, but do not issue
 	 * more than one write at a time per sequential zone. This avoids write
-- 
2.13.5
