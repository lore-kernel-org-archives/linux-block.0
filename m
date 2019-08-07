Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13014C32751
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDB121E71
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s487BfnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbfHGOSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:18:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35041 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfHGOSK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 10:18:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so241741wmg.0
        for <linux-block@vger.kernel.org>; Wed, 07 Aug 2019 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkeCGHY0DrsSxD9DKRdcnC2Wr0bb+DymKOjtK802aV8=;
        b=s487BfnVB9DFRp3LPdjVxRcYZly5YMoGZEBCfc4Yk3Hs9KDNnZp/jkEHPUUrLPNVG3
         22uvC0GjMLtxHzpnrmH7k6IQ5EMXulSzuzzEeZ+TMPpXRsM4Cy3q9X03+8x+lXnO8Q0W
         wvAGp6vk06yhqPgWh7GJ9aU0iNmuzyYJv9CwoZBkxC+7m14HlpyA5RmRFBLmj5qrwJ4F
         ThM4d4PIwnK7kYhw5T+tfJJO1O7m0Mps2/BVDGzUn/rxYMUwJTptf6n2oWzhBwxlGf8S
         XjbswJu8iiM2PFjuwp+Wn/jsK5ShQ/5zx1PodtxwKmgV0tUjPBAAxoAvlIEYsDuff5yz
         Zjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkeCGHY0DrsSxD9DKRdcnC2Wr0bb+DymKOjtK802aV8=;
        b=XkBx1HANh+CovTRjMK3/5SySfZXGQjjwsHVYHABaWYL9yTLszzJbb8cn4pZj24+QQo
         bg8+bxA0lhsYCpOLSTG/gNxfVYPDY88ePmEVyPGmmrcqCnbIDRhOFl9YG31Pi/2d3Tfq
         brHyKU09Y0R1YO3X+t1esQ/ctOZ7kd/szMRPNYDKGvbYUinp2WlljYLo7nsJg/3V5x4W
         zmKmCeO0hYsOlkW4wftsmJiq1gg8UctuPjWCM3M7ucjINzhF/DOn5oW6+qVRn7kAnTx4
         gv0i8CrgdGYC9vFi4XHqP/dKNNwlZexYQqtOUrbFz4wUHtD7YfBJlPX3MkiVjID9UFZf
         /RUg==
X-Gm-Message-State: APjAAAUhwBe2Y3pYNwTmhiJn7dgMAj530/Nj66sklYqePE4gyPp9vEsr
        6vP3JkYYUnR6e2LF6I1CYyBp4g==
X-Google-Smtp-Source: APXvYqxBikW160o/IgvXRE2/Rs7ztL0oE2L/3/w6NtjyBftI6H8FuCL2HWhs+cOtNBrQvERchRk0Hw==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr204052wmh.55.1565187488110;
        Wed, 07 Aug 2019 07:18:08 -0700 (PDT)
Received: from localhost.localdomain (88-147-66-140.dyn.eolo.it. [88.147.66.140])
        by smtp.gmail.com with ESMTPSA id o7sm83472wmc.36.2019.08.07.07.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 07:18:07 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        pavel@denx.de, Paolo Valente <paolo.valente@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH BUGFIX 1/2] block, bfq: reset last_completed_rq_bfqq if the pointed queue is freed
Date:   Wed,  7 Aug 2019 16:17:53 +0200
Message-Id: <20190807141754.3567-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807141754.3567-1-paolo.valente@linaro.org>
References: <20190807141754.3567-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 13a857a4c4e8 ("block, bfq: detect wakers and
unconditionally inject their I/O"), BFQ stores, in a per-device
pointer last_completed_rq_bfqq, the last bfq_queue that had an I/O
request completed. If some bfq_queue receives new I/O right after the
last request of last_completed_rq_bfqq has been completed, then
last_completed_rq_bfqq may be a waker bfq_queue.

But if the bfq_queue last_completed_rq_bfqq points to is freed, then
last_completed_rq_bfqq becomes a dangling reference. This commit
resets last_completed_rq_bfqq if the pointed bfq_queue is freed.

Fixes: 13a857a4c4e8 ("block, bfq: detect wakers and unconditionally inject their I/O")
Reported-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 586fcfe227ea..b2009650afc2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1924,12 +1924,13 @@ static void bfq_add_request(struct request *rq)
 		 * confirmed no later than during the next
 		 * I/O-plugging interval for bfqq.
 		 */
-		if (!bfq_bfqq_has_short_ttime(bfqq) &&
+		if (bfqd->last_completed_rq_bfqq &&
+		    !bfq_bfqq_has_short_ttime(bfqq) &&
 		    ktime_get_ns() - bfqd->last_completion <
 		    200 * NSEC_PER_USEC) {
 			if (bfqd->last_completed_rq_bfqq != bfqq &&
-				   bfqd->last_completed_rq_bfqq !=
-				   bfqq->waker_bfqq) {
+			    bfqd->last_completed_rq_bfqq !=
+			    bfqq->waker_bfqq) {
 				/*
 				 * First synchronization detected with
 				 * a candidate waker queue, or with a
@@ -4808,6 +4809,9 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 			bfqq->bfqd->burst_size--;
 	}
 
+	if (bfqq->bfqd && bfqq->bfqd->last_completed_rq_bfqq == bfqq)
+		bfqq->bfqd->last_completed_rq_bfqq = NULL;
+
 	kmem_cache_free(bfq_pool, bfqq);
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	bfqg_and_blkg_put(bfqg);
-- 
2.20.1

