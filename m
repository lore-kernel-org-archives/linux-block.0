Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37092C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 11:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D934B23A40
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 11:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbhANL6W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 06:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhANL6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 06:58:22 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A14C061575;
        Thu, 14 Jan 2021 03:57:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b5so3065068pjk.2;
        Thu, 14 Jan 2021 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aE8Gpce0dusI5ufIrjvwfjO/RPhWK1H8CVWXZPRQ1bg=;
        b=ePQFrPvQmQWHau9JTuzYSKkg2wRECTDCJLUujoltBw3cIcB+ShZZQblwreb7cJXj7M
         MmD76EmvTK0GgvEJr+/KA1HyI1Gu/5dbg9d1o1ZAZxkIfQ2nIPexZxe0pmsx0LcJ8I7A
         9tc+l2b0teCDELNU2kQThm1GfwDuD/UUyjSQKwZcQvYVKyg8ExJ9rQckQwh6bRfKBBvZ
         8NZpdW3vQHU2bCNPMBtaYjhupqfoBekRmxxg+AIdvOwnSQyYv+faeiL84i/88JvIp5Gv
         eRbNdQhI5hlmL0pC3sZ7dPmO0Egx5P+g7F2bFscNhqnmLZUr1AzalFvMTbVkF2rxU8nj
         SYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aE8Gpce0dusI5ufIrjvwfjO/RPhWK1H8CVWXZPRQ1bg=;
        b=FZS2W+1JFvj/+pvjEU8wUvPDX1qf6m8rDSVHoIWkIzdprUYL+QmdrWA6OBeDC0hwOC
         s8qJTcaNfs/5RogO9+QHIrP1Unvy/XYcYWCB5Adqap96ruYA+7gbbEkCt2d0z8TjASLd
         hEUqGviaqKZS1OKRXcFzwSFeDUDCn9xuCcYzBOaQuGPmL9vLLms8cy+01jp93ky15fS4
         +S1urBgKSzTNL1BqlsqPeCVg6Rqk9Gmu+SqiLLhkPL+wBS5QXINFNt8kofB3JfnWkS2o
         HaANz0jiJD2AZ+g9ZWB5d4neSx8kFXtHyZOmaVHX/Wc34gbcZNyLWKvzXw2+Y6lRqFEo
         CrSQ==
X-Gm-Message-State: AOAM531Oe/YS/JvDGWcS38P305raw2dTN362zDjPOYfVKc6DvX5nW2B7
        a4rFTmyDsEETnKVR1rSA/I8=
X-Google-Smtp-Source: ABdhPJy7kieV/fIXINVZvKUSOp+Z8ie1D+czt4R7bDu8iDW2M+2z8f1vy89JJQ9yFavgV8iP/hWimA==
X-Received: by 2002:a17:90a:5303:: with SMTP id x3mr4755040pjh.54.1610625461297;
        Thu, 14 Jan 2021 03:57:41 -0800 (PST)
Received: from varodek.localdomain ([223.190.37.127])
        by smtp.gmail.com with ESMTPSA id t4sm5107914pfe.212.2021.01.14.03.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 03:57:40 -0800 (PST)
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
Subject: [PATCH v4 2/3] rsxx: use generic power management
Date:   Thu, 14 Jan 2021 17:24:22 +0530
Message-Id: <20210114115423.52414-3-vaibhavgupta40@gmail.com>
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
---
 drivers/block/rsxx/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 63f549889f87..937ad8a28e85 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -1032,12 +1032,15 @@ static void rsxx_pci_remove(struct pci_dev *dev)
 	kfree(card);
 }
 
-static int rsxx_pci_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused rsxx_pci_suspend(
+	__attribute__((unused)) struct device *dev)
 {
 	/* We don't support suspend at this time. */
 	return -ENOSYS;
 }
 
+#define rsxx_pci_resume NULL
+
 static void rsxx_pci_shutdown(struct pci_dev *dev)
 {
 	struct rsxx_cardinfo *card = pci_get_drvdata(dev);
@@ -1073,12 +1076,14 @@ static const struct pci_device_id rsxx_pci_ids[] = {
 
 MODULE_DEVICE_TABLE(pci, rsxx_pci_ids);
 
+static SIMPLE_DEV_PM_OPS(rsxx_pci_pm_ops, rsxx_pci_suspend, rsxx_pci_resume);
+
 static struct pci_driver rsxx_pci_driver = {
 	.name		= DRIVER_NAME,
 	.id_table	= rsxx_pci_ids,
 	.probe		= rsxx_pci_probe,
 	.remove		= rsxx_pci_remove,
-	.suspend	= rsxx_pci_suspend,
+	.driver.pm	= &rsxx_pci_pm_ops,
 	.shutdown	= rsxx_pci_shutdown,
 	.err_handler    = &rsxx_err_handler,
 };
-- 
2.30.0

