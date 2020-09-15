Return-Path: <SRS0=dDIv=CZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74817C433E2
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 00:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2743920770
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 00:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="uHSTTG9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIPAmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgIONCz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 09:02:55 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC93C061788
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 06:02:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id e4so1308579pln.10
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rc6KaAEAFGC1bquGjMDTwVXCIGizoAvEk7c9RDuLwUU=;
        b=uHSTTG9SkzuWvTWWD5CiQWnUreepxjLDXUrW6B7M7673ifJte619xFMebuGUKkNww4
         bG8GTdnqecPbRu3IgxB4aRhc+mexcZ6eN5KK4euTNlp1gKFzKVIe2ts+PlcKiAmuLIqB
         fJL2tItNCkXJnufEmBCgqWlq5wG3sztMd+FCYu3K9zqquLZLCWBQkEiDPszHTdxnh+XG
         AInVgU+TUJ4lHuE/KgghIeubyhwp46t68stuqmwWJhvQcXxlvrJTeuCJligdwBHyl5sX
         J42JWxskVo5f+N42nvYckziJh+S0GXbYzGCMVi73KNgTcE+sdpR3ZacUacGUKjQ1KLCf
         cHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rc6KaAEAFGC1bquGjMDTwVXCIGizoAvEk7c9RDuLwUU=;
        b=OM+4tm+vppdmc/NCbZzfZ5+su05EtH8wGVx7JgzGRxTJUR9J3wWGkM+J1eisNXQ/uk
         RGdqV5Q6otc7ihbnROC9vqJhf95tVBfb77ZogT//y9KSTmnrRokHC/rsC15hXL8EbmrT
         yOYdOcReLoRols2pu9qvdnxGNCNzNfGxXgJ3T5sjN6WpOk6fx06CpAt/Z1AGUGmcZlCE
         Xp4FhIdSLP+8PPX3vfP6tTzX/xO9zJlvKYpqClYkkakD/cLonzNQ932dU7EqL+dEiTY/
         xOgmhG1m65zXyJq8/BlVTiop63GO0odGEjl2iC+bl53F89vH12jOtnh5zExdhllQS9MJ
         7T/A==
X-Gm-Message-State: AOAM533d3dEpUuyf65Vb4EJ6ELQvDmoaN3mV9zsCRXoVioE90Mi1mGlr
        kn0eXI1z2w6/020CXPiP5g58MA==
X-Google-Smtp-Source: ABdhPJz2EWD6fENT6TGgZ8NuSVKrRjf/5CKkJlBWOkx7TnR0YUJy0AAJv/T2UmCjTO170TN5QGqGGQ==
X-Received: by 2002:a17:90a:72c7:: with SMTP id l7mr4186306pjk.19.1600174973787;
        Tue, 15 Sep 2020 06:02:53 -0700 (PDT)
Received: from MacBook-Pro.local.net ([103.136.221.73])
        by smtp.gmail.com with ESMTPSA id c5sm12133263pgj.0.2020.09.15.06.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:02:53 -0700 (PDT)
From:   Yinyin Zhu <zhuyinyin@bytedance.com>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com
Subject: [PATCH] io_uring: fix the bug of child process can't do io task
Date:   Tue, 15 Sep 2020 21:02:45 +0800
Message-Id: <20200915130245.89585-1-zhuyinyin@bytedance.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

when parent process setup a io_uring_instance, the ctx->sqo_mm was
assigned of parent process'mm. Then it fork a child
process. So the child process inherits the io_uring_instance fd from
parent process. Then the child process submit a io task to the io_uring
instance. The kworker will do the io task actually, and use
the ctx->sqo_mm as its mm, but this ctx->sqo_mm is parent process's mm,
not the child process's mm. so child do the io task unsuccessfully. To
fix this bug, when a process submit a io task to the kworker, assign the
ctx->sqo_mm with this process's mm.

Signed-off-by: Yinyin Zhu <zhuyinyin@bytedance.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f115fff39cf4..f5d6bd54a625 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -514,7 +514,7 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 	}
 
 	req->files = current->files;
-
+	ctx->sqo_mm = current->mm;
 	spin_lock_irqsave(&ctx->task_lock, flags);
 	list_add(&req->task_list, &ctx->task_list);
 	req->work_task = NULL;
-- 
2.11.0

