Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDD0C04EBF
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D72D2080D
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IHqA9CKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D72D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeKRICR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:02:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37305 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKRICR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:02:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so12122114pge.4
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vAyTfU2587OXyFZkad4b/5LE5tx6YC2PCTyuDpDarDo=;
        b=IHqA9CKL+rkio6YR5t2/L/dA622exqxyAHzTW4fYgyRbubqPJnXqdtA01+FHQVeInG
         fFtdruNPvZLZvPodkwq9aIdUMAIMAIrBpHM1ws5rhw19zTnoKLgv5twY2jZ9yH9qqNBx
         sv5RNRBIoejP+yfYNE3iSBqgA0REULMMXJGIHWRiorZcr7P/nuVOM/c1Iiw1ejjuA/z5
         6dkdRTzaNtjFCg+9BUl0JE5qqCDWWjyQzZRakvfZM28ETxB5uFd+k5zUeEq76L0svo6z
         0WWFWJwMlcGg4MmwbmA6gfb/OkgYLEb3r/O09RvI1xvNy13e1lWf0CbpUZELGqUXjaYw
         +P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vAyTfU2587OXyFZkad4b/5LE5tx6YC2PCTyuDpDarDo=;
        b=MIbZR5IVVpJWB0xm/F/xqzTZ36Yp31qKzYxwKxJkqxJbkpdAi6Sn+wcPAIjoYU+HQh
         coRteg9QgQjzVkQaGTmR+YWon9/oEHz4apVp6Gm+1RBpWDw698u+MDnsFSevKtC+x6Ez
         NChmugeUZL6yTtxU2tjGvBdzUdn51UGcctmNmPFf5FOGr4AHeFMZuehSDp3Ep063xZYz
         2JVKHygt4MfcgkIo0l2QFm1vSVYPiUyev4hF5fxDTFwNukvp0GgEzrBKKeTnzKrw5fxq
         QQ8VdqS4WgbvQeEGEHAN5y7mcbOYSmZoBm8PM49/qm3VQqrH/JGvu7x8kcCrBwwuHFm9
         TWcg==
X-Gm-Message-State: AGRZ1gIy6XypMJ9V9J3zYgg8syhJnSp8y6dBRxLiwG2uOwvrhtT7qKIm
        zxkpWPECtyXqgJ3rEafWgA1l8qv20J0=
X-Google-Smtp-Source: AJdET5eayCXDC9bJDvWKGVL4LFv1fj4oML/wfBkyeyIP1uGCdfP6ka+q13skl4/LeK6KGooJaON6ew==
X-Received: by 2002:a62:d2c1:: with SMTP id c184mr7705356pfg.248.1542491053181;
        Sat, 17 Nov 2018 13:44:13 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o84sm29006501pfi.172.2018.11.17.13.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 13:44:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/7] blk-mq: ensure mq_ops ->poll() is entered at least once
Date:   Sat, 17 Nov 2018 14:43:54 -0700
Message-Id: <20181117214354.822-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we immediately bail if need_resched() is true, but
we need to do at least one loop in case we have entries waiting.
So just invert the need_resched() check, putting it at the
bottom of the loop.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0a2847d9248b..4769c975b8c8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3336,7 +3336,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, bool spin)
 	hctx->poll_considered++;
 
 	state = current->state;
-	while (!need_resched()) {
+	do {
 		int ret;
 
 		hctx->poll_invoked++;
@@ -3356,7 +3356,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, bool spin)
 		if (ret < 0 || !spin)
 			break;
 		cpu_relax();
-	}
+	} while (!need_resched());
 
 	__set_current_state(TASK_RUNNING);
 	return 0;
-- 
2.17.1

