Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4292C2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFEA613BD
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhFRArV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:21 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:35738 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhFRArV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:21 -0400
Received: by mail-pl1-f173.google.com with SMTP id x19so3821763pln.2
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0iD14Ru51kND5VtafJkBd0EUPHs/gOKbFP4JvK7IqU=;
        b=RwsDeE6pmIxWp/FpsYi2Qxb4fZIZHsCpld4AfD3CTbRzHFkFszijj33vK2v6Wvn/hq
         E2GkjgWuIz+mxJvyWWHa7OffOi8V7834lO2HEX4Rjxsd42XjulblDqTVXogp7HJwBwih
         k4ICmmRNJU9YWxBJIkUiPEq1ObifSQziINld4tkBsQrT0p47+ZR/0cMKgB2i9ThFbsEL
         DjrraHcW6HaG0ybypPfN30hEyz/dmV9i3b8OL0woKGnknK/WT6gS3mZOE8sbdHFMOspi
         7yrfO4Q5DPYiOjVenFUtM0OXnNeMG6m7Obf2eew4yJqLd1DtYldVT114h4s3mpefkW/A
         4tgQ==
X-Gm-Message-State: AOAM530fHdbg7YhSaROtNRHr+Bx4ZK5dheNKAQed102tAj8q2xfcoPUq
        +CIJe2WFOuSIY/s37AXK7jw=
X-Google-Smtp-Source: ABdhPJyry9qb8V6SlnRnXmPiLK36UlQKj5Xq3TiOATinfSFFl2SRZkx4pXtzd47wzuIR9lhCTT1mkQ==
X-Received: by 2002:a17:902:aa04:b029:ec:f779:3a2b with SMTP id be4-20020a170902aa04b02900ecf7793a2bmr2256503plb.44.1623977111654;
        Thu, 17 Jun 2021 17:45:11 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 05/16] block/mq-deadline: Add several comments
Date:   Thu, 17 Jun 2021 17:44:45 -0700
Message-Id: <20210618004456.7280-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the code easier to read by adding more comments.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 8eea2cbf2bf4..31418e9ce9e2 100644
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
+ * Callback from inside blk_mq_free_request().
+ *
  * For zoned block devices, write unlock the target zone of
  * completed write requests. Do this while holding the zone lock
  * spinlock so that the zone is never unlocked while deadline_fifo_request()
