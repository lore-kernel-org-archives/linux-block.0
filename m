Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44FAC4332D
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 11:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E882310E
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 11:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbhANL63 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 06:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbhANL62 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 06:58:28 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8010DC061757;
        Thu, 14 Jan 2021 03:57:47 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p18so3612253pgm.11;
        Thu, 14 Jan 2021 03:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tcZE8BRAv/NJVfB5M18fw0NCIqwov/ZYMzn1kuA4UBY=;
        b=VNTOAti0MWyEZzCYS4lan3mExDIRYFRkmh5EWl3SLsnfp06oVI7rScejhpigUxS4rI
         rEKsDsOuFriN066twd2Nrs9Wv0MYT+EKh3ybqUEf0V4BeGXFQEs3pw73HsvofJ1NlE9d
         PliYu9UA0vrPX38xaUJSR4NaLw7LpyaAuQDti1y32RdjsYRs3OMj5332r4KR5AHlQQjK
         1ZMwJeYZh+ljp2Bj8IEfPo65J2lgig9iUBu3t2/gk8csxRKL874VJ72cTkr8xsGYeJ55
         NC20GMW6aKqZIfSphAn+yA1f7FRS18ONaowNIwaojOdJsIC1vDhFavWNAI2XOxqQXso7
         dcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tcZE8BRAv/NJVfB5M18fw0NCIqwov/ZYMzn1kuA4UBY=;
        b=Cgac7ppbtb4KQjNJd3p2uBFjOHCPu3Klnu9ZWRyc6KLuQ6V7B9jVpDwra6MjYFuw88
         BHEywc2fhzFr/t5BQVqgt2+b7lMTn+IOEYRZ8uExo0hjY+otDHyQOLLx2tPzvwN2fij0
         JrXRzWUpoeSiPkTOObssdhWH74+WbHj1TasDLYriGzCnrINzsZEDyH4Y63gzqG1z8mzi
         SX94wOPhpfxvBBLGlWwYiZoG7CUJCqmfmM11iOdGB3kqC6Taul/hTXVL2mYzqgKStV5t
         Ea1N9oFmJekdZAT5rhK7Drudodk9blmpYV1JRXWWF1lapdzuMxCiTPlnS4Soz/544KiX
         OYFA==
X-Gm-Message-State: AOAM5306iL9bgQS5XXwwr2yRvGwmLfUfiE3iBR5VnCzkBiAGSNv2l8Yz
        dNvOeWoabl3WqSELCKO5+aI=
X-Google-Smtp-Source: ABdhPJzJ4Q6s3S1My5Bqh+pXNgNLR75+S7Aw69Tio7wJkf74lSkcGqaHNCSVvWzYz16ZoggW9EsBZA==
X-Received: by 2002:a65:689a:: with SMTP id e26mr7191253pgt.413.1610625467131;
        Thu, 14 Jan 2021 03:57:47 -0800 (PST)
Received: from varodek.localdomain ([223.190.37.127])
        by smtp.gmail.com with ESMTPSA id t4sm5107914pfe.212.2021.01.14.03.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 03:57:46 -0800 (PST)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v4 3/3] skd: use generic power management
Date:   Thu, 14 Jan 2021 17:24:23 +0530
Message-Id: <20210114115423.52414-4-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210114115423.52414-1-vaibhavgupta40@gmail.com>
References: <20200722083335.50068-1-vaibhavgupta40@gmail.com>
 <20210114115423.52414-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drivers using legacy power management .suspen()/.resume() callbacks
have to manage PCI states and device's PM states themselves. They also
need to take care of standard configuration registers.

Switch to generic power management framework using a single
"struct dev_pm_ops" variable to take the unnecessary load from the driver.
This also avoids the need for the driver to directly call most of the PCI
helper functions and device power state control functions, as through
the generic framework PCI Core takes care of the necessary operations,
and drivers are required to do only device-specific jobs.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Tested-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/skd_main.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a962b4551bed..8194b58525e2 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3317,10 +3317,11 @@ static void skd_pci_remove(struct pci_dev *pdev)
 	return;
 }
 
-static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused skd_pci_suspend(struct device *dev)
 {
 	int i;
 	struct skd_device *skdev;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	skdev = pci_get_drvdata(pdev);
 	if (!skdev) {
@@ -3339,18 +3340,15 @@ static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	if (skdev->pcie_error_reporting_is_enabled)
 		pci_disable_pcie_error_reporting(pdev);
 
-	pci_release_regions(pdev);
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	return 0;
 }
 
-static int skd_pci_resume(struct pci_dev *pdev)
+static int __maybe_unused skd_pci_resume(struct device *dev)
 {
 	int i;
 	int rc = 0;
 	struct skd_device *skdev;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	skdev = pci_get_drvdata(pdev);
 	if (!skdev) {
@@ -3358,16 +3356,8 @@ static int skd_pci_resume(struct pci_dev *pdev)
 		return -1;
 	}
 
-	pci_set_power_state(pdev, PCI_D0);
-	pci_enable_wake(pdev, PCI_D0, 0);
-	pci_restore_state(pdev);
+	device_wakeup_disable(dev);
 
-	rc = pci_enable_device(pdev);
-	if (rc)
-		return rc;
-	rc = pci_request_regions(pdev, DRV_NAME);
-	if (rc)
-		goto err_out;
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc)
 		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
@@ -3376,7 +3366,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
 		goto err_out_regions;
 	}
 
-	pci_set_master(pdev);
 	rc = pci_enable_pcie_error_reporting(pdev);
 	if (rc) {
 		dev_err(&pdev->dev,
@@ -3429,10 +3418,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
 		pci_disable_pcie_error_reporting(pdev);
 
 err_out_regions:
-	pci_release_regions(pdev);
-
-err_out:
-	pci_disable_device(pdev);
 	return rc;
 }
 
@@ -3452,13 +3437,14 @@ static void skd_pci_shutdown(struct pci_dev *pdev)
 	skd_stop_device(skdev);
 }
 
+static SIMPLE_DEV_PM_OPS(skd_pci_pm_ops, skd_pci_suspend, skd_pci_resume);
+
 static struct pci_driver skd_driver = {
 	.name		= DRV_NAME,
 	.id_table	= skd_pci_tbl,
 	.probe		= skd_pci_probe,
 	.remove		= skd_pci_remove,
-	.suspend	= skd_pci_suspend,
-	.resume		= skd_pci_resume,
+	.driver.pm	= &skd_pci_pm_ops,
 	.shutdown	= skd_pci_shutdown,
 };
 
-- 
2.30.0

