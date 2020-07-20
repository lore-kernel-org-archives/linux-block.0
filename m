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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC4BC433E5
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4741322C9C
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 13:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlq7eiz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgGTNb5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGTNb5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 09:31:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B0C061794;
        Mon, 20 Jul 2020 06:31:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so9049766pfu.8;
        Mon, 20 Jul 2020 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iRMBvN5jV5opfKEhcuX/0MlxIGyzv8/E8aHaaJydPsI=;
        b=Mlq7eiz4SaK0rfAqdCqjDr42hEQvoG274qJTe2zE7Mv6gC3Gna3YwLIA8xR80HqFUt
         t3EKQKx4iZTEo8GDJ2w/Vt/E8lI45nprBlO/xShWM/4Ra2FY4ApMIjYCje9yfOPsdLkV
         Xin7heyCOU1xUA1gZtkFX5xA9eMY5/WnojDItX4m5yuOlP/i0EKBFUJqX76H5gAkjRb8
         Z7cS36k2kxNetPOPNMXA/0fBFjTjeST2kT1t6BUy05TdFoaMcueg/ff2+xtcBzeiiy15
         UJsMQ0iAq2WDGCxmw2osbdNdwX9BIoFjPukogrEgi65tPtC+Qxf9/tM6piLQMmL3/fLg
         wv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRMBvN5jV5opfKEhcuX/0MlxIGyzv8/E8aHaaJydPsI=;
        b=eCrAc5eXTvwm1Y8CTjEZReniEsY27zZs/rZ0kSrBBW+7TD/zxce/Nki3NbzMXxN9x7
         8pr2Ej1qCoySvfXHxtQShwC6Sf+KOX/9lpyJiCf3YlxJ/BU7BZBBT8B9qOMrK2KnHXDI
         I046Ou7ZsalWBt88STy2Z4P8lP6VuyHvbtX0C8C6QsQR2QYIu6Ypv+pcmBpNHwT1TfcD
         A/C+tIMfZFaTfyN7L5nz8xb5JAa6pn2mR6YYImzr3qe0tzMUiZk8Kp/85X07MJm6PzJ1
         0s9a2HFXLsWYaxfvs8yKU2pxmb1y9xX39jtimtMNL1+eCH+Ea94o6EpbDEKkMbvr+HGp
         2e6Q==
X-Gm-Message-State: AOAM532D9Xzu825bJfBTrQ1JTcGHBbYXN65bImxI7yxxCHYA9PntizSW
        xaSfY49i0Dt9H9qpgyGxfNw=
X-Google-Smtp-Source: ABdhPJzVz/Bv6kxUHBnTen1OKzAHUuO66oAoJVsdPcd58bfNooMisDb7Yt+pYNjM4kUjko8g69Ta3w==
X-Received: by 2002:a65:5cc7:: with SMTP id b7mr18837690pgt.445.1595251916416;
        Mon, 20 Jul 2020 06:31:56 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id t5sm14814356pgl.38.2020.07.20.06.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:31:55 -0700 (PDT)
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
Subject: [PATCH v2 2/3] rsxx: use generic power management
Date:   Mon, 20 Jul 2020 19:00:01 +0530
Message-Id: <20200720133002.448809-3-vaibhavgupta40@gmail.com>
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

This driver has not defined .resume(), hence define it as NULL.

Change function parameter in both .suspend() to "struct device*" type and
mark the parameter as "__attribute__((unused)) " as the function body is
empty.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/block/rsxx/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 10f6368117d8..866153fd380a 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -1030,12 +1030,15 @@ static void rsxx_pci_remove(struct pci_dev *dev)
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
@@ -1071,12 +1074,14 @@ static const struct pci_device_id rsxx_pci_ids[] = {
 
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
2.27.0

