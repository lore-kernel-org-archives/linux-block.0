Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25665C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 23:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiFWX0T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiFWX0S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 19:26:18 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBB5D113
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:18 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id h192so832628pgc.4
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGkmOPdQjkionkQeEiD2XzJRJeBRx1ZoOb71Pb1WGpM=;
        b=nXZWEOBl7M5h+YXndDZd+TVoeF9lvucV+Kn4P5vKc5AFQpBXDbY09gvj81hQYQ/13b
         XRSCe+sYnQWKPDLHH9V1H7/y5likF28851/kj82Rz9iCSR5F0jLgrdOYxLRQCvRXJUPG
         OlDO9u5hW1mT2FU0m5mWswvU41GJAJACZnNw5MvvYVAFJVzfADI53WK8q99er/omADDk
         eV79CkKt43iJwd8aziUaEpiFBjr4FAQ2O+xMIW0g2ZetDrg9N4e54A4Ro5CKtaIcJidv
         7GHEDH2x+LOsDhERj7SAFiroBkyRKTdnMlDz7KG6P09xiBJJ+ds/aQyJxfJuU5kz0Yck
         dTiA==
X-Gm-Message-State: AJIora9aOegOHF6L5B1Ik9qjoQpNrpV1b1SSKIaMCq/pc9JuQVnAY7sL
        sHUAePHIqd5OdUDB/N3eulw=
X-Google-Smtp-Source: AGRyM1tJo6eR6bm+Pk/V99t4BbjPqwZSI0226BUF1UVHV/699ugoevVBt0KC4P3Ni3vV2PRGjpkpKw==
X-Received: by 2002:a05:6a00:1948:b0:525:45e3:2eb7 with SMTP id s8-20020a056a00194800b0052545e32eb7mr10759104pfk.77.1656026777437;
        Thu, 23 Jun 2022 16:26:17 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id f11-20020a62380b000000b0051829b1595dsm184709pfa.130.2022.06.23.16.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:26:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 5/6] block/null_blk: Refactor null_queue_rq()
Date:   Thu, 23 Jun 2022 16:26:02 -0700
Message-Id: <20220623232603.3751912-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623232603.3751912-1-bvanassche@acm.org>
References: <20220623232603.3751912-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a local variable for the expression bd->rq since that expression
occurs multiple times. This patch does not change any functionality.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
