Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD691C352A4
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADC921734
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 20:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI24w9HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLUXZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:23:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35574 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLUXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 15:23:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so3992663wrt.2
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 12:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yWsKB+a3ZjYcN/0REYG1TMy1vc1xk8C1cBkr08M7nvk=;
        b=VI24w9HHfDbU2qSN86AeWXKzwALWZY5q1p6AJHdf/G+NF2t2iFSpPdNkeBEC8WH4NB
         zb/Otv1eO0dOzYG09kHAqN9FVUxz/gtZvGRPrYjlB2GtDmu4MskXvE79Iyu73BJAzajk
         twtTyNvwwwIY40fqbH1sRXCEk2rC0LTZf2DWtLygBsxt72WJuqSZi+JxwYzMJZt/z+KB
         /p6DwbWsMnXUJ3DlaBkT7H8IejyLF78CS8lgCCUJ8PeCQoSQqjqxdIdS5YSs5hoP3S4n
         h8p74ggUtj+b/lCXTl5u0xc2a2o55qkEW/woKj33oRhXqNrUS/+TUmPkgr6WjvmBuapJ
         nKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yWsKB+a3ZjYcN/0REYG1TMy1vc1xk8C1cBkr08M7nvk=;
        b=syvrdIfY8lDcJAsXJ2faXFK3NDoT90ayi5A7bVcDXyRzk+2Ep6yK3S/mqR8BlBjves
         xW0v26APl5kJlf62pkKa0fOi8iVkKDxWOTTMub/VvjVqAwslWCFuYfLKNlFbpuCKHucx
         osAN0O+7RH0DhP++9wEVS6+/vjgq8xtEJ8Q4mu32cWni4Vj9v3ObnmrEkBrRcf6JAX+Z
         5BhZJ31oxRiMnNi++AO88oVQRajNNd2QK/GAnPIO4pdydwkTKohHn/sn+UKhmS4TVO4X
         fOyREHHb2ye4aqP15siPftGh4sPlL5kFUbRMh4+b9ZSHSnOFilb7/TQnWwEPwZupSCg2
         zPTg==
X-Gm-Message-State: APjAAAWaHjC2B259V558+z7nZSogvigxCffOuMKJod/vovHbJJl7hdB4
        FVreSz9w7nwt/SFgtMTKhM7DJbs=
X-Google-Smtp-Source: APXvYqxubkOCT0XfKgvlKmVJD40n2Kye7exIBsHeirjVFTWpucnbfZOWkStkQG/v/l+OPTKuRiIcNw==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr16718056wrv.316.1581539002918;
        Wed, 12 Feb 2020 12:23:22 -0800 (PST)
Received: from avx2 ([46.53.253.3])
        by smtp.gmail.com with ESMTPSA id z11sm1902377wrv.96.2020.02.12.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 12:23:22 -0800 (PST)
Date:   Wed, 12 Feb 2020 23:23:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] null_blk: fix spurious IO errors after failed past-wp access
Message-ID: <20200212202320.GA2704@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Steps to reproduce:

	BLKRESETZONE zone 0

	// force EIO
	pwrite(fd, buf, 4096, 4096);

	[issue more IO including zone ioctls]

It will start failing randomly including IO to unrelated zones because of
->error "reuse". Trigger can be partition detection as well if test is not
run immediately which is even more entertaining.

The fix is of course to clear ->error where necessary.

Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
---

 drivers/block/null_blk_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -605,6 +605,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 	if (tag != -1U) {
 		cmd = &nq->cmds[tag];
 		cmd->tag = tag;
+		cmd->error = BLK_STS_OK;
 		cmd->nq = nq;
 		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
 			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
@@ -1385,6 +1386,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 		cmd->timer.function = null_cmd_timer_expired;
 	}
 	cmd->rq = bd->rq;
+	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;
 
 	blk_mq_start_request(bd->rq);
