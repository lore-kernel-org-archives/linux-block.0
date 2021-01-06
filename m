Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5864C433DB
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 05:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C4B22CAF
	for <linux-block@archiver.kernel.org>; Wed,  6 Jan 2021 05:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAFFFE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jan 2021 00:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFFFE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jan 2021 00:05:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C4CC06134C
        for <linux-block@vger.kernel.org>; Tue,  5 Jan 2021 21:04:24 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b5so978834pjk.2
        for <linux-block@vger.kernel.org>; Tue, 05 Jan 2021 21:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tNOPfD4c9xC4JU0sv7YNkOGrtP2x/JJ9yLr1Lzz8dr8=;
        b=uBz+oOPhq4lKe4uq8+gplxpEnlQ7vEBW1RhMwim94AVBVsigaxpIj8jiLIANEq1bax
         ZythFAvNBDtP6qvsKqGarJYHZ3dxEUv2Y8rzJEag7GKXsRvPv9agIGbtPpIIn/cBephQ
         jDKrNkBfVeIrzUQ1z+DeM18Uoa4Pw/6nrbj5+D+N9Pzz7104patPiC5Q64KmKpyRI2BL
         df+tQzSkgzUtndoyAI/bxUPhV6GAn1Udm6Fg2bA2BONiUqVHGF5TYbBB7aVj4FmzBhP1
         VuI7+93FozNTd+F782tzkWRbQi6Y+aB/WNtZDhPPZKPsTrt8CqHeCbujEJi7csDzCMhw
         moNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tNOPfD4c9xC4JU0sv7YNkOGrtP2x/JJ9yLr1Lzz8dr8=;
        b=q2pxxzK3DPbxccz1QNn2coks/C1kkLbae1HUJ1fFtopllHrwHee8SD0Yzgq1vE5RuB
         UamxuDfVLgg7I5UpWUtmpcSvGRH9qJ53pCMrPyiYRj5mgtFh25ciJoCPwAfmagW6BuJG
         osiw7Tqp2MBJGUamQaaldb2A5BPLTnSRd0iY2Ys3zzRC0DG2uszVLM1AHCBdnuSj4GAP
         icfZHOfW56PPA/NxTh0QpZiVy1wyeBszfWYOHrCg/lqHm2zy0vUNulKrCQ+JeIoIZDc6
         pbEVp4k7xhaa0y0h29HiErnNSoFWKnsrnrTpwuKu6BU7yviPDfeUbxUTAMWW7HbvBYFY
         2WDw==
X-Gm-Message-State: AOAM530Vy3LIlRkKxoyXIMowFEA5L0mIXaKkXc3tt06Wn87aA3mo4hjO
        OEGHtPXIS88jfXhlXsY01ZA=
X-Google-Smtp-Source: ABdhPJyjDk5oT9EZu7PBPIO4PWMo8dKTZ7EqX6CHcKOIT1hwWBUBS4aCYk7+JnL0o865q+G9JQE55g==
X-Received: by 2002:a17:902:b7c3:b029:da:76bc:2aa9 with SMTP id v3-20020a170902b7c3b02900da76bc2aa9mr2503554plz.21.1609909464005;
        Tue, 05 Jan 2021 21:04:24 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id q23sm916628pgm.89.2021.01.05.21.04.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 21:04:23 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove redundant get/put operations for queue
Date:   Wed,  6 Jan 2021 13:03:41 +0800
Message-Id: <1609909421-3487-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

When calling blkcg_schedule_throttle(), for the same queue,
redundant get/put operations can be removed.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/blk-cgroup.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 031114d..e9b264b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1757,12 +1757,15 @@ void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
 	if (unlikely(current->flags & PF_KTHREAD))
 		return;
 
-	if (!blk_get_queue(q))
-		return;
+	if (current->throttle_queue != q) {
+		if (!blk_get_queue(q))
+			return;
+
+		if (current->throttle_queue)
+			blk_put_queue(current->throttle_queue);
+		current->throttle_queue = q;
+	}
 
-	if (current->throttle_queue)
-		blk_put_queue(current->throttle_queue);
-	current->throttle_queue = q;
 	if (use_memdelay)
 		current->use_memdelay = use_memdelay;
 	set_notify_resume(current);
-- 
1.8.3.1

