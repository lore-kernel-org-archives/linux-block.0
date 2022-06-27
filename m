Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC350C43334
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 23:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbiF0Xn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbiF0Xn5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 19:43:57 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F2613DFF
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:56 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 23so10510939pgc.8
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTaG9EFjLZI6DmzwdDvZnWJOpRPKMWzU1i3ABuclBq0=;
        b=yqvuQystxZkCo/idQNkzG4IxUafHWMDuKE2f4L5ZQau2mqZkkh73oCqSrwNCNPeF2t
         tOgQf8juPQA35dONWXIJMXehItva4vSiOhe6/sJClCxZmqiGBFrTD2o/TAfCZJpn5Nna
         iHpPxGrvn2hagSwft5HaBeydYgG9DuXlKLRefKYylRO/ps0KMNt/wtg/9OzqvA3mMMzB
         IUPsLYy1/10IeGH+FwLcnFkWkdtGrgt6HDu5wE7OwODQrRrz2Kupz/O1iPcZyGNZ16PD
         xm+tc3+IV8vWRPaiJZKh9q3wOPya6pbTay3OnhNfOW34anczpyzFQ6YIC0uzZDUmnxxf
         A+Eg==
X-Gm-Message-State: AJIora/wc4d+wOY1PtopkWQN+VTtJ+VjHfAPhaDaxfrK463C2xIod7Eq
        HKWWX54xQoF2GcRh5jj5am0=
X-Google-Smtp-Source: AGRyM1umtTN5+ZtAZMWib/wUHudsWYltW+oxASH6gfqKeMqReYV3TRf2umvHtvkV1sCziV0d8oKAhg==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr1658153pfi.84.1656373436003;
        Mon, 27 Jun 2022 16:43:56 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm7907456pjb.47.2022.06.27.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:43:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v3 5/8] block/null_blk: Refactor null_queue_rq()
Date:   Mon, 27 Jun 2022 16:43:32 -0700
Message-Id: <20220627234335.1714393-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627234335.1714393-1-bvanassche@acm.org>
References: <20220627234335.1714393-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a local variable for the expression bd->rq since that expression
occurs multiple times. This patch does not change any functionality.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6b67088f4ea7..fd68e6f4637f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1609,10 +1609,11 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 			 const struct blk_mq_queue_data *bd)
 {
-	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
+	struct request *rq = bd->rq;
+	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct nullb_queue *nq = hctx->driver_data;
-	sector_t nr_sectors = blk_rq_sectors(bd->rq);
-	sector_t sector = blk_rq_pos(bd->rq);
+	sector_t nr_sectors = blk_rq_sectors(rq);
+	sector_t sector = blk_rq_pos(rq);
 	const bool is_poll = hctx->type == HCTX_TYPE_POLL;
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
@@ -1621,14 +1622,14 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		cmd->timer.function = null_cmd_timer_expired;
 	}
-	cmd->rq = bd->rq;
+	cmd->rq = rq;
 	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;
-	cmd->fake_timeout = should_timeout_request(bd->rq);
+	cmd->fake_timeout = should_timeout_request(rq);
 
-	blk_mq_start_request(bd->rq);
+	blk_mq_start_request(rq);
 
-	if (should_requeue_request(bd->rq)) {
+	if (should_requeue_request(rq)) {
 		/*
 		 * Alternate between hitting the core BUSY path, and the
 		 * driver driven requeue path
@@ -1637,21 +1638,21 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (nq->requeue_selection & 1)
 			return BLK_STS_RESOURCE;
 		else {
-			blk_mq_requeue_request(bd->rq, true);
+			blk_mq_requeue_request(rq, true);
 			return BLK_STS_OK;
 		}
 	}
 
 	if (is_poll) {
 		spin_lock(&nq->poll_lock);
-		list_add_tail(&bd->rq->queuelist, &nq->poll_list);
+		list_add_tail(&rq->queuelist, &nq->poll_list);
 		spin_unlock(&nq->poll_lock);
 		return BLK_STS_OK;
 	}
 	if (cmd->fake_timeout)
 		return BLK_STS_OK;
 
-	return null_handle_cmd(cmd, sector, nr_sectors, req_op(bd->rq));
+	return null_handle_cmd(cmd, sector, nr_sectors, req_op(rq));
 }
 
 static void cleanup_queue(struct nullb_queue *nq)
