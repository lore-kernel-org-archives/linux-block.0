Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41437C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjDGX6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDGX6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:42 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC347EF8D
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:41 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id q2so5069845pll.7
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911921; x=1683503921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDZ0a4ViXZtUJ7fNZdyM/i6Nk6el+pS0D6Bc/VV4l5M=;
        b=50uS+HvXA3fhwJ6tJkvt5wPiy2FeUgFSU08pyn4DpnQ1AogUfg0HdxwO8UcnvA9ZCl
         IM8azJ6MrMlUn3cJVlEeq3UUePae8sgoWtocgP1uceEnn6eTcrB6+md01ZukfqDXVHKG
         cLCt8vDVsmGQfId8vkyW8VWnBO8FUHvPnTJc9dBqegalNNakqbFVcUXg9d0ti84lCHEV
         mGtpr0+CY5NtgIjkT7tIu9x7/+IudBDnbshqnA4UKaatUBqSDgK4fGOWKqXtG4chBhHk
         ylDWw6IPUFlEy22WT58y5gKo9V8d3IvYIqt+DyG1V3VXCX1siG44VYz7EGbyEP5AgsKN
         rMjQ==
X-Gm-Message-State: AAQBX9dLywe60S/eEiYn7zDdj4gBYR3dbnv5DsNZKcQi4U9kaYEv+qiY
        ltETUL1KF7VNLffqsC0JPp8=
X-Google-Smtp-Source: AKy350ZxCQr3cIJHBGUSszbcZN07olU8EINFmtB9xaWSwr1toXmd1iXqJSIu73TU2aLyZBhXHcfclg==
X-Received: by 2002:a05:6a20:b05d:b0:cd:91bc:a9af with SMTP id dx29-20020a056a20b05d00b000cd91bca9afmr3268237pzb.58.1680911921145;
        Fri, 07 Apr 2023 16:58:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 01/12] block: Send zoned writes to the I/O scheduler
Date:   Fri,  7 Apr 2023 16:58:11 -0700
Message-Id: <20230407235822.1672286-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Send zoned writes inserted by the device mapper to the I/O scheduler.
This prevents that zoned writes get reordered if a device mapper driver
has been stacked on top of a driver for a zoned block device.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 16 +++++++++++++---
 block/blk.h    | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index db93b1a71157..fefc9a728e0e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3008,9 +3008,19 @@ blk_status_t blk_insert_cloned_request(struct request *rq)
 	blk_account_io_start(rq);
 
 	/*
-	 * Since we have a scheduler attached on the top device,
-	 * bypass a potential scheduler on the bottom device for
-	 * insert.
+	 * Send zoned writes to the I/O scheduler if an I/O scheduler has been
+	 * attached.
+	 */
+	if (q->elevator && blk_rq_is_seq_zoned_write(rq)) {
+		blk_mq_sched_insert_request(rq, /*at_head=*/false,
+					    /*run_queue=*/true,
+					    /*async=*/false);
+		return BLK_STS_OK;
+	}
+
+	/*
+	 * If no I/O scheduler has been attached or if the request is not a
+	 * zoned write bypass the I/O scheduler attached to the bottom device.
 	 */
 	blk_mq_run_dispatch_ops(q,
 			ret = blk_mq_request_issue_directly(rq, true));
diff --git a/block/blk.h b/block/blk.h
index d65d96994a94..4b6f8d7a6b84 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -118,6 +118,25 @@ static inline bool bvec_gap_to_prev(const struct queue_limits *lim,
 	return __bvec_gap_to_prev(lim, bprv, offset);
 }
 
+/**
+ * blk_rq_is_seq_zoned_write() - Whether @rq is a write request for a sequential zone.
+ * @rq: Request to examine.
+ *
+ * In this context sequential zone means either a sequential write required or
+ * to a sequential write preferred zone.
+ */
+static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
+{
+	switch (req_op(rq)) {
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+		return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
+	case REQ_OP_ZONE_APPEND:
+	default:
+		return false;
+	}
+}
+
 static inline bool rq_mergeable(struct request *rq)
 {
 	if (blk_rq_is_passthrough(rq))
