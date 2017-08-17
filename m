Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 55/55] skd: Bump driver version
Date: Thu, 17 Aug 2017 13:13:38 -0700
Message-Id: <20170817201338.16537-56-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Bump the driver version. Remove the build ID because build IDs do
not make sense for an upstream kernel driver. Keep the driver
version in the module information but do not report it during every
load, unload or probe.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/block/skd_main.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index bcd8df0bf203..a61c7a3a5557 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -53,14 +53,13 @@ static int skd_isr_comp_limit = 4;
 	} while (0)
 
 #define DRV_NAME "skd"
-#define DRV_VERSION "2.2.1"
-#define DRV_BUILD_ID "0260"
+#define DRV_VERSION "3.0.0"
 #define PFX DRV_NAME ": "
 
 MODULE_LICENSE("GPL");
 
-MODULE_DESCRIPTION("STEC s1120 PCIe SSD block driver (b" DRV_BUILD_ID ")");
-MODULE_VERSION(DRV_VERSION "-" DRV_BUILD_ID);
+MODULE_DESCRIPTION("STEC s1120 PCIe SSD block driver");
+MODULE_VERSION(DRV_VERSION);
 
 #define PCI_VENDOR_ID_STEC      0x1B39
 #define PCI_DEVICE_ID_S1120     0x0001
@@ -3206,10 +3205,8 @@ static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	char pci_str[32];
 	struct skd_device *skdev;
 
-	dev_info(&pdev->dev, "STEC s1120 Driver(%s) version %s-b%s\n",
-		 DRV_NAME, DRV_VERSION, DRV_BUILD_ID);
-	dev_info(&pdev->dev, "vendor=%04X device=%04x\n", pdev->vendor,
-		 pdev->device);
+	dev_dbg(&pdev->dev, "vendor=%04X device=%04x\n", pdev->vendor,
+		pdev->device);
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -3664,8 +3661,6 @@ static int __init skd_init(void)
 	BUILD_BUG_ON(offsetof(struct skd_msg_buf, scsi) != 64);
 	BUILD_BUG_ON(sizeof(struct skd_msg_buf) != SKD_N_FITMSG_BYTES);
 
-	pr_info(PFX " v%s-b%s loaded\n", DRV_VERSION, DRV_BUILD_ID);
-
 	switch (skd_isr_type) {
 	case SKD_IRQ_LEGACY:
 	case SKD_IRQ_MSI:
@@ -3714,8 +3709,6 @@ static int __init skd_init(void)
 
 static void __exit skd_exit(void)
 {
-	pr_info(PFX " v%s-b%s unloading\n", DRV_VERSION, DRV_BUILD_ID);
-
 	pci_unregister_driver(&skd_driver);
 
 	if (skd_major)
-- 
2.14.0
