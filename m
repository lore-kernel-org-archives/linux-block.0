Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51656C77B6C
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjDGARi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbjDGARh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:37 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A699ED2
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:31 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id kc4so38855101plb.10
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826651; x=1683418651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZf9GTQmWyzqPhonfoNHUKso5UeZ2r0GPOtB8iA+7ls=;
        b=z6BjS4hzZMdBuccjUInnfgB0xnC7Hxp9mOmwO8Dcnraz4zQ7tKW/PRHczd/qz7Z2m7
         BM19LJxD4jatCXv6unaiXEVkd1XFP05SY/mPRNnZtsDdmajWPxsV3faIbGX19psk8eQu
         aQZqpm4EHFcrK42cuNCeBoRxrs9ti5xZGL/hLBkSh2hmW8MvV4yevWG6D3534OzBMh8U
         Ra8klyMdZ84gI1nOhVzMBe9icQV9wn8nAoyNn+4r6AeED1w28YBztjKFvDp5pHc1/itR
         sLoFUTGVH3EpI3UdhmdNtxzucGHL188uZ7LrCoM8USpcR1wtBRviGI89NczlN1fvCB4i
         zn5Q==
X-Gm-Message-State: AAQBX9emFYl/9js0BNBQqRdSSHpaOZH1w8wH1b0C7Ynow7fCps44TUrL
        CSy2n0IeKh/s8jqDI9Wswws=
X-Google-Smtp-Source: AKy350aPPnmukwf3PXEAFaLd6XFyHRvfmSFraaChmsJhnZCbPVnVHfAYq+LkZU6LzSJcyKZ8rEKpUg==
X-Received: by 2002:a17:902:e5c7:b0:1a0:5349:6606 with SMTP id u7-20020a170902e5c700b001a053496606mr916034plf.56.1680826651086;
        Thu, 06 Apr 2023 17:17:31 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 12/12] block: mq-deadline: Handle requeued requests correctly
Date:   Thu,  6 Apr 2023 17:17:10 -0700
Message-Id: <20230407001710.104169-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a zoned write is requeued with an LBA that is lower than already
inserted zoned writes, make sure that it is submitted first.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index d49e20d3011d..2e046ad8ca2c 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -162,8 +162,19 @@ static void
 deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
 {
 	struct rb_root *root = deadline_rb_root(per_prio, rq);
+	struct request **next_rq = &per_prio->next_rq[rq_data_dir(rq)];
 
 	elv_rb_add(root, rq);
+	if (*next_rq == NULL || !blk_queue_is_zoned(rq->q))
+		return;
+	/*
+	 * If a request got requeued or requests have been submitted out of
+	 * order, make sure that per zone the request with the lowest LBA is
+	 * submitted first.
+	 */
+	if (blk_rq_pos(rq) < blk_rq_pos(*next_rq) &&
+	    blk_rq_zone_no(rq) == blk_rq_zone_no(*next_rq))
+		*next_rq = rq;
 }
 
 static inline void
@@ -822,6 +833,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
+		struct list_head *insert_before;
+
 		deadline_add_rq_rb(per_prio, rq);
 
 		if (rq_mergeable(rq)) {
@@ -834,7 +847,20 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		 * set expire time and add to fifo list
 		 */
 		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
-		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
+		insert_before = &per_prio->fifo_list[data_dir];
+		if (blk_rq_is_seq_zoned_write(rq)) {
+			const unsigned int zno = blk_rq_zone_no(rq);
+			struct request *prev;
+
+			while ((prev = deadline_earlier_request(rq))) {
+				if (blk_rq_zone_no(prev) != zno)
+					continue;
+				if (blk_rq_pos(rq) >= blk_rq_pos(prev))
+					break;
+				insert_before = &prev->queuelist;
+			}
+		}
+		list_add_tail(&rq->queuelist, insert_before);
 	}
 }
 
