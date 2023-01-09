Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E83DC63797
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbjAIX2H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbjAIX14 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:27:56 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24BFB49B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:27:55 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id v23so6398559plo.1
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUCV5HwEYttl/XmNL0bKMbcwHvDrjNKe2/xgoVJatNg=;
        b=lMKYYPrF2EzENM9LfFeJuj1w6OLtJTEjZo2GAYdwCP5yd56+UG1CJ7Kouyp2gjVhIl
         Zb5VblcWnp40uuPHrvKIZcsTJutvh0cAgla2O02kGTWVdZUDjzIVNOBnG5HIMPC0WShl
         5kLoSC8RVErxGciixe4s5KpeWCjC6xhb0kYERnzdn5PpTGHXSSYCNkJrSUX0CKyvp2eI
         kSlsCWF/rjQpc0WVIo2Nud0W/Lh0vFkK8ep5p4w8oAyyY3cU+FctKmjqrjwRP8HDVEn7
         rpaW0d2COCqTSaKCumpcAn/vgH/3Am/g4Qc7Vl411IBz4XAApsk+wWf16lrIaU2r1i3e
         MRFg==
X-Gm-Message-State: AFqh2koGHrnZQA0jmgG3Ixbp0tDNEiMlS1ldGb5OqORz6puSy+wQyEmE
        bsrTOatXFSx4hbv867pYa8xGpzCkQa0=
X-Google-Smtp-Source: AMrXdXuv654MholQ2AhY8DH/FyXNCFIHD8AZRWV3zCJTbZTRdHELibvmb/fVpQ2v5EO7qvdv5pkySw==
X-Received: by 2002:a05:6a21:1507:b0:9d:efbe:529a with SMTP id nq7-20020a056a21150700b0009defbe529amr77088396pzb.10.1673306875414;
        Mon, 09 Jan 2023 15:27:55 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm5032244pfb.155.2023.01.09.15.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:27:54 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH 5/8] block/null_blk: Refactor null_queue_rq()
Date:   Mon,  9 Jan 2023 15:27:35 -0800
Message-Id: <20230109232738.169886-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109232738.169886-1-bvanassche@acm.org>
References: <20230109232738.169886-1-bvanassche@acm.org>
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
index 4c601ca9552a..d401230b1e20 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1660,10 +1660,11 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
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
@@ -1672,14 +1673,14 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -1688,21 +1689,21 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
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
