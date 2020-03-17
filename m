Return-Path: <SRS0=EH6z=5C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6303FC10F29
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 15:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E1C20738
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 15:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCQPLU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:11:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33854 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgCQPLU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Mar 2020 11:11:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 28492290AC5
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, kernel@collabora.com,
        andrzej.p@collabora.com, Evan Green <evgreen@chromium.org>
Subject: [PATCH 1/2] loop: Report EOPNOTSUPP properly
Date:   Tue, 17 Mar 2020 16:11:10 +0100
Message-Id: <20200317151111.25749-2-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317151111.25749-1-andrzej.p@collabora.com>
References: <20200317151111.25749-1-andrzej.p@collabora.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

Properly plumb out EOPNOTSUPP from loop driver operations, which may
get returned when for instance a discard operation is attempted but not
supported by the underlying block device. Before this change, everything
was reported in the log as an I/O error, which is scary and not
helpful in debugging.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..87307454f768 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -460,7 +460,9 @@ static void lo_complete_rq(struct request *rq)
 
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
-		if (cmd->ret < 0)
+		if (cmd->ret == -EOPNOTSUPP)
+			ret = BLK_STS_NOTSUPP;
+		else if (cmd->ret < 0)
 			ret = BLK_STS_IOERR;
 		goto end_io;
 	}
@@ -1953,7 +1955,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
-		cmd->ret = ret ? -EIO : 0;
+		if (ret == -EOPNOTSUPP)
+			cmd->ret = ret;
+		else
+			cmd->ret = ret ? -EIO : 0;
 		blk_mq_complete_request(rq);
 	}
 }
-- 
2.17.1

