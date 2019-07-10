Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E97C74A36
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 19:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A05020645
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 19:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="1p+GRmWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfGJTwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:52:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46986 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfGJTwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 15:52:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so3771293qtn.13
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=h2XA2X1ZY1EHxtyN0Imads8NvEkfjbdW711+ZDB5c94=;
        b=1p+GRmWLsFIydILSpH4SUU4qr33pL1CfrGVK7adXHtu2RSh053cgJVt/KL03koY5Gn
         +IE3FsqsOtjrvoaqjzN+STTVBDYcATwAhiiZ72usKmSe+2GmdGTw1VqUJ81hmVRPqt9H
         WVj4/Hj7zFsQ8S6Nbzk0xZZZsKW6+YytJ25j+yLDZfZhiDbpUnAxCfHiWBhQTNDZ1k6X
         cogq57vJw2oU8h0NdUvaJkKFy1dL3TbV6KTF9ZGhf1fy1PVEBOBt9AxARFnuvgi3ohVY
         QKgO1aJtdScOA9O3P99DUQsZDSLrrRDeG2axQh+RCu2+Oqna0uk/n/Ihmh9h7Bc0bSLL
         l8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=h2XA2X1ZY1EHxtyN0Imads8NvEkfjbdW711+ZDB5c94=;
        b=gJoYNr+MpaQRkBXCKjRScAvPRIyUX2goyuwJn6cNa3V6h9nF6yYAG3u55Iq21vvM2h
         sJAXQNwT3lr79mMeYgk4PgELRiHwu2TwJQ7j1onbuYmg75DBFGk295a4Onuwz755X4aS
         SUJL8IHxJYXgnpga8LjNUkB3qVBRSZFX3pd54OoplbBmTM59riHY47bkXZLvIMQDvBkm
         uCh/4OJwfQ6axcNRSolnGHEBEpySc94NgJz/Fp9P1nBx7S81fv0TbdaxJA7kibTdqwvO
         1xAzuLAiaEBhgmplvtQCJLRUFdeGG9zWiIYcxpNXEQ3FXmY3JqGvFlMCC0WESLmXzQOX
         4toQ==
X-Gm-Message-State: APjAAAXuA4PERaU9f671CQXI57NUfzlulI8rQLn2Dt7YTF7cfRvR3E/3
        DGkX3mk1b61hHEcXUGYYaRTDlQ==
X-Google-Smtp-Source: APXvYqyBfvrfYhxjdfcV4ySFNAvtIm75K1LNcIgBlruRP7C/8rwENvmllFbXCx4jBoSGkRQebtMdHQ==
X-Received: by 2002:ac8:2fa8:: with SMTP id l37mr25255325qta.358.1562788352412;
        Wed, 10 Jul 2019 12:52:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5ce])
        by smtp.gmail.com with ESMTPSA id i1sm1386769qtb.7.2019.07.10.12.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:52:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH 2/2] rq-qos: fix missed wake-ups in rq_qos_throttle
Date:   Wed, 10 Jul 2019 15:52:27 -0400
Message-Id: <20190710195227.92322-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190710195227.92322-1-josef@toxicpanda.com>
References: <20190710195227.92322-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We saw a hang in production with WBT where there was only one waiter in
the throttle path and no outstanding IO.  This is because of the
has_sleepers optimization that is used to make sure we don't steal an
inflight counter for new submitters when there are people already on the
list.

We can race with our check to see if the waitqueue has any waiters (this
is done locklessly) and the time we actually add ourselves to the
waitqueue.  If this happens we'll go to sleep and never be woken up
because nobody is doing IO to wake us up.

Fix this by checking if the waitqueue has multiple sleepers after we add
ourselves to the list, that way we have an uptodate view of the list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-rq-qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 659ccb8b693f..b39b5f3fb01b 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -244,6 +244,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		return;
 
 	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
+	has_sleeper = wq_has_multiple_sleepers(&rqw->wait);
 	do {
 		if (data.got_token)
 			break;
-- 
2.17.1

