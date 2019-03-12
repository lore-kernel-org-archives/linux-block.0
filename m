Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2586C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D062147C
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 09:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l21Jl1yZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfCLJAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:00:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53723 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfCLJAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 05:00:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id e74so1707198wmg.3
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3yl3XU7a49GA8s9ZssN4iqwWKfxKo62fpyxLFCHTfdM=;
        b=l21Jl1yZjVVBrUCvymJJxze0ysYHTiw8TwtK9e3AcziIbTngV9WXO4AnA9uaSTgijV
         D9MiZAR73lQWdDxKHhfzUeEpliUC5D0O9sZw0nt2rKKp8HrBo8chqhzCVM9OsrR/kIlL
         P0pyx7lS+4XtIDzMH0kO89P5l+IhAEwDth3GMsu2NSFiVT8BxqLESpvxWTN5Q0iPqB/W
         ImhpUq7ArZI6iObjZu8dHr/cRWWH4zFWQkkJxcYC5RrkB53h8LJ16qt/3BnkWHZlz59o
         +TmHndTPD2q4e/yulwkvL/dGT7lE7gfxkW0XWYl0rGKQu4IjNcr6yfThWciXGbglUCA8
         QJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3yl3XU7a49GA8s9ZssN4iqwWKfxKo62fpyxLFCHTfdM=;
        b=fB1UduCC/VjFc4QRxQjvzemsafTSqluf+n/SZ74QhD6CEycqDbBABZ/G/DH1zidI0F
         RkGXV3yF7SSx5zXHLFVb+RaBTkb6evxDMdoJntqp/GUumxEDB4Vas8/kZIbZIguCFfCE
         BfPL0/SJs2CkW1nCO6FTet4vRjkM6HdADBd7/q/dhWEXLkF7WeW6QJh909Ju6ng87xNe
         bbrlsmYpJlCHzDG1zhEL3AlyvurixfdIM1R5LwYO3H154FoJZgvZ/CqIlPnKxMxEoMzK
         6MKTISI+eO9Jly5P6JQ9yuY3cuE6E0E4OMyBKwZoUm/cD/nB0sZ8JsMAQwkS5LbPyMN5
         24EQ==
X-Gm-Message-State: APjAAAXAGgr2OGOoCYkvGYTWp8YbS6NAZdA0khnYJ4Fv3Eic+3cvpRab
        ZdSUfjNfAopx/DckeAbaji01IQ==
X-Google-Smtp-Source: APXvYqzQ7IHQ9WwuM0Q9tw7gv7qFqwjCUs6TELpsRlFlDakqOvH8fKgNzrzIbsrEQi8VLBL974Z4rw==
X-Received: by 2002:a1c:9694:: with SMTP id y142mr1501451wmd.98.1552381209127;
        Tue, 12 Mar 2019 02:00:09 -0700 (PDT)
Received: from localhost.localdomain ([84.33.65.66])
        by smtp.gmail.com with ESMTPSA id y20sm3953043wmi.34.2019.03.12.02.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:00:08 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, holger@applied-asynchrony.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V3 5/9] block, bfq: do not tag totally seeky queues as soft rt
Date:   Tue, 12 Mar 2019 09:59:31 +0100
Message-Id: <20190312085935.11340-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312085935.11340-1-paolo.valente@linaro.org>
References: <20190312085935.11340-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
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

