Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB094C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D7A20657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQjeBpFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfAQJ4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:56:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33149 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAQJ4W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 04:56:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so4608057pfb.0
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IW2uhgT08+LLNQBfcQStkFVLTpneOU+S7/nPPY2L1z0=;
        b=LQjeBpFbGrb+BjEf1JqPFvYeoMEW+qt1b4qS8bzWVKS+gKr88AdsDUHjemS+xvka1m
         r1BQn299vM4qmA7tV3Vodp2FlRESmCvAd8vlYzAG2QD26lftI2s9YDYGF77/DQEUqEZO
         jXLVHaudSfdgiMEcfKv+twoPOoEgGP5oyraUpvCtj+2PsGFPnGcrzTt/NjpYp3PgwTdK
         B568BnUDa2WMXQ2w+o0vCkQmv1AcKfET/E90r8DybUFM8IHbQM+s9NzozFytVqX+DCAo
         +2Wdt3EI7CYQsP4FbawOx82O8iDlCsMRe5u3YLdTV+aFbV+fcLJlxBmYXK0TZfCEfGrF
         PAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IW2uhgT08+LLNQBfcQStkFVLTpneOU+S7/nPPY2L1z0=;
        b=g0PUYmlauCvxgXtieIXtRCZ6a2AaiexSqQsTk5rYGSu9b+d2Xqmv7B8avrGDPRjaTS
         BY4rS4A0Pgxgs2IFSdG5MTlJtGMPH7XhZVMmgAh7QH0BZRl/vXz0Tb9b0aBSKHqxu3Vl
         LwtyphVODjCIoaNrwt1jNjQMPWmEHdHAVXPekFyvg8e+FJq477qjzoWTB/gKzn57Hg3w
         3oLK3F8LW2vcFWrGAfc3vhc6q69FclxflLUAqcHZEaGAvjF7Tr5jhNdZxR0Ys6xlLMeU
         aTwhi3mia+5t88ojlTrViKUpuTJLeHUpzj4RUFaUW3n9Vy9SaG79VOXtQmseyGasmvCs
         pT4Q==
X-Gm-Message-State: AJcUukeMwBOVHt/t7tl+0ztWbuyBHEnsqBaYYJFTra4KhtYRfejHoEW8
        PsqRYLvUZA5tv+G2IP7UWRY=
X-Google-Smtp-Source: ALg8bN4sgWRWwI6m1qsRfD83A6BDJ+RS4R8hZmb4KyE1rXkc9WuYw4ArDZ/Tn34mRxQZuES+G4VZCA==
X-Received: by 2002:a62:6303:: with SMTP id x3mr14641209pfb.110.1547718981974;
        Thu, 17 Jan 2019 01:56:21 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id h134sm3052056pfe.27.2019.01.17.01.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 01:56:21 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     josef@toxicpanda.com, axboe@fb.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        shaoyafang@didiglobal.com, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] nbd: use kmalloc instead of kzalloc when allocating recv_thread_args
Date:   Thu, 17 Jan 2019 17:55:55 +0800
Message-Id: <1547718955-870-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As all the members of recv_thread_args will be set before queue_work(),
we don't need to use kzalloc() here.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 08696f5..1656a60 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -983,7 +983,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 	if (!sock)
 		return err;
 
-	args = kzalloc(sizeof(*args), GFP_KERNEL);
+	args = kmalloc(sizeof(*args), GFP_KERNEL);
 	if (!args) {
 		sockfd_put(sock);
 		return -ENOMEM;
@@ -1166,7 +1166,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 	for (i = 0; i < num_connections; i++) {
 		struct recv_thread_args *args;
 
-		args = kzalloc(sizeof(*args), GFP_KERNEL);
+		args = kmalloc(sizeof(*args), GFP_KERNEL);
 		if (!args) {
 			sock_shutdown(nbd);
 			return -ENOMEM;
-- 
1.8.3.1

