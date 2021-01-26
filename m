Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E704C4332E
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C3520679
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbhAZV7Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405170AbhAZUF1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:05:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F9A2221FC;
        Tue, 26 Jan 2021 20:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611691486;
        bh=fdhWEaWpzuIXUXekLSW8eaffZvV/ttR8sSOmkit1xso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSyTpywASzDtowrz1dakcmvWM7/GR95qVHkvESv2eJw709pbBFYaDCDl1+N2DjCVV
         8PxmXeIXQ++8XD+Pnoojrbo70bWXrpReLfwNekYkTafKae24KY4GjabXGrewkqOEr/
         kFh5CF4kiw1ZlvdD1OF+WamkhKLGWn4xxHPCluNaEFzjoBHIBrApvP62R0r6wodTeg
         bo0EHAxecwwH1FPVTqs+7xe0ox/KW/Q15DPuaVkJuwvYes3EpWSsGL4rZBLpj5oP22
         IH1T2gz7jNf0ACKJVkpg4NG2a+kM3JLROMbkrHk1SODrNh60e5wisNDtvRZSB8lUEF
         HgaGJAyYECsOA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] mtip32xx: use PCI #defines instead of numbers
Date:   Tue, 26 Jan 2021 14:04:32 -0600
Message-Id: <20210126200433.2911982-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126200433.2911982-1-helgaas@kernel.org>
References: <20210126200433.2911982-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use PCI #defines for PCIe Device Control register values instead of
hard-coding bit positions.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 53ac59d19ae5..543eb30a3bc0 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3932,8 +3932,8 @@ static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
 		pci_read_config_word(pdev,
 			pos + PCI_EXP_DEVCTL,
 			&pcie_dev_ctrl);
-		if (pcie_dev_ctrl & (1 << 11) ||
-		    pcie_dev_ctrl & (1 << 4)) {
+		if (pcie_dev_ctrl & PCI_EXP_DEVCTL_NOSNOOP_EN ||
+		    pcie_dev_ctrl & PCI_EXP_DEVCTL_RELAX_EN) {
 			dev_info(&dd->pdev->dev,
 				"Disabling ERO/No-Snoop on bridge device %04x:%04x\n",
 					pdev->vendor, pdev->device);
-- 
2.25.1

