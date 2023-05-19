Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64EAC77B75
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 22:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjESWEJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 18:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjESWEI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 18:04:08 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34257114
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 15:03:59 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso1316271b3a.0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 15:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684533838; x=1687125838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FG9P6kp8DT2pC5HrNxWKUyP2fErJ5WR60bhX+XGSqE0=;
        b=WQVYzWdcqv1OjMCMifRp7HyTddT1yob1K3vyrrfhKd/deKOH0Yr6V591jPpFQaMDMC
         iw0FkiWV5WRpZ2VdGXQ6QRHdqX539383ZXghXYESpGuRvqMluvflxJB5F4rSfUzqyrB/
         HPAGSGwmd0ie6rqP0DRQi8wDFWry4/K2JVvPXWKNPkjVRIz9+U0Zc62B76L13dKbSF5A
         J9tIcLC5bTQwoLt5bAj5dhU4AZ6Z4YGfgviu54ymF5uf4e/4DPrXnTKbPDF729PVU/qD
         MKtr+EScvnZ33gkPHmJBxS/9JVs5BWKrteJC4kBxGtYtIhIjEYv3BZemT7YklWoOgfax
         KqBw==
X-Gm-Message-State: AC+VfDw5znHVIuxZzNyUVs6kjTwuc+GMw8R22yC3yY6yuNNafkeGjfWA
        sjmhnqGD+6cdveTLh7Hh4GY=
X-Google-Smtp-Source: ACHHUZ5LP62I6e9aS81Gk2c+pTe12jDuIHij2zz/OboXCZNIS1OId8IzMV4lgZ0nE7lblWvUjN4CgA==
X-Received: by 2002:a05:6a00:2282:b0:643:b263:404 with SMTP id f2-20020a056a00228200b00643b2630404mr5144471pfe.33.1684533838451;
        Fri, 19 May 2023 15:03:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b0064d32771fa8sm142114pfn.134.2023.05.19.15.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 15:03:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH] block: BFQ: Move an invariant check
Date:   Fri, 19 May 2023 15:03:46 -0700
Message-ID: <20230519220347.3643295-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Check bfqq->dispatched for each BFQ queue instead of checking it for an
invalid bfqq pointer.

Fixes: 3e49c1e4a615 ("block: BFQ: Add several invariant checks")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c5727afad159..09bbbcf9e049 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5405,6 +5405,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 
 	WARN_ON_ONCE(!list_empty(&bfqq->fifo));
 	WARN_ON_ONCE(!RB_EMPTY_ROOT(&bfqq->sort_list));
+	WARN_ON_ONCE(bfqq->dispatched);
 
 	kmem_cache_free(bfq_pool, bfqq);
 	bfqg_and_blkg_put(bfqg);
@@ -7150,7 +7151,6 @@ static void bfq_exit_queue(struct elevator_queue *e)
 	for (actuator = 0; actuator < bfqd->num_actuators; actuator++)
 		WARN_ON_ONCE(bfqd->rq_in_driver[actuator]);
 	WARN_ON_ONCE(bfqd->tot_rq_in_driver);
-	WARN_ON_ONCE(bfqq->dispatched);
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
