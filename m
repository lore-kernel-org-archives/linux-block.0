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
Subject: [PATCH 20/55] skd: Fix size argument in skd_free_skcomp()
Date: Thu, 17 Aug 2017 13:13:03 -0700
Message-Id: <20170817201338.16537-21-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Pass the correct size to pci_free_consistent() in skd_free_skcomp().

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 53090a10150f..ab344bfa91c9 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -4252,14 +4252,9 @@ static struct skd_device *skd_construct(struct pci_dev *pdev)
 
 static void skd_free_skcomp(struct skd_device *skdev)
 {
-	if (skdev->skcomp_table != NULL) {
-		u32 nbytes;
-
-		nbytes = sizeof(skdev->skcomp_table[0]) *
-			 SKD_N_COMPLETION_ENTRY;
-		pci_free_consistent(skdev->pdev, nbytes,
+	if (skdev->skcomp_table)
+		pci_free_consistent(skdev->pdev, SKD_SKCOMP_SIZE,
 				    skdev->skcomp_table, skdev->cq_dma_address);
-	}
 
 	skdev->skcomp_table = NULL;
 	skdev->cq_dma_address = 0;
-- 
2.14.0
