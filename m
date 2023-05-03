Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDCAC77B78
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 22:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjECWwc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 18:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjECWwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:30 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4EC44B6
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:26 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso5043872a12.1
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154346; x=1685746346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvyV5nB3Z6rJkKiErzOVe3S6el5xPZ52sQ/N5pFxNtQ=;
        b=g7Xkm6s/XWaZka/99S9T4kPGERCip1berzdeBDtA68A5V0V9F42EOi3ILuSdR/v4A6
         iy2wK70l0/lxFTc1FC1xDrNti3j1N6ZWngOQ3mUlogRYnHjhhuxAgRmseaVVPrtqgsEW
         zyGrVpuBz8TtkVfC08POakbdckHiwXpRl9gO0QQ+UPDSIRZTNyHV818F+UO7TcXDEitf
         SoiJFz7veK+1OxD3a2yVDaRbTg7oGY3mAIQ3bhmoiIAyrrGeocqgIQkbNGDYei4WIZzr
         Y6u/+BOJXNN/IT8EpO3hlW0ypwV8QNYKK7b+L7qWA5ZOVEMjndWJAE7VWcGieRDIo/j0
         f9zg==
X-Gm-Message-State: AC+VfDxS2mW7iCXarOaSHBy1ayJjtcn8+bgk5HjaQoB+MOqKdlYhtK5d
        tMEKLiFvx+ulFYCbHMmo6Ao=
X-Google-Smtp-Source: ACHHUZ4qQqGGS1cxJ/0ZSvOzeRK3J/TuIL0p77uNW4z+tbW4N64EhDKknZA4vk0Xz64AyXTKWC1PKg==
X-Received: by 2002:a17:902:968e:b0:1a1:bff4:49e9 with SMTP id n14-20020a170902968e00b001a1bff449e9mr1473286plp.23.1683154346021;
        Wed, 03 May 2023 15:52:26 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 10/11] block: mq-deadline: Handle requeued requests correctly
Date:   Wed,  3 May 2023 15:52:07 -0700
Message-ID: <20230503225208.2439206-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
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
 block/mq-deadline.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b482b707cb37..6c196182f86c 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -156,13 +156,28 @@ deadline_latter_request(struct request *rq)
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
@@ -812,6 +827,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
+		struct list_head *insert_before;
+
 		deadline_add_rq_rb(per_prio, rq);
 
 		if (rq_mergeable(rq)) {
@@ -824,7 +841,20 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
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
 
