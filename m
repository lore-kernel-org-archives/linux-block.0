Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC28C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9619C20659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BstM0Ucl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9619C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeK0Dav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:30:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54599 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeK0Dav (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:30:51 -0500
Received: by mail-it1-f196.google.com with SMTP id m123-v6so5009405ita.4
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/IBFVWV8/9cHpHivEgC4qsXTRnszXOXgHHSPu+O1gfg=;
        b=BstM0UcleU6Oj9/CJ5rEqrksTn04L/iRF/r+wlVu0zZH6nQR8LMmxudeNKDPEMaGiZ
         XLnGj5syo8dBYK2VlhUmDrg7knsCbbxaLrTgE0Jv8FI6Qym1rKRr/qcKBQISQdRDTx8q
         fKJZ6JP4f3d28RT6l0RXaom8QfvFKbVCN+EIxpYB2RtjMHlhM5vdqGIJq+wdRROd7k4h
         9rAfRntJ5KLpqVxZGZeYiNAThAKlcvQ66gKYe2ZArjFfUC1M59clSIVxXxrK0SpR0+4a
         XEg/iPYXFk0PmcJL57zTrAv8CzzbFDh4kon7Ttx3qKPxnkUdoxDqCwgrCs0Vvc9hO5w+
         uBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/IBFVWV8/9cHpHivEgC4qsXTRnszXOXgHHSPu+O1gfg=;
        b=mvcJByZLFZaocavy7X2k3uHWcdctGlm2pvMHu5Cm8Fsx+Rt9X/wvxwk8ZEg+U51yVK
         UWpWGhMJsIESvb2P39T+zsE1FEAwvQkwMT68kmt7DjIjLby9D0OxAOOQGh9HBWgHBvB6
         BIHM0l90RZ43j5eCG5lb0vKs4sVZPJkEufrYlXdONW9xzSVWorrWG8pNuDGDzjHViBb6
         D5mueXiddsJNNFli9Mz+JD15yQNUWgXs0wgLWUcmY0h+0jfrOJRCCTOnCOO8TnjXEMPF
         sg2W8RZdiKpheMwmAGLhDmc/WV9WpofFmxpqJf4v7lAmE/YWg7QwZQwqiZTX3WrYZt3R
         hebQ==
X-Gm-Message-State: AA+aEWbHzSx9x+yuZSpH0ZBgLlsFBRdhxzD358nAGgIHOUua0U/ZRzgO
        yIt0fUlIDqsDk/nAnaJkRs8XomdU3Yk=
X-Google-Smtp-Source: AJdET5cLtxZdynO8Oh5MGhpDWy98RkZzCjGVC1E99MT+CinWhh7yWEI8HjLRfRQ9wuMUhgUU57INpw==
X-Received: by 2002:a24:3390:: with SMTP id k138mr22782463itk.132.1543250173429;
        Mon, 26 Nov 2018 08:36:13 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm263717iog.46.2018.11.26.08.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:36:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] ataflop: implement mq_ops->commit_rqs() hook
Date:   Mon, 26 Nov 2018 09:35:54 -0700
Message-Id: <20181126163556.5181-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need this for blk-mq to kick things into gear, if we told it that
we had more IO coming, but then failed to deliver on that promise.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ataflop.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index f88b4c26d422..475cb972f324 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1471,6 +1471,13 @@ static void setup_req_params( int drive )
 			ReqTrack, ReqSector, (unsigned long)ReqData ));
 }
 
+static void ataflop_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	spin_lock_irq(&ataflop_lock);
+	finish_fdc();
+	spin_unlock_irq(&ataflop_lock);
+}
+
 static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				     const struct blk_mq_queue_data *bd)
 {
@@ -1947,6 +1954,7 @@ static const struct block_device_operations floppy_fops = {
 
 static const struct blk_mq_ops ataflop_mq_ops = {
 	.queue_rq = ataflop_queue_rq,
+	.commit_rqs = ataflop_commit_rqs,
 };
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
-- 
2.17.1

