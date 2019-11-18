Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C106C432C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E805920748
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="Md6Zu6Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfKRAVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Nov 2019 19:21:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36843 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfKRAVP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Nov 2019 19:21:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id j7so13721425oib.3
        for <linux-block@vger.kernel.org>; Sun, 17 Nov 2019 16:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wINNGpwv7rfFjkOocRZinKoRo1EENB9vc5x4WXjd+NU=;
        b=Md6Zu6Hf26Pi97+YT3Y3YaEfxiXS2RlDrYentpQ1YYF++gN0B8+XJlQyLBEdSEJ8k2
         /lVUs4hHhTDSkgDSs1rfBp4aZEFo3Zs6jaiYMiLr/sgi7M0BA/kJOr2LcJQupVboUiMC
         P4yF51yrAW6rqzgDi+VNCrb7evSOuE937VJ3pFefub48AFyW03t6EK2cvibRwOdCKWbz
         eBfh5jPuCF0p25+TFDypI/uJshS6jOyExtu15XqcWtHmaZs0OX9XnuU9Nkkv6FAWAeBR
         0HNok0nFKouqVG8NQL80KDpqt5d/HkS4Fpi0B7WNgtCklDdyCD7vxDUrXeqzH8ylYlbq
         uJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wINNGpwv7rfFjkOocRZinKoRo1EENB9vc5x4WXjd+NU=;
        b=hIqcJxUHrhwsR8EvtDq5iVTz1be1WLakvGRDfKR7Aosoq2uU2N3Y/lBCirQ/Ry+C5A
         q0OuvR/oLFTxAa+FJQl55Tt4CuQQvSVf9v3fyJzNj8Pimwfl7CSPJXvDD4v6JmWGiuVY
         BcPGMSBlJzjzIctp7jtP5TTo+Tnh9+W+OD3mAd4vKFCw1P/60o6EFXANGfIg32WCnTeh
         VoxmxNZOflu9i7qkC/cYnvnTpGKeIwrgMO1BXCUjDAe8smiDfo/ZoCrlp/+butDa9rEE
         KlbxYDQwjRigWmKBdJYo7yfZcbwKAmntOjUEn0eOeEdhHaskFW5g8+x8l7/zInvzaceu
         PYHA==
X-Gm-Message-State: APjAAAWkhZ9r92yhn1Hn4YxFpsIrfS3Jp0OCVcNHb1M+s3KDQnz5au7H
        NP3yrcuUV9nai1SyrWD5n4HW7g==
X-Google-Smtp-Source: APXvYqz1qPqJq5C0BfZ+47CDZnFM48RNuI0KKG/3cQjhSRx0HCmWRg6V368wYAWKApLJyfaEDHiV9w==
X-Received: by 2002:aca:ddc2:: with SMTP id u185mr18492063oig.174.1574036474399;
        Sun, 17 Nov 2019 16:21:14 -0800 (PST)
Received: from com.attlocal.net ([2600:1700:4870:71e0::10])
        by smtp.gmail.com with ESMTPSA id 65sm5532194oie.50.2019.11.17.16.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 16:21:13 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     axboe@kernel.dk
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        bvanassche@acm.org
Subject: [PATCH v2 3/4] mtip32xx: Prefer pcie_capability_read_word()
Date:   Sun, 17 Nov 2019 18:20:56 -0600
Message-Id: <20191118002057.9596-4-fred@fredlawl.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118002057.9596-1-fred@fredlawl.com>
References: <20191118002057.9596-1-fred@fredlawl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
added accessors for the PCI Express Capability so that drivers didn't
need to be aware of differences between v1 and v2 of the PCI
Express Capability.

Replace pci_read_config_word() and pci_write_config_word() calls with
pcie_capability_read_word() and pcie_capability_write_word().

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 964f78cfffa0..35703dc98e25 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3938,22 +3938,18 @@ static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
 	int pos;
 	unsigned short pcie_dev_ctrl;
 
-	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
-	if (pos) {
-		pci_read_config_word(pdev,
-			pos + PCI_EXP_DEVCTL,
-			&pcie_dev_ctrl);
-		if (pcie_dev_ctrl & (1 << 11) ||
-		    pcie_dev_ctrl & (1 << 4)) {
-			dev_info(&dd->pdev->dev,
-				"Disabling ERO/No-Snoop on bridge device %04x:%04x\n",
-					pdev->vendor, pdev->device);
-			pcie_dev_ctrl &= ~(PCI_EXP_DEVCTL_NOSNOOP_EN |
-						PCI_EXP_DEVCTL_RELAX_EN);
-			pci_write_config_word(pdev,
-				pos + PCI_EXP_DEVCTL,
-				pcie_dev_ctrl);
-		}
+	if (!pci_is_pcie(pdev))
+		return;
+
+	pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &pcie_dev_ctrl);
+	if (pcie_dev_ctrl & (1 << 11) ||
+	    pcie_dev_ctrl & (1 << 4)) {
+		dev_info(&dd->pdev->dev,
+			 "Disabling ERO/No-Snoop on bridge device %04x:%04x\n",
+			 pdev->vendor, pdev->device);
+		pcie_dev_ctrl &= ~(PCI_EXP_DEVCTL_NOSNOOP_EN |
+					PCI_EXP_DEVCTL_RELAX_EN);
+		pcie_capability_write_word(pdev, PCI_EXP_DEVCTL, pcie_dev_ctrl);
 	}
 }
 
-- 
2.20.1

