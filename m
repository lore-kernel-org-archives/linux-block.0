Return-Path: <SRS0=eh4K=IG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26650C433DB
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F6064DE5
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 10:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhCHKGF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 05:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCHKGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 05:06:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68816C06174A;
        Mon,  8 Mar 2021 02:06:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so2829068pjg.5;
        Mon, 08 Mar 2021 02:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WWejwpLhyC6iuRsf5vtcly9Siaqt+WSO97OS0nHSQs8=;
        b=iXKPcjOVrqtwo2m505qjSWxWVAeWTE0KDhqhcvfhBzqiRO6M4OWM8myJWWOemYHrDF
         CKUGBhkrmi2GhZeoSrnhd4MVFVGtJJEdOHaAEjIZPpT/AdH9rg3aeYoEuuypV5kCd5Cw
         3jh7HFlhx+Duhn4dYQ2zPiigV28TOS4/Qke0/+QblX6lSa1mXvpz8OLssFHBfcHROlBd
         7czY4GMIGI9aUJ+UsE7S3yaCjSaaTx+DajPjorm2ph2epUx3DVSwC2ssRqLboHq1nDwj
         i2DNqqyXQ7pL9W7gc75TqylzpAPzwuAXMtaFLfcs1XVI3xQnHMLRgQ0vq7EUOQzyTCWj
         LPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WWejwpLhyC6iuRsf5vtcly9Siaqt+WSO97OS0nHSQs8=;
        b=EE/Wkct2b3DWTb7xhE/UqYD1+wPYlWO1rwj5jSsyUlK7h4rXX3B2joOKq+lupmTr4h
         Mnj6ue19rmASUE2UFjUsSMj2SiDJV3ZaMsMzbv+MHfP6Ibk7dvhlE6inxKLoKlEQuzux
         X7dUI/xWFdzFik0eLQzL7n+YiwMzDL4zSRowCjFDlRYSjzKZvzaOmO3PiovG9t4fPRap
         XFlnGyEyCrUo7NwXJIvezwZQHKVtcx9Qw/Hf4Zc9U9o2/ZColGaAKaLkejI63e9RbnDZ
         ODsLzXgN3icDJcu4EdBUlMDyc2MHhw2EmbxFxpBY9J6uvgZYaZKPWathWvwOi9SutSj6
         iFeA==
X-Gm-Message-State: AOAM531wEibg0G6simsYUDKlN8zTOw3ViKVSY9pSZQDEbF7YuE3LC1VJ
        rExUmb9//ioe7QYNz2eDobA=
X-Google-Smtp-Source: ABdhPJycWl+N+bSlBrvgzj/WM+hwN1oSija1n9jZokEze19FlHiDpswWefp+jjE8YmIsQoQJy9+ulg==
X-Received: by 2002:a17:90a:7c48:: with SMTP id e8mr24833033pjl.89.1615197963717;
        Mon, 08 Mar 2021 02:06:03 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.99])
        by smtp.gmail.com with ESMTPSA id 138sm9986301pfv.192.2021.03.08.02.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:06:03 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     josh.h.morris@us.ibm.com, pjk1939@linux.ibm.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] block: rsxx: fix error return code of rsxx_pci_probe()
Date:   Mon,  8 Mar 2021 02:05:54 -0800
Message-Id: <20210308100554.10375-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some error handling segments of rsxx_pci_probe() do not return error code, 
so add error code for these segments.

Fixes: 8722ff8cdbfa ("block: IBM RamSan 70/80 device driver")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/block/rsxx/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 63f549889f87..6b3b9b31a3e8 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -760,13 +760,17 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	pci_set_drvdata(dev, card);
 
 	st = ida_alloc(&rsxx_disk_ida, GFP_KERNEL);
-	if (st < 0)
+	if (st < 0) {
+		st = -ENOMEM;
 		goto failed_ida_get;
+	}
 	card->disk_id = st;
 
 	st = pci_enable_device(dev);
-	if (st)
+	if (st) {
+		st = -EIO;
 		goto failed_enable;
+	}
 
 	pci_set_master(dev);
 
@@ -774,6 +778,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	if (st) {
 		dev_err(CARD_TO_DEV(card),
 			"No usable DMA configuration,aborting\n");
+		st = -EIO;
 		goto failed_dma_mask;
 	}
 
@@ -781,6 +786,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	if (st) {
 		dev_err(CARD_TO_DEV(card),
 			"Failed to request memory region\n");
+		st = -EIO;
 		goto failed_request_regions;
 	}
 
@@ -817,6 +823,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	if (st) {
 		dev_err(CARD_TO_DEV(card),
 			"Failed requesting IRQ%d\n", dev->irq);
+		st = -EINVAL;
 		goto failed_irq;
 	}
 
@@ -824,6 +831,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	st = rsxx_creg_setup(card);
 	if (st) {
 		dev_err(CARD_TO_DEV(card), "Failed to setup creg interface.\n");
+		st = -EINVAL;
 		goto failed_creg_setup;
 	}
 
@@ -862,6 +870,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	if (st) {
 		dev_info(CARD_TO_DEV(card),
 			"Failed to setup DMA engine\n");
+		st = -EINVAL;
 		goto failed_dma_setup;
 	}
 
@@ -869,14 +878,17 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	card->event_wq = create_singlethread_workqueue(DRIVER_NAME"_event");
 	if (!card->event_wq) {
 		dev_err(CARD_TO_DEV(card), "Failed card event setup.\n");
+		st = -ENOMEM;
 		goto failed_event_handler;
 	}
 
 	INIT_WORK(&card->event_work, card_event_handler);
 
 	st = rsxx_setup_dev(card);
-	if (st)
+	if (st) {
+		st = -EINVAL;
 		goto failed_create_dev;
+	}
 
 	rsxx_get_card_state(card, &card->state);
 
-- 
2.17.1

