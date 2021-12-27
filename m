Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E11AC433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Dec 2021 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhL0Qlt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Dec 2021 11:41:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45098 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhL0Qlt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Dec 2021 11:41:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8B70B810E5
        for <linux-block@vger.kernel.org>; Mon, 27 Dec 2021 16:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1EEC36AED;
        Mon, 27 Dec 2021 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640623306;
        bh=EXvrCVLqlbJIq3ahfQk2vdaa75rjTa4g5DSilhy9jUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/6gPL94rCXRjEDlAt1TX3UbAoF8TI5T1J3Jr+DVhvxyuHnbdKUYUHGrdhY0x9QSl
         1swRts3w/G6hPEDxB7qX0V3kuAhaNyPh8MpfRH7sppZv1xVRpQ2OKII/0NWhEDcNXj
         nUqTUNDcXcNwIFINfJLOdfojK75SdbFSO6cIAyvx53OqY53XFR/bt+btIb40wTRt6x
         AYDbdtkLDbzs6LeJ48DmlRFmhCo8Swuk+Ghdp1MNZu7r7TcN8TNIcPBr2p75iqYxFW
         eD27hfab5rE7wG6Yihc2Rv5K2Tep8srnSqGRuKpX1khYZwUbnl2mAYDBNmGdxBbojH
         /oYLvkjqZAxjw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Date:   Mon, 27 Dec 2021 08:41:38 -0800
Message-Id: <20211227164138.2488066-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211227164138.2488066-1-kbusch@kernel.org>
References: <20211227164138.2488066-1-kbusch@kernel.org>
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
failed request '1' and will attempt to submit an unprepped command.

Fix this by updating the rqlist accordingly using the request list
helper functions.

Fixes: d62cbcf62f2f ("nvme: add support for mq_ops->queue_rqs()")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Replaced the backward looking iterator with the forward looking
  version implemented in PATCH 1/3. This is a little easier to read.

  Replaced the driver's list manipulation with the helper function
  provided in PATCH 2/3.

 drivers/nvme/host/pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50deb8b69c40..992ee314e91b 100644
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
+			rq_list_move(rqlist, &requeue_list, req, prev, next);
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

