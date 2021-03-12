Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712C1C4160E
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 11:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE156500E
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 11:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhCLLJU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhCLLI6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 06:08:58 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85ECC061574;
        Fri, 12 Mar 2021 03:08:58 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id s21so1642373pfm.1;
        Fri, 12 Mar 2021 03:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hunTPZCviArd0MXDnzzzFZQhSy4vbv7jKWoalPSpEQw=;
        b=SrCFlWpyYEENRUBIySkHbIQhj3YL/u8Dq4FFAhdS3eeNRP8iej9jnd0fxfZgReZzq6
         vQbg8sifDsDYphc1Xv+ncKLBisptBg6GlH0013HzPCzSPkA/12LCWS61x6KtPhDcdTMw
         yuzt+ATDX2NbXACFByh9moNeIOuO+VN7i12hTiaB7qqDwr9dUPqpZF/MhoA64Cx99DUm
         +jx9n3kGXj1eDGOOksXjz5TVRpAsEpqWh1mkpDoXV/z3xXuvRCWfEW5CC6boKc8P89RL
         RLKcSlaMj5yqtGWc7okGN3PB7hSjtsPBFfple7Eee8i7AvJyiin26R2tP86CmrROgyF7
         8jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hunTPZCviArd0MXDnzzzFZQhSy4vbv7jKWoalPSpEQw=;
        b=CAmqfX2MMxO7qZ2yrVWaQiCnD7LHFE9lBo8ddJ1Mr78L6vraEzxfWUPGnjm55tRKHn
         9DNWf+ZajpJCAU4Dwk7yEFOl3CcgQIakrawZVGaiHdWx717tg1+4egxtq+yteL+AWu7E
         PTeNHFptu1DXVkdo1THZQAUOUkfwj4EGjA/XQ4rta7K+62FX8GHvsUAbFTXPygJ3uY6L
         hi36zTtnTYyb8X6XzqZ0a3kSsyKuZ3nJ55cimQfdRFu68vmP0uMZCi2F53W78pSu4FAx
         BS90K0gfI8mmAAgp7zYz/AG6ltxE/7Z+h/4vZcyZ2lcXYL2mKMSVNLhtpFFaTSORM+0U
         ANbw==
X-Gm-Message-State: AOAM531cQKsjE/9VVOBtignPePeFO+Qz2IvtvINaILqVs5vTZwloowPa
        yALsH11q1oXlgxRvB5y/InU=
X-Google-Smtp-Source: ABdhPJyvyI1eJ1KcpGMI7kjlKJJ0otm9rAhR9+gmTS0WlkgeI7YqcPoszbCabXyl8WuqDLxZtxOaAA==
X-Received: by 2002:a63:2c0f:: with SMTP id s15mr11331171pgs.351.1615547338331;
        Fri, 12 Mar 2021 03:08:58 -0800 (PST)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id t5sm4942181pgl.89.2021.03.12.03.08.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 03:08:57 -0800 (PST)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 04/11] bfq: limit the IO depth of idle_class to 1
Date:   Fri, 12 Mar 2021 19:08:38 +0800
Message-Id: <e5928d0b76ef665701df034eb2bd7f85681f4656.1615527324.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1615517202.git.brookxu@tencent.com>
References: <cover.1615517202.git.brookxu@tencent.com>
In-Reply-To: <cover.1615527324.git.brookxu@tencent.com>
References: <cover.1615527324.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The IO depth of queues belong to CLASS_IDLE  is limited to 1,
so that it can avoid introducing a larger tail latency under
a device with a larger IO depth. Although limiting the IO
depth may reduce the performance of idle_class, it is
generally not a big problem, because idle_class usually does
not have strict performance requirements.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f0f53d6f1f6e..91e903f1e550 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4808,6 +4808,17 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	if (!bfqq)
 		goto exit;
 
+	/*
+	 * Here, the IO depth of queues belong to CLASS_IDLE is limited
+	 * to 1, so that it can avoid introducing a larger tail latency
+	 * under a device with a larger IO depth. Although limiting the
+	 * IO depth may reduce the performance of idle_class, it is
+	 * generally not a big problem, because idle_class usually
+	 * does not have strict performance requirements.
+	 */
+	if (bfq_class_idle(bfqq) && bfqq->dispatched)
+		goto exit;
+
 	rq = bfq_dispatch_rq_from_bfqq(bfqd, bfqq);
 
 	if (rq) {
-- 
2.30.0

