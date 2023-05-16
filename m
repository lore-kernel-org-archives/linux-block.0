Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30700C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjEPWdt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEPWds (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:48 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305C76A2
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:41 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ae50da739dso417895ad.1
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276420; x=1686868420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAl94Tb/uTywl4h7fTUUfHM03u/h0eEBWXhvRspn1G4=;
        b=R8DEJXfEhQef132J2GGAqgaYzCCFLeubOLY26I3ZqRIiHkvRSdjlAiyTvyQgg0sZLS
         Cdi6rOuc9+vtpVEbcZ3Y+PDi3Lb72q7VuUCDj19RFAewfGl9lk1sMZkHRbPZNyTrzHjj
         jHcIkCOPj+9DM4vR0PHZp8n2H+CNUOQbhIypES0FMcdxRIrLuYZ1wu7/xvWQhTo3LvP5
         OtR707Jzidexth56bPWa9tqBVHVMZ318wLGJVEo728Gy98MjCPib1XwdCuYG2QcNQKQs
         kW44iv37PrM94qTsk9pAi4CPUVedJ+AD7vuWmWBzBQxjkoK9J7aFHWsd/B7zfaeCtV4P
         cJRA==
X-Gm-Message-State: AC+VfDzqpYLiKXf+J1/xp2I0nPlTAOMu45rNwPONgsKAtIJYu5olpFM5
        XVgSQkxBmSgkXzvd9+CcHqk=
X-Google-Smtp-Source: ACHHUZ4oWgG9SuVNN5R3Gt55wgGg8Ha/K6tI6fhx5ADMsW377RkEaiYdom4EPwX7Bub8H0vL4S9ikQ==
X-Received: by 2002:a17:902:d48a:b0:1ac:8db3:d4e5 with SMTP id c10-20020a170902d48a00b001ac8db3d4e5mr35719210plg.69.1684276420475;
        Tue, 16 May 2023 15:33:40 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 10/11] block: mq-deadline: Handle requeued requests correctly
Date:   Tue, 16 May 2023 15:33:19 -0700
Message-ID: <20230516223323.1383342-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
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
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6d0b99042c96..059727fa4b98 100644
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
 
