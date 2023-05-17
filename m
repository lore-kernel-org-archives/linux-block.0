Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAA8C7EE2D
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjEQRpj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjEQRpe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:34 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F554AD26
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:03 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6434e65d808so1009086b3a.3
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345485; x=1686937485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiPSD3ypK27BFIDaFIHIvt91IAeB1EY3KLLD7n21fic=;
        b=AHBUfuOYu0qaPlY5Vlq/a17mytu+FhoJ0ukAbDQJRacXJaSixJxi7EHC32EE1DLjzq
         bNOjVqgIkzPxWdYB36a2vf/1MsbERFHDY7aozcRQ9YZsgK0ksoIsf18o3IdqkN3Vu2a+
         o1KZpiDZvyurFzVFYC3Iu/DqHd1cYfu9hxhxhdpaIAnyCpRo8l+6tHABdgxr1BlEdFeq
         6wyW0KX3qeqSMUKuTdgbBdSEpg1XWYqoE/mtumeBs46eGywId6SMqdxOlQ4E8qhzmJ3E
         iOMCQpf2TtKU7LQy7Khh/LnYBGCS4XZxo3h0nIE1k3+PE2fw8Hd94XslNe0/qxw2VYtM
         Yf4Q==
X-Gm-Message-State: AC+VfDwWfS8OfPcC5e2ZNEHMlCzDeKxHyo+YeLrGtgxwZJKdhVZ0V9vZ
        FQ1ucUZe1z9lxcB+St9zWUE=
X-Google-Smtp-Source: ACHHUZ40nl6xOPGnb8krchVrLAd5z4aSvBJEKdHyovJ/nbRwbdNRE8NPEEafil82D5BqHjTkbHvZcg==
X-Received: by 2002:a05:6a00:1953:b0:64a:f8c9:a42c with SMTP id s19-20020a056a00195300b0064af8c9a42cmr620253pfk.18.1684345484701;
        Wed, 17 May 2023 10:44:44 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 10/11] block: mq-deadline: Handle requeued requests correctly
Date:   Wed, 17 May 2023 10:42:28 -0700
Message-ID: <20230517174230.897144-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Start dispatching from the start of a zone instead of from the starting
position of the most recently dispatched request.

If a zoned write is requeued with an LBA that is lower than already
inserted zoned writes, make sure that it is submitted first.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 91b689261d30..e90879869c90 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -156,13 +156,28 @@ deadline_latter_request(struct request *rq)
 	return NULL;
 }
 
-/* Return the first request for which blk_rq_pos() >= pos. */
+/*
+ * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
+ * return the first request after the start of the zone containing @pos.
+ */
 static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 				enum dd_data_dir data_dir, sector_t pos)
 {
 	struct rb_node *node = per_prio->sort_list[data_dir].rb_node;
 	struct request *rq, *res = NULL;
 
+	if (!node)
+		return NULL;
+
+	rq = rb_entry_rq(node);
+	/*
+	 * A zoned write may have been requeued with a starting position that
+	 * is below that of the most recently dispatched request. Hence, for
+	 * zoned writes, start searching from the start of a zone.
+	 */
+	if (blk_rq_is_seq_zoned_write(rq))
+		pos -= round_down(pos, rq->q->limits.chunk_sectors);
+
 	while (node) {
 		rq = rb_entry_rq(node);
 		if (blk_rq_pos(rq) >= pos) {
@@ -806,6 +821,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
+		struct list_head *insert_before;
+
 		deadline_add_rq_rb(per_prio, rq);
 
 		if (rq_mergeable(rq)) {
@@ -818,7 +835,20 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		 * set expire time and add to fifo list
 		 */
 		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
-		list_add_tail(&rq->queuelist, &per_prio->fifo_list[data_dir]);
+		insert_before = &per_prio->fifo_list[data_dir];
+#ifdef CONFIG_BLK_DEV_ZONED
+		/*
+		 * Insert zoned writes such that requests are sorted by
+		 * position per zone.
+		 */
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
 
