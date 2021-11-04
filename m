Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB6CC4332F
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4696121F
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhKDSYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhKDSYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:24:48 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFE3C061203
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:22:09 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g25-20020a9d5f99000000b0055af3d227e8so5047625oti.11
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMc2U7aNLUIipa0Yuo51ied8PbRQ1VYWGknVm8Hbf/o=;
        b=zvP89dK+wAjOY7J8KSr2URtt/u15Mn8DiUuOpYm9KgId9HKCvCqMYUFscjRYP8A7wU
         fP2/qYhovtIuI0vS6SCCCTD1pC0xJ/QbDnlDMChotogjuWUJ+mPN+ZP8dutGdePyP6s/
         sCz3GtOK6vw6O8idI135I5opq5+0KaE2hp0oeiR3Umn997eDUXKaMWIgReQde+5JPljv
         w+o8cB8SVPDTb31x6jaYgqDXxRqhgd8LPTS3j4Qwl5BYB9G32mZhF3cXr1j9/hzDTKyB
         OCQAi8haOEUoxuNmE7V2psjF+YvvidXeD9I0z0/xNiG3rtQxcxrWiPMh1FPYGl9fAbzT
         oPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMc2U7aNLUIipa0Yuo51ied8PbRQ1VYWGknVm8Hbf/o=;
        b=cDvx75TSZSBHHT63Fdll4eg56DbPUwxugWWdfnRIyBXTUMt1ptSGwBeSjcT3OjI7ZQ
         XjiOjP7rsuqirD8AvALtFjkXhT6qmZ/ZANLgmc1nyUAkmTwQjnBoaNhpl71ucHkjLTQ6
         1QfIbfNnO9B1CNv4HjTr9ic+j0/xoknk92T2zmi8TNK6IaRB1S6sio4MQwSVctLWWu8t
         P4iZd+3xfGFcwtu32r6OqO74Og2kQVNfxvVWKinzRubqWBHMsRSUElJ6+FV6YEVauxh0
         CZlB9iPC1zwyD0Dix+dEb1zvNHAbFt+/E01LPiKjRvBWV9720kWJ8tjRE6DOiilLjHRA
         Lohg==
X-Gm-Message-State: AOAM5303Rf/VIatnaD+faBN15BXHo5YZd5woi53rflTCe+RBxFiot9ol
        HSvGXsYs9Gn40bo8zd60qSTzGfMopPUNqw==
X-Google-Smtp-Source: ABdhPJyP4GYxXWbfq1Aev9Ox9ubH42hSotUry9+nb1CjztufvgDdlMVIaTgOLQJNiomEXijJldwUKQ==
X-Received: by 2002:a05:6830:16c6:: with SMTP id l6mr14819276otr.315.1636050128938;
        Thu, 04 Nov 2021 11:22:08 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s206sm1595445oia.33.2021.11.04.11.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 11:22:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] block: split request allocation components into helpers
Date:   Thu,  4 Nov 2021 12:21:58 -0600
Message-Id: <20211104182201.83906-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104182201.83906-1-axboe@kernel.dk>
References: <20211104182201.83906-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is in preparation for a fix, but serves as a cleanup as well moving
the cached vs regular alloc logic out of blk_mq_submit_bio().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 71 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5498454c2164..dcb413297a96 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2478,6 +2478,51 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 	return BLK_MAX_REQUEST_COUNT;
 }
 
+static struct request *blk_mq_get_new_requests(struct request_queue *q,
+					       struct blk_plug *plug,
+					       struct bio *bio)
+{
+	struct blk_mq_alloc_data data = {
+		.q		= q,
+		.nr_tags	= 1,
+		.cmd_flags	= bio->bi_opf,
+	};
+	struct request *rq;
+
+	if (plug) {
+		data.nr_tags = plug->nr_ios;
+		plug->nr_ios = 1;
+		data.cached_rq = &plug->cached_rq;
+	}
+
+	rq = __blk_mq_alloc_requests(&data);
+	if (rq)
+		return rq;
+
+	rq_qos_cleanup(q, bio);
+	if (bio->bi_opf & REQ_NOWAIT)
+		bio_wouldblock_error(bio);
+	return NULL;
+}
+
+static inline struct request *blk_mq_get_request(struct request_queue *q,
+						 struct blk_plug *plug,
+						 struct bio *bio)
+{
+	if (plug) {
+		struct request *rq;
+
+		rq = rq_list_peek(&plug->cached_rq);
+		if (rq) {
+			plug->cached_rq = rq_list_next(rq);
+			INIT_LIST_HEAD(&rq->queuelist);
+			return rq;
+		}
+	}
+
+	return blk_mq_get_new_requests(q, plug, bio);
+}
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2518,29 +2563,9 @@ void blk_mq_submit_bio(struct bio *bio)
 	rq_qos_throttle(q, bio);
 
 	plug = blk_mq_plug(q, bio);
-	if (plug && plug->cached_rq) {
-		rq = rq_list_pop(&plug->cached_rq);
-		INIT_LIST_HEAD(&rq->queuelist);
-	} else {
-		struct blk_mq_alloc_data data = {
-			.q		= q,
-			.nr_tags	= 1,
-			.cmd_flags	= bio->bi_opf,
-		};
-
-		if (plug) {
-			data.nr_tags = plug->nr_ios;
-			plug->nr_ios = 1;
-			data.cached_rq = &plug->cached_rq;
-		}
-		rq = __blk_mq_alloc_requests(&data);
-		if (unlikely(!rq)) {
-			rq_qos_cleanup(q, bio);
-			if (bio->bi_opf & REQ_NOWAIT)
-				bio_wouldblock_error(bio);
-			goto queue_exit;
-		}
-	}
+	rq = blk_mq_get_request(q, plug, bio);
+	if (unlikely(!rq))
+		goto queue_exit;
 
 	trace_block_getrq(bio);
 
-- 
2.33.1

