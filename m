Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A550C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 20:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhLTU7c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:59:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43272 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhLTU7c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 15:59:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D7FC612FE
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 20:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CA9C36AE2;
        Mon, 20 Dec 2021 20:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640033971;
        bh=Wg2eMOK8vtJAqVTAWMkAJowvAQJ5DcrWK3Mh4E8Xczo=;
        h=From:To:Cc:Subject:Date:From;
        b=F3W9EhfDjZS4ic9yB11vPW8GnFaqZ0P1oEhQji8yL2n0/tzOloQzEFId+icC56dLr
         NZRHWoWXz5/5qT8URhVcVqXVCzFGRkVTzgh2lCMXY48+uhKyIp3xPps1RnPC9nyE/k
         1ztZQRsj4rIlA+DvlwbDN1oYM4clDd7q9CGsDf6FcRGamaHxAD21NHorPvuv1XrOVN
         p3E9B81VqoZXfZWguB1PXYwaJf61IjTZaZkiY3DMcMYXs0mXW3lpnJtFCUQm559V3R
         qy0vRUY1mF6WsiGVloN9rsaWIUGnIqxaC4lITaaBzQIWc9rjkovVLCqxGEhOOBcOw8
         kEU/BrIBXp2ZQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] blk-mq: blk-mq: check quiesce state before queue_rqs
Date:   Mon, 20 Dec 2021 12:59:19 -0800
Message-Id: <20211220205919.180191-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The low level drivers don't expect to see new requests after a
successful quiesce completes. Check the queue quiesce state within the
rcu protected area prior to calling the driver's queue_rqs().

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Set new function scope to static

 block/blk-mq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 51991232824a..998a85b5b46c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2549,6 +2549,14 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 		blk_mq_commit_rqs(hctx, &queued, from_schedule);
 }
 
+static void __blk_mq_flush_plug_list(struct request_queue *q,
+				     struct blk_plug *plug)
+{
+	if (blk_queue_quiesced(q))
+		return;
+	q->mq_ops->queue_rqs(&plug->mq_list);
+}
+
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *this_hctx;
@@ -2580,7 +2588,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		if (q->mq_ops->queue_rqs &&
 		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
 			blk_mq_run_dispatch_ops(q,
-				q->mq_ops->queue_rqs(&plug->mq_list));
+				__blk_mq_flush_plug_list(q, plug));
 			if (rq_list_empty(plug->mq_list))
 				return;
 		}
-- 
2.25.4

