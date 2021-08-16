Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA5C432BE
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFEE6142A
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 01:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhHPBpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:45:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37260 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhHPBpb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 21:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629078299; x=1660614299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N9HTUe3fPenLFb7TILYqOuQ90dOIPTNwU0OUTxnf8fo=;
  b=gm4W51wKj3gU8moPcFHy8uzxnsHZKCEb/DG8f8JEvK9TU11CfYtgCGDT
   LV5sqQrwV3ZrOhyoti35fn9W7Dly83kktTFjTWBRMKpeMFCmbK5kbngrW
   PbuCajfTto21qLOsWE6y0L5wTnR/5n/5hujw4r7f0kHmBYwM/E+8aAEMk
   Ue8nHsdoiDpEAJxpf5GQ25TVejd7k+nRa9M6FBitHlLrCJ3o/gP9Bgbqr
   J6xTmbxHxU6G4FnchuzUXx+nTz5hpjIb5MjIx9BX44mrChbrdFxgVU2DK
   SFPFVYgkpz1s1MwRmHjdlwvxCXrc7ayQtTuSMOSLjq/CcGiFtZV8FJyRs
   A==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="177326679"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 09:44:58 +0800
IronPort-SDR: /Kohvq34GAF/ljduOSOesRZL2TdQdKkgnYGdqKdpPUQHzoZpu/DYZzHbWUDYvgp3lvlhFV+Tj4
 o2uvE3qmYvk3JSf9CqbhyVzFFzjNjDvCcutEn0zrxIrNGbmamukEI3R0gLrJcpkvWdNGH8dY2g
 73QhRPqCwtOhnOYffVR2SMfNTLsH40XewTumBNWPPKvXzPS5kUPZ4ATOotdHCBHTRYIDx5En/8
 hQZGIOQGTaI1+55Z3I02t6EkIFft259sJL4M4WoFS5ETvd8fLNJNj28+y/zT49jWVjJJHLBhNu
 cdG6UMmKQkuhKQsBmEc0jF1n
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 18:20:25 -0700
IronPort-SDR: KLk3XdXy/x41QHM02FW1flFBqvuFZqCVyQeelYeIyJiUnRtBaUUzUXQj2Is0EOCP8jmbKVVfPz
 DQ/HhnLZjEyCO0t2e8jV5WRktjg81SYmqbZapq3MA/V4mFQBQywCeRhBG5oBcqooSwYYn0C9R5
 3hm69JQHEuSV3EYkilL51cnzTK+WzSmu24n94UpON1ihbCp4E0fdSMPbPdFKKoE+zfRtvUDO05
 2xYniTz13w32k8hJqACW0KVL6Fr8eB74IaBK4bIxgRasEi+/5GkajOPgdFczEXkLajh8hvhhbq
 nFs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2021 18:45:00 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v7 01/11] libata: fix ata_host_alloc_pinfo()
Date:   Mon, 16 Aug 2021 10:44:46 +0900
Message-Id: <20210816014456.2191776-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816014456.2191776-1-damien.lemoal@wdc.com>
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid static checkers warnings about a potential NULL pointer
dereference for the port info variable pi. To do so, test that at least
one port info is available on entry to ata_host_alloc_pinfo() and start
the ata port initialization for() loop with pi initialized to the first
port info passed as argument (which is already checked to be non NULL).
Within the for() loop, get the next port info, if it is not NULL,
after initializing the ata port using the previous port info.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/ata/libata-core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 61c762961ca8..b237a718ea0f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5441,16 +5441,17 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 	struct ata_host *host;
 	int i, j;
 
+	/* We must have at least one port info */
+	if (!ppi[0])
+		return NULL;
+
 	host = ata_host_alloc(dev, n_ports);
 	if (!host)
 		return NULL;
 
-	for (i = 0, j = 0, pi = NULL; i < host->n_ports; i++) {
+	for (i = 0, j = 0, pi = ppi[0]; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-		if (ppi[j])
-			pi = ppi[j++];
-
 		ap->pio_mask = pi->pio_mask;
 		ap->mwdma_mask = pi->mwdma_mask;
 		ap->udma_mask = pi->udma_mask;
@@ -5460,6 +5461,15 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 
 		if (!host->ops && (pi->port_ops != &ata_dummy_port_ops))
 			host->ops = pi->port_ops;
+
+		/*
+		 * Check that the next port info is not NULL.
+		 * If it is, keep using the current one.
+		 */
+		if (j < n_ports - 1 && ppi[j + 1]) {
+			j++;
+			pi = ppi[j];
+		}
 	}
 
 	return host;
-- 
2.31.1

