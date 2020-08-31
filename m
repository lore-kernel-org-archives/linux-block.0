Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969CFC433E2
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7C4214D8
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 15:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgHaPdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgHaPbj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 11:31:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64858C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 08:31:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2610:98:8005::6b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7B600297891;
        Mon, 31 Aug 2020 16:31:36 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH] block: Fix inflight statistic for MQ submission with !elevator
Date:   Mon, 31 Aug 2020 11:31:27 -0400
Message-Id: <20200831153127.3561733-1-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

According to Documentation/block/stat.rst, inflight should not include
I/O requests that are in the queue but not yet dispatched to the device,
but blk-mq identifies as inflight any request that has a tag allocated,
which, for queues without elevator, happens at request allocation time
and before it is queued in the ctx (default case in blk_mq_submit_bio).

A more precise approach would be to only consider requests with state
MQ_RQ_IN_FLIGHT.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0015a1892153..997b3327eaa8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -105,7 +105,7 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part == mi->part)
+	if (rq->part == mi->part && rq->state == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
 	return true;
-- 
2.28.0

