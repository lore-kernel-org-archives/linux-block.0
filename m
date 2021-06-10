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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B756C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640F8613C9
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFJHZm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:25:42 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:37857 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhFJHZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 03:25:39 -0400
Received: by mail-pl1-f182.google.com with SMTP id h12so508339plf.4;
        Thu, 10 Jun 2021 00:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GxLL6QnmEPTEzqADHSi/TrcJeIj4iMdkXLkWOx3ig7I=;
        b=Vcj2iPzdqscLRGdr+q354xSBqw6bXuq9O5vYlPsWUBaS48a/P9zzT1XqICMHISNEaf
         sTK2VU1i0ZOAh85T0vorfHzlHUgu6d7uzFnIc3DslGB9JnBmYFWo6A2D27onhz1n8RnS
         thyrcm3uJ/EzaZWOY0EI/AGN6McVByhFOCrZxBKy8IcZ7xgxNJ3Igg3tQH+5uroE2yLr
         v3s/DahvZC/UeppYPHuk0FoKzUHGXWXd74cAMJlPNafoCyLTJiE6yIn4xYzPCh+60J/l
         LZnfiSZ3naUUDqGB+S+vmgIaYwPtrv9U80a/UoYgpiH/SxFDeAoKa0i7GxJXV5BVUgKa
         YOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GxLL6QnmEPTEzqADHSi/TrcJeIj4iMdkXLkWOx3ig7I=;
        b=h9zSYDgC9JgawwO1bhNKrwE/Z9URc+WEmhHrcjh4qsf/xixEKTDDDj0co6FAL73Ddv
         X2WwHRTQYpO3OPjeG5pVpLh5Sabh0hpTHqyeiG2CSDaBAYMmEI/jqHzs3rty/d4AJUR9
         p3si9F0lEUBTRLEJ06WqlJccFKDbnHq55ZFYSmx6BkSSw55/YXsTuMd/XG4tRbQ8QlU+
         Zo7QnSJmF7kRDIoP+pwCyP7eV3ZLi4oC9QYPvrkADnkd52JkFR91zgfEU5RRx7kz6gUv
         z2/XigROq5wlf2P62cCto/6zofW49Kq6EMHHxVJ7M3YPp52hxe9LavT7RkxL/Ga15N+n
         qEtQ==
X-Gm-Message-State: AOAM533Zm99LAUa7503U6R3o8kvbpJopNTS+Wk+I0HOBxijHqiOXIjzs
        4ZmDYpoufpMUaaQaHjRH3Uw=
X-Google-Smtp-Source: ABdhPJzTpsHkyCqWi/r5iKPtQH+F0Igw9fTmnl8q9J2nWrDMQAzlfKQfuAW/iIzKzK9KX6SBIYluSA==
X-Received: by 2002:a17:90a:3f17:: with SMTP id l23mr1919689pjc.229.1623309763612;
        Thu, 10 Jun 2021 00:22:43 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id u24sm1591310pfm.200.2021.06.10.00.22.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:22:43 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 3/8] bfq: limit the IO depth of CLASS_IDLE to 1
Date:   Thu, 10 Jun 2021 15:22:32 +0800
Message-ID: <34edd545a9f6f6b327fc6779fbd17fd3a519ed4c.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
References: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20210610072232.lT9oUiJ6U64HauWNK7SMhy2JbSaW-Y-GYlZoFFqf5LA@z>

From: Chunguang Xu <brookxu@tencent.com>

The IO depth of queues belong to CLASS_IDLE is limited to 1,
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
index ec482e6..29940ec 100644
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
1.8.3.1

