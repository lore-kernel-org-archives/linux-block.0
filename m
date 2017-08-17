Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 07/55] skd: Remove ESXi code
Date: Thu, 17 Aug 2017 13:12:50 -0700
Message-Id: <20170817201338.16537-8-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since the code guarded by #ifdef SKD_VMK_POLL_HANDLER / #endif
is never built on Linux systems, remove it.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 06544f58dc73..74489da762a1 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -4777,20 +4777,6 @@ static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_timer;
 	}
 
-
-#ifdef SKD_VMK_POLL_HANDLER
-	if (skdev->irq_type == SKD_IRQ_MSIX) {
-		/* MSIX completion handler is being used for coredump */
-		vmklnx_scsi_register_poll_handler(skdev->scsi_host,
-						  skdev->msix_entries[5].vector,
-						  skd_comp_q, skdev);
-	} else {
-		vmklnx_scsi_register_poll_handler(skdev->scsi_host,
-						  skdev->pdev->irq, skd_isr,
-						  skdev);
-	}
-#endif  /* SKD_VMK_POLL_HANDLER */
-
 	return rc;
 
 err_out_timer:
-- 
2.14.0
