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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C063C433E2
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81E12074B
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMnHL1YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgGQIKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGQIKg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 04:10:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBB7C061755;
        Fri, 17 Jul 2020 01:10:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls15so6163314pjb.1;
        Fri, 17 Jul 2020 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZjzGiciE1mRdv57FSEZmpziMkegKz0PO+BIzmQwRfA=;
        b=VMnHL1YOb9YOEXXi/OnuLA/sSel2Odj47qKeawJDhqx1RAoLxMXt+Q//5VIxc6wnXp
         RZB6OdTw35/W1ERtFx9vBDPYJm6le1X5GVy9YmfUa6+19Nrcf2p+pXCSEAw0/0R1jNs1
         c2F0xbfbwL+wxsivT3czCVjRrqXbcCEjvvfbLVCBPDIIHS/KJ62ZMmwFx+tmSEjNSQC3
         cWwa3sHY95Axfuw5naqINQPuz49HDx4qo12KrZdVO85qzzjH4KUi2hVDrmqe0ddbUUsB
         OKsPeSHu5WhTmxUBFNn1/al/dt8/4U3Vpc7zX3Flchi8qnI+6h+ype58UYMzDzw8iQ2y
         f1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZjzGiciE1mRdv57FSEZmpziMkegKz0PO+BIzmQwRfA=;
        b=mvhHXduV9Lqrqe7p/hzV9wd5rVSt4V16hmtdgcwe+07MGiGx+MIkgqe5/k8mP7ZSHc
         rUFGJ2qtnAuuXfHQ+xO9CgW65z2mnWC0KqfVLzRtyD3w4VLWhI3OJHKLsg78A67x6blK
         jVbdDiD0E0C1zw90uJoDGkRluNwFOvxVWY7Zo4bbcYh1Ok5u46YAAhNh28KdRNlvKdC6
         YXAuCl8ukr5y+tJD1CehOLn28geKHwm9NmokEMLSFiSx6wMfUPG0n543LI4ejYuA1zae
         tKMWQIO+sqKpTtRbcPlHNPQh9nHi7ZoNu0fyoZNW3uXhO6mCAEjw/+MXQHkl8oMxzRG/
         mQhg==
X-Gm-Message-State: AOAM533juvQ8G8wQ+um2cmWbQPw+2eZLn5sH9Wli64nBjszw3H14UcDP
        gIXFpzdBQwAORJu5VZuMYYM=
X-Google-Smtp-Source: ABdhPJyGKgakP3e2eFrh35aHdGLeSwy7yHiVg0bx3UuHraWqnM5wZiRGjyj0qHqCkCz5Dz583pnhTQ==
X-Received: by 2002:a17:90a:1901:: with SMTP id 1mr9158692pjg.199.1594973436153;
        Fri, 17 Jul 2020 01:10:36 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id d5sm1937296pju.15.2020.07.17.01.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:10:35 -0700 (PDT)
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
Subject: [PATCH v1 1/3] mtip32xx: use generic power management
Date:   Fri, 17 Jul 2020 13:39:08 +0530
Message-Id: <20200717080910.342741-2-vaibhavgupta40@gmail.com>
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

