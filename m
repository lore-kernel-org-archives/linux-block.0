Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2039C4332F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEB26135F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 15:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhJSPf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhJSPfS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 11:35:18 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C378C061776
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:05 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k3so18823034ilu.2
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2IVTGJOXa34g7zaZVPSnTIdxeithhMltU8f7waUJSLg=;
        b=vtpyJFkqmNRcIek6ec9y8UlVo+rIKnl7CzJ6VteIFljwrl+7VWBAv4ZS+tuhQVnblL
         /nQCE79kZcloFM3PX6rGHNXXXeGYqd4tVpixjzqcgKyFaBQbNOVOdLx7JfQRjhGtD9/5
         qF3XA4ReLgtylMriuAH9668J0lXhYxi4miXeeOmDFHDP6sBsfYOMn2JnQsVYUaqJaB9o
         gG+tuBQHmChB+NkhjUekmnr1xHMAWJXXd50+RUFKRxnlMEaAFIslkW2kTL9q9MS364eQ
         RWtNRCaDkhDQ4lrZEVQudw5jZd4MS7i9M/v1jc7J5Ce0goIj7bt4tn1A4cVTNzNVD0oe
         elmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2IVTGJOXa34g7zaZVPSnTIdxeithhMltU8f7waUJSLg=;
        b=7D7onYOtCnDU4OmlDzhuskUTh7LNze8bLROHuP3yYGG4nryD46cKzse7DgxSrwHRFN
         uDn4KLJuZk6CB77finPyx6h+xPiNNJB+nJyzv9f9BdmMQNxQyovGLHx3VMqZqBW/mpxD
         YCxziPRw2rdpBEkslR8L0p6qN9duBLurMNSPemGdc690aSIt/ZjlbrINPdQDJHgzaOzU
         Xh853fti2VjpgJcJbaGmAfkwPXCGJQXZn7v4bXZZr/CDZ8AdLj8sae1LczXwX0eSi18S
         JJZtXwQYYbIOi3N4vBuyEjj2jghD1lEWGoG9mujRUuoCJSXTf4Mcy77jWSrYY+reWhIr
         6f5Q==
X-Gm-Message-State: AOAM533XYHJ/Bpd9hjCqoHjqX/kFEn6eLw7oVfMu4rFg5Acwva6SeDGB
        EjPhCCglw9bVUE/bnj21KJZN4QGI2Ys+nA==
X-Google-Smtp-Source: ABdhPJyshNnixwAnGJlCIZwe6f1r5B3pU+SIaGsOsba66Nu5+sQbEIm8pbrDVqNxjCB+t2Y2YJjNjg==
X-Received: by 2002:a05:6e02:1807:: with SMTP id a7mr17930941ilv.285.1634657584438;
        Tue, 19 Oct 2021 08:33:04 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t12sm8409555ilp.43.2021.10.19.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:33:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] block: pass in blk_mq_tags to blk_mq_rq_ctx_init()
Date:   Tue, 19 Oct 2021 09:32:58 -0600
Message-Id: <20211019153300.623322-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019153300.623322-1-axboe@kernel.dk>
References: <20211019153300.623322-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of getting this from data for every invocation of request
initialization, pass it in as an argument instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 93b6912768ff..fbaecb6e6dd4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -300,12 +300,11 @@ void blk_mq_wake_waiters(struct request_queue *q)
 }
 
 static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
-		unsigned int tag, u64 alloc_time_ns)
+		struct blk_mq_tags *tags, unsigned int tag, u64 alloc_time_ns)
 {
 	struct blk_mq_ctx *ctx = data->ctx;
 	struct blk_mq_hw_ctx *hctx = data->hctx;
 	struct request_queue *q = data->q;
-	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
 
 	if (!(data->rq_flags & RQF_ELV)) {
@@ -377,20 +376,22 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
 		u64 alloc_time_ns)
 {
 	unsigned int tag, tag_offset;
+	struct blk_mq_tags *tags;
 	struct request *rq;
-	unsigned long tags;
+	unsigned long tag_mask;
 	int i, nr = 0;
 
-	tags = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
-	if (unlikely(!tags))
+	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
+	if (unlikely(!tag_mask))
 		return NULL;
 
-	for (i = 0; tags; i++) {
-		if (!(tags & (1UL << i)))
+	tags = blk_mq_tags_from_data(data);
+	for (i = 0; tag_mask; i++) {
+		if (!(tag_mask & (1UL << i)))
 			continue;
 		tag = tag_offset + i;
-		tags &= ~(1UL << i);
-		rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
+		tag_mask &= ~(1UL << i);
+		rq = blk_mq_rq_ctx_init(data, tags, tag, alloc_time_ns);
 		rq_list_add(data->cached_rq, rq);
 	}
 	data->nr_tags -= nr;
@@ -461,7 +462,8 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		goto retry;
 	}
 
-	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
+	return blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag,
+					alloc_time_ns);
 }
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
@@ -547,7 +549,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-	return blk_mq_rq_ctx_init(&data, tag, alloc_time_ns);
+	return blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
+					alloc_time_ns);
 
 out_queue_exit:
 	blk_queue_exit(q);
-- 
2.33.1

