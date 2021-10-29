Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D0C433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 20:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98E5604AC
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 20:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhJ2UcY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhJ2UcW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 16:32:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB18C061570
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 13:29:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j21so19587214edt.11
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShYiVfE/eyJoJkHw/xgSf+q4u1l5KZNBbgPEz8ztBHU=;
        b=mT0O2rDLCePPZAC05+hpMPhhTUXC2btNrX9grZTcYj/pAOz7UdVWy6IEqXTm+j/ANi
         44O3loYGzVD9KJnIhuy6y2/5Q9wSsMXKaY6aBfp9X54dTJqGH8HSwDp6/HfPegsoPV6S
         OEqYl6E7rzuMzAa7HIj37CcOf+C9zRIHHH3Cbsu19TRzeXtGWfZ+5KU88AD3WUyShGl/
         u2P8Bgg2jSnuu7331CLxdWVqckY9RHuUysR4hpsIxOzEQwv4sH25Ha6te4JZgjxdrjPt
         /2zNlhP7uhKjsFA8aIAUVrxS1JW8afRzm9UGmWf61i6bD5kTMjtOMBTzKA87uh7UhbUD
         3HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShYiVfE/eyJoJkHw/xgSf+q4u1l5KZNBbgPEz8ztBHU=;
        b=G1od+rwh4SJNt3uFI6eBfs5VhQe5CcmKMaztDJ6Wvv3zRnVwMVUmRXuVnAeN5EyMqg
         jcwFjR7oJPVTQug1ifdIuz5w59OnlkS6XMen/BrWrXA5Mq6Ni2zqOnKNQgxkp7XqbOJz
         uBx8bCMMFUtM0R5EkpxRrpRAc+TyvsWh89qezmGPO7va/SUUqmT1LDgLq/6nprLcFjXD
         ousb/YvpNmGiYHg4oN8MRYXlf1GKg1kHyVEeqjl/yCMATz2e/8stmZchv3qUavmd9DJe
         eHAW328XgikiAqcGqzxzB/WR1F/3xmjHU51CXgpyldm+G356rI9FZjT+hrR1e2tKoc2X
         /Cyw==
X-Gm-Message-State: AOAM533Kgkdt4uQOvVnuehX29bzT9qPOR747jWnuqHkTMoHdyBv0/w/d
        nbpLDpijjnIk2anXc8TzL0YUepZygnU=
X-Google-Smtp-Source: ABdhPJzocvhwzwlOtQBQdhjlEdsYmQTXfVY5lKYt7+ijjx+U3EDeceno1mnfCVr9YhRHUkcUTrxGBw==
X-Received: by 2002:a17:906:314e:: with SMTP id e14mr16313143eje.165.1635539391565;
        Fri, 29 Oct 2021 13:29:51 -0700 (PDT)
Received: from localhost (tor-exit-62.for-privacy.net. [185.220.101.62])
        by smtp.gmail.com with ESMTPSA id z1sm3994652edc.68.2021.10.29.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:29:51 -0700 (PDT)
From:   =?UTF-8?q?J=CE=B5an=20Sacren?= <sakiwit@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH for-next] blk-mq: fix redundant check of !e expression
Date:   Fri, 29 Oct 2021 14:29:45 -0600
Message-Id: <20211029202945.3052-1-sakiwit@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jean Sacren <sakiwit@gmail.com>

In the if branch, e is checked.  In the else branch, ->dispatch_busy is
merely a number and has no effect on !e.  We should remove the check of
!e since it is always true.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 block/blk-mq-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0f006cabfd91..a38d4dd32516 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -502,7 +502,7 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 		 * busy in case of 'none' scheduler, and this way may save
 		 * us one extra enqueue & dequeue to sw queue.
 		 */
-		if (!hctx->dispatch_busy && !e && !run_queue_async) {
+		if (!hctx->dispatch_busy && !run_queue_async) {
 			blk_mq_try_issue_list_directly(hctx, list);
 			if (list_empty(list))
 				goto out;
