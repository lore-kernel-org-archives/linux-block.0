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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3436DC433EA
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088882080D
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 08:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCuFcZ89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgGVIfP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGVIfO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 04:35:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C218FC0619DC;
        Wed, 22 Jul 2020 01:35:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n5so817055pgf.7;
        Wed, 22 Jul 2020 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpj8809C+sM2nooGQLQ3iMt8QMJk//10RMuL0DlWSoY=;
        b=lCuFcZ89wu3kx/HDgLnV34IcRrMlG7aDlTeDCogo1z+xJsDs6Wt3gHYAmUYLYYymwz
         LbLT/kvUpr2yAcLgIEGCL/KerGqeLpgBZR3R1d2KVCVSlW5fWfJ3k2DjDFSuq59FnBwU
         fydm/2wJOR81lNZC9ELNZ0L+wXxNlHT844vsA+G8wx1Sg8lFAL+D8ZOMt5e54apigXjb
         GMgKzTjhtwqDsraa5gfConSamFiiH3C/6E6IlPfxtSlYlo9csKJp0N7vOoo8kVFvaXQ1
         /ftjKgH/9S5av/7nSOg1+oG++dP7z0CGduYc71fE3XZAHajBt8yVJtGHOx0EEIzyokKN
         vocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpj8809C+sM2nooGQLQ3iMt8QMJk//10RMuL0DlWSoY=;
        b=dQQqy8MY0kk+ffjYZqDyhS29JEa0SFfH7+2S0mGO288/O1ZSeFhTxcqZI40QE/uzSi
         XoG0W/6s1VPe0fqcfKnEnDELXhnyhzKNdWg1BejPRvhW/LjgwUc70yDWGh9q6sy+BTxZ
         Tzu7F0WLoqb/zZc/vnLsklNWag8G20A75JpQ4eu0r+f+GtMTLHgtfVFwRI0dbk4wX74u
         c6MrQblNsXukz5ILJ4aCVlNcmQ7PCTYT+Ii3ASQlffYt5keVXr61fsmQqFBv4OJaMIby
         vz0e9ah4vUR/R7Rh9a3n4CER0fYBRshzO22+2eulgHMT0xTbQIAful9AHCA9BwPdBezo
         kW+A==
X-Gm-Message-State: AOAM531CUZpH2hDj7DipoHBYSKbLNXrbwAV8SMQbLjlgTTK4NlbVoa/i
        Fh6NLpOpDoCyW72rPdJ5T4s=
X-Google-Smtp-Source: ABdhPJx65JiqSe4jtWXtltTFaph81bwxLCBhoqEguFtl6wLw3r0pC4e4SP9leSx6uipZWkdMYfW2pQ==
X-Received: by 2002:a62:347:: with SMTP id 68mr26799465pfd.185.1595406914260;
        Wed, 22 Jul 2020 01:35:14 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id g13sm5777319pje.29.2020.07.22.01.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 01:35:13 -0700 (PDT)
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
Subject: [PATCH v3 2/3] rsxx: use generic power management
Date:   Wed, 22 Jul 2020 14:03:34 +0530
Message-Id: <20200722083335.50068-3-vaibhavgupta40@gmail.com>
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

