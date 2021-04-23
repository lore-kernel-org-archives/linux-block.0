Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F7CC433ED
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 21:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478D5613C4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 21:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhDWV6l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232283AbhDWV6l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 17:58:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85EC361467;
        Fri, 23 Apr 2021 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619215084;
        bh=4BwAoZYuq6EaqLBmiYSzglPsq0jkn4ZTw3NCgs2hImE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gw+Iyl49gnWv7NDa8Hlu281dehcjpVddZq8mJuY1nw+SiRFJ8krW9hxo29qLCFPxh
         /b90LVeNyS+CscnUYj7G8oBXptJd9b9/XsHCw69Yyio5gAxkf8bTd+TNoyD77z5oXE
         DT+mdnqSgX57T6OAyfpCJT/enRJCSQRHEWoOtmgQWoPoO9pG0Tq1lQDgxumxr+aaPP
         08VW5qTnLe5kRFuqaBFBd887CI2GtcIyp4skFTrOZoMnm6HqA95AOkFAqiBzbrLoHG
         VqNR2e5axSy282+FWnP0ORfQDKrTSEbCg0wfElLEysHxOZloRxjaJidvlTZsYnO7Hz
         qqks98E8yyiwQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Date:   Fri, 23 Apr 2021 14:58:00 -0700
Message-Id: <20210423215800.40648-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210423215800.40648-1-kbusch@kernel.org>
References: <20210423215800.40648-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't have an nvme status to report if the driver's .queue_rq()
returns an error without dispatching the requested nvme command. Use the
return value from blk_execute_rq() so the caller may know their command
was not successful.

Reported-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85538c38aae9..b57157106cac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1000,12 +1000,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (poll)
 		nvme_execute_rq_polled(req->q, NULL, req, at_head);
 	else
-		blk_execute_rq(NULL, req, at_head);
+		ret = blk_execute_rq(NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
-	else
+	else if (nvme_req(req)->status)
 		ret = nvme_req(req)->status;
  out:
 	blk_mq_free_request(req);
-- 
2.25.4

