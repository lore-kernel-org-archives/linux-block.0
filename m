Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA3C4727E
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA8D23787
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="YvKeBCRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIWLo6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgIWLox (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 07:44:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC4C0613D3
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 04:44:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f1so6682082plo.13
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9itEseAD+a+MBY3AfvJv+oRl5Fh7iHmbspsMNgiBQ8I=;
        b=YvKeBCRWp8yZc41o0eMSB8UggT0lNlhX9n/s6kiLonLBDwzHc1vJjz799Jatl8GLLC
         6N1DNrlPQCsphlq3gd5f9HDgeOmTUAWDWDjOLOAgtCK7Kzry1XXCNk8IlsmRg93vGW7E
         5tg2AH7Dv++QCOAHINDuQAhNHlgXO45E41R9aUboCHc55TNusZ/gnDiUxZQGy4M1+nA9
         br3CU5TT1DDHHx48gH1KIlgAVPITQTtSfhF8WoSMq3NDAlgmR7yMz8LiS+/p9O34Y03F
         HPUXGlFZmGeEf5+vWD7vIprFInNSnie+66zDIOAKeKkNp536kIo00KLzPN76oJb4a2hs
         Z4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9itEseAD+a+MBY3AfvJv+oRl5Fh7iHmbspsMNgiBQ8I=;
        b=ugIGlQB9TClRJFCzy2xmztCe6VIoTcKEn/Xoej7fIvTLntQw5cP6ta2P2QnaP0xmtF
         BUF/iJ9Ykao5Ye2n8um7nNGUVR1oD0M2r39bLlXAOBZJ705mStX6nr3E+S623grcfxxz
         YooNAHA219oBEcs8S0ei4KPUyM+s9tym92M5CxnqhCCNyL05kSTgcXNV5no62VF2dRKj
         06drAL2Z8aow0EgHV/pr495x6Mj/zXDnugmz1jZBYEDFGU5opiUlt89rGMjmzeYvs0YD
         va/ofefpLtNZMprKAJ/l7Hdhvnm9W4n76948igsmDPgUnQQejKE5ekbyOZWLE5voNeKO
         wemQ==
X-Gm-Message-State: AOAM5302PiG9g+SimTP/c1H3HzgfaAFxXgK+lVYaa3hvRSm9B+APFL2D
        zj+0qRP1eX54huZewYuLdVWYkw==
X-Google-Smtp-Source: ABdhPJzbDjZyLMX7GEC8J08bKLOJ6wgTzVSs5DFKee7t3ShM5SM9T0nNlvhDV6m5e2q8u58tqQMycg==
X-Received: by 2002:a17:90a:e2cc:: with SMTP id fr12mr7955245pjb.125.1600861492822;
        Wed, 23 Sep 2020 04:44:52 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:52 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 3/5] io_uring: Fix remove irrelevant req from the task_list
Date:   Wed, 23 Sep 2020 19:44:17 +0800
Message-Id: <20200923114419.71218-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the process 0 has been initialized io_uring is complete, and
then fork process 1. If process 1 exits and it leads to delete
all reqs from the task_list. If we kill process 0. We will not
send SIGINT signal to the kworker. So we can not remove the req
from the task_list. The io_sq_wq_submit_work() can do that for
us.

Fixes: 1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/io_uring.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c80c37ef38513..12e68ea00a543 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2277,13 +2277,11 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 					break;
 				cond_resched();
 			} while (1);
-end_req:
-			if (!list_empty(&req->task_list)) {
-				spin_lock_irq(&ctx->task_lock);
-				list_del_init(&req->task_list);
-				spin_unlock_irq(&ctx->task_lock);
-			}
 		}
+end_req:
+		spin_lock_irq(&ctx->task_lock);
+		list_del_init(&req->task_list);
+		spin_unlock_irq(&ctx->task_lock);
 
 		/* drop submission reference */
 		io_put_req(req);
@@ -3725,15 +3723,16 @@ static int io_uring_fasync(int fd, struct file *file, int on)
 static void io_cancel_async_work(struct io_ring_ctx *ctx,
 				 struct files_struct *files)
 {
+	struct io_kiocb *req;
+
 	if (list_empty(&ctx->task_list))
 		return;
 
 	spin_lock_irq(&ctx->task_lock);
-	while (!list_empty(&ctx->task_list)) {
-		struct io_kiocb *req;
 
-		req = list_first_entry(&ctx->task_list, struct io_kiocb, task_list);
-		list_del_init(&req->task_list);
+	list_for_each_entry(req, &ctx->task_list, task_list) {
+		if (files && req->files != files)
+			continue;
 
 		/*
 		 * The below executes an smp_mb(), which matches with the
@@ -3743,7 +3742,7 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 		 */
 		smp_store_mb(req->flags, req->flags | REQ_F_CANCEL); /* B */
 
-		if (req->work_task && (!files || req->files == files))
+		if (req->work_task)
 			send_sig(SIGINT, req->work_task, 1);
 	}
 	spin_unlock_irq(&ctx->task_lock);
-- 
2.11.0

