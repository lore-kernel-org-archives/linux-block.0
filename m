Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B4FA3741
	for <linux-block@archiver.kernel.org>; Sat, 29 Oct 2022 01:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJ2BGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 21:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJ2BGO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 21:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84104A11C
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 18:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667005515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fjfkx07SjYxWr8sMhLK/U2/DgNEb0au67+TJu81fKGQ=;
        b=FvpKmm8HphIfHtq/Ip91I9jyt6OeVNlbkSo+p83R8mGLKn7xwPB24PTNKFD8qSB6dElUn6
        ps3zU4J4cMabAdjHNrzA66H6q9ypaTwfefUNbDhKm0R/AHwRDZzSvr0YzVBakrRe9WeGJj
        nSDx1Dld2cF/JGu01A76/yji1fpoz54=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-VOhxLn6AMTCY9NC8SgXihg-1; Fri, 28 Oct 2022 21:05:04 -0400
X-MC-Unique: VOhxLn6AMTCY9NC8SgXihg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 469DB3C0F42F;
        Sat, 29 Oct 2022 01:05:04 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B9661121315;
        Sat, 29 Oct 2022 01:05:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/4] ublk_drv: add ublk_queue_cmd() for cleanup
Date:   Sat, 29 Oct 2022 09:04:32 +0800
Message-Id: <20221029010432.598367-5-ming.lei@redhat.com>
In-Reply-To: <20221029010432.598367-1-ming.lei@redhat.com>
References: <20221029010432.598367-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add helper of ublk_queue_cmd() so that both ublk_queue_rq()
and ublk_handle_need_get_data() can reuse this helper.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 47 ++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3a59271dafe4..f96cb01e9604 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -817,12 +817,28 @@ static void ublk_submit_cmd(struct ublk_queue *ubq, const struct request *rq)
 	}
 }
 
+static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq,
+		bool last)
+{
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
+
+	if (ublk_can_use_task_work(ubq)) {
+		enum task_work_notify_mode notify_mode = last ?
+			TWA_SIGNAL_NO_IPI : TWA_NONE;
+
+		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
+			__ublk_abort_rq(ubq, rq);
+	} else {
+		if (llist_add(&data->node, &ubq->io_cmds))
+			ublk_submit_cmd(ubq, rq);
+	}
+}
+
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
 	struct ublk_queue *ubq = hctx->driver_data;
 	struct request *rq = bd->rq;
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
 	blk_status_t res;
 
 	/* fill iod to slot in io cmd buffer */
@@ -845,21 +861,12 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(bd->rq);
 
 	if (unlikely(ubq_daemon_is_dying(ubq))) {
- fail:
 		__ublk_abort_rq(ubq, rq);
 		return BLK_STS_OK;
 	}
 
-	if (ublk_can_use_task_work(ubq)) {
-		enum task_work_notify_mode notify_mode = bd->last ?
-			TWA_SIGNAL_NO_IPI : TWA_NONE;
+	ublk_queue_cmd(ubq, rq, bd->last);
 
-		if (task_work_add(ubq->ubq_daemon, &data->work, notify_mode))
-			goto fail;
-	} else {
-		if (llist_add(&data->node, &ubq->io_cmds))
-			ublk_submit_cmd(ubq, rq);
-	}
 	return BLK_STS_OK;
 }
 
@@ -1185,24 +1192,12 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 }
 
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
-		int tag, struct io_uring_cmd *cmd)
+		int tag)
 {
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-	if (ublk_can_use_task_work(ubq)) {
-		/* should not fail since we call it just in ubq->ubq_daemon */
-		task_work_add(ubq->ubq_daemon, &data->work, TWA_SIGNAL_NO_IPI);
-	} else {
-		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-
-		if (llist_add(&data->node, &ubq->io_cmds)) {
-			pdu->ubq = ubq;
-			io_uring_cmd_complete_in_task(cmd,
-					ublk_rq_task_work_cb);
-		}
-	}
+	ublk_queue_cmd(ubq, req, true);
 }
 
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
@@ -1290,7 +1285,7 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		io->addr = ub_cmd->addr;
 		io->cmd = cmd;
 		io->flags |= UBLK_IO_FLAG_ACTIVE;
-		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag, cmd);
+		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
 		break;
 	default:
 		goto out;
-- 
2.31.1

