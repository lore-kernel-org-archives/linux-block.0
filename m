Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83205C4363A
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 00:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4845C20829
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 00:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603759102;
	bh=9+3VoOP+nxTVMDbH4zV35RJX/lzj91BA3Ht3ZiGjQZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XEsxObROM4rQrEafZgYUjQCU3eUMAxmf6VSJ8tlCL006eXb7pqmiVZ55cO+MLO3zX
	 BjgSg0CAtpMttnPksIw/TwJSBecNtn2jHsgFrnyAxe5CB1KWHumQlzta1WIBeyVcbc
	 PHkFQ3RFaC3JrC8kXpYU8YLsVUn9r6vysCSxNL/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410131AbgJ0Ae0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409330AbgJZXvL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 19:51:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B344E20878;
        Mon, 26 Oct 2020 23:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756271;
        bh=9+3VoOP+nxTVMDbH4zV35RJX/lzj91BA3Ht3ZiGjQZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/JQei82sTEmJQClUB3HlFlw//547F5HGUk1+CGa8qr6j2Ce2dHKlq+w84z9ZPsce
         gkxRdU1LrhToWxLv7WY1RrbA76aw9zzlwxIurTgSnFJInil32LLkEW//SOqt/jQWwX
         4uZa7sQL1tkBc72SlsXZ3ORuYDXiNG/65mcG6vvU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 103/147] block: Consider only dispatched requests for inflight statistic
Date:   Mon, 26 Oct 2020 19:48:21 -0400
Message-Id: <20201026234905.1022767-103-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026234905.1022767-1-sashal@kernel.org>
References: <20201026234905.1022767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit a926c7afffcc0f2e35e6acbccb16921bacf34617 ]

According to Documentation/block/stat.rst, inflight should not include
I/O requests that are in the queue but not yet dispatched to the device,
but blk-mq identifies as inflight any request that has a tag allocated,
which, for queues without elevator, happens at request allocation time
and before it is queued in the ctx (default case in blk_mq_submit_bio).

In addition, current behavior is different for queues with elevator from
queues without it, since for the former the driver tag is allocated at
dispatch time.  A more precise approach would be to only consider
requests with state MQ_RQ_IN_FLIGHT.

This effectively reverts commit 6131837b1de6 ("blk-mq: count allocated
but not started requests in iostats inflight") to consolidate blk-mq
behavior with itself (elevator case) and with original documentation,
but it differs from the behavior used by the legacy path.

This version differs from v1 by using blk_mq_rq_state to access the
state attribute.  Avoid using blk_mq_request_started, which was
suggested, since we don't want to include MQ_RQ_COMPLETE.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cdced4aca2e81..fd578a0ea67dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -105,7 +105,7 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
 {
 	struct mq_inflight *mi = priv;
 
-	if (rq->part == mi->part)
+	if (rq->part == mi->part && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
 	return true;
-- 
2.25.1

