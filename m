Return-Path: <Damien.LeMoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien
 Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] sd_zbc: Force use of READ16/WRITE16
Date: Fri, 11 Nov 2016 14:53:26 +0900
Message-ID: <1478843606-15647-1-git-send-email-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

Normally, sd_read_capacity sets sdp->use_16_for_rw to 1 based on the
disk capacity so that READ16/WRITE16 are used for large drives.
However, for a zoned disk with RC_BASIS set to 0, the capacity reported
through READ_CAPACITY may be very small, leading to use_16_for_rw not being
set and READ10/WRITE10 commands being used, even after the actual zoned disk
capacity is corrected in sd_zbc_read_zones. This causes LBA offset overflow for
accesses beyond 2TB.

As the ZBC standard makes it mandatory for ZBC drives to support
the READ16/WRITE16 commands anyway, make sure that use_16_for_rw is set.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/scsi/sd_zbc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 394ab49..92620c8 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -612,6 +612,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp,
 	if (ret)
 		goto err;
 
+	/* READ16/WRITE16 is mandatory for ZBC disks */
+	sdkp->device->use_16_for_rw = 1;
+	sdkp->device->use_10_for_rw = 0;
+
 	return 0;
 
 err:
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
