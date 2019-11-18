Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F88C432C3
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD8B20748
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="DuZR75PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfKRAVR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Nov 2019 19:21:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46745 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfKRAVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Nov 2019 19:21:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id n23so12960476otr.13
        for <linux-block@vger.kernel.org>; Sun, 17 Nov 2019 16:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Ovt6jbDPjyCR0/arOz9a+rgIf56RvTTsMB0ccBa1ek=;
        b=DuZR75PETpq9SHSgVGX4A7aW1VbYfbZpBNrGJMQG94ixdnUnssFw8RwbbiqCZWa/ad
         Ib1io05cexSPa9pmwdrRDzgcgZ7FNsfNhleHAGvS7g/SNVm3GEQbn9XIt7fJ2WUDrVnJ
         vF71JXj/NIpCafPIliMJxG0OjI3A+r//g0kJ1s4eIn0bHDy/Ci0Z4Q1M3TrxGD/1CccX
         T1TcO83huhJL5HXu/UTUdSTCduX4v83PJKYlEktUQgpXvRMqcB+xsHT6QeIEwdHcQVrc
         h6YVSw4gQ3rPaPuT4mzbVcReI8r5mdt90esAKNQ+uXv4Bw6Mxkb+mFPAmxGtbP57LSnB
         wnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Ovt6jbDPjyCR0/arOz9a+rgIf56RvTTsMB0ccBa1ek=;
        b=BdrTxc4+7iLDyiYoGQA/Wrwr6m9lLmip/kJje3iJVMvQy+SCNWxDh+vwvnrLmJ3BhA
         j1r53tUl1gzNs0lcM+Sup6m846ZrnqvO7prelSsDQr+X8UNp6NkWY9s4NazOnVr4QBab
         WmQoMVxcASanS4SaMAnp0Ir9l3Cxie66Mypa1IsmfJNhTU+H1asGFDNzUUYGm2z+bCqM
         1ZmFrMn2XLb25Wj5VLmGmCIK8iLVuw7GJksMLY36sIGtqejEDljB6zsdFx0f4Jyrgcfm
         VUASCRO2VS3Qbk4SAyhT1W/4qidMA4m0mtk1fA8w/QqZxpqaFbdCd78V5LGURt3swfK6
         HI5g==
X-Gm-Message-State: APjAAAWTrZckE2sKvN+eMzQM3E8S5vVtPhnrs3xjpFNa7kSOt8qajVvM
        jPQ2cAcIVq3ALcHRwmaKH5GCAdQf45atCEac
X-Google-Smtp-Source: APXvYqwrOBmroGm4Xd11i377lyNFKSWESfgTnNADfHHvp4d6oK0HIA88i6ywpvr+uizhKDds258Opw==
X-Received: by 2002:a9d:6288:: with SMTP id x8mr21052106otk.170.1574036476012;
        Sun, 17 Nov 2019 16:21:16 -0800 (PST)
Received: from com.attlocal.net ([2600:1700:4870:71e0::10])
        by smtp.gmail.com with ESMTPSA id 65sm5532194oie.50.2019.11.17.16.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 16:21:15 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     axboe@kernel.dk
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        bvanassche@acm.org
Subject: [PATCH v2 4/4] mtip32xx: Replace magic numbers with PCI constants
Date:   Sun, 17 Nov 2019 18:20:57 -0600
Message-Id: <20191118002057.9596-5-fred@fredlawl.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118002057.9596-1-fred@fredlawl.com>
References: <20191118002057.9596-1-fred@fredlawl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Readability was improved by replacing pci_read_config_word() with
pcie_capability_read_word(). Take that a step further by replacing magic
numbers with PCI reg constants.

No functional change intended.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
v2:
- Added this patch
---
 drivers/block/mtip32xx/mtip32xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 35703dc98e25..225c6ae62385 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3942,8 +3942,8 @@ static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
 		return;
 
 	pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &pcie_dev_ctrl);
-	if (pcie_dev_ctrl & (1 << 11) ||
-	    pcie_dev_ctrl & (1 << 4)) {
+	if (pcie_dev_ctrl & PCI_EXP_DEVCTL_NOSNOOP_EN ||
+	    pcie_dev_ctrl & PCI_EXP_DEVCTL_RELAX_EN) {
 		dev_info(&dd->pdev->dev,
 			 "Disabling ERO/No-Snoop on bridge device %04x:%04x\n",
 			 pdev->vendor, pdev->device);
-- 
2.20.1

