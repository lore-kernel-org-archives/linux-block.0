Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA34C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 22:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5340861480
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 22:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhDWWGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 18:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231218AbhDWWGi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 18:06:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 373A9613AB;
        Fri, 23 Apr 2021 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619215561;
        bh=W6iSvtmcGry1oGNwCHkbmf8AJ6FjkkxhjYdlYI6DiKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEK+OeK4LP79mREz/vtHtLxP6evSWlgetgB3oPi98zYDr9A4qIRm/ZlXHKER93LyZ
         bKQmG29duJ3brVA0uQnFNRHsfns48RkkwNvOkfntzWDmhABi81kox58u2G0njNFS/m
         kE/nzwNlkzmopyfz058boUv9jW2qps3ETAKcyGcAKrOA0E708dyW+hlt4A7tEVdcmk
         qZeFJEgUPg5Y3yeiQ9QYNgmMU+446gLji+GSGiF2++1M/Zk4dxAEuKjkVFaDUCXZC7
         z7lfb3NTOR71RRrKQVx97d7FLUUrnpxEgFeHTAaNGtWZpnTSpnNDdy2JaryPl9FWgn
         22c7vEE79mFNg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/5] block: support polling through blk_execute_rq
Date:   Fri, 23 Apr 2021 15:05:54 -0700
Message-Id: <20210423220558.40764-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210423220558.40764-1-kbusch@kernel.org>
References: <20210423220558.40764-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Poll for completions if the request's hctx is a polling type.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-exec.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index beae70a0e5e5..b960ad187ba5 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -63,6 +63,11 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
+static bool blk_rq_is_poll(struct request *rq)
+{
+	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
+}
+
 /**
  * blk_execute_rq - insert a request into queue for execution
  * @bd_disk:	matching gendisk
@@ -83,7 +88,12 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
-	if (hang_check)
+	if (blk_rq_is_poll(rq)) {
+		do {
+			blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
+			cond_resched();
+		} while (!completion_done(&wait));
+	} else if (hang_check)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
-- 
2.25.4

