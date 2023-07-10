Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3598EB64DC
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjGJSC2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGJSC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 14:02:28 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58637AB
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:24 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5577900c06bso3684959a12.2
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012144; x=1691604144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0A9NyIpfQV6lRpjnJcy3o0fOAxrWavnDAITb4WfrYk=;
        b=PETGwB2xEZRLgsmZMvP2ZbSw/6ikRFsoaB1/c4TZXFe0hRk0gd2F6S6qX1HnEpvSjL
         u7yPGrVolkVs3tQuJfGPHyxugOuxBdaMsx1MFcraYsXW7272zEZcuBjrjRvrJ04JUdLY
         oomyEgRg5eFPG9MlrgsIjNuqkVAseoFVtFkqe/pUKW3R1XGjNScGQG9nBYz0qMPEeIXa
         VP6pwbtxsrHi4UMbBulUkUBkp0Efo/TgOcbvdRaNoCk2QKUB+X5ejoC2RU99mqUwe3Fe
         wdHW08asMHoH8b0IAhTl09/SUqKqx76wDiHYZKqoSz4P88VoToQWujhsw5zTgrizWU3I
         /LUQ==
X-Gm-Message-State: ABy/qLZFzI83Jp/hWn3j2rUDO9s06QckB64TUa+DwvaExDL13AU0Be6X
        yhwHqTLgC/yWDwDG/9xdTMlXbOpkd38=
X-Google-Smtp-Source: APBJJlHdK0leGcGQ5+ND1cD3ytZMl7kVM+ryaIJ2o39cKdQeBseR+BmlWpX1K3LQKA6IhsrjgXz+lQ==
X-Received: by 2002:a17:90a:2e82:b0:263:e814:5d0f with SMTP id r2-20020a17090a2e8200b00263e8145d0fmr13611149pjd.41.1689012143648;
        Mon, 10 Jul 2023 11:02:23 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e582:53b1:a691:ab70])
        by smtp.gmail.com with ESMTPSA id gt4-20020a17090af2c400b00263f446d432sm6531846pjb.43.2023.07.10.11.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:02:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 2/5] block/mq-deadline: Only use zone locking if necessary
Date:   Mon, 10 Jul 2023 11:01:39 -0700
Message-ID: <20230710180210.1582299-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230710180210.1582299-1-bvanassche@acm.org>
References: <20230710180210.1582299-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Measurements have shown that limiting the queue depth to one for zoned
writes has a significant negative performance impact on zoned UFS devices.
Hence this patch that disables zone locking from the mq-deadline scheduler
for storage controllers that support pipelining zoned writes. This patch is
based on the following assumptions:
- Applications submit write requests to sequential write required zones
  in order.
- It happens infrequently that zoned write requests are reordered by the
  block layer.
- The storage controller does not reorder write requests that have been
  submitted to the same hardware queue. This is the case for UFS: the
  UFSHCI specification requires that UFS controllers process requests in
  order per hardware queue.
- The I/O priority of all pipelined write requests is the same per zone.
- Either no I/O scheduler is used or an I/O scheduler is used that
  submits write requests per zone in LBA order.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c   |  3 ++-
 block/mq-deadline.c | 14 +++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0f9f97cdddd9..59560d1657e3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -504,7 +504,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		break;
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
-		if (!args->seq_zones_wlock) {
+		if (!blk_queue_pipeline_zoned_writes(q) &&
+		    !args->seq_zones_wlock) {
 			args->seq_zones_wlock =
 				blk_alloc_zone_bitmap(q->node, args->nr_zones);
 			if (!args->seq_zones_wlock)
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6aa5daf7ae32..0bed2bdeed89 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -353,7 +353,8 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		return NULL;
 
 	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
+	    blk_queue_pipeline_zoned_writes(rq->q))
 		return rq;
 
 	/*
@@ -398,7 +399,8 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	if (!rq)
 		return NULL;
 
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
+	    blk_queue_pipeline_zoned_writes(rq->q))
 		return rq;
 
 	/*
@@ -526,8 +528,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	}
 
 	/*
-	 * For a zoned block device, if we only have writes queued and none of
-	 * them can be dispatched, rq will be NULL.
+	 * For a zoned block device that requires write serialization, if we
+	 * only have writes queued and none of them can be dispatched, rq will
+	 * be NULL.
 	 */
 	if (!rq)
 		return NULL;
@@ -933,7 +936,8 @@ static void dd_finish_request(struct request *rq)
 
 	atomic_inc(&per_prio->stats.completed);
 
-	if (blk_queue_is_zoned(q)) {
+	if (blk_queue_is_zoned(rq->q) &&
+	    !blk_queue_pipeline_zoned_writes(q)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
