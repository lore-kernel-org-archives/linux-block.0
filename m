Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E7C77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjDRWkb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjDRWkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:25 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC3A5C6
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:19 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-63b620188aeso2858534b3a.0
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857619; x=1684449619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRAofSqTGr8thWv6K8/33dM7IjWJELRCM5q93U6DUBs=;
        b=D168mPNc4D/wRa9NjTjdLmtsk3TZSAIlikUvOSa0g/Ao27IGG3lLyXzf+a1ft0mrws
         UGWDmxpaz8aGoDIbLiwyDAbOyKgl7T8VrZN6KPiX0bnRVPBzs5GzwTrJuk8NszADoA8O
         El/KbfChq4QIMglKpBGlToutQzI4rmKrON04Aj7m0/e6GgE8nJwy59qEv4v1e0n30yMz
         dxfuqU+4qJBxc/YhJ91IC/5f/ZWDu2DJaTdGm1dN46SGOlMHHMRCxXffd1MGdMCbDjG6
         lSU24yAMfQFJ6Rf/b4oSg3Rao58/YR91ByABv+DW2V66saRrchFgq2oVduOv8DndYVCP
         AS3w==
X-Gm-Message-State: AAQBX9eOP0uav+r20JzvqHaIewGGCrF7aLns+uuk31L2nRgkfx1n3uPe
        861VYFU+oDiMP0QD75TOeeU=
X-Google-Smtp-Source: AKy350ZwgJJBwnWTYF0VWIESg1d0fVRtLKJP+IdDOvJUtEfjnk2DlRfAkN76KkP3PY5zrxqjGPSSag==
X-Received: by 2002:a17:903:7d0:b0:1a6:7510:170a with SMTP id ko16-20020a17090307d000b001a67510170amr2850744plb.11.1681857619293;
        Tue, 18 Apr 2023 15:40:19 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 09/11] block: mq-deadline: Handle requeued requests correctly
Date:   Tue, 18 Apr 2023 15:40:00 -0700
Message-ID: <20230418224002.1195163-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
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
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 32a2cc013ed3..4d2bfb3898b0 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -160,8 +160,22 @@ static void
 deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
 {
 	struct rb_root *root = deadline_rb_root(per_prio, rq);
+	struct request **next_rq __maybe_unused;
 
 	elv_rb_add(root, rq);
+#ifdef CONFIG_BLK_DEV_ZONED
+	next_rq = &per_prio->next_rq[rq_data_dir(rq)];
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
+#endif
 }
 
 static inline void
@@ -816,6 +830,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
+		struct list_head *insert_before;
+
 		deadline_add_rq_rb(per_prio, rq);
 
 		if (rq_mergeable(rq)) {
@@ -828,7 +844,16 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		 * set expire time and add to fifo list
 		 */
 		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
-		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
+		insert_before = &per_prio->fifo_list[data_dir];
+#ifdef CONFIG_BLK_DEV_ZONED
+		if (blk_rq_is_seq_zoned_write(rq)) {
+			struct request *rq2 = deadline_latter_request(rq);
+
+			if (rq2 && blk_rq_zone_no(rq2) == blk_rq_zone_no(rq))
+				insert_before = &rq2->queuelist;
+		}
+#endif
+		list_add_tail(&rq->queuelist, insert_before);
 	}
 }
 
