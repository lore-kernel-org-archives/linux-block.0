Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB63DC48BD7
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9464E2085A
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1UbVuQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfFYFNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:13:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38135 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfFYFNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 01:13:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so1435016wmj.3
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 22:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDUKv8YUyogiDpRRrW1kMLdeBfpgWpL6nQUelcgrRGk=;
        b=P1UbVuQAQAxdEuobXFG66avtxb07lOHKpDbpTaxKfsxl05uYaz7+ztqWh3qTSOslXw
         rsOUdD4c3nDgaH4dPRY1Mr9udMkIN9CpzscP/Svrwe2NRK3B2O1dJ7lGN/ROvgyDU6Sk
         PnAf1ulxThb8PdJfbojGyLcuMOsJmQKGxa0bsal6Z3DGKXhnR1JRhVPTu2wAs7ZT5bfT
         h58RYIHsHZ0zTgei4x0GDZKaUIQEW4qwMVhzN2ImIcPQSv358AkUzeFIPgTt3tFXgau+
         OuazCdzSt6jUbFR/NqxSWpO1k9EGsUPYn1OBDGTdT8/eso7X+JIGh9tayMVvcme5uXNS
         4KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDUKv8YUyogiDpRRrW1kMLdeBfpgWpL6nQUelcgrRGk=;
        b=lJZxHeo2f9d5pgBYiY+6dcu0g65ZauAMpmjNAMzjD4vA4sDEdrpDJt0TBbohwJk7wc
         p454lY1JG/XaZb7FfH6qulABoexVs0UoLd6aDuOi9pvUlGHik+qrUAUa9Wwqyr1zXN54
         5e7H88Fs3Oc7p+fihXx0mO1uHPXtlTb1nzcAQF2VXPMxSlmfuut41FDMwcn9jkr1Bm2U
         9EcT35lyoVmq/Ex83c8DYvYgS/618GWSPUqKu7rUNZIbIlb5WmbJ0+QTayij+L0P366h
         o1YoaD0zHPutE8/fR2KgCxUzSs5Esz/wptiPSL83PV7z+ySV+8UZj6t39viPYJo79qXg
         ME6g==
X-Gm-Message-State: APjAAAXGNBo+iIV2lte4m9G2gmLqAI+r0iPxCcsoWnQC0zZ5DrX4liNR
        VwnbCQlWLuY4Qa9nvt6gjQUfFQ==
X-Google-Smtp-Source: APXvYqye9+BosaBHq2W3kVdYV/oWBvsbLFzXFJY8xj1nm51j3plSV51adEqi9N6ZJ3ylPkhnQ3bnmA==
X-Received: by 2002:a1c:a6d3:: with SMTP id p202mr19024488wme.26.1561439588831;
        Mon, 24 Jun 2019 22:13:08 -0700 (PDT)
Received: from localhost.localdomain (146-241-102-168.dyn.eolo.it. [146.241.102.168])
        by smtp.gmail.com with ESMTPSA id q20sm28543149wra.36.2019.06.24.22.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:13:08 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 4/7] block, bfq: bring forward seek&think time update
Date:   Tue, 25 Jun 2019 07:12:46 +0200
Message-Id: <20190625051249.39265-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625051249.39265-1-paolo.valente@linaro.org>
References: <20190625051249.39265-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Until the base value for request service times gets finally computed
for a bfq_queue, the inject limit for that queue does depend on the
think-time state (short|long) of the queue. A timely update of the
think time then guarantees a quicker activation or deactivation of the
injection. Fortunately, the think time of a bfq_queue is updated in
the same code path as the inject limit; but after the inject limit.

This commits moves the update of the think time before the update of
the inject limit. For coherence, it moves the update of the seek time
too.

Reported-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Tested-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 62442083b147..d5bc32371ace 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4979,19 +4979,9 @@ static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
 static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			    struct request *rq)
 {
-	struct bfq_io_cq *bic = RQ_BIC(rq);
-
 	if (rq->cmd_flags & REQ_META)
 		bfqq->meta_pending++;
 
-	bfq_update_io_thinktime(bfqd, bfqq);
-	bfq_update_has_short_ttime(bfqd, bfqq, bic);
-	bfq_update_io_seektime(bfqd, bfqq, rq);
-
-	bfq_log_bfqq(bfqd, bfqq,
-		     "rq_enqueued: has_short_ttime=%d (seeky %d)",
-		     bfq_bfqq_has_short_ttime(bfqq), BFQQ_SEEKY(bfqq));
-
 	bfqq->last_request_pos = blk_rq_pos(rq) + blk_rq_sectors(rq);
 
 	if (bfqq == bfqd->in_service_queue && bfq_bfqq_wait_request(bfqq)) {
@@ -5079,6 +5069,10 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		bfqq = new_bfqq;
 	}
 
+	bfq_update_io_thinktime(bfqd, bfqq);
+	bfq_update_has_short_ttime(bfqd, bfqq, RQ_BIC(rq));
+	bfq_update_io_seektime(bfqd, bfqq, rq);
+
 	waiting = bfqq && bfq_bfqq_wait_request(bfqq);
 	bfq_add_request(rq);
 	idle_timer_disabled = waiting && !bfq_bfqq_wait_request(bfqq);
-- 
2.20.1

