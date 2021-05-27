Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD8BC47082
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC040613C5
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhE0BDU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:20 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:33596 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhE0BDU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:20 -0400
Received: by mail-pf1-f169.google.com with SMTP id f22so2366134pfn.0
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yeomt37aZvE3pGOlGPZ2DrhRIPFlungSBjtQq0xgL9A=;
        b=bNWBybfQdTChF6Z4rAMGmohEgqvChdsh09wZKaYv0d65ZCGJO9HMBWyMWMwNdDtImj
         wKd78TAZWwZ9wXoPsvNCDgWUNYHrWASBhA0JJ6CuAKs5ysiH1AB6ahrcIJ3jbfetZY9N
         04o5QVH50ZWHnjY3927UhWJ/3PgN/R3KPWfaq20r/yrSIfEC0qpjXw3i0hXIx8PbgLra
         GL3H+rC4hKCDFEVxPKC9IqFbMNi9w9DBWu2J7gFoPshbjvS9jEzvqrWj4ljytKTkSMCo
         kUZJQbOR/UdT1XEReqCupnKksv6cf89kJBYJzLm9fv3hXDTBXWN+UJIuSdPuIUPCTdjx
         6uOA==
X-Gm-Message-State: AOAM530xVwY8Yf2hHw4GQSWhsXngOUVPg5JybrHzwr+jM4xT3z8UePmQ
        zgvHadyGb+Txfaj6BcObzCY=
X-Google-Smtp-Source: ABdhPJyaz4mdTGJLNsp0MuFHgKv9qD1MTY8emL8kG8QlNdJxpMwHZgs3hGiB5eQyLXgdalSkQx1TQQ==
X-Received: by 2002:a63:64c6:: with SMTP id y189mr1215345pgb.333.1622077307049;
        Wed, 26 May 2021 18:01:47 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:01:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/9] block/mq-deadline: Add several comments
Date:   Wed, 26 May 2021 18:01:26 -0700
Message-Id: <20210527010134.32448-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the code easier to read by adding more comments.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 8eea2cbf2bf4..64cabbc157ea 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -139,6 +139,9 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
 	}
 }
 
+/*
+ * Callback function that is invoked after @next has been merged into @req.
+ */
 static void dd_merged_requests(struct request_queue *q, struct request *req,
 			       struct request *next)
 {
@@ -375,6 +378,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 }
 
 /*
+ * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests().
+ *
  * One confusing aspect here is that we get called for a specific
  * hardware queue, but we may return a request that is for a
  * different hardware queue. This is because mq-deadline has shared
@@ -438,6 +443,10 @@ static int dd_init_queue(struct request_queue *q, struct elevator_type *e)
 	return 0;
 }
 
+/*
+ * Try to merge @bio into an existing request. If @bio has been merged into
+ * an existing request, store the pointer to that request into *@rq.
+ */
 static int dd_request_merge(struct request_queue *q, struct request **rq,
 			    struct bio *bio)
 {
@@ -461,6 +470,10 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 	return ELEVATOR_NO_MERGE;
 }
 
+/*
+ * Attempt to merge a bio into an existing request. This function is called
+ * before @bio is associated with a request.
+ */
 static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
@@ -518,6 +531,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	}
 }
 
+/*
+ * Called from blk_mq_sched_insert_request() or blk_mq_sched_insert_requests().
+ */
 static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 			       struct list_head *list, bool at_head)
 {
@@ -544,6 +560,8 @@ static void dd_prepare_request(struct request *rq)
 }
 
 /*
+ * Callback function called from inside blk_mq_free_request().
+ *
  * For zoned block devices, write unlock the target zone of
  * completed write requests. Do this while holding the zone lock
  * spinlock so that the zone is never unlocked while deadline_fifo_request()
