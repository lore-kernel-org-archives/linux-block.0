Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A984AC7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjDXUdr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjDXUdo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:44 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218F759D5
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:44 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-63b73203e0aso30790583b3a.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368424; x=1684960424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycm0II5V2vvvBo4OxocwgHymfj0kMbZbh+LKQrfKdNo=;
        b=eoeB/Zl3scxgV9D/1U4CRXS7+7qjQFx/PkIgRmikwzDNHMa6KcHiiJwf3l/1Uq074C
         Scvr1F9SuoKS6IivxuwlH2A95TgKeCopGj0nPAUsXuh+Hu/aH4jSxCUNJG8B4ScCH4f2
         TKCmAKGz3gZhdKfIVbu5xCSz6SRTe+D8qNtPbbABJs6lgPe5SvpnATA6hLAByElMk0so
         JkEhjOPdiO3yY/AO4mM5xYkekPZJJwh/i0JGjq5SyI/lsAXlvmW5M6VoMAUEyE3b/TCt
         xsrKBHO9+sf7PVBPatLQJe7VOaWYBE645LhM9BXw1DhjO/5HsG3htbiFgnVFhyHExT1I
         cl/Q==
X-Gm-Message-State: AAQBX9d2ucMwYoPHX8Dq4l2X8VyC3AJYWWtDV72UPlyw71cNTIFojaLr
        TUMoS/KYbyKw7B8K/Ifb9BQ=
X-Google-Smtp-Source: AKy350Y1W8kO3Ksiqnn+cV2GCVBc3BvYKZ1O3DACYM/7ud5kSNA1CrWNfOzskOKYr69xLiAYfSclLQ==
X-Received: by 2002:a05:6a20:3d17:b0:ee:4210:6ca with SMTP id y23-20020a056a203d1700b000ee421006camr17742735pzi.7.1682368423698;
        Mon, 24 Apr 2023 13:33:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 8/9] block: mq-deadline: Handle requeued requests correctly
Date:   Mon, 24 Apr 2023 13:33:28 -0700
Message-ID: <20230424203329.2369688-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230424203329.2369688-1-bvanassche@acm.org>
References: <20230424203329.2369688-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Start dispatching from the start of a zone instead of from the starting
position of the most recently dispatched request.

If a zoned write is requeued with an LBA that is lower than already
inserted zoned writes, make sure that it is submitted first.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index bf1dfe9fe9c9..2de6c63190d8 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -156,13 +156,23 @@ deadline_latter_request(struct request *rq)
 	return NULL;
 }
 
-/* Return the first request for which blk_rq_pos() >= pos. */
+/*
+ * Return the first request for which blk_rq_pos() >= @pos. For zoned devices,
+ * return the first request after the highest zone start <= @pos.
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
+	if (blk_rq_is_seq_zoned_write(rq))
+		pos -= bdev_offset_from_zone_start(rq->q->disk->part0, pos);
+
 	while (node) {
 		rq = rb_entry_rq(node);
 		if (blk_rq_pos(rq) >= pos) {
@@ -809,6 +819,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
+		struct list_head *insert_before;
+
 		deadline_add_rq_rb(per_prio, rq);
 
 		if (rq_mergeable(rq)) {
@@ -821,7 +833,16 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
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
 
