Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8E7C76192
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 02:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B5921783
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 02:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="mjlTX6k9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfGRCJE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:09:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45280 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbfGRCJD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 22:09:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so27252225otq.12
        for <linux-block@vger.kernel.org>; Wed, 17 Jul 2019 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1moG08RDjKKJ7MKDJKOBn/sNbWf8lRGlaG8g2yFaYCY=;
        b=mjlTX6k9ha9WQs1z2Dav1UPfb9oXjocFhGrzlD32ubltgNCmFxq1fSeVXzZ1MQapvg
         xqdWIBvsro3RxZQnOUGsKLxy8Aq1LXjj/GseaJKaH3bcSt2Ju0Sgagiq1s0325PhLnZu
         2r0evYryQ3CHMxoybNXTqg5i51j2R90th4tHMNcOxwh3sdFs1cKJsCKJAaYPuEJE28Jc
         enNytVYqsFb+RPvCnDw973qQ4X5kqPB6+UUd1Be2+b/uCAT+zU9jG4A5kBuXRW9JX16U
         AhKhchrN2J8e7DP7mwypmWILoLye6xIJt8HZByxh0b3m7L/E9PqB5ebZ5nQuE1e/MSmq
         onwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1moG08RDjKKJ7MKDJKOBn/sNbWf8lRGlaG8g2yFaYCY=;
        b=Y0tpq2ZF6nZbd/1RK198IxAMSg/Z65rYJKNiuvQ2mTVz+gnIGBtyTUfI879JRf+Iah
         JLI1jUaH42EHUJah5CmerrI2/w1wYlGSSFBGSHuLC3itCx1m0vuAk0EihsW2YNgD7Wd5
         X9OwM0UU3a1ooAAfKlRAYlo6j+IJYxY44eUxns+389grsYMoHzuxhQI6M2tjiw6c+osb
         VaSxbIOyRqwaRx24lL2LXyiU+5CRkJgM1gSJDSp972Y+XzJ91E+eBBUk+RjWdnLctGj/
         fjVKnb+68wLfK5iwluzpBHNLOrHBq/L7CEWwbFzas5S0OQRUHckdQvAbtXyLzLfdl6Lb
         3YhA==
X-Gm-Message-State: APjAAAXBewbPQggiYczWMvR7Zd29KDQDqT1wgbbghZM/PSfR1avFHYRM
        CkP0HVOxRzYN3C7/d0uw8gE=
X-Google-Smtp-Source: APXvYqx7sGWIB1b7IVwEiaxWJUqTW3MEGVIytib3Q+lDGrN6yhxGtGSZSJx5KMvltgqwxS3gWBfrgg==
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr33919317oto.35.1563415742817;
        Wed, 17 Jul 2019 19:09:02 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:18af:e893:6cb0:139a])
        by smtp.gmail.com with ESMTPSA id r9sm9784752otc.26.2019.07.17.19.09.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 19:09:02 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     axboe@kernel.dk
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: [PATCH] mtip32xx: Prefer pcie_capability_read_word()
Date:   Wed, 17 Jul 2019 21:07:41 -0500
Message-Id: <20190718020745.8867-6-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718020745.8867-1-fred@fredlawl.com>
References: <20190718020745.8867-1-fred@fredlawl.com>
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
index f0105d118056..b7b26e33248b 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3952,22 +3952,18 @@ static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
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
2.17.1

