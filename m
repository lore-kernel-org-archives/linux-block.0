Return-Path: <SRS0=t3nT=CY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB7EC43461
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAD921D1B
	for <linux-block@archiver.kernel.org>; Tue, 15 Sep 2020 08:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="HkzVjO/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgIOISo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 04:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgIOIQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 04:16:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B3C06121D
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 01:16:27 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bg9so946245plb.2
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2020 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yeFwfk8Fpky7+g0bZ85JgIbAdUzzzWR3a+mPLSdrdV0=;
        b=HkzVjO/FOfTkR/OgQ7OzDwoYETbOrDAd2UlR+0I8bmpH18gj/WpgtRMLBDIuo0BXFe
         Y3IRdNfnVt0vpzutQiMKIQmO5xoPv8dJE5VripWF0LvE3KDFO0nJaOnvkXt0jGwp1sat
         on+ikT+ooKjrN/6aK0hoZilQ8PcflhRuUumS9R+hhNW/YPI9h5fecdXuZ0h5ByXqLvFY
         KEfCt3LPgvl0K7w1Om9zefFCGHnVIiXgi7L3GRub1oXIlFYDpOcCRbkGWHYkhTiqz2lK
         zeEJq61DGDMvB1ywJN/CVKLhJzuOM3DFuB5G8EjnFrsVeA40oyjXQKintNV0W326fzIm
         cjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeFwfk8Fpky7+g0bZ85JgIbAdUzzzWR3a+mPLSdrdV0=;
        b=HIikoz8/Aj1LFm8mKBj+LjWd4QCybod34WpW0f6wLyy5UVGOz4uMte5OTROjF41uRj
         y66VpE7Rg3bl7yX2Av2/MSWbq7ffnTqRf/fkXAPiMr+3e+jznzD9F/drXQmqBxBQ/zf0
         D+q1BnnYFudqtCibCLI4kH2N8ht/gLbuiXCOTYeAkhYvxnAP9ll9T/oFv0/PsnHlzUju
         DwcKLo/l6Rnfh9pYPk2NUTfAtI1PkDUvWUlD7mv2KVcfuBGt5agVYicuvgjeHIUIZNZ2
         ir+wY2aw52sJyBQFf0fuqfB5H0EtHkoz4mYFADOKBPON5rclCgroedc4oTJ47jboACzl
         7Snw==
X-Gm-Message-State: AOAM532EvWl8AKb5BKim7N7tMP8lm/WUAhf9cDJ7N2h0o+1uNHkq2jH0
        Cjt4EQf+VEZ0nco31Hh4MsmbDQ==
X-Google-Smtp-Source: ABdhPJx+JN8JVfTOwoiHYm896JtzN+/OSIrJBJw4sQYZu6grmFAU24fWL1bmw+Ee2XkBtf98ne8ghA==
X-Received: by 2002:a17:90b:1988:: with SMTP id mv8mr3170235pjb.23.1600157786660;
        Tue, 15 Sep 2020 01:16:26 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id x19sm10539429pge.22.2020.09.15.01.16.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 01:16:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/3] io_uring: Fix remove irrelevant req from the task_list
Date:   Tue, 15 Sep 2020 16:15:51 +0800
Message-Id: <20200915081551.12140-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915081551.12140-1-songmuchun@bytedance.com>
References: <20200915081551.12140-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
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
index adaafe857b074..2b95be09c0dad 100644
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
@@ -3716,15 +3714,16 @@ static int io_uring_fasync(int fd, struct file *file, int on)
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
@@ -3734,7 +3733,7 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 		 */
 		smp_store_mb(req->flags, req->flags | REQ_F_CANCEL); /* B */
 
-		if (req->work_task && (!files || req->files == files))
+		if (req->work_task)
 			send_sig(SIGINT, req->work_task, 1);
 	}
 	spin_unlock_irq(&ctx->task_lock);
-- 
2.11.0

