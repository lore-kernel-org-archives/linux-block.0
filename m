Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6065C001E0
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 22:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGaWP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 18:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjGaWPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 18:15:25 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13004B2
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:25 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1bb81809ca8so39789075ad.3
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 15:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841724; x=1691446524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52d6Yv2j3msvKUoHhQfE+78n/6sSy14S5P1th7+0tyg=;
        b=HUAQrLdqX0lIg7plFNmt+hyt67iEHOO9L6QqhNtRduPHV1Y/Np1AagKid9X1G3jKvw
         27LG/SfQraOol8m5yqtd4xZA2s7k/6iWx6F06pMsHYnMMhl4WxeMIr76W2t9CD4riqxB
         55PYanSbF2FzwsGNliwuvDPVh1b2b7iMCIkpsLItIEoDltkjlskbnLizNz3fNJKKZHmm
         HXNhHe8DGb5TY1jEpBHqd28knNte7ZJBTL2TTej0bHJ5x4p09PxWmgaPFtIuK9qLEebw
         JNyuLMiLxE0ilqfYaGwVIhGFTkbuz7pWvh+iQlmc5ZxgqnAuYbQkydGBhEuILli48R5d
         mQDA==
X-Gm-Message-State: ABy/qLb8UWJvzg/FgNixxwrdj2q7Ev5YW44958i1/n7s8Zq6l+yjA7Vm
        LP3gZd2Nr+2CkPj/WZYXslA=
X-Google-Smtp-Source: APBJJlHGPY6DTsfCodAnX1Trs1U2GLvB9BRXH4h2kiHW+gB7EV8bsy/whwMrkchE1L06K5UteK2qhg==
X-Received: by 2002:a17:903:22c1:b0:1b8:b2c6:7e8d with SMTP id y1-20020a17090322c100b001b8b2c67e8dmr13054253plg.66.1690841724371;
        Mon, 31 Jul 2023 15:15:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9346:70e3:158a:281c])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001b895a18472sm9000888plb.117.2023.07.31.15.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:15:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 2/7] block/mq-deadline: Only use zone locking if necessary
Date:   Mon, 31 Jul 2023 15:14:38 -0700
Message-ID: <20230731221458.437440-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230731221458.437440-1-bvanassche@acm.org>
References: <20230731221458.437440-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Measurements have shown that limiting the queue depth to one per zone for
zoned writes has a significant negative performance impact on zoned UFS
devices. Hence this patch that disables zone locking by the mq-deadline
scheduler if the storage controller preserves the command order. This
patch is based on the following assumptions:
- It happens infrequently that zoned write requests are reordered by the
  block layer.
- The I/O priority of all write requests is the same per zone.
- Either no I/O scheduler is used or an I/O scheduler is used that
  submits write requests per zone in LBA order.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 02a916ba62ee..1f4124dd4a0b 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -338,6 +338,16 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 	return rq;
 }
 
+/*
+ * Use write locking if either QUEUE_FLAG_NO_ZONE_WRITE_LOCK has not been set.
+ * Not using zone write locking is only safe if the block driver preserves the
+ * request order.
+ */
+static bool dd_use_zone_write_locking(struct request_queue *q)
+{
+	return blk_queue_is_zoned(q) && !blk_queue_no_zone_write_lock(q);
+}
+
 /*
  * For the specified data direction, return the next request to
  * dispatch using arrival ordered lists.
@@ -353,7 +363,7 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		return NULL;
 
 	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !dd_use_zone_write_locking(rq->q))
 		return rq;
 
 	/*
@@ -398,7 +408,7 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	if (!rq)
 		return NULL;
 
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !dd_use_zone_write_locking(rq->q))
 		return rq;
 
 	/*
@@ -526,8 +536,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
@@ -552,7 +563,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	/*
 	 * If the request needs its target zone locked, do it.
 	 */
-	blk_req_zone_write_lock(rq);
+	if (dd_use_zone_write_locking(rq->q))
+		blk_req_zone_write_lock(rq);
 	rq->rq_flags |= RQF_STARTED;
 	return rq;
 }
@@ -933,7 +945,7 @@ static void dd_finish_request(struct request *rq)
 
 	atomic_inc(&per_prio->stats.completed);
 
-	if (blk_queue_is_zoned(q)) {
+	if (dd_use_zone_write_locking(rq->q)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
