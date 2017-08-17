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
Subject: [PATCH 19/55] skd: Introduce SKD_SKCOMP_SIZE
Date: Thu, 17 Aug 2017 13:13:02 -0700
Message-Id: <20170817201338.16537-20-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 98dc16073072..53090a10150f 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -103,6 +103,10 @@ MODULE_VERSION(DRV_VERSION "-" DRV_BUILD_ID);
 
 #define SKD_N_INTERNAL_BYTES    (512u)
 
+#define SKD_SKCOMP_SIZE							\
+	((sizeof(struct fit_completion_entry_v1) +			\
+	  sizeof(struct fit_comp_error_info)) * SKD_N_COMPLETION_ENTRY)
+
 /* 5 bits of uniqifier, 0xF800 */
 #define SKD_ID_INCR             (0x400)
 #define SKD_ID_TABLE_MASK       (3u << 8u)
@@ -2834,13 +2838,7 @@ static void skd_release_special(struct skd_device *skdev,
 
 static void skd_reset_skcomp(struct skd_device *skdev)
 {
-	u32 nbytes;
-	struct fit_completion_entry_v1 *skcomp;
-
-	nbytes = sizeof(*skcomp) * SKD_N_COMPLETION_ENTRY;
-	nbytes += sizeof(struct fit_comp_error_info) * SKD_N_COMPLETION_ENTRY;
-
-	memset(skdev->skcomp_table, 0, nbytes);
+	memset(skdev->skcomp_table, 0, SKD_SKCOMP_SIZE);
 
 	skdev->skcomp_ix = 0;
 	skdev->skcomp_cycle = 1;
@@ -3851,16 +3849,12 @@ static int skd_cons_skcomp(struct skd_device *skdev)
 {
 	int rc = 0;
 	struct fit_completion_entry_v1 *skcomp;
-	u32 nbytes;
-
-	nbytes = sizeof(*skcomp) * SKD_N_COMPLETION_ENTRY;
-	nbytes += sizeof(struct fit_comp_error_info) * SKD_N_COMPLETION_ENTRY;
 
 	dev_dbg(&skdev->pdev->dev,
-		"comp pci_alloc, total bytes %d entries %d\n",
-		nbytes, SKD_N_COMPLETION_ENTRY);
+		"comp pci_alloc, total bytes %zd entries %d\n",
+		SKD_SKCOMP_SIZE, SKD_N_COMPLETION_ENTRY);
 
-	skcomp = pci_zalloc_consistent(skdev->pdev, nbytes,
+	skcomp = pci_zalloc_consistent(skdev->pdev, SKD_SKCOMP_SIZE,
 				       &skdev->cq_dma_address);
 
 	if (skcomp == NULL) {
-- 
2.14.0
