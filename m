Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA52C433EB
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB20322CB1
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgwbPooM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgGTNcC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGTNcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 09:32:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E757DC061794;
        Mon, 20 Jul 2020 06:32:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so10306773pgh.3;
        Mon, 20 Jul 2020 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdW8YVkSwsvSdafwpx9CmQx9hyj6eB3CIWhrxwTQhLk=;
        b=kgwbPooMUcUzPyWrDty06nlIw0qmtTGM39h5cjjSeTPDwBxA1YCFWGfeXBibM0dd3t
         Wlrs/87RF6llLbVofGVHWqXQ6q9AYCQz0SXfyilzbCXjhgcNuL1wV0C2BuwyT4dgMm7l
         O/Hkv18sIxWQ9EGPkSOq7KrgxQDH64OEtttiJV1urY8miLFKDtoxdcpOHqi8/vOCOZKf
         TSyvtiYZoAs19S4DS+jD91Pmih63XM1HDyFXkDX1y4N57p6yDADKc8QxSxmAmuTmy4WV
         /l/T+S8vlZDoWxUUxLZstzgliEW/wTuhlSFy2TgOci8pmvszolQkS2C3gKyFPEkVtDiF
         uIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdW8YVkSwsvSdafwpx9CmQx9hyj6eB3CIWhrxwTQhLk=;
        b=BIQQGIlJfPzl1LACSHG8oVIVLL/Ad9yMuVPN3B8dSxCpinY0L83s+Ai0eE+eBqzHvI
         rKI9HfDuk0KOR2RTH78vxkTZGhth2XE7QQcGMG9EzfiUUX7P0cqjPezxEJPiGK/01Xnw
         ld9cOI9vVU8YWFagxybf6VgQluaEpsiNwjqNJFACepxCKogquH6vL5B2RCoqj5UbD2hs
         KxvrVbaOWX9t9lpArLUEuK5ig+hnLBGwFNeKTOmB03y02OtVqXI00IPMxChVeyBZIGpN
         uptXhBr40jia+/2MhQqTHJTOMre73vUSRaKfekBmbWlNb8D4hlrlYz/jXK5p4dAkFPyA
         ht9A==
X-Gm-Message-State: AOAM531ywWvVjV1NmG9+5GIEvGoRwKMGj+vHmtZ/Jpa96Cz/ejhLcFzI
        ABb/il3TDdz6vWSB3R+zgAdMosW37Bjn4w==
X-Google-Smtp-Source: ABdhPJy12Yuf+XpijjM8gyY91+QuWc0SM7s6y96fC7u0GiPzAtGGAchfZs27Gz0rI5qAg7EnjB7sxA==
X-Received: by 2002:a63:6c0a:: with SMTP id h10mr18720104pgc.11.1595251921328;
        Mon, 20 Jul 2020 06:32:01 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id t5sm14814356pgl.38.2020.07.20.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:32:00 -0700 (PDT)
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
Subject: [PATCH v2 3/3] skd: use generic power management
Date:   Mon, 20 Jul 2020 19:00:02 +0530
Message-Id: <20200720133002.448809-4-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720133002.448809-1-vaibhavgupta40@gmail.com>
References: <CY4PR04MB37516C5544A7DCAD84921937E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720133002.448809-1-vaibhavgupta40@gmail.com>
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

