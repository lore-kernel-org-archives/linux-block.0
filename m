Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4C5C001DE
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 00:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjGZA54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 20:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjGZA5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 20:57:52 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FCBBC
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:57:51 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-666edfc50deso308585b3a.0
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333071; x=1690937871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlhirHeZ9D5mH766yvDJm3Juv19BdZSWGgzb/O9c98I=;
        b=DHcP9zfZbZxtTiR6TiVIDQB9XgdT/8e+TaqgTBqtO4ZMZlx3/VHn6P+s6fYU5YzlVV
         uDhTea2mMma0JLE7IirPxtaUkV6QiKhxslIkSYuFbDbEc0vTG7U33Jkq3MUmIY2huxgD
         fJBR7fD65SGNoU86S6QYtKm4iPt5DqpPnWI3///jbg8svhl3FH6bJpZX0RMeXDo01kWr
         WpPunY2CnhiO5musYMVEJXjZwhkcBGyj+VWo8+/sVZK2vs4cdS6oyWhA1lx2aqz4Cz4b
         XzwGcq1NUMJcMLeapyZnqgz2zxZwfdkcZZydI5nEA4Yz+zpQimm1XmNftYEofxbP1b5Z
         JdFQ==
X-Gm-Message-State: ABy/qLZYO7ybQwH4A4fYL4n8OeJAI6OXM2/NPzmHQOEv2uo+j9KdB1QB
        toICPbOaIGrpFLrfGZABi4g=
X-Google-Smtp-Source: APBJJlGumd8ACDhfRV0s5Y3leJiOK1an3JGr+J3DKWZRdVFpRub7FnZkNs1KpyboSSwW5ml88Kc/uw==
X-Received: by 2002:a05:6a21:6d8f:b0:12e:4174:6a4d with SMTP id wl15-20020a056a216d8f00b0012e41746a4dmr988779pzb.10.1690333070618;
        Tue, 25 Jul 2023 17:57:50 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([2601:642:4c05:4a8d:dbda:6b13:2798:9795])
        by smtp.gmail.com with ESMTPSA id t10-20020a63954a000000b005634bd81331sm11090138pgn.72.2023.07.25.17.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:57:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 2/6] block/mq-deadline: Only use zone locking if necessary
Date:   Tue, 25 Jul 2023 17:57:26 -0700
Message-ID: <20230726005742.303865-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726005742.303865-1-bvanassche@acm.org>
References: <20230726005742.303865-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Measurements have shown that limiting the queue depth to one for zoned
writes has a significant negative performance impact on zoned UFS devices.
Hence this patch that disables zone locking by the mq-deadline scheduler
if zoned writes are submitted in order and if the storage controller
preserves the command order. This patch is based on the following
assumptions:
- It happens infrequently that zoned write requests are reordered by the
  block layer.
- The I/O priority of all write requests is the same per zone.
- Either no I/O scheduler is used or an I/O scheduler is used that
  submits write requests per zone in LBA order.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 02a916ba62ee..ce5b5048935e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -338,6 +338,18 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 	return rq;
 }
 
+/*
+ * Use write locking if either QUEUE_FLAG_NO_ZONE_WRITE_LOCK or
+ * REQ_NO_ZONE_WRITE_LOCK has not been set. Not using zone write locking is
+ * only safe if the submitter allocates and submit requests in LBA order per
+ * zone and if the block driver preserves the request order.
+ */
+static bool dd_use_write_locking(struct request *rq)
+{
+	return !blk_queue_no_zone_write_lock(rq->q) ||
+		!(rq->cmd_flags & REQ_NO_ZONE_WRITE_LOCK);
+}
+
 /*
  * For the specified data direction, return the next request to
  * dispatch using arrival ordered lists.
@@ -353,7 +365,8 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		return NULL;
 
 	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
+	    !dd_use_write_locking(rq))
 		return rq;
 
 	/*
@@ -398,7 +411,8 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	if (!rq)
 		return NULL;
 
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
+	    !dd_use_write_locking(rq))
 		return rq;
 
 	/*
@@ -526,8 +540,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
@@ -552,7 +567,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	/*
 	 * If the request needs its target zone locked, do it.
 	 */
-	blk_req_zone_write_lock(rq);
+	if (dd_use_write_locking(rq))
+		blk_req_zone_write_lock(rq);
 	rq->rq_flags |= RQF_STARTED;
 	return rq;
 }
@@ -933,7 +949,7 @@ static void dd_finish_request(struct request *rq)
 
 	atomic_inc(&per_prio->stats.completed);
 
-	if (blk_queue_is_zoned(q)) {
+	if (blk_queue_is_zoned(rq->q) && dd_use_write_locking(rq)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
