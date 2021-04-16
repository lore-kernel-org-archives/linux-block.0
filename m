Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5235C43460
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 16:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A690F6124B
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 16:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhDPQy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 12:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236427AbhDPQy1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 12:54:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8BC360FF1;
        Fri, 16 Apr 2021 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618592042;
        bh=4BwAoZYuq6EaqLBmiYSzglPsq0jkn4ZTw3NCgs2hImE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMEdiYxw1S3OQT+9bb26WpZwLoOOYE0EiOtelQtYkpfYq10YSIJubHsSAfS/Sj7Y4
         cIdedZtM6UoEbY2V1al77en5ibuCQALoZKswomRLoLHa1FkeR0GXPIvmfm8C9EZLZY
         MeGCe2aprMZEIh0VKOcUfcPP7gItayPQ4PrN+G0WUJK09UfjnjDl9LjEswevQaXjxs
         tyS0MBDvw8m8GVlVZNmOhvkwRLlt4vni1mpc0ZGhTcyaQQJ3qJAV9n5L0T/Ea7nSVq
         K1ujrNQKRvAB/0Tw+AEW2xkEN564eMTknUWj9kyTVacFNhsmFErrB87gio7g2c1d92
         BIIA+RWOfHMIg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>,
        Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Date:   Fri, 16 Apr 2021 09:53:53 -0700
Message-Id: <20210416165353.3088547-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210416165353.3088547-1-kbusch@kernel.org>
References: <20210416165353.3088547-1-kbusch@kernel.org>
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

