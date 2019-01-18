Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B73C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 11:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8938820896
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 11:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZM9f5QXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfARLwh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:52:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38931 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfARLwf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 06:52:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so4214333wmi.4
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 03:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8vQW2xfZ3nYT48XTv7O5Fvq/rW1TVfhYcpInM5Lwzo=;
        b=ZM9f5QXxENn1/zcigDnvU61nSMmX6E/IaP7lKHQ1H21ACWYHq4oT4OenfjicVjDtqK
         agPkCIdOiHU+zZRL/8RjUpKhq0+HFQNIM4JRwWCYhZV5t2H2McQdsBn6CIqL5OZiEj6Q
         tGQDYpW19wJUiKGkUxUQY2JVkTr9jAYatVstg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8vQW2xfZ3nYT48XTv7O5Fvq/rW1TVfhYcpInM5Lwzo=;
        b=WZ3pTia0WulopVNNraLFiDvU7lBM3+fGArsAj2oq0UrZvAxFrcKaGaY+lxmcp6eF2o
         ajJgJs8l5PwFjmTM4aZjXGjsnm1d+nuh9OsN9EDy6Gohz9tU93IB6Rjxp/Ziv8xN729o
         ufGFlQfoZ2yG+ew//AmgoZEBxUkoQ0DC3TqBMiy1dnpvESKZCNMIwHUZRfVm0q5Wb48p
         ZIn+qIACZGHDqf6ukU+Y/SAftmUxKgocPehnZ7lr/3eqtVa4TGlaq7K2La8m55VENqjy
         Es7XfUjOicrgaD6KgK9+KH9QhPkEBbVmN78jWITrareVCm4tDqMkfmQm/6vziqOi7F6l
         2Fjg==
X-Gm-Message-State: AJcUukcsrIKp9Kl3mZmTvdXVQNGnWGoRPtKZ7TPmnAIioySCNu+uxK6F
        BLvOIseYBH18BEzYgJ6XRHK+YQ==
X-Google-Smtp-Source: ALg8bN6vROdG7I9UGb/eDxSiCt5eIG6jjE/e4XGgWFZPJgYOolDqEDFtJpYWoVjrFJPIRRKSgwym9Q==
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr15707901wme.16.1547812354308;
        Fri, 18 Jan 2019 03:52:34 -0800 (PST)
Received: from localhost.localdomain (146-241-71-93.dyn.eolo.it. [146.241.71.93])
        by smtp.gmail.com with ESMTPSA id i13sm75183049wrw.32.2019.01.18.03.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 03:52:33 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, hurikhan77+bko@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX RFC 1/2] Revert "bfq-iosched: remove unused variable"
Date:   Fri, 18 Jan 2019 12:52:18 +0100
Message-Id: <20190118115219.63576-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118115219.63576-1-paolo.valente@linaro.org>
References: <20190118115219.63576-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit bd7d4ef6a4c9b3611fa487a0065bf042c71ce620.
---
 block/bfq-iosched.c | 15 ++++++++-------
 block/bfq-iosched.h |  6 ++++++
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index cd307767a134..8cc3032b66de 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5303,25 +5303,26 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 				      struct sbitmap_queue *bt)
 {
 	unsigned int i, j, min_shallow = UINT_MAX;
+	bfqd->sb_shift = bt->sb.shift;
 
 	/*
 	 * In-word depths if no bfq_queue is being weight-raised:
 	 * leaving 25% of tags only for sync reads.
 	 *
 	 * In next formulas, right-shift the value
-	 * (1U<<bt->sb.shift), instead of computing directly
-	 * (1U<<(bt->sb.shift - something)), to be robust against
-	 * any possible value of bt->sb.shift, without having to
+	 * (1U<<bfqd->sb_shift), instead of computing directly
+	 * (1U<<(bfqd->sb_shift - something)), to be robust against
+	 * any possible value of bfqd->sb_shift, without having to
 	 * limit 'something'.
 	 */
 	/* no more than 50% of tags for async I/O */
-	bfqd->word_depths[0][0] = max((1U << bt->sb.shift) >> 1, 1U);
+	bfqd->word_depths[0][0] = max((1U<<bfqd->sb_shift)>>1, 1U);
 	/*
 	 * no more than 75% of tags for sync writes (25% extra tags
 	 * w.r.t. async I/O, to prevent async I/O from starving sync
 	 * writes)
 	 */
-	bfqd->word_depths[0][1] = max(((1U << bt->sb.shift) * 3) >> 2, 1U);
+	bfqd->word_depths[0][1] = max(((1U<<bfqd->sb_shift) * 3)>>2, 1U);
 
 	/*
 	 * In-word depths in case some bfq_queue is being weight-
@@ -5331,9 +5332,9 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	 * shortage.
 	 */
 	/* no more than ~18% of tags for async I/O */
-	bfqd->word_depths[1][0] = max(((1U << bt->sb.shift) * 3) >> 4, 1U);
+	bfqd->word_depths[1][0] = max(((1U<<bfqd->sb_shift) * 3)>>4, 1U);
 	/* no more than ~37% of tags for sync writes (~20% extra tags) */
-	bfqd->word_depths[1][1] = max(((1U << bt->sb.shift) * 6) >> 4, 1U);
+	bfqd->word_depths[1][1] = max(((1U<<bfqd->sb_shift) * 6)>>4, 1U);
 
 	for (i = 0; i < 2; i++)
 		for (j = 0; j < 2; j++)
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 0b02bf302de0..4de5dc349a1e 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -697,6 +697,12 @@ struct bfq_data {
 	/* bfqq associated with the task issuing current bio for merging */
 	struct bfq_queue *bio_bfqq;
 
+	/*
+	 * Cached sbitmap shift, used to compute depth limits in
+	 * bfq_update_depths.
+	 */
+	unsigned int sb_shift;
+
 	/*
 	 * Depth limits used in bfq_limit_depth (see comments on the
 	 * function)
-- 
2.20.1

