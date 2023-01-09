Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CEFC54EBE
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbjAIX2H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbjAIX1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:27:55 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A1B49B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:27:54 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id d3so11288447plr.10
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BH5vLribh8aOPgt9vOhItoFB0+zm3eKjdJ+5DkhJ/Mw=;
        b=soaSVYpsQVlVmhIhukVN076wtV+vle79el03fpoq5d1zpFXAQD3d6bhEL7tKs9hejN
         nl8ja1R03840j5ludNOeNjE6l3xKC2Vn9UcBAFgG9Qpb8hRTpgIDp/HjZBY+sZXCy7iN
         vp1DzLhdGmCBRMUyhlQU/rTrLtDQKx5IoO2W8yr0W5Y8b+2mufm1zrWIj8ZA9Iw7tam8
         i2At9JmB6LdHuZeq/AGs2jgatEM2Nv7DiNjY2/HOrn5dqzh+E8kOVlihUvmKZkJ7KjDP
         rtHzywvWtXXIrYdvflSDman620vFBxb/5V6FMyBJoURYUb46yW6cGoeLR52aBb4C3Ea2
         vKFg==
X-Gm-Message-State: AFqh2kotne2KcyUPWUrckbqfRQXOCqwXZpshGqyUG6gDAGy6OSRLPWkD
        +LZPmLL4Px2Qwtf9Egkfr3w=
X-Google-Smtp-Source: AMrXdXtvD0lj7JpKXm/529NN5IfUWILW6UFx64x2+zLnMYnxYqWXoyEzKgpeDw8MLaIA762dBUpjuA==
X-Received: by 2002:a05:6a20:4e10:b0:aa:4010:8886 with SMTP id gk16-20020a056a204e1000b000aa40108886mr73610178pzb.1.1673306873585;
        Mon, 09 Jan 2023 15:27:53 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm5032244pfb.155.2023.01.09.15.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:27:52 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Date:   Mon,  9 Jan 2023 15:27:34 -0800
Message-Id: <20230109232738.169886-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109232738.169886-1-bvanassche@acm.org>
References: <20230109232738.169886-1-bvanassche@acm.org>
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

If applications submit write requests to sequential write required zones
in order, at least one of the pending requests will succeed. Hence, the
number of retries that is required is at most (number of pending
requests) - 1.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c   |  3 ++-
 block/mq-deadline.c | 14 +++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index db829401d8d0..158638091e39 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -520,7 +520,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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
index f10c2a0d18d4..e41808c0b007 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -339,7 +339,8 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		return NULL;
 
 	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
+	    blk_queue_pipeline_zoned_writes(rq->q))
 		return rq;
 
 	/*
@@ -378,7 +379,8 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	if (!rq)
 		return NULL;
 
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
+	    blk_queue_pipeline_zoned_writes(rq->q))
 		return rq;
 
 	/*
@@ -503,8 +505,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
@@ -893,7 +896,8 @@ static void dd_finish_request(struct request *rq)
 
 	atomic_inc(&per_prio->stats.completed);
 
-	if (blk_queue_is_zoned(q)) {
+	if (blk_queue_is_zoned(rq->q) &&
+	    !blk_queue_pipeline_zoned_writes(q)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
