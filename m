Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:48849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732368AbeGLUkc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jul 2018 16:40:32 -0400
Date: Thu, 12 Jul 2018 22:29:16 +0200
From: Helge Deller <deller@gmx.de>
To: Bart Van Assche <bart.vanassche@wdc.com>,
        linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org
Subject: [PATCH] block: skd: Use %pad printk format for dma_addr_t values
Message-ID: <20180712202916.GA32416@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use the existing %pad printk format to print dma_addr_t values.
This avoids the following warnings when compiling on the parisc64 platform:

drivers/block/skd_main.c: In function 'skd_preop_sg_list':
drivers/block/skd_main.c:660:4: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index bc7aea6d7b7c..9ba61c194b4c 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -657,8 +657,8 @@ static bool skd_preop_sg_list(struct skd_device *skdev,
 
 	if (unlikely(skdev->dbg_level > 1)) {
 		dev_dbg(&skdev->pdev->dev,
-			"skreq=%x sksg_list=%p sksg_dma=%llx\n",
-			skreq->id, skreq->sksg_list, skreq->sksg_dma_address);
+			"skreq=%x sksg_list=%p sksg_dma=%pad\n",
+			skreq->id, skreq->sksg_list, &skreq->sksg_dma_address);
 		for (i = 0; i < n_sg; i++) {
 			struct fit_sg_descriptor *sgd = &skreq->sksg_list[i];
 
@@ -1190,8 +1190,8 @@ static void skd_send_fitmsg(struct skd_device *skdev,
 {
 	u64 qcmd;
 
-	dev_dbg(&skdev->pdev->dev, "dma address 0x%llx, busy=%d\n",
-		skmsg->mb_dma_address, skd_in_flight(skdev));
+	dev_dbg(&skdev->pdev->dev, "dma address %pad, busy=%d\n",
+		&skmsg->mb_dma_address, skd_in_flight(skdev));
 	dev_dbg(&skdev->pdev->dev, "msg_buf %p\n", skmsg->msg_buf);
 
 	qcmd = skmsg->mb_dma_address;
@@ -1250,9 +1250,9 @@ static void skd_send_special_fitmsg(struct skd_device *skdev,
 		}
 
 		dev_dbg(&skdev->pdev->dev,
-			"skspcl=%p id=%04x sksg_list=%p sksg_dma=%llx\n",
+			"skspcl=%p id=%04x sksg_list=%p sksg_dma=%pad\n",
 			skspcl, skspcl->req.id, skspcl->req.sksg_list,
-			skspcl->req.sksg_dma_address);
+			&skspcl->req.sksg_dma_address);
 		for (i = 0; i < skspcl->req.n_sg; i++) {
 			struct fit_sg_descriptor *sgd =
 				&skspcl->req.sksg_list[i];
@@ -2685,8 +2685,8 @@ static int skd_cons_skmsg(struct skd_device *skdev)
 
 		WARN(((uintptr_t)skmsg->msg_buf | skmsg->mb_dma_address) &
 		     (FIT_QCMD_ALIGN - 1),
-		     "not aligned: msg_buf %p mb_dma_address %#llx\n",
-		     skmsg->msg_buf, skmsg->mb_dma_address);
+		     "not aligned: msg_buf %p mb_dma_address %pad\n",
+		     skmsg->msg_buf, &skmsg->mb_dma_address);
 		memset(skmsg->msg_buf, 0, SKD_N_FITMSG_BYTES);
 	}
 
