Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4EEC433EF
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 17:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbiAERFb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbiAERFa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 12:05:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1424C061201
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 09:05:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F198B81CBB
        for <linux-block@vger.kernel.org>; Wed,  5 Jan 2022 17:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A599C36AF2;
        Wed,  5 Jan 2022 17:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641402328;
        bh=Z8VHzQF+RrX+Y/7r/9niEAi8EOiYU9sVNurudNt+iRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8AhOdMLmHyhNy8IQuJbHY46fft0TAdIoqgsmH9RaOvmOQ8LDMNWbMY5+/oMO8VUz
         W8q9tcHXBR0HDoGhtFOd60NbBImDGgPCJPMwLzYEPq83sfAAl0eoXklTtOTaX/FIV6
         fMdLUH82VgPUkeQZxEc94XCNuG5ykPKSVF7RaczZj2KT58dMuRfDxCNKaL/+CPDa1g
         EcDPw7vYs2fANJO4kF7LhK3biXHXajInSEmJiLyM7Eob/z8/3fK2Wv7g+1yDKbdSMA
         4tzVU39y9kwS6a8yzPVcGaDkds/5uJL/OqUY2WN1lpUOJUpYbENsoaLTKh4J4u/jwb
         vBBjwxY4sxfJw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 4/4] nvme-pci: fix queue_rqs list splitting
Date:   Wed,  5 Jan 2022 09:05:18 -0800
Message-Id: <20220105170518.3181469-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220105170518.3181469-1-kbusch@kernel.org>
References: <20220105170518.3181469-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If command prep fails, current handling will orphan subsequent requests
in the list. Consider a simple example:

  rqlist = [ 1 -> 2 ]

When prep for request '1' fails, it will be appended to the
'requeue_list', leaving request '2' disconnected from the original
rqlist and no longer tracked. Meanwhile, rqlist is still pointing to the
failed request '1' and will attempt to submit the unprepped command.

Fix this by updating the rqlist accordingly using the request list
helper functions.

Fixes: d62cbcf62f2f ("nvme: add support for mq_ops->queue_rqs()")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50deb8b69c40..d8585df2c2fd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -999,30 +999,30 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 
 static void nvme_queue_rqs(struct request **rqlist)
 {
-	struct request *req = rq_list_peek(rqlist), *prev = NULL;
+	struct request *req, *next, *prev = NULL;
 	struct request *requeue_list = NULL;
 
-	do {
+	rq_list_for_each_safe(rqlist, req, next) {
 		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 
 		if (!nvme_prep_rq_batch(nvmeq, req)) {
 			/* detach 'req' and add to remainder list */
-			if (prev)
-				prev->rq_next = req->rq_next;
-			rq_list_add(&requeue_list, req);
-		} else {
-			prev = req;
+			rq_list_move(rqlist, &requeue_list, req, prev);
+
+			req = prev;
+			if (!req)
+				continue;
 		}
 
-		req = rq_list_next(req);
-		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
+		if (!next || req->mq_hctx != next->mq_hctx) {
 			/* detach rest of list, and submit */
-			if (prev)
-				prev->rq_next = NULL;
+			req->rq_next = NULL;
 			nvme_submit_cmds(nvmeq, rqlist);
-			*rqlist = req;
-		}
-	} while (req);
+			*rqlist = next;
+			prev = NULL;
+		} else
+			prev = req;
+	}
 
 	*rqlist = requeue_list;
 }
-- 
2.25.4

