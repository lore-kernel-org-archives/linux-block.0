Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6ADC433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 00:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbiCHAEm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbiCHAEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 19:04:40 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41466344E9
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 16:03:45 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc1ce31261so139998287b3.6
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 16:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+EaaN9rrO3ntvRkcqCnT36NX3bdOataMRNYTDOWB4Hc=;
        b=lJQd7e3/lr+iipERF0USMu3L7FPdeoWWOBqyphwmo+CH34oFlfmCXIHP/OIgpx1gt9
         xxdz51I6tg0FVaFbCNjDleQRCDPdoLwd2konWOj7y2nmel2vgFzt6+CVm2EfbVGC27dj
         RoyUUoSQ85nVqnLq5Nvv+agVX9lrpJ8d1ByH8aQx4UnP+RnNcm7fnVl5UyjhGlkna3LF
         UvC5VYj+gnG9JM1aWtLGrXUq4tvdnez56p2Ou0glohHnuPD74vQXZyj4fBXzjX31P/w/
         TNjfFR+ePZ3ZPmyt4cb/qXx9iKkaR1OwUyGNIIgPLXYjp9HhZehMzOzTl50R0Qkrce//
         FknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+EaaN9rrO3ntvRkcqCnT36NX3bdOataMRNYTDOWB4Hc=;
        b=axHUyLS7jGJzFgpzE+72HdF22w+qcoE5yFH53/gfih3qwxjXyoUOrDxb2rLtZTyJmG
         Do7rHzxfqxTMqpzdGhuMci4eM4K8rZ7i8uNXXb8a26FvxA0JNn0xGqWuDPqZokd7sodC
         MfDHpF6bZq2My3r2Gpx06q1sn9xpJjrLMqewe1pOLyPlWJmU3P8jBWOpmBU7dh+l1e5N
         NI40fNYEkyRhWi+vmGDxV8guH2Tc38ZGqyCtSTMJhco0IgwUx3Itpt1UEQyjBLrXXIS9
         z6q/PnZqv9VXvDuieRmNkbrFosfr4j/R8r6RItmDLkkGiaOeWgKFZJWD8UD5++zffUru
         ACxg==
X-Gm-Message-State: AOAM530YZJt6hk8Aw6yNAIpz7P6wKN6qjdbJG8tNtR4yj/hNChkdxfj3
        YBgxKEzq/3XrgoIyRb1nL67wb1iy5e0=
X-Google-Smtp-Source: ABdhPJxOxCli3zIPDkGfJiqLTWAJLHb8P4M9PCUnTnb76hVlgOVnfnlLiDQDUTy18FLi5SiqTvhUuEmIeKQ=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:9113:6b5:b00c:3d40])
 (user=khazhy job=sendgmr) by 2002:a25:e54a:0:b0:628:b77e:5352 with SMTP id
 c71-20020a25e54a000000b00628b77e5352mr9911259ybh.445.1646697824483; Mon, 07
 Mar 2022 16:03:44 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:02:53 -0800
Message-Id: <20220308000253.645107-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] bfq: default slice_idle to 0 for SSD
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This improves performance on SSDs dramatically, and was default for CFQ

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 36a66e97e3c2..f3196036940c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7105,7 +7105,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->bfq_fifo_expire[1] = bfq_fifo_expire[1];
 	bfqd->bfq_back_max = bfq_back_max;
 	bfqd->bfq_back_penalty = bfq_back_penalty;
-	bfqd->bfq_slice_idle = bfq_slice_idle;
+	/* Default to no idling for SSDs */
+	bfqd->bfq_slice_idle = blk_queue_nonrot(q) ? 0 : bfq_slice_idle;
 	bfqd->bfq_timeout = bfq_timeout;
 
 	bfqd->bfq_large_burst_thresh = 8;
-- 
2.35.1.616.g0bdcbb4464-goog

