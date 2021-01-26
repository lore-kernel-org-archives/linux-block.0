Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECB2C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27749230FD
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 10:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbhAZKwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 05:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404468AbhAZKwc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 05:52:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6489BC06178A
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j18so2037106wmi.3
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldZICOD4+ui/kUfiZ0vMoBvq1PCCAphXE29xFBVIlys=;
        b=G7ICBg/HX4w9a1GqJB27JAqz8cc0X+kgoIkcDQuZenp2gsTZ6mTqoSdCRx2eU+IwKP
         f5wj1S20RZAybyxk4/MFclkHANhWhRWHb/fcC4gAASOO2hG/iGRZh2GMekfcgoHqVe2H
         ZTqQPDHc32sLwRfFBznLHU/4kV7jbB5EXWGbJM/81ppffPe6nEeV9ZCATOM9/BNrjTaO
         stBVUNGL+6fVd5urSrOyGPEIsWOU81GNcrsGKozsA63vc2nkttojVn8rcOJM1SitPMIP
         mu/yrZvXFY0L5bTAml5HRVLfAWeX1zPB0dapun8rAPq3RsVhHhEHXmvzzUH3MmLz/vm/
         t2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldZICOD4+ui/kUfiZ0vMoBvq1PCCAphXE29xFBVIlys=;
        b=mn8qzA294rdD4pgY9M6UoY2EfzVHqkP11oJQ8NkaEe5EFSkOO6ccAUxIi33u+Ds8VL
         buGg4PgmEgnQqs91jWvQrUkWGIhjRRRyMA9Wvcioe5grIceTgdjmqBSF2A8USuNo6TnU
         1IvPileLMNXJsJ9lFGKOhFIstpE7jqEJtZsglX+DpQD60sb7Nuckz/w6o1weYxFwkz85
         cesuRo+XP+C0YtFCMNHSb5gSXkLK3G2V+QHDkiAEBoLGtyyick0seoz5wfpHwY+Lzbje
         eMAebrZEjmei9Keh+TCPebVYmlq9/HiAnhiA+cl9GF4ZKcqjAxJXEyFZp8MF5KwtpPTv
         k7Bg==
X-Gm-Message-State: AOAM532e6OxF5u4D7Gznsahud5FSgd7YfYlRZ5Sski/3RSvQER1id1/9
        GhI0uoyMwoAkmc+X6jpYBbIZww==
X-Google-Smtp-Source: ABdhPJwJW9GfocdFPmrjj+lUfufIOZMzP5Wi4MiM4O4hzEq21ri6ywTRe8vvpEuZThiA0f+A54Zg1w==
X-Received: by 2002:a1c:5456:: with SMTP id p22mr4111219wmi.81.1611658280142;
        Tue, 26 Jan 2021 02:51:20 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:19 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 2/6] block, bfq: put reqs of waker and woken in dispatch list
Date:   Tue, 26 Jan 2021 11:50:58 +0100
Message-Id: <20210126105102.53102-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126105102.53102-1-paolo.valente@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Consider a new I/O request that arrives for a bfq_queue bfqq. If, when
this happens, the only active bfq_queues are bfqq and either its waker
bfq_queue or one of its woken bfq_queues, then there is no point in
queueing this new I/O request in bfqq for service. In fact, the
in-service queue and bfqq agree on serving this new I/O request as
soon as possible. So this commit puts this new I/O request directly
into the dispatch list.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a83149407336..e5b83910fbe0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5640,7 +5640,22 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
-	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
+
+	/*
+	 * Additional case for putting rq directly into the dispatch
+	 * queue: the only active bfq_queues are bfqq and either its
+	 * waker bfq_queue or one of its woken bfq_queues. In this
+	 * case, there is no point in queueing rq in bfqq for
+	 * service. In fact, the in-service queue and bfqq agree on
+	 * serving this new I/O request as soon as possible.
+	 */
+	if (!bfqq ||
+	    (bfqq != bfqd->in_service_queue &&
+	     bfqd->in_service_queue != NULL &&
+	     bfq_tot_busy_queues(bfqd) == 1 + bfq_bfqq_busy(bfqq) &&
+	     (bfqq->waker_bfqq == bfqd->in_service_queue ||
+	      bfqd->in_service_queue->waker_bfqq == bfqq)) ||
+	    at_head || blk_rq_is_passthrough(rq)) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
 		else
-- 
2.20.1

