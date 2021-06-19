Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8260BC48BE5
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 14:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F47F61168
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 14:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhFSOM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jun 2021 10:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbhFSOMY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 10:12:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2176AC061760
        for <linux-block@vger.kernel.org>; Sat, 19 Jun 2021 07:10:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b3so3870839wrm.6
        for <linux-block@vger.kernel.org>; Sat, 19 Jun 2021 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSPAxrpWy5WBZnxErtByjmy66zeZTj10pU/KsiI/8sg=;
        b=HvXTpRs5J3sSdl3kN4GehJwJojqFWyCpLC6YxZJlH7JmB9eCwrFBO/57quiXULgDKS
         TK7v1MnrJN9PbNWtue/lgIC7wzvau68haAPYDOL98xlyV+IxWrvMmaIHPSVSEgoaoSt5
         Gnm1+qRid8N7/8nhyRLfTY2NKEbSm1plyXV/sTKBvfymiIvbLG0Ie/dOr09by5ewf11b
         iyJJUEsjIoMtFUykb6YPJ5i2KXmKOo+K5DcrdH8P80UkvJanANJZX1JetfWRaGB2TD8L
         38Wd9AgrE6KZtqGQ6CZNiNcITSlfjzl6PuVPKzwEgbQUnEO4bTuh6/KY6OCSGHn/8JVD
         C+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSPAxrpWy5WBZnxErtByjmy66zeZTj10pU/KsiI/8sg=;
        b=MQfU6Yy9OeH9M7qqB5VxlqX+gRzahS3PPwlf6eiJokWedbmVgXddC+ynpHe93jSUWH
         WN/9cXvjXtGbyJV1V8+kBn8nsoz20YdkgGUUL0flbHaq+zEz1Z8g54FHgBau+QMqVG4M
         /FGWJ+MvZGd4kETCNgO6uZjuGg+bEL+dMB1LftNEiFqojpFMrG3xlBoJSxVtX/PaBMUC
         65+xUTbmomsPVoouiKQIj94fp1QaXIRRB2sE4u46FtYAy4TudQoxCJ79P+i5lGcLuQkW
         ndibanu2cIzXIMwtAy9UkniDf3f4nxhy5hnw0D2Nmij8DLNF51v+WX5pn9QBYhq1db6s
         DDOA==
X-Gm-Message-State: AOAM532/lyMx+u1Apm64vX3UBUQ84eP1ihX9vl3AGSoqAIGqzx9Z/iem
        Bkpv0iW6VaOnaOEdLuELRk+1Kw==
X-Google-Smtp-Source: ABdhPJxUgy88rE8nMFkkBALHziPCCCyMYP1MvHiX9o+AwZkzMCfSySSrr3OtnymjMzCzfzCvkEir3g==
X-Received: by 2002:adf:9084:: with SMTP id i4mr17943238wri.23.1624111810664;
        Sat, 19 Jun 2021 07:10:10 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y16sm8379350wrp.51.2021.06.19.07.10.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 07:10:10 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH FIXES/IMPROVEMENTS 5/7] block, bfq: avoid delayed merge of async queues
Date:   Sat, 19 Jun 2021 16:09:46 +0200
Message-Id: <20210619140948.98712-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since commit 430a67f9d616 ("block, bfq: merge bursts of newly-created
queues"), BFQ may schedule a merge between a newly created sync
bfq_queue, say Q2, and the last sync bfq_queue created, say Q1. To this
goal, BFQ stores the address of Q1 in the field bic->stable_merge_bfqq
of the bic associated with Q2. So, when the time for the possible merge
arrives, BFQ knows which bfq_queue to merge Q2 with. In particular,
BFQ checks for possible merges on request arrivals.

Yet the same bic may also be associated with an async bfq_queue, say
Q3. So, if a request for Q3 arrives, then the above check may happen
to be executed while the bfq_queue at hand is Q3, instead of Q2. In
this case, Q1 happens to be merged with an async bfq_queue. This is
not only a conceptual mistake, because async queues are to be kept out
of queue merging, but also a bug that leads to inconsistent states.

This commits simply filters async queues out of delayed merges.

Fixes: 430a67f9d616 ("block, bfq: merge bursts of newly-created queues")
Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 98a42ddb1760..7bf073ef9443 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2718,7 +2718,13 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * costly and complicated.
 	 */
 	if (unlikely(!bfqd->nonrot_with_queueing)) {
-		if (bic->stable_merge_bfqq &&
+		/*
+		 * Make sure also that bfqq is sync, because
+		 * bic->stable_merge_bfqq may point to some queue (for
+		 * stable merging) also if bic is associated with a
+		 * sync queue, but this bfqq is async
+		 */
+		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
 		    time_is_before_jiffies(bfqq->split_time +
 					  msecs_to_jiffies(bfq_late_stable_merging)) &&
-- 
2.20.1

