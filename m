Return-Path: <willy@infradead.org>
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 10/26] rsxx: Convert to new IDA API
Date: Thu, 21 Jun 2018 14:28:19 -0700
Message-Id: <20180621212835.5636-11-willy@infradead.org>
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
List-ID: <linux-block@vger.kernel.org>

Eliminate the custom spinlock and the call to ida_pre_get.
Also add a call to ida_free() in the card remove routine, which I believe
fixes a bug in this driver.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/rsxx/core.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index b7d71914a32a..f2c631ce793c 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -58,7 +58,6 @@ MODULE_PARM_DESC(sync_start, "On by Default: Driver load will not complete "
 			     "until the card startup has completed.");
 
 static DEFINE_IDA(rsxx_disk_ida);
-static DEFINE_SPINLOCK(rsxx_ida_lock);
 
 /* --------------------Debugfs Setup ------------------- */
 
@@ -771,19 +770,10 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	card->dev = dev;
 	pci_set_drvdata(dev, card);
 
-	do {
-		if (!ida_pre_get(&rsxx_disk_ida, GFP_KERNEL)) {
-			st = -ENOMEM;
-			goto failed_ida_get;
-		}
-
-		spin_lock(&rsxx_ida_lock);
-		st = ida_get_new(&rsxx_disk_ida, &card->disk_id);
-		spin_unlock(&rsxx_ida_lock);
-	} while (st == -EAGAIN);
-
-	if (st)
+	st = ida_alloc(&rsxx_disk_ida, GFP_KERNEL);
+	if (st < 0)
 		goto failed_ida_get;
+	card->disk_id = st;
 
 	st = pci_enable_device(dev);
 	if (st)
@@ -985,9 +975,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 failed_dma_mask:
 	pci_disable_device(dev);
 failed_enable:
-	spin_lock(&rsxx_ida_lock);
-	ida_remove(&rsxx_disk_ida, card->disk_id);
-	spin_unlock(&rsxx_ida_lock);
+	ida_free(&rsxx_disk_ida, card->disk_id);
 failed_ida_get:
 	kfree(card);
 
@@ -1050,6 +1038,7 @@ static void rsxx_pci_remove(struct pci_dev *dev)
 	pci_disable_device(dev);
 	pci_release_regions(dev);
 
+	ida_free(&rsxx_disk_ida, card->disk_id);
 	kfree(card);
 }
 
-- 
2.17.1
