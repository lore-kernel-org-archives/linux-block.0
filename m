Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EC3C49EA6
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 14:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E3C61168
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 14:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhFSOMa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jun 2021 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbhFSOM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 10:12:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57529C0617AF
        for <linux-block@vger.kernel.org>; Sat, 19 Jun 2021 07:10:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i94so14109900wri.4
        for <linux-block@vger.kernel.org>; Sat, 19 Jun 2021 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cCR55PjBCxLhmDeRiMz3VW8PhgOXFh9It9QkVb9bRw=;
        b=vB4npVjdGxwWpcaRlFlkzRxBN5FdGeJmtFaJf1MtlnLibr9K/cUlP3YkQFTkXwjPnn
         ddYR6Spaxh4CrqL3qzJ/HYwoMT/S/qITSUcnAUlT1doT68fMFe67BdAg5maPUfftwhgh
         0NTC/1oAQOwSNKq0MvqsMGggjTpjaTUGC9u+LXRVdvOVcEnJsVYdQZV9nyugRYTR3UoK
         DEPmbEns9CkiqeCegRDUU2cwlAz4BxiyL1/UJHCT1l0vhJt6KDVxXqcq6KaVhf1Nq+nD
         k/oNw1urCNuBl212a9e8oz9d6FmdMp7TcSXme4NTXk32yo2a+MSgRiJOlfNgThicDovk
         At7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cCR55PjBCxLhmDeRiMz3VW8PhgOXFh9It9QkVb9bRw=;
        b=NoWVjpmJTgiJwZgYSa9ucbSvDNMS2RyizS9yvfRZJ13QsVPqoYiIQLlG0cs13eOQfJ
         4/PTT4gRFKGWi8CQWUlY4xc9jsiGWyoA4/cNyfscR67U66kxi28hqzXGtdvIN4ANBtEy
         H5LETivquONT/a9/Z/Kmi3KcG9fngzQBbHlEtqS25eYUvr5r60LWiLAP4zWSWM1GZsqg
         +O3lnxYGftbmmxyQF6IbYBA83AH6O/unabrc8xarnR90EjdSqip+uPLkfU4/nIOr0NLa
         Tt03ey9e3gudposRTGmJNbMjOsTDQXlaQhqo1uNCOoiJm+vW7EtzAiqDuXEr2QdkkcS6
         WaXA==
X-Gm-Message-State: AOAM533nVYZtUH6daPPWHfYOz8bb5wbccfuOMS5zLdIYbZPmqkvk9GEs
        k0mN41j7TvRkEDmb9ZTWchq6Qw==
X-Google-Smtp-Source: ABdhPJxwoV2PPv/MIS7pll8TpR+IDqS0ZmIHCfRCw1PgHG4SfYvBesOjREgg3VRGRYou2JYS1IvGmg==
X-Received: by 2002:adf:fac6:: with SMTP id a6mr18330692wrs.251.1624111812978;
        Sat, 19 Jun 2021 07:10:12 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y16sm8379350wrp.51.2021.06.19.07.10.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 07:10:12 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH FIXES/IMPROVEMENTS 7/7] block, bfq: reset waker pointer with shared queues
Date:   Sat, 19 Jun 2021 16:09:48 +0200
Message-Id: <20210619140948.98712-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 85686d0dc194 ("block, bfq: keep shared queues out of the waker
mechanism") leaves shared bfq_queues out of the waker-detection
mechanism. It attains this goal by not updating the pointer
last_completed_rq_bfqq, if the last request completed belongs to a
shared bfq_queue (so that the pointer will not point to the shared
bfq_queue).

Yet this has a side effect: the pointer last_completed_rq_bfqq keeps
pointing, deceptively, to a bfq_queue that actually is not the last
one to have had a request completed. As a consequence, such a
bfq_queue may deceptively be considered as a waker of some bfq_queue,
even of some shared bfq_queue.

To address this issue, reset last_completed_rq_bfqq if the last
request completed belongs to a shared queue.

Fixes: 85686d0dc194 ("block, bfq: keep shared queues out of the waker mechanism")
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a273b2bcea2a..fedb0a8fd388 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6165,11 +6165,13 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 	 * of other queues. But a false waker will unjustly steal
 	 * bandwidth to its supposedly woken queue. So considering
 	 * also shared queues in the waking mechanism may cause more
-	 * control troubles than throughput benefits. Then do not set
-	 * last_completed_rq_bfqq to bfqq if bfqq is a shared queue.
+	 * control troubles than throughput benefits. Then reset
+	 * last_completed_rq_bfqq if bfqq is a shared queue.
 	 */
 	if (!bfq_bfqq_coop(bfqq))
 		bfqd->last_completed_rq_bfqq = bfqq;
+	else
+		bfqd->last_completed_rq_bfqq = NULL;
 
 	/*
 	 * If we are waiting to discover whether the request pattern
-- 
2.20.1

