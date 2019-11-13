Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298EDC43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 06:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA66222CD
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 06:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/0dR930"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfKMGjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 01:39:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38173 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfKMGjA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 01:39:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so736484pgh.5;
        Tue, 12 Nov 2019 22:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tB9AYDSxsTqJPT8wcekDci2iu2m/7gu/sjqNAn149fQ=;
        b=C/0dR930MA1kbc8j6GjGGV6Ufam4ZkttBfD6R4Eajv5UCZ3Kw7cyAmA5Og8ODHCmsI
         IR7sMdsvrc8zQNYaOOTWF3U4NHZODC3pwHWm3UjoBF1LiMvWLSihuI3podvLQsBqXeeC
         tWj4icZZ9pjdw/LROvjaNVfyZmysruFhv711j3OPSglzMUdhhYJVzvLywXaZRynJJX5F
         SwY3mq/ZASlY745JENj7y2O00afbNjQuC7JAxQPVHNlRWBnYrnJr4k3GTMznAisTLTyX
         EDmfbgxeyuUruw+aXGr1NKv01afC6NWTyq0yynmGHm5X7j+9UgMcr3s6deoDw5kVeJLV
         s5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tB9AYDSxsTqJPT8wcekDci2iu2m/7gu/sjqNAn149fQ=;
        b=czSQnSMu0ZUNjx1ycMaVZNGRVRsGwYIrayHLbFs6k5DZ+4/9xxmbZ3nDv73vF6U3C+
         k756WySViBKvmh/84ZXktSDK6MgLLwBo8Mecebb+Q06Pvcz3rAzT8rGyCNcHsxtNe19+
         7b4q5o+aU1tCS7QpjCqfKQWNao6d/1ut9pGB5Kk2gS1uHpXBv8Os6QIR2NrXfaaINbM1
         Damm1/JZjId6C3Hys9ZJK/I/s0dFESNmoz8TtqR0NUFVroMUzcx7y27LkdZkLdMg/wHs
         DRuoZH1Qj8VXgSJ1UEjsyyXFWjUKaXMvyR+5mVupatxofC3si9FJFzj+YZD6csqrYq2G
         27wA==
X-Gm-Message-State: APjAAAWTOZSi6Ca2XA6j6cRDkhOrQ9RjtJIy8DoFiTFXX4Ka44CS0irb
        S2FNy1ZopvNi2Z5GfpRBUp8=
X-Google-Smtp-Source: APXvYqz//JVWdR2pTawVDPImphXVJwA/A1GaAtCQXYt0nidQlO7y/R2lkHWHwMZOhW6hEZ6OjEyX8w==
X-Received: by 2002:a62:ab17:: with SMTP id p23mr2418010pff.116.1573627139775;
        Tue, 12 Nov 2019 22:38:59 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id y138sm1310868pfb.174.2019.11.12.22.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 22:38:59 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] rsxx: add missed destroy_workqueue calls in remove
Date:   Wed, 13 Nov 2019 14:38:47 +0800
Message-Id: <20191113063847.8955-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The driver misses calling destroy_workqueue in remove like what is done
when probe fails.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/block/rsxx/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 76b73ddf8fd7..10f6368117d8 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -1000,8 +1000,10 @@ static void rsxx_pci_remove(struct pci_dev *dev)
 
 	cancel_work_sync(&card->event_work);
 
+	destroy_workqueue(card->event_wq);
 	rsxx_destroy_dev(card);
 	rsxx_dma_destroy(card);
+	destroy_workqueue(card->creg_ctrl.creg_wq);
 
 	spin_lock_irqsave(&card->irq_lock, flags);
 	rsxx_disable_ier_and_isr(card, CR_INTR_ALL);
-- 
2.23.0

