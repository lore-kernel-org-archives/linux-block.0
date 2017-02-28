Return-Path: <Damien.LeMoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: MPT-FusionLinux.pdl@broadcom.com,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 3/3] mpt3sas: Do not check resid for non medium access commands
Date: Tue, 28 Feb 2017 19:25:35 +0900
Message-Id: <20170228102535.15966-4-damien.lemoal@wdc.com>
In-Reply-To: <20170228102535.15966-1-damien.lemoal@wdc.com>
References: <20170228102535.15966-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Bart Van Assche <bart.vanassche@sandisk.com>

Commit f2e767bb5d6e ("mpt3sas: Force request partial completion
alignment") introduced a forced alignment of resid to the device
logical block size to fix bogus HBA firmware sometimes returning an
unaligned value. This fix however did not consider the case of
commands not operating on logical block size units
(e.g. REQ_OP_ZONE_REPORT and its 64B aligned partial replies). This
could result is incorrectly aligning resid for these commands, which
for REQ_OP_REPORT_ZONES result in the inability to determine the
number of zone descriptors returned.

Fix the resid alignment check to exclude all requests that are not
medium access requests using blk_rq_access_medium(). This will exclude
from the resid forced fix all passthrough requests as well as zone
command requests.

Fixes: f2e767bb5d6e ("mpt3sas: Force request partial completion alignment")
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 46e866c..405dc84 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -4748,8 +4748,8 @@ _scsih_io_done(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index, u32 reply)
 	 * then scsi-ml does not need to handle this misbehavior.
 	 */
 	sector_sz = scmd->device->sector_size;
-	if (unlikely(!blk_rq_is_passthrough(scmd->request) && sector_sz &&
-		     xfer_cnt % sector_sz)) {
+	if (unlikely(sector_sz && (xfer_cnt & (sector_sz - 1)) &&
+		     blk_rq_accesses_medium(scmd->request))) {
 		sdev_printk(KERN_INFO, scmd->device,
 		    "unaligned partial completion avoided (xfer_cnt=%u, sector_sz=%u)\n",
 			    xfer_cnt, sector_sz);
-- 
2.9.3

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
