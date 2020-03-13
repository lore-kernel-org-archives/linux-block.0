Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E8C10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92BB20749
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 15:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCMPRa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:17:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgCMPR3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 11:17:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ACF7AAE35;
        Fri, 13 Mar 2020 15:17:28 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Guenther Roeck <linux@roeck-us.net>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] sata_fsl: fixup compilation errors
Date:   Fri, 13 Mar 2020 16:17:22 +0100
Message-Id: <20200313151722.74659-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixup compilation errors introduced by the libata DPRINTK rewrite.

Fixes: d9cbc6ab0938 ("sata_fsl: move DPRINTK to ata debugging")
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_fsl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 730f6701052c..45c15c4e9f8a 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -315,7 +315,7 @@ static void fsl_sata_set_irq_coalescing(struct ata_host *host,
 		"%s: interrupt coalescing, count = 0x%x, ticks = %x\n",
 		__func__, intr_coalescing_count, intr_coalescing_ticks);
 	dev_dbg(host->dev,
-		"%s: ICC register status: (hcr base: 0x%x) = 0x%x\n",
+		"%s: ICC register status: (hcr base: 0x%p) = 0x%x\n",
 		__func__, hcr_base, ioread32(hcr_base + ICC));
 }
 
@@ -1381,7 +1381,7 @@ static int sata_fsl_init_controller(struct ata_host *host)
 	 * callback, that should also initiate the OOB, COMINIT sequence
 	 */
 
-	ata_port_dbg(ap, "HStatus = 0x%x HControl = 0x%x\n",
+	dev_dbg(host->dev, "HStatus = 0x%x HControl = 0x%x\n",
 		     ioread32(hcr_base + HSTATUS),
 		     ioread32(hcr_base + HCONTROL));
 
@@ -1462,7 +1462,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base + TRANSCFG);
 	}
 
-	ata_port_dbg(ap, "@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
+	dev_dbg(&ofdev->dev, "@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
 
 	host_priv = kzalloc(sizeof(struct sata_fsl_host_priv), GFP_KERNEL);
 	if (!host_priv)
-- 
2.16.4

