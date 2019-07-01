Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6946C06510
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93F120B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfGAPrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:47:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35474 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGAPrl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 11:47:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so6251551pgl.2
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 08:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHzr7PxPAIytmB++kdY6myTHoz6xGyuKMT1UEJSFjbk=;
        b=thRGSKTXw8HWtVO8sQ1GoRnmfmOtnyS+c+VcwxqKJVPwvUIqEM0HyA8ELp1beBgdiL
         CK6heXY8O2QJRGkqejes6/vhPWk7qx9qa9jOp+r7Al22F+eT3gozO5Lk1+4/9Mm6IPCP
         eL5h316SfOp/yIDXwmUdoc/pPiK7O1V6aVHb7l1v9I+n1yN7stornzWgvAaz1QG2hdDy
         l8obZDqKNTYPqDesvAylWCRRMpDHh9rIDFDh5AjjYGua2/T9TSG+k1VxFwhprLAzE8eJ
         47J5oWHmFUWJB7OZu0ROVTYzVWy2HOLw57s690sag1itFNdEF41YChAPZclLgTysDmEW
         +66Q==
X-Gm-Message-State: APjAAAX3NQ5XYEzvMufmNqAjNN4wd6/hzfsXPgHH1lSknq9cWiv28Dg3
        mK379tW1OWdi5UjAo+WHDiU=
X-Google-Smtp-Source: APXvYqwEXPlkLcQmDd+mVhlfro4USp6bLIpR4t/8t1XocAdTuM/+VfbciRaRf6DxD9nGkpSTZ5PUKg==
X-Received: by 2002:a63:c006:: with SMTP id h6mr24896419pgg.285.1561996060219;
        Mon, 01 Jul 2019 08:47:40 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x7sm11469103pfa.125.2019.07.01.08.47.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:47:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 2/2] blk-mq: Simplify blk_mq_make_request()
Date:   Mon,  1 Jul 2019 08:47:30 -0700
Message-Id: <20190701154730.203795-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190701154730.203795-1-bvanassche@acm.org>
References: <20190701154730.203795-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the blk_mq_bio_to_request() call in front of the if-statement.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4d661545ad1d..0fa03f524541 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1975,10 +1975,10 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	cookie = request_to_qc_t(data.hctx, rq);
 
+	blk_mq_bio_to_request(rq, bio, nr_segs);
+
 	plug = current->plug;
 	if (unlikely(is_flush_fua)) {
-		blk_mq_bio_to_request(rq, bio, nr_segs);
-
 		/* bypass scheduler for flush rq */
 		blk_insert_flush(rq);
 		blk_mq_run_hw_queue(data.hctx, true);
@@ -1990,8 +1990,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		unsigned int request_count = plug->rq_count;
 		struct request *last = NULL;
 
-		blk_mq_bio_to_request(rq, bio, nr_segs);
-
 		if (!request_count)
 			trace_block_plug(q);
 		else
@@ -2005,8 +2003,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		blk_add_rq_to_plug(plug, rq);
 	} else if (plug && !blk_queue_nomerges(q)) {
-		blk_mq_bio_to_request(rq, bio, nr_segs);
-
 		/*
 		 * We do limited plugging. If the bio can be merged, do that.
 		 * Otherwise the existing request in the plug list will be
@@ -2031,10 +2027,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
-		blk_mq_bio_to_request(rq, bio, nr_segs);
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
 	} else {
-		blk_mq_bio_to_request(rq, bio, nr_segs);
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
 
-- 
2.22.0.410.gd8fdbe21b5-goog

