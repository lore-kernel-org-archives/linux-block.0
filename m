Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0600DC32751
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D065E22296
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Slbetn8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbfHGRV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:21:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55756 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbfHGRV1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 13:21:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so790635wmf.5
        for <linux-block@vger.kernel.org>; Wed, 07 Aug 2019 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2EJNQPnOEl3GZNAxpz5JJlhH5o76gr2JP/NdmhEjGs=;
        b=Slbetn8k4h8b+dLP23JOZzACY2KPtfhEdyy4tIy1t0kM6CLvwNMntuGC8OWdSosCwC
         Mn1hdHbI42z8YdGqz3QU3H5n2snOQDR/snOwPv52MyekKooNtPIfnm8/xJm1l0R1kd0v
         GB4Vw1raWpROllTv0w7r/AdyRxKhXb7T0BrhMDejdNdArhaNlj9/4IFqRsPN27rghRaR
         IroQlGR7jYdWs4YoT8GQbtavA8dOdKl7/jOIXcNFH4NePAZfTYGplEszVQK4o9k/HSoL
         65ECmXVSCxDJFQtPd4UuGfmfXGDqliW49oP8V/KGMXudqKR8YfhlR0rej4aMYD4dlDyC
         uKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2EJNQPnOEl3GZNAxpz5JJlhH5o76gr2JP/NdmhEjGs=;
        b=OFRvWjtKST0d9O207EtJLjmTTZTQrQcuNJp7gULys/9JRsE1B81mmBJgbgk6hklc9s
         Klf6bmMfo9/Pm+cg06nKAWAdav4GWWAzJ1dZhsIsj0nlhqGtnr2wmwQoq0R3sMd3vLXc
         BsJkJQKNpf6ydGdVEO6JOaV+8/vfzhF7GqnTYq7sJZoftNHEaGyhi6YZ3HgJ98c010yR
         Rwupje1HutAB5QsYm7p9WWg366hPMSrfTcHO2olHCk+TTBKprEEWVgrHuRNZSBlcVM1Q
         D/P2nC3lGEfYLAZPrXmIMmwJUQs7HrbNFJi0RzMq+WNQv0dlmEssroLuRhkcfmMlbPqc
         XBKw==
X-Gm-Message-State: APjAAAXJqH2aJ5KufBY1k2ab5x/okHTVe5uh8SKfWydsik2Tlc0yaPG8
        zHAFCZzgCnEVTzo5RaJmerdKuw==
X-Google-Smtp-Source: APXvYqzBdRIfE+HrknLNxY/zsTEgRLTff26RF5t3imH7y4D5rR5RbsMu8UTWdbsANsG2R+dUMRYXXg==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr920609wmc.13.1565198484766;
        Wed, 07 Aug 2019 10:21:24 -0700 (PDT)
Received: from localhost.localdomain (88-147-66-140.dyn.eolo.it. [88.147.66.140])
        by smtp.gmail.com with ESMTPSA id q193sm586773wme.8.2019.08.07.10.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 10:21:24 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux@roeck-us.net
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [BUGFIX 1/1] block, bfq: handle NULL return value by bfq_init_rq()
Date:   Wed,  7 Aug 2019 19:21:11 +0200
Message-Id: <20190807172111.4718-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807172111.4718-1-paolo.valente@linaro.org>
References: <20190807172111.4718-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As reported in [1], the call bfq_init_rq(rq) may return NULL in case
of OOM (in particular, if rq->elv.icq is NULL because memory
allocation failed in failed in ioc_create_icq()).

This commit handles this circumstance.

[1] https://lkml.org/lkml/2019/7/22/824

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Hsin-Yi Wang <hsinyi@google.com>
Cc: Hsin-Yi Wang <hsinyi@google.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 586fcfe227ea..32686300d89b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2250,9 +2250,14 @@ static void bfq_request_merged(struct request_queue *q, struct request *req,
 	    blk_rq_pos(container_of(rb_prev(&req->rb_node),
 				    struct request, rb_node))) {
 		struct bfq_queue *bfqq = bfq_init_rq(req);
-		struct bfq_data *bfqd = bfqq->bfqd;
+		struct bfq_data *bfqd;
 		struct request *prev, *next_rq;
 
+		if (!bfqq)
+			return;
+
+		bfqd = bfqq->bfqd;
+
 		/* Reposition request in its sort_list */
 		elv_rb_del(&bfqq->sort_list, req);
 		elv_rb_add(&bfqq->sort_list, req);
@@ -2299,6 +2304,9 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 	struct bfq_queue *bfqq = bfq_init_rq(rq),
 		*next_bfqq = bfq_init_rq(next);
 
+	if (!bfqq)
+		return;
+
 	/*
 	 * If next and rq belong to the same bfq_queue and next is older
 	 * than rq, then reposition rq in the fifo (by substituting next
@@ -5436,12 +5444,12 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
-	if (at_head || blk_rq_is_passthrough(rq)) {
+	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
 		else
 			list_add_tail(&rq->queuelist, &bfqd->dispatch);
-	} else { /* bfqq is assumed to be non null here */
+	} else {
 		idle_timer_disabled = __bfq_insert_request(bfqd, rq);
 		/*
 		 * Update bfqq, because, if a queue merge has occurred
-- 
2.20.1

