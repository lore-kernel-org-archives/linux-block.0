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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EADDC433E4
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD3222CAF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzw05a6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgGTNbw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGTNbv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 09:31:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6917C061794;
        Mon, 20 Jul 2020 06:31:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md7so10113674pjb.1;
        Mon, 20 Jul 2020 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZjzGiciE1mRdv57FSEZmpziMkegKz0PO+BIzmQwRfA=;
        b=bzw05a6gk51C2yd1FBssAkJPG1LVfOBywHQPUwbmRKXfu+jA+DfssuhmxRncn9dQNQ
         oJgenuKpN1Dus8Hv2Vd5nLa/6NOdeX47TonvsvMDe14cysjtEAZ0nu/mMbacAJqboqnm
         gpDwvCUEexQjN/7qSUOVdtadjTUw2nXNonRa40T3LrzuUbgZXUfV/lTY0/h7i0t0HDjx
         t86vBPEncGHX1M+pvNOXozW00K15BoLKJGPwSdMpm2eqziCaZQjaalw+IXp1PEizhLG+
         TMsJ800WHopDFIRzCKctMPasxhnWj2OtqNfUBX93KeU6OKcQ7ItFn1s9egJ/tawpzFFp
         X3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZjzGiciE1mRdv57FSEZmpziMkegKz0PO+BIzmQwRfA=;
        b=oJb5WEnR9tPJb0kzTOkItK78LrhJ/KcXHxDPDPU/bd9dwaUPRrrWFVz0f70/6j/Vb6
         Vfpry2gRNYVj1IGmVM1wtTzCSRTNCP4EVsrrqlCGGljTN0kF/ZSqpvTsZtAorIevPK7o
         dmXrRIxUs46fdhuFD4N/5VEc7fAG+dMi9XBBAgFGvCr2e5su8zP8h0BR+TaoIWU22vax
         j2t6O5sew2Exr9bFmkhM/Q2ls29VY9T/TjF2nXSHhWDgTmIWsKVj8Vs/IX9dn09IVLEl
         JD3DQhWcO/GpdOvD4r8fezfporwNJKkg2RyvchEN2HhGXq1LXc11Dx3aQwcZ7qzbLYnl
         kemg==
X-Gm-Message-State: AOAM533wgsuH4mZXjpTPpuk3mUHDwMfQoRzzy4+7tH4P/9hSqpMIv5tR
        u1ouCqB9a+U59+6VM7f+PVk=
X-Google-Smtp-Source: ABdhPJw9vk9NP6XxFmMyM/2EeMLZVUTlXr1BsNwtGbmp/wnpbXjTGcXLG/qRRf5LzwMhMZUyvqln6g==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr18658312plt.158.1595251911142;
        Mon, 20 Jul 2020 06:31:51 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id t5sm14814356pgl.38.2020.07.20.06.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:31:50 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mtip32xx: use generic power management
Date:   Mon, 20 Jul 2020 19:00:00 +0530
Message-Id: <20200720133002.448809-2-vaibhavgupta40@gmail.com>
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
pci_save/restore_state(), pci_disable_device(), pcim_enable_device(),
pci_set_power_state() and pci_set_master() to do required operations. In
generic mode, they are no longer needed.

Change function parameter in both .suspend() and .resume() to
"struct device*" type. Use dev_get_drvdata() to get drv data.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 54 +++++++------------------------
 1 file changed, 12 insertions(+), 42 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index f6bafa9a68b9..7d1280952b35 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4246,14 +4246,13 @@ static void mtip_pci_remove(struct pci_dev *pdev)
  *	0  Success
  *	<0 Error
  */
-static int mtip_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int __maybe_unused mtip_pci_suspend(struct device *dev)
 {
 	int rv = 0;
-	struct driver_data *dd = pci_get_drvdata(pdev);
+	struct driver_data *dd = dev_get_drvdata(dev);
 
 	if (!dd) {
-		dev_err(&pdev->dev,
-			"Driver private datastructure is NULL\n");
+		dev_err(dev, "Driver private datastructure is NULL\n");
 		return -EFAULT;
 	}
 
@@ -4261,21 +4260,8 @@ static int mtip_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 
 	/* Disable ports & interrupts then send standby immediate */
 	rv = mtip_block_suspend(dd);
-	if (rv < 0) {
-		dev_err(&pdev->dev,
-			"Failed to suspend controller\n");
-		return rv;
-	}
-
-	/*
-	 * Save the pci config space to pdev structure &
-	 * disable the device
-	 */
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-
-	/* Move to Low power state*/
-	pci_set_power_state(pdev, PCI_D3hot);
+	if (rv < 0)
+		dev_err(dev, "Failed to suspend controller\n");
 
 	return rv;
 }
@@ -4287,42 +4273,25 @@ static int mtip_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
  *      0  Success
  *      <0 Error
  */
-static int mtip_pci_resume(struct pci_dev *pdev)
+static int __maybe_unused mtip_pci_resume(struct device *dev)
 {
 	int rv = 0;
 	struct driver_data *dd;
 
-	dd = pci_get_drvdata(pdev);
+	dd = dev_get_drvdata(dev);
 	if (!dd) {
-		dev_err(&pdev->dev,
-			"Driver private datastructure is NULL\n");
+		dev_err(dev, "Driver private datastructure is NULL\n");
 		return -EFAULT;
 	}
 
-	/* Move the device to active State */
-	pci_set_power_state(pdev, PCI_D0);
-
-	/* Restore PCI configuration space */
-	pci_restore_state(pdev);
-
-	/* Enable the PCI device*/
-	rv = pcim_enable_device(pdev);
-	if (rv < 0) {
-		dev_err(&pdev->dev,
-			"Failed to enable card during resume\n");
-		goto err;
-	}
-	pci_set_master(pdev);
-
 	/*
 	 * Calls hbaReset, initPort, & startPort function
 	 * then enables interrupts
 	 */
 	rv = mtip_block_resume(dd);
 	if (rv < 0)
-		dev_err(&pdev->dev, "Unable to resume\n");
+		dev_err(dev, "Unable to resume\n");
 
-err:
 	clear_bit(MTIP_DDF_RESUME_BIT, &dd->dd_flag);
 
 	return rv;
@@ -4353,14 +4322,15 @@ static const struct pci_device_id mtip_pci_tbl[] = {
 	{ 0 }
 };
 
+static SIMPLE_DEV_PM_OPS(mtip_pci_pm_ops, mtip_pci_suspend, mtip_pci_resume);
+
 /* Structure that describes the PCI driver functions. */
 static struct pci_driver mtip_pci_driver = {
 	.name			= MTIP_DRV_NAME,
 	.id_table		= mtip_pci_tbl,
 	.probe			= mtip_pci_probe,
 	.remove			= mtip_pci_remove,
-	.suspend		= mtip_pci_suspend,
-	.resume			= mtip_pci_resume,
+	.driver.pm		= &mtip_pci_pm_ops,
 	.shutdown		= mtip_pci_shutdown,
 };
 
-- 
2.27.0

