Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F07C2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34293214D8
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="01ysSC8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIWLo6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgIWLo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 07:44:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F0C0613D6
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 04:44:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q12so6684473plr.12
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WN/2aVaL/WoH1KRLeXq71c9eCEQAH6H70sGmLsN6lU=;
        b=01ysSC8hFBY3eDCc/RpgxJQX9B/h7CFkxAz+3QPQEB4/2blFaWo2etOmLBAfgEwCLF
         htkynXCLOqwtDLHb2P3xVS18HiakMBmVeSRYcvK483uOAbvMjgMV6ab1RH2p2VenTUAE
         D1J+/xyjSO+CWX+W5w1pdGifoy4pgPF0pA1vk9YXf2q72kxNKoPCH1vDImG7PBQrUC7x
         z7SmInT0MpIX9IQXDKiIeHRxD9Sg6pBo5W/eIil3EFGoS8QltH3XIJNTHoT7/n55nTce
         7pFHLCULrR+wMCma+pUNV2X+ZtwQ56keEc+2DBmf/BiAIpgh5vmrlvniWAzxnFBPmzog
         iSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WN/2aVaL/WoH1KRLeXq71c9eCEQAH6H70sGmLsN6lU=;
        b=Hy2Xw5pbrc4r8Si7bUVSORCy2wzzrLOam9c9bjEsdajoq5qWs+GJjlIaXL6pF0iGI8
         X6JOjpTfzNDPW8/ICzAWVPKWVT446Q6EHPKb5YNdYxefZG5M4CBXhpDRFKxaJ7/XPYRh
         7v9g4oZ6en58wmyWGgW8gPLqPgLCwXor04E7OcptTt5d3IfV2WJ9dSQPjHxwmD3qFXEO
         Wu5t2DBdAZ3MDoj8HN8ostP+4/qJrpaYm8F10zjv6yN9cCqKpj0diNHrhPFnG2od5FQh
         IgdZCSTBg+FPeQgW3LO6VM73vIPk4q4BAiuc+MFxdyp6EnQWVW2P85VCOJm8qeqSwYpr
         BU2w==
X-Gm-Message-State: AOAM530rSN0szeCTP7aRVaf38R7vqC7LXoDUFqyxPj7eEAIOTaXLiXzD
        ZW7yBnWCU2FMhBCu0y3GPdC+fQ==
X-Google-Smtp-Source: ABdhPJwdxYXVAqCqvVIAa3BXdJbmtpQ0JBjfJ1hB7+Gji0Vv4dxpIc7rUeJaGhMul6qvv9McfULcPg==
X-Received: by 2002:a17:90a:d304:: with SMTP id p4mr8215672pju.138.1600861496349;
        Wed, 23 Sep 2020 04:44:56 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:55 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 4/5] io_uring: Fix missing save the current thread files
Date:   Wed, 23 Sep 2020 19:44:18 +0800
Message-Id: <20200923114419.71218-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We forget to save the current thread files, in this case, we can not
send SIGINT signal to the kworker because the files is not equal.

Fixes: 54ee77961e79 ("io_uring: Fix NULL pointer dereference in io_sq_wq_submit_work()")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 12e68ea00a543..c65f78f395655 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2391,6 +2391,8 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 	if (ret) {
 		struct io_ring_ctx *ctx = req->ctx;
 
+		req->files = current->files;
+
 		spin_lock_irq(&ctx->task_lock);
 		list_add(&req->task_list, &ctx->task_list);
 		req->work_task = NULL;
-- 
2.11.0

