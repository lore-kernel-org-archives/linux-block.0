Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150AEC77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjEPWjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjEPWjA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:39:00 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C06199
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:38:59 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1aaf70676b6so1296705ad.3
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276739; x=1686868739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbTl2fwmxxba7nVg2C7zBSYx8NZ8xgbjj9t9Aqkh8Fs=;
        b=fdBk4YJSEt1pZZpA/qrk5zcCxxAeuiyUp/fE3fcpG/KswwnrK4QtXItqzgmvZo8rnN
         zDnhuP532EJc5IRYYMfxAGxyQYoaHV5tjkDq6pQ/V6E5vgL5K/9Lh0Ik9tDrwg0MD8xf
         BCNMlP+5bcpJ688gg00TE+E1TGxODzW/qwbkY02qQfF9UOgii44QFiw0R6nhNR+gFm6o
         e5F4Cnwkb284bKq74PsUoSzxNleZ1vl4n1URzZxbTvrMwWr8Dc1/dVuWvmgvGwfaPM5g
         f1Ts5mP33oJVSN3PCsEXImsOxwdkOop4DU9A5c97SPrRVHj7KVRZ4R0uj9CYi3xurzme
         b+Cg==
X-Gm-Message-State: AC+VfDxkijpNZU0bMcQjlgATTus73JTaVyv47hhXxKtSWzAhqG3yNA4I
        XLiQaRzkzEmmC7+5PF8hwaU=
X-Google-Smtp-Source: ACHHUZ5/Hh9X78Mquwqwb1/dUmqKiP3wBGmT8lwk4Kh/mjs+HruND8TPlxEX+nWlsR7yZ4iU67hIRw==
X-Received: by 2002:a17:902:b7cc:b0:1ac:3ddf:2299 with SMTP id v12-20020a170902b7cc00b001ac3ddf2299mr39030768plz.44.1684276739374;
        Tue, 16 May 2023 15:38:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id fu11-20020a17090ad18b00b0024df400a9e6sm86725pjb.37.2023.05.16.15.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:38:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Jan Kara <jack@suse.cz>, Yu Kuai <yukuai3@huawei.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH] block: BFQ: Add several invariant checks
Date:   Tue, 16 May 2023 15:38:53 -0700
Message-ID: <20230516223853.1385255-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If anything goes wrong with the counters that track the number of
requests, I/O locks up. Make such scenarios easier to debug by adding
invariant checks for the request counters. Additionally, check that
BFQ queues are empty before these are freed.

Cc: Jan Kara <jack@suse.cz>
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-iosched.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3164e3177965..c5727afad159 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5403,6 +5403,9 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 	if (bfqq->bfqd->last_completed_rq_bfqq == bfqq)
 		bfqq->bfqd->last_completed_rq_bfqq = NULL;
 
+	WARN_ON_ONCE(!list_empty(&bfqq->fifo));
+	WARN_ON_ONCE(!RB_EMPTY_ROOT(&bfqq->sort_list));
+
 	kmem_cache_free(bfq_pool, bfqq);
 	bfqg_and_blkg_put(bfqg);
 }
@@ -7135,6 +7138,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 {
 	struct bfq_data *bfqd = e->elevator_data;
 	struct bfq_queue *bfqq, *n;
+	unsigned int actuator;
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
@@ -7143,6 +7147,11 @@ static void bfq_exit_queue(struct elevator_queue *e)
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	spin_unlock_irq(&bfqd->lock);
 
+	for (actuator = 0; actuator < bfqd->num_actuators; actuator++)
+		WARN_ON_ONCE(bfqd->rq_in_driver[actuator]);
+	WARN_ON_ONCE(bfqd->tot_rq_in_driver);
+	WARN_ON_ONCE(bfqq->dispatched);
+
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
 	/* release oom-queue reference to root group */
