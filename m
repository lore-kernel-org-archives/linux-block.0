Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F27FC77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjDXUds (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXUdr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:47 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E4059D5
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:45 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-63f273b219eso2031450b3a.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368425; x=1684960425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8a5scYpTbdax7m3bT5pD+twXlnJVENiNHaccxcBHPg=;
        b=CIxukGrL0nI601nKY1sXM7B+VydG4v7gE0ZbNshJRGfpqwom8IzbsdN9qcOvlSZqE9
         QVbF2KecmozTNItIQmQ1ZiE0FXIC2B4Cvl1TNpnPlsO5Y8eauWAIOzxW3ONPpIt6TA5s
         jZsT9XOwTg6Mwms+XQlY4m88LqsJfJEHFhn0C3t++JDQVKT36cWL6SZ6ehunrJyAFEvm
         tiVkmOTehQFf83ZSIOXTrym0LM+L33zm3HpEuXVePugacnTxbQLlkHmOhpvJQAbmpDn6
         D+O1PcLos2xYWR2AT6dYbZIUEzAmqYjB+7bnw8RQIkEgV+dw+15zAnV4KeUGwFoDYL0R
         eQ/A==
X-Gm-Message-State: AAQBX9e+gzhNBC+SW2XB/6cXn4hUKsNeDTuenUemWm3h2uZnvNeMdEEB
        td15/aGoab6NCA5iuER9+wQ=
X-Google-Smtp-Source: AKy350YI4i8hnlHKpIAE3Bq9gEnAE0k5mMIurjE0EI10DS/bnqjvl25j4aqHLckZy4THojRuSwUPfw==
X-Received: by 2002:a05:6a21:3286:b0:ef:b897:5b0a with SMTP id yt6-20020a056a21328600b000efb8975b0amr19755596pzb.19.1682368424916;
        Mon, 24 Apr 2023 13:33:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 9/9] block: mq-deadline: Fix handling of at-head zoned writes
Date:   Mon, 24 Apr 2023 13:33:29 -0700
Message-ID: <20230424203329.2369688-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230424203329.2369688-1-bvanassche@acm.org>
References: <20230424203329.2369688-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before dispatching a zoned write from the FIFO list, check whether there
are any zoned writes in the RB-tree for a lower LBA for the same zone.
This patch ensures that zoned writes happen in order even if at_head is
set for some writes for a zone and not for others.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2de6c63190d8..ed0da04c51ec 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -341,7 +341,7 @@ static struct request *
 deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
-	struct request *rq;
+	struct request *rq, *rb_rq, *next;
 	unsigned long flags;
 
 	if (list_empty(&per_prio->fifo_list[data_dir]))
@@ -353,13 +353,19 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 
 	/*
 	 * Look for a write request that can be dispatched, that is one with
-	 * an unlocked target zone. For some HDDs, breaking a sequential
-	 * write stream can lead to lower throughput, so make sure to preserve
-	 * sequential write streams, even if that stream crosses into the next
-	 * zones and these zones are unlocked.
+	 * an unlocked target zone. For each write request from the FIFO list,
+	 * check whether an earlier write request exists in the RB tree. For
+	 * some HDDs, breaking a sequential write stream can lead to lower
+	 * throughput, so make sure to preserve sequential write streams, even
+	 * if that stream crosses into the next zones and these zones are
+	 * unlocked.
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
-	list_for_each_entry(rq, &per_prio->fifo_list[DD_WRITE], queuelist) {
+	list_for_each_entry_safe(rq, next, &per_prio->fifo_list[DD_WRITE],
+				 queuelist) {
+		rb_rq = deadline_from_pos(per_prio, data_dir, blk_rq_pos(rq));
+		if (rb_rq && blk_rq_pos(rb_rq) < blk_rq_pos(rq))
+			rq = rb_rq;
 		if (blk_req_can_dispatch_to_zone(rq) &&
 		    (blk_queue_nonrot(rq->q) ||
 		     !deadline_is_seq_write(dd, rq)))
