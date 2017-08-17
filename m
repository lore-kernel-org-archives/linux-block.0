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
Subject: [PATCH 47/55] skd: Move skd_free_sg_list() up
Date: Thu, 17 Aug 2017 13:13:30 -0700
Message-Id: <20170817201338.16537-48-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Issue a warning if a NULL argument is passed to skd_free_sg_list().
Move this function up to make the blk-mq conversion patch easier
to read.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 451974138b32..b69b1a041c8f 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2850,6 +2850,18 @@ static struct fit_sg_descriptor *skd_cons_sg_list(struct skd_device *skdev,
 	return sg_list;
 }
 
+static void skd_free_sg_list(struct skd_device *skdev,
+			     struct fit_sg_descriptor *sg_list, u32 n_sg,
+			     dma_addr_t dma_addr)
+{
+	u32 nbytes = sizeof(*sg_list) * n_sg;
+
+	if (WARN_ON_ONCE(!sg_list))
+		return;
+
+	pci_free_consistent(skdev->pdev, nbytes, sg_list, dma_addr);
+}
+
 static int skd_cons_skreq(struct skd_device *skdev)
 {
 	int rc = 0;
@@ -3105,19 +3117,6 @@ static void skd_free_skmsg(struct skd_device *skdev)
 	skdev->skmsg_table = NULL;
 }
 
-static void skd_free_sg_list(struct skd_device *skdev,
-			     struct fit_sg_descriptor *sg_list,
-			     u32 n_sg, dma_addr_t dma_addr)
-{
-	if (sg_list != NULL) {
-		u32 nbytes;
-
-		nbytes = sizeof(*sg_list) * n_sg;
-
-		pci_free_consistent(skdev->pdev, nbytes, sg_list, dma_addr);
-	}
-}
-
 static void skd_free_skreq(struct skd_device *skdev)
 {
 	u32 i;
-- 
2.14.0
