Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C63C433E1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BED20737
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHAChKFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgGQIKt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGQIKs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 04:10:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69693C061755;
        Fri, 17 Jul 2020 01:10:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so6321403pgc.5;
        Fri, 17 Jul 2020 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLhlrw/90h7K4R1QF2JfjCIuOOucm4jPTVhciHTu7NQ=;
        b=XHAChKFHhQc6obPfyO+UKg/XlIwERzLzqEX6cJAhJOvU/hWMeD9qdbFrQIGZHfjS6X
         fsrdNtWZ+dtR0YuDf5+T7jFayKJ2xs+nl+uFyBEdm0cvLI/E9S9qGDd0SKGFs6fCj5J8
         7wxCkTIx69J3WtMwMjIW0dJ3ij62cpDqS5kVU0cB9sbyNnfVZbqlgTt7ZlHvmQEFA67g
         W2l2/qNgWdnBWhPgLrOXTy7tiZ22XPnfMU828RWZBbAwe47Gnggn6MYt9aPMhNHFO5l7
         0bdk6glvzgR0WXAqsUIceEJQjq8KooGzaJOQPLfNphESHQC95lcr05OVauDMk4xEIw2v
         w2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLhlrw/90h7K4R1QF2JfjCIuOOucm4jPTVhciHTu7NQ=;
        b=Nh70wpGLvo+yBIDzVCCCO1ACxmFOwCdmRsjQyPBSMsjW6phbfGS1r4Ldj8KEFPrglz
         jxDHzYdNSzXOtUsmIH6YQLs3dcA5/DGd+PLaMl+Q3asSUBd/Kfo5Oqk7OQsX4ikd/ycB
         hd85L9XZC3guRouAbSBAVPTN84R+ba7wB96YFwjaHgf/rCjTtB5hjJYJ+kGorl9nKm7Y
         M+e0/wF1YvURs70PQNrIEeYQXO0ypEGxFDuKXpKIDaNC3PmzEu/ww91pbzfd1/l+2wf5
         oG9TS9+7nO9l5N3KHlBXCbuu2FSRwkwMWHSGHHyWwFor1n3y1D6qOqmxVGS1zGLAc6WJ
         scWQ==
X-Gm-Message-State: AOAM533HPttoCFuelFD4H/a/PcpOfyKrlmHnWezicZeSnIE/pZXRy/s2
        pA6jGsKNbEDwgtEDMiEaGeQ=
X-Google-Smtp-Source: ABdhPJxjPpwPG0D9XGfq9voxFl0VuxE7FX55nSfoIgIuNg8975Ev940nVh6O+LLYSJPd2LMRPzVwFQ==
X-Received: by 2002:aa7:8582:: with SMTP id w2mr7318162pfn.34.1594973447856;
        Fri, 17 Jul 2020 01:10:47 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id d5sm1937296pju.15.2020.07.17.01.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:10:47 -0700 (PDT)
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
Subject: [PATCH v1 3/3] skd: use generic power management
Date:   Fri, 17 Jul 2020 13:39:10 +0530
Message-Id: <20200717080910.342741-4-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717080910.342741-1-vaibhavgupta40@gmail.com>
References: <20200717080910.342741-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drivers using legacy PM have to manage PCI states and device's PM states
themselves. They also need to take care of configuration registers.

With improved and powerful support of generic PM, PCI Core takes care of
above mentioned, device-independent, jobs.

This driver makes use of PCI helper functions like
pci_save/restore_state(), pci_enable/disable_device(),
pci_request/release_regions(), pci_set_power_state() and
pci_set_master() to do required operations. In generic mode, they are no
longer needed.

Change function parameter in both .suspend() and .resume() to
"struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variable.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/block/skd_main.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 51569c199a6c..d8d1042e7338 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3315,12 +3315,12 @@ static void skd_pci_remove(struct pci_dev *pdev)
 	return;
 }
 
-static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused skd_pci_suspend(struct device *dev)
 {
 	int i;
-	struct skd_device *skdev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct skd_device *skdev = pci_get_drvdata(pdev);
 
-	skdev = pci_get_drvdata(pdev);
 	if (!skdev) {
 		dev_err(&pdev->dev, "no device data for PCI\n");
 		return -EIO;
@@ -3337,35 +3337,23 @@ static int skd_pci_suspend(struct pci_dev *pdev, pm_message_t state)
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
-	struct skd_device *skdev;
 
-	skdev = pci_get_drvdata(pdev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct skd_device *skdev = pci_get_drvdata(pdev);
 	if (!skdev) {
 		dev_err(&pdev->dev, "no device data for PCI\n");
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
@@ -3374,7 +3362,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
 		goto err_out_regions;
 	}
 
-	pci_set_master(pdev);
 	rc = pci_enable_pcie_error_reporting(pdev);
 	if (rc) {
 		dev_err(&pdev->dev,
@@ -3427,10 +3414,6 @@ static int skd_pci_resume(struct pci_dev *pdev)
 		pci_disable_pcie_error_reporting(pdev);
 
 err_out_regions:
-	pci_release_regions(pdev);
-
-err_out:
-	pci_disable_device(pdev);
 	return rc;
 }
 
@@ -3450,13 +3433,14 @@ static void skd_pci_shutdown(struct pci_dev *pdev)
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

