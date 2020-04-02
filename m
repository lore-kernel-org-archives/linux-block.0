Return-Path: <SRS0=2u2q=5S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4080CC43331
	for <linux-block@archiver.kernel.org>; Thu,  2 Apr 2020 17:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7002078B
	for <linux-block@archiver.kernel.org>; Thu,  2 Apr 2020 17:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbgDBRGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:06:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45082 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbgDBRGO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Apr 2020 13:06:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 041422975E5
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     evgreen@chromium.org
Cc:     asavery@chromium.org, axboe@kernel.dk, bvanassche@acm.org,
        darrick.wong@oracle.com, dianders@chromium.org,
        gwendal@chromium.org, hch@infradead.org,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, kernel@collabora.com
Subject: [PATCH v8 1/2] loop: Report EOPNOTSUPP properly
Date:   Thu,  2 Apr 2020 19:06:02 +0200
Message-Id: <20200402170603.19649-2-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402170603.19649-1-andrzej.p@collabora.com>
References: <20200402170603.19649-1-andrzej.p@collabora.com>
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
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/block/loop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..6969be9a855a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -461,7 +461,7 @@ static void lo_complete_rq(struct request *rq)
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
 		if (cmd->ret < 0)
-			ret = BLK_STS_IOERR;
+			ret = errno_to_blk_status(cmd->ret);
 		goto end_io;
 	}
 
@@ -1953,7 +1953,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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

