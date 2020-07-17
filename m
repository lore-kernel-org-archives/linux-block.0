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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F212C433EA
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3863120775
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 08:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmHO/eZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgGQIKm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGQIKm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 04:10:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C721C061755;
        Fri, 17 Jul 2020 01:10:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 72so5140361ple.0;
        Fri, 17 Jul 2020 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iRMBvN5jV5opfKEhcuX/0MlxIGyzv8/E8aHaaJydPsI=;
        b=HmHO/eZDd0+8PW70sN9QzeabUtqpZZrvu2RYNEtW25g5QZ7/HT9+hDxQ2gBLm1aJyU
         ZBZbKlKA8GBPsSdf6GMHnzCdMUJsPij6/lKPox6+Te3Sj7pSAbZTB6H+TcWqhR7Dpj5M
         H90j9eVITqNucGzIk1rsKC7znL3hTG9PeNbXhlX4YkybdM6SOGRGhi0wtCsJV1e3qWjz
         vSo+/ATEK276kyKxNtFkuLmfukJvVRPBd58R11Jrj3xy/W2xp5ky366Hbbsf2J7RuKB5
         MKWtbvW3joAr3FoQP1GQjv+HWo5RmQzE3pAVHSy05PkBEdMSDY1cGlsq0neqWpF9axLQ
         0veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRMBvN5jV5opfKEhcuX/0MlxIGyzv8/E8aHaaJydPsI=;
        b=e9B6bovYsOtyP6G2WfKlcjjTek7WgZD9YWseQ+cLP+nEub+z++QeHqm/3EbySUkhJQ
         sDsMUUxYEDubs972/Y6NAXlN6oYXsJE08IhEns4rpwPGPU1xPgiI/pD87eXZdQIZGqpj
         HnuKWQelOW1xvt04y33VfXqL+vuiGlbV1KZYM30CN2hCGTUHNwlL9Ch2MJpoyr85+Z/U
         gXbydsup0qd/UuetpDV9i36ThcUmRFrTT96YUZ0uafph/KZ9ofPCrSGcww8sCUeU2pbr
         lonrNpaI9vvJyNNFh2Nn5Z6GyIon7jgydrVr4bz7JsQwlIXExhM9iK3/+3dmHlUoNpLZ
         WtAQ==
X-Gm-Message-State: AOAM532I6LoiQFSo64T78ggCBxVd6n+KlwSvqj5m0FEt1iEfeP+rnb6h
        B5f0KALa6k1gVWGlZyGoy68=
X-Google-Smtp-Source: ABdhPJyE8L2iwEKxWiGnIhifYEnsfEu0RpKl7X3WakdF5Pv/dp2KCSwf8f471+NnlYLcej7ngyRL8Q==
X-Received: by 2002:a17:90a:4b0d:: with SMTP id g13mr908667pjh.200.1594973441663;
        Fri, 17 Jul 2020 01:10:41 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id d5sm1937296pju.15.2020.07.17.01.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:10:41 -0700 (PDT)
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
Subject: [PATCH v1 2/3] rsxx: use generic power management
Date:   Fri, 17 Jul 2020 13:39:09 +0530
Message-Id: <20200717080910.342741-3-vaibhavgupta40@gmail.com>
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

