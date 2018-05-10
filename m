Return-Path: <christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: axboe@kernel.dk,
	ming.lei@redhat.com,
	martin.petersen@oracle.com,
	sagi@grimberg.me,
	chris.gekas@gmail.com,
	bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mtip32xx: Fix an error handling path in 'mtip_pci_probe()'
Date: Thu, 10 May 2018 09:27:31 +0200
Message-Id: <20180510072731.19956-1-christophe.jaillet@wanadoo.fr>
List-ID: <linux-block@vger.kernel.org>

Branch to the right label in the error handling path in order to keep it
logical.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 769c551e3d71..06257b872a7d 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4273,7 +4273,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	if (!dd->isr_workq) {
 		dev_warn(&pdev->dev, "Can't create wq %d\n", dd->instance);
 		rv = -ENOMEM;
-		goto block_initialize_err;
+		goto setmask_err;
 	}
 
 	memset(cpu_list, 0, sizeof(cpu_list));
-- 
2.17.0
