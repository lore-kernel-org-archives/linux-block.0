Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0857C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AD320817
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 21:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IEBDpUs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AD320817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeKRICK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:02:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34268 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeKRICJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:02:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so11857862pgg.1
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 13:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H55bb8wp7wkS/nESuGn9Ie3eERQNTXp7uDD13Q7fiM4=;
        b=IEBDpUs3ZNrlI+QMxbKKjqF5obyBGhC6FICFH0YxTzbCDY2blqDM8QzbN9ClXwknAf
         xTB3H+wHHfLBi3yvs0Dla8zNDTOwTQF2HebNcN8RYnnGZiIqM03rTv8cvl4EIyHkuBZC
         Ad48j9lTCfIrZzOVXrLueB2yhbAL4ES/zgGeoleywE/oboBgoLCyx3hYLuQACTp89aZp
         zAP8vOthvXk/oKiMShcxLMY4RxcxFjFfRFRiz7yfM/m4IqZCz3EF07Kg22nd1ZEEU66U
         3aYvUINUJ0RUkXstFfhCFFF5TTDqBCUi4e2v6tupiWMvPIUCA9TSHqYW1KRs069ZrwS7
         jn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H55bb8wp7wkS/nESuGn9Ie3eERQNTXp7uDD13Q7fiM4=;
        b=ViHyWbZdvtL6D+wFZQJRurn00n76Qp2QwXdwiyjkszBYK7FTaVQfbLkPTcWVGJX2u1
         hkeGnHHBdWAnJ42IwFaHyGdhCCEH7vZ0F4HZKcCJ/bnRoRGDPSBWBvlaMAoEwn7Qrv3e
         jKrZykbVPZs0gvhXqr+/crIPbA0Ad3aYbSkpxm+7EyjrhqKypSdE03fbVBWogRs1oOkf
         ctsaQNAX1Ms2AG3j7DccrV6KZKFJh6X+6GmI+SG5pAfcNW1W63KVoqZsqQNE4QNJjmWJ
         zTDtvZp7hNr8Wi9ySWR4HsAm0yH5l1XlGHB4wPXhEtIlFTOJJJVvOTahkUmciQEls3wW
         lUYw==
X-Gm-Message-State: AA+aEWa16+amlVDiUJK+LxcBc2iEPae9YKCciJw9RPruiFFaM82ewW0/
        P8oOlOJwVwTvtt/7vAZqz+TeM1schOc=
X-Google-Smtp-Source: AJdET5cRg8RS/2biv1j/tjlkYMhCvUHjAFZbZfddtB3ivj8B+ABFPwQmIMFN43yZl1LlhP0mNldEXw==
X-Received: by 2002:a62:9657:: with SMTP id c84mr3040385pfe.77.1542491045738;
        Sat, 17 Nov 2018 13:44:05 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o84sm29006501pfi.172.2018.11.17.13.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 13:44:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/7] nvme-fc: remove unused poll implementation
Date:   Sat, 17 Nov 2018 14:43:50 -0700
Message-Id: <20181117214354.822-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This relies on the fc taget ops setting ->poll_queue, which
nobody does. Otherwise it just checks if something has
completed, which isn't very useful.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/fc.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 98c3c77f48f6..de797c641265 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2302,38 +2302,6 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
 }
 
-static struct blk_mq_tags *
-nvme_fc_tagset(struct nvme_fc_queue *queue)
-{
-	if (queue->qnum == 0)
-		return queue->ctrl->admin_tag_set.tags[queue->qnum];
-
-	return queue->ctrl->tag_set.tags[queue->qnum - 1];
-}
-
-static int
-nvme_fc_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
-
-{
-	struct nvme_fc_queue *queue = hctx->driver_data;
-	struct nvme_fc_ctrl *ctrl = queue->ctrl;
-	struct request *req;
-	struct nvme_fc_fcp_op *op;
-
-	req = blk_mq_tag_to_rq(nvme_fc_tagset(queue), tag);
-	if (!req)
-		return 0;
-
-	op = blk_mq_rq_to_pdu(req);
-
-	if ((atomic_read(&op->state) == FCPOP_STATE_ACTIVE) &&
-		 (ctrl->lport->ops->poll_queue))
-		ctrl->lport->ops->poll_queue(&ctrl->lport->localport,
-						 queue->lldd_handle);
-
-	return ((atomic_read(&op->state) != FCPOP_STATE_ACTIVE));
-}
-
 static void
 nvme_fc_submit_async_event(struct nvme_ctrl *arg)
 {
@@ -2404,7 +2372,6 @@ static const struct blk_mq_ops nvme_fc_mq_ops = {
 	.init_request	= nvme_fc_init_request,
 	.exit_request	= nvme_fc_exit_request,
 	.init_hctx	= nvme_fc_init_hctx,
-	.poll		= nvme_fc_poll,
 	.timeout	= nvme_fc_timeout,
 };
 
-- 
2.17.1

