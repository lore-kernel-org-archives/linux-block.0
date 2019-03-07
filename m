Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB236C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3DB20854
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 16:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BiU1VLV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCGQ0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:26:49 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36356 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCGQ0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 11:26:20 -0500
Received: by mail-wr1-f45.google.com with SMTP id o17so18166608wrw.3
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUHw4uD/6PdjAyafvFS/vFaSGIdhMTKmdDdLyjrgLw8=;
        b=BiU1VLV7jOAsQD02bezreQzwIST1pRkoNjFNXNMIbkymkn6y1h3pGaiPA1uO5bH2tc
         cONVastuhjLUsr9yYGpMMEWqjG04/YeI0pJx2g9w5UdpvPEV9TEIFRNCqFwCRkGoU7SM
         5EIN1eo1fuCtsw1vF1jDOJvTvgzWRq3xSJqvy3zwSarw+l3WmHSpxHKJlCsUqpIdDweM
         NUAETypSqhLe60fcKAgBcNIM+d3Yc0HGgMh8spHwJovuYjTV8wS7ygNDRX7m1D25lBDw
         HOQnCf2m2NqIidufGcDSNtuGKRqDTLQ7alooDns/2LyDYQvekS8HhSPCkWDybqkIzDQh
         DzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUHw4uD/6PdjAyafvFS/vFaSGIdhMTKmdDdLyjrgLw8=;
        b=Yv8Qqcz/+UWJPDW9bZ8M3WtH8T+wZIwYzJE9F2lMPtC6MUzjELT+W+zlkAiPmFGQit
         5fMbq7TdyvXEDdJviQfX1qcebSmPihL94pV3hisDTLR6r4O2XtT3V+T6OLen/9r5rd/5
         OUyWtlKl54w9/7byWsSnCQLh9w8uYSv90xYA++eiMNmHdAbWjLyL9aBjUX1wXwF8qpxM
         DUrbi8vpFDcGSerhTXY5b0Jl1FZp5Eo5ECqgUsNk8BS6Sx+4K/NVzbQitDZ9/doSezzU
         weuYDVfGR8cdeBJr4hJE8IiUzvjEAEmMQdGkOpm5MlNK8fwGXSON3JqV/5JMJpOsiAAC
         vlYg==
X-Gm-Message-State: APjAAAVhHzVN/p7RBYpIrRsia5k7olJ7yOnuyPPpYP3RjyJ4jcTqVCMp
        paR3XETgaPkBw+YGRa3injfiFQ==
X-Google-Smtp-Source: APXvYqxH/k9Ocfv1Rbijdvaa9erPU0H6oubxWJA9pAEYHe/zCBKpzWf2Tu/dyMBY1YGxg4nOwKlAjw==
X-Received: by 2002:adf:a4c9:: with SMTP id h9mr7363248wrb.254.1551975978016;
        Thu, 07 Mar 2019 08:26:18 -0800 (PST)
Received: from localhost.localdomain (146-241-117-61.dyn.eolo.it. [146.241.117.61])
        by smtp.gmail.com with ESMTPSA id o127sm5801797wmo.20.2019.03.07.08.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:26:17 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 5/8] block, bfq: do not tag totally seeky queues as soft rt
Date:   Thu,  7 Mar 2019 17:25:51 +0100
Message-Id: <20190307162554.77205-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307162554.77205-1-paolo.valente@linaro.org>
References: <20190307162554.77205-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sync random I/O is likely to be confused with soft real-time I/O,
because it is characterized by limited throughput and apparently
isochronous arrival pattern. To avoid false positives, this commits
prevents bfq_queues containing only random (seeky) I/O from being
tagged as soft real-time.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b96be3764b8a..d34b80e5c47d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -242,6 +242,14 @@ static struct kmem_cache *bfq_pool;
 	  blk_rq_sectors(rq) < BFQQ_SECT_THR_NONROT))
 #define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
 #define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 19)
+/*
+ * Sync random I/O is likely to be confused with soft real-time I/O,
+ * because it is characterized by limited throughput and apparently
+ * isochronous arrival pattern. To avoid false positives, queues
+ * containing only random (seeky) I/O are prevented from being tagged
+ * as soft real-time.
+ */
+#define BFQQ_TOTALLY_SEEKY(bfqq)	(bfqq->seek_history & -1)
 
 /* Min number of samples required to perform peak-rate update */
 #define BFQ_RATE_MIN_SAMPLES	32
@@ -1622,6 +1630,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 */
 	in_burst = bfq_bfqq_in_large_burst(bfqq);
 	soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
+		!BFQQ_TOTALLY_SEEKY(bfqq) &&
 		!in_burst &&
 		time_is_before_jiffies(bfqq->soft_rt_next_start) &&
 		bfqq->dispatched == 0;
@@ -4816,6 +4825,11 @@ bfq_update_io_seektime(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	bfqq->seek_history <<= 1;
 	bfqq->seek_history |= BFQ_RQ_SEEKY(bfqd, bfqq->last_request_pos, rq);
+
+	if (bfqq->wr_coeff > 1 &&
+	    bfqq->wr_cur_max_time == bfqd->bfq_wr_rt_max_time &&
+	    BFQQ_TOTALLY_SEEKY(bfqq))
+		bfq_bfqq_end_wr(bfqq);
 }
 
 static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
-- 
2.20.1

