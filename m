Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6C3C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02ABA61207
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 20:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhJRUj4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhJRUjz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 16:39:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B37C061765
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:37:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r18so4137347edv.12
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+HXVcu2x/PFm7UXxUdYHEvn+f68pA4E31anhqTCGNg=;
        b=n7323djZZwfiCZkP3zhz7OtTc/uPWDLWoGZSLrnCz0Xr4lZjvy7g3yQszATbOwoztQ
         kBxjuWIsYfknBEgLzUHirUoSTGyfDPsrbgO3qvviZBEMF3VLH20lkC/I55YAr6/YuNRY
         nlyIrxzPYrSqikZEZeWTwmz6/ulcKUdrXpA1ptHAOjMZQhgXzc7dC4lLZ2ARBE54jzl/
         r9lTYHYC2Ko7mh25HCYAGluHZrz5vqf8AV5rQJJ3di6pd4UgdUkRsBDVevdY1+cwA5Vh
         qp+lL5g9QTt0DEVsc2sJ7MDGXCe9wNygvRuSRaE2dkARN2gD+GuBbXBcLNV41N87yOqF
         Blog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+HXVcu2x/PFm7UXxUdYHEvn+f68pA4E31anhqTCGNg=;
        b=Q1fOK7v4nKokEeYtJRf5SIPLnifKbOEQC+1jHfTbTfjrgQy0a/fWLHL71jqt9fHM3T
         UTfdsracnE+7fRMTmQVBQjH5SHewcI4scX3zmnNjUezli9wFIKlxkZogVS+2GHN/BCw0
         C59isNnaZojKxf3V2jWJ4f3hwOMAWNY7abNsnJfYq600tN2MFsg21ypP0mHyQdDb7KyG
         3aeco359yrlxYNPmT42p53XJdD+Tr+ndDBG/XvSl4XRMO4yB+b1/l0n5oTmZzfsWOFuO
         XtbYpNIVNixTMust7IeumE2QrMuwCK94sI3Lgve9Z1xrWcS+mrGUvlVEb+xKsIX/FfGh
         vF6g==
X-Gm-Message-State: AOAM533ABHrTpi8EXAhmkQbDwoaV+MckLoQ78ZAngcqJ9zCRlk9qHjQB
        G9a5+dHxGiett3LEZGuJ3JbfPuziuwW2oQ==
X-Google-Smtp-Source: ABdhPJyVTi4CPWbJoHlsIOMm1X4RSjgq3N1NGkIF7aZWKhF5m/c8s4lSUfIT8o9VyjVbJQTCLNZKjQ==
X-Received: by 2002:a17:907:77c8:: with SMTP id kz8mr32199624ejc.188.1634589461903;
        Mon, 18 Oct 2021 13:37:41 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.213])
        by smtp.gmail.com with ESMTPSA id y19sm11124889edd.39.2021.10.18.13.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 13:37:41 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 3/3] block: cache rq_flags inside blk_mq_rq_ctx_init()
Date:   Mon, 18 Oct 2021 21:37:29 +0100
Message-Id: <a02c72308106e033b1b0ea9c951ae971e52df2be.1634589262.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634589262.git.asml.silence@gmail.com>
References: <cover.1634589262.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a local variable for rq_flags, it helps to compile out some of
rq_flags reloads.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fa4de25c3bcb..633d73580712 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -318,17 +318,23 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	struct elevator_queue *e = q->elevator;
 	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
 	struct request *rq = tags->static_rqs[tag];
+	unsigned int rq_flags = 0;
 
 	if (e) {
-		rq->rq_flags = RQF_ELV;
+		rq_flags = RQF_ELV;
 		rq->tag = BLK_MQ_NO_TAG;
 		rq->internal_tag = tag;
 	} else {
-		rq->rq_flags = 0;
 		rq->tag = tag;
 		rq->internal_tag = BLK_MQ_NO_TAG;
 	}
 
+	if (data->flags & BLK_MQ_REQ_PM)
+		rq_flags |= RQF_PM;
+	if (blk_queue_io_stat(q))
+		rq_flags |= RQF_IO_STAT;
+	rq->rq_flags = rq_flags;
+
 	if (blk_mq_need_time_stamp(rq))
 		rq->start_time_ns = ktime_get_ns();
 	else
@@ -338,10 +344,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->mq_ctx = ctx;
 	rq->mq_hctx = hctx;
 	rq->cmd_flags = data->cmd_flags;
-	if (data->flags & BLK_MQ_REQ_PM)
-		rq->rq_flags |= RQF_PM;
-	if (blk_queue_io_stat(q))
-		rq->rq_flags |= RQF_IO_STAT;
 	rq->rq_disk = NULL;
 	rq->part = NULL;
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
-- 
2.33.1

