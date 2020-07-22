Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E8C433F1
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1335020787
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5mjbVyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGVIfV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVIfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 04:35:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9BAC0619DC;
        Wed, 22 Jul 2020 01:35:20 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 1so801615pfn.9;
        Wed, 22 Jul 2020 01:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HO2KdHTG8CWRvUWixHHguAvRh8U1JUtcNnQoDE9NJ0=;
        b=B5mjbVyJZ28XLKNNuTPsCQ2bHZiK3f7R81S9TV/ugmZxnh3o0zlKPuacx5FU+trUnb
         AcdY3P0T2l/jeHkfkGAngdXYHBrjLDyafgM3ktkEoGbqnI4YUqHr1WB2at1x0tcvWATx
         SQxzG9FlSh0oW2Q4wZIzEsJRXW4WaqRLs7ip5O+qnqA/fc68BtE0XL5tdc64WYBsiLoh
         qErNJHJuVRC1va4D0SMTSQIduCSWdWop7Z4H9WRoNvWFqKBLZXhxCMTl4G8PmMKbdGZF
         nrg7PtG1/xXE1n6nPnSsVEPg9SmvmXtWCprIRiANxke/oU8QZ5DA673Pcvkq/MawEE+W
         ykyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HO2KdHTG8CWRvUWixHHguAvRh8U1JUtcNnQoDE9NJ0=;
        b=FMmENo3Lr8M6qInoJLbrPKRj36RRThqE+uW9Pu9lyFiLg5lujjOw3W/NH+2rU1IR2+
         vI7HfiHLC4vwua8KhL/EeBaxXaEZ6Ipqo11ukKLX/H9KnDPyHrpJOAsxnCF3VifWBxCf
         4aTq4/GS6QY9/buAF1kEtg4k3cRRMAUzSlqHqvUxs05WTdKm7wq1HSqzpazeY1ISljb7
         IEohqW0aQIcQMMqA7MkF6OvTpSidJeBs8pTAPQG98zbWzYRQ/yS8FGaaohOIcfbVImlF
         DB7yzHIxsUTNQgY9ftphpBW9TgjMdvpak2aZmINLTByQCM1VxHKFFRgH+GHgNDdFlGiH
         QnKA==
X-Gm-Message-State: AOAM531BrknNeB9/lnVCCxl7yp0HJjtuG/wLX0MqIK6+e1Fgn0F+rnfI
        ekxRD7ETczrJ1xFEXmo6GCk=
X-Google-Smtp-Source: ABdhPJxoD+asLmN+X4Kni/JrR8aEg1m0w9rLbNcvu3qHjQBL8mcRuLHj6gJ3gf40pij6nNmKGWPSMA==
X-Received: by 2002:a62:8342:: with SMTP id h63mr26886028pfe.183.1595406920209;
        Wed, 22 Jul 2020 01:35:20 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id g13sm5777319pje.29.2020.07.22.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 01:35:19 -0700 (PDT)
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
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 3/3] skd: use generic power management
Date:   Wed, 22 Jul 2020 14:03:35 +0530
Message-Id: <20200722083335.50068-4-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722083335.50068-1-vaibhavgupta40@gmail.com>
References: <ea5881cdfd4d612193feed646ce89f253a36db69.camel@wdc.com>
 <20200722083335.50068-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
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
---
 drivers/block/skd_main.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 51569c199a6c..7f2d42900b38 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3315,10 +3315,11 @@ static void skd_pci_remove(struct pci_dev *pdev)
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
@@ -3337,18 +3338,15 @@ static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)
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
@@ -3356,16 +3354,8 @@ static int skd_pci_resume(struct pci_dev *pdev)
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
@@ -3374,7 +3364,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
 		goto err_out_regions;
 	}
 
-	pci_set_master(pdev);
 	rc = pci_enable_pcie_error_reporting(pdev);
 	if (rc) {
 		dev_err(&pdev->dev,
@@ -3427,10 +3416,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
 		pci_disable_pcie_error_reporting(pdev);
 
 err_out_regions:
-	pci_release_regions(pdev);
-
-err_out:
-	pci_disable_device(pdev);
 	return rc;
 }
 
@@ -3450,13 +3435,14 @@ static void skd_pci_shutdown(struct pci_dev *pdev)
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
2.27.0

