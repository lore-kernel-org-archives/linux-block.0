Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A37C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA4F20674
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbhAZV7o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405193AbhAZUFa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:05:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9956422B2C;
        Tue, 26 Jan 2021 20:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611691489;
        bh=GhsOY7dwQeZzdKA+1WHW1WqJfwy0Ae81jjbvBQf+Bz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llrd9nfy8Dt6Zb89AhD2HLqH4a/mu0ZfVrMYSBrf68Fod1XWPOruDFCBtlH82SKjb
         S5WvwbzpR+KXNcHb0Kp/Mx8MXQ+A4RfbRdePrw1DC/u9hFS87Vlc8mu10m3gni6uls
         4ELRnoMJbovojVOK5kGo7IUvddFZqbvjQ2whtgcidMyyH20FOntQ7puARVhCqeq3EG
         Nc54r/WkTdzZnJuKCSZKQ3LFKZS/jO2aKxgCdnFufzmqVP6WGO/RWtKsSspZ5cvUQV
         HO77qx+U15ZWssTLVJ0/V8uIDIe5aJfSkYpz9XU/vNsup8kAGjYzINOb6FoVQ1+4AI
         1OXjIIMk4IpBg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] mtip32xx: prefer pcie_capability_read_word()
Date:   Tue, 26 Jan 2021 14:04:33 -0600
Message-Id: <20210126200433.2911982-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126200433.2911982-1-helgaas@kernel.org>
References: <20210126200433.2911982-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Replace pci_read_config_word() with pcie_capability_read_word().

pcie_capability_read_word() takes care of a few special cases when reading
the PCIe capability.  See 8c0d3a02c130 ("PCI: Add accessors for PCI Express
Capability").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 543eb30a3bc0..a0f9bf152ddc 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3924,14 +3924,10 @@ static DEFINE_HANDLER(7);
 
 static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
 {
-	int pos;
 	unsigned short pcie_dev_ctrl;
 
-	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
-	if (pos) {
-		pci_read_config_word(pdev,
-			pos + PCI_EXP_DEVCTL,
-			&pcie_dev_ctrl);
+	if (pci_is_pcie(pdev)) {
+		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &pcie_dev_ctrl);
 		if (pcie_dev_ctrl & PCI_EXP_DEVCTL_NOSNOOP_EN ||
 		    pcie_dev_ctrl & PCI_EXP_DEVCTL_RELAX_EN) {
 			dev_info(&dd->pdev->dev,
@@ -3939,8 +3935,7 @@ static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
 					pdev->vendor, pdev->device);
 			pcie_dev_ctrl &= ~(PCI_EXP_DEVCTL_NOSNOOP_EN |
 						PCI_EXP_DEVCTL_RELAX_EN);
-			pci_write_config_word(pdev,
-				pos + PCI_EXP_DEVCTL,
+			pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
 				pcie_dev_ctrl);
 		}
 	}
-- 
2.25.1

