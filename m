Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B9BC433FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561A860ED4
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhJMQvp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhJMQvp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:51:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE67C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:42 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 188so397727iou.12
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/7HQR6yl8NWlBYBOTfGlONmwBvze2rjltdV3uROPZI=;
        b=Rsw/2EeGGMOzslIMSWWWoEhTr5Om9A/tyRaweH/KyDpkUITkAHXyIdYqWZD4oPH2Oh
         zwxZKSRiq99wBeccKXg87Xsu2AnVosWPZGD/9CkImhXHaTpurdiMoX4P6DWjBJWDWl9R
         /Mekdqre4ARfNZzPU3BLsSVVzXY9J4klJmZQNrR4l9RqiQQna3ShELeD6llMJ/TojEmp
         0vDuXL4qqqMCGNKvAHQMOdY0MMqWIs0HP2m3z+K0t04niBp6zAdXIYgeSvUXqLs1SreL
         0vzpq4EhOBmh+VIdcmv5bN3uyYGqyI/SmdL0ieOQtxY/V/PiPoIfHiRlmLwp3H2rIDQO
         tIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/7HQR6yl8NWlBYBOTfGlONmwBvze2rjltdV3uROPZI=;
        b=yy/X8AE6hnm4kafsxH7oIY4208HpPfhrMvkl+DqTjbkkLDO1PNl7HrnTa5zZsAdKXo
         8qhdkLtcG3atNorhb8pY71S8qynoQXH9jWqlkZT4vKBu2mIyqyRQTfZI7cbiguShT714
         WotlqUzYpeYj5cfntOGxX4FZUZJrgunUGuvpu5SVSJPA7STPmGmuYAXVS5ayxw2qezKg
         FZf50XHh7zKlqpG/gqAOlQURkEnpnKwcGdxnsFa1S5KsE7q8drIxWdopmP9XzHPq8ubF
         S6tZa9Py0J/6dZ/qbERla5Ju3/9DSZimfLQXMp4R722yPbZ8BJaFxs/Iii+Gyl5Hsgtr
         rjhQ==
X-Gm-Message-State: AOAM532q+GkbLFIzdFNO6U1sFI3Zz9wWtqasmLs+9aLRxJtWvNsVCpuR
        hv7aN3hVjHj2u48S6IfRNkJM5xqzeVllcQ==
X-Google-Smtp-Source: ABdhPJyNxyyIZJMTw7rZ63v5jwBQ0hlWKkedEwuU8ehJLxZBItYTDtiHbIizTJm05S3rDR5fkpNCIQ==
X-Received: by 2002:a05:6638:2403:: with SMTP id z3mr313118jat.141.1634143781384;
        Wed, 13 Oct 2021 09:49:41 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v15sm17217ilg.87.2021.10.13.09.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:49:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/4] block: provide helpers for rq_list manipulation
Date:   Wed, 13 Oct 2021 10:49:34 -0600
Message-Id: <20211013164937.985367-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013164937.985367-1-axboe@kernel.dk>
References: <20211013164937.985367-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of open-coding the list additions, traversal, and removal,
provide a basic set of helpers.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 21 +++++----------------
 include/linux/blk-mq.h | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6dfd3aaa6073..46a91e5fabc5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -426,10 +426,10 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 			tag = tag_offset + i;
 			tags &= ~(1UL << i);
 			rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
-			rq->rq_next = *data->cached_rq;
-			*data->cached_rq = rq;
+			rq_list_add_tail(data->cached_rq, rq);
 		}
 		data->nr_tags -= nr;
+		return rq_list_pop(data->cached_rq);
 	} else {
 		/*
 		 * Waiting allocations only fail because of an inactive hctx.
@@ -453,14 +453,6 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 
 		return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
 	}
-
-	if (data->cached_rq) {
-		rq = *data->cached_rq;
-		*data->cached_rq = rq->rq_next;
-		return rq;
-	}
-
-	return NULL;
 }
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
@@ -603,11 +595,9 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
 void blk_mq_free_plug_rqs(struct blk_plug *plug)
 {
-	while (plug->cached_rq) {
-		struct request *rq;
+	struct request *rq;
 
-		rq = plug->cached_rq;
-		plug->cached_rq = rq->rq_next;
+	while ((rq = rq_list_pop(&plug->cached_rq)) != NULL) {
 		percpu_ref_get(&rq->q->q_usage_counter);
 		blk_mq_free_request(rq);
 	}
@@ -2264,8 +2254,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	plug = blk_mq_plug(q, bio);
 	if (plug && plug->cached_rq) {
-		rq = plug->cached_rq;
-		plug->cached_rq = rq->rq_next;
+		rq = rq_list_pop(&plug->cached_rq);
 		INIT_LIST_HEAD(&rq->queuelist);
 	} else {
 		struct blk_mq_alloc_data data = {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a9c1d0882550..c05560524841 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -473,6 +473,31 @@ struct blk_mq_tag_set {
 	struct list_head	tag_list;
 };
 
+#define rq_list_add_tail(listptr, rq)	do {		\
+	(rq)->rq_next = *(listptr);			\
+	*(listptr) = rq;				\
+} while (0)
+
+#define rq_list_pop(listptr)				\
+({							\
+	struct request *__req = NULL;			\
+	if ((listptr) && *(listptr))	{		\
+		__req = *(listptr);			\
+		*(listptr) = __req->rq_next;		\
+	}						\
+	__req;						\
+})
+
+#define rq_list_peek(listptr)				\
+({							\
+	struct request *__req = NULL;			\
+	if ((listptr) && *(listptr))			\
+		__req = *(listptr);			\
+	__req;						\
+})
+
+#define rq_list_next(rq)	(rq)->rq_next
+
 /**
  * struct blk_mq_queue_data - Data about a request inserted in a queue
  *
-- 
2.33.0

