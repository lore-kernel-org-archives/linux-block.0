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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5180FC433E6
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246E120787
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmynCEVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgGVIfI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGVIfI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 04:35:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E956BC0619DC;
        Wed, 22 Jul 2020 01:35:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t6so605277plo.3;
        Wed, 22 Jul 2020 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28LVHZQ5kNi3X4WVWRNBhsyjK8e2AXuHyTrkUX2gYzI=;
        b=GmynCEVDYL8vUdF/dEi+NEtI+iKXNlgK/RQ7XrkC2bdnEwCeiQfM1MQxJyBxznCxdP
         kmxk4C66hNqBKB2QUc1skHhm0mSkkVJ/LRRTFxUfyzsd8PXE3ddJtkc7VEk1yxt8G/SS
         hMX+b0zA3PVxDyNytY3xg9t2INZFXrYXhQWH7nWt3WWjjmRPcwAx+frJioOPSFP1aLJ+
         LC46zqpag99ScnDKs+RI6xPDmy25JXWhh+xOlQ/Fg0c1KwuP7O/PJgEYXV9XgjoET6UL
         tljtmCnUcXhtWWu/8iHiwKn6W0INYH2kTKw82cxg79tJYMfI1Ct0MhyoducO00LIDmH4
         LOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28LVHZQ5kNi3X4WVWRNBhsyjK8e2AXuHyTrkUX2gYzI=;
        b=SGaqe7orSQtpa2xUCCogZVHzIQS8hZowf2v/+xU9bu3hmO4BJtB6XRmt7XosXPQSA+
         lbt6AnjXeVtryyyTkAft4KWWyDMOPA7lR3SQDi0pqtynRFH4CcyuO9EhgP9nt4ltTAiZ
         DEbz3l/CGVO0HGCc95xauuzqrBT9gZHpuJxlpbawheppSGdtXMkZKG2ZnJqDHwkX/AbI
         7h9rtthg4i8B25ReegbChy3Dx3Qxz5CjmL91KNo5CMbMWRQcO1yABKreTcJlLKjHL8K4
         HufnHfBvQIXjMhOzlVA4W4zxLVEIkux7gWB3IohvexYHGoQegvThlbYq9HEk210O1xBw
         HEDg==
X-Gm-Message-State: AOAM530ZqnAq3o5IiBHSNw2YRHkcnJRlrItZx1nNrDaVktfOL239q9+k
        XVI44xIQSE0D0+dXcSYF6J1PNzn3JoHmkg==
X-Google-Smtp-Source: ABdhPJwbgrO0RP+E/o1QaKac8oSWHOrV2QrpXZWoauBIG5d+sFnfguSNdUB9tr89uey4iD3pQ1ow3w==
X-Received: by 2002:a17:902:a5c5:: with SMTP id t5mr25735544plq.47.1595406907398;
        Wed, 22 Jul 2020 01:35:07 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id g13sm5777319pje.29.2020.07.22.01.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 01:35:06 -0700 (PDT)
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
Subject: [PATCH v3 1/3] mtip32xx: use generic power management
Date:   Wed, 22 Jul 2020 14:03:33 +0530
Message-Id: <20200722083335.50068-2-vaibhavgupta40@gmail.com>
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

