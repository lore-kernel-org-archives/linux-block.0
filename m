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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A64C433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 05:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9553622581
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 05:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbhAYFG5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 00:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbhAYFGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 00:06:52 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FDCC061573
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 21:06:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id p15so7633154pjv.3
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 21:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uxBG5rtv9eW/8VYKo6wzb+Eo7+2F6XEBqRP2xPkeqHs=;
        b=clHluVjahHYJNKc/rHi/oC2Nbu4d3BBqgo3XgM8Plr1J2DZGkKTPfDvGq9AdL+v6qa
         69yBn1ZRLDanA9tgZKLUt6wg1kR5Nxl6jIlZ45y5LR8wnB9BgUTlBF5Ua1XK7HsIIIvL
         RibbSy2ABc3+wRlaUwV91C8Bt2XE9MMePmNV8ZBjDQyV0SdEigxr6irihodaoXGev45N
         n78uuniCNiBQAGbd9mfg856YoyPylDPs/XLNYfc8uhHWuNtUBasF8BcflUO73uAF2uvM
         P8a2J5QH1kKBuoeiQ4y6TLER6IMoeLPcW0pj3PZkIafq8VwPblYKBc7JnZfT8FF9DEu/
         qJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uxBG5rtv9eW/8VYKo6wzb+Eo7+2F6XEBqRP2xPkeqHs=;
        b=WQ3fTvizB9VHp/Q2FOgQWOkkUsZNzQ3D5GsfK9J1WOluHe+hgxsRiMSupTWLjMxt4/
         /VVhA9eHVHTZTve02Dpwv/rIPHm8oPL9bX8FhP2gHG3+pgNJBbvCc1neSHnyBbUMQicP
         O260VkhT93iQ5j58rym1BfzfmRe8ykOkZ5R/HeZs76E9xFs3n9hNi4MnUfLwoqGvSfSB
         5NwF+1eFqJQXuLceQDaSBVn5YrJ3lPr9sSVjG9jfzqIJv6cRYJdwGJ/jlJmuAKFiBHM5
         KqeT+tM/WAqt2tY+UqrrMm039WGLi2dF6VCaSfmozWmOX8MVLw0fE4RhdvJTlk3gA9eB
         MCEg==
X-Gm-Message-State: AOAM533z+CEMLaDozSoAmUuXMPzZcivxfNWQX68GHHAwWA8I5DNpt9Rf
        JtMGH1Yj1pX2SFY4qI274C0=
X-Google-Smtp-Source: ABdhPJy1XKLDKcuoqL4RCrDk1mB3LCKGALVGl3smfeexAOp3anHgP2QbFmEcw/bPELAIYVmpcwdYfg==
X-Received: by 2002:a17:90a:ab88:: with SMTP id n8mr5334100pjq.70.1611551171476;
        Sun, 24 Jan 2021 21:06:11 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id v8sm7267374pfn.114.2021.01.24.21.06.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jan 2021 21:06:10 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH RESEND] blkcg: delete redundant get/put operations for queue
Date:   Mon, 25 Jan 2021 13:05:28 +0800
Message-Id: <1611551128-1238-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

When calling blkcg_schedule_throttle(), for the same queue,
redundant get/put operations can be removed.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Acked-by: Tejun Heo <tj@kernel.org>
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

