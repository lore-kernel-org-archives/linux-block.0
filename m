Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC576C4707E
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB1F6135A
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhEUUXM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 16:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhEUUXL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 16:23:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CE436138C;
        Fri, 21 May 2021 20:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621628508;
        bh=7fKyXomK4hFiDm2INagcL6+HlGVnAnxLwG9I5Nn7FtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcGK2RiIJrNTsOOLSed3MaAUH2+FdMZQOwcKqN8ViR9wqIf0KQGnXGHcWv7D18Tnp
         c5X/7ztoyXzLVqcnhbDnXHbAEyXfKFHEaJzUcVYK60QSoMIPQ0f7PGIbENCpgH5SPe
         pJbIr0m7ELXTXC+JrgJsn23EsJVX5XtKBLkeuD9gQH+uAW3hanEZwPdqnVfE9CF7oi
         h5lbqkmt6RsFHHCDbmrV3/LEXCV5vtg15KYTtxbVBn4X4iWDOzhSOfzYTWCya6PGH6
         DMIeXNhxyTbMSChZNQuZlh21lKDs7O0UrL3atS+utHznlwsUUNvb8/xJ6XJ9iNgaFK
         4naUPBqEOMziA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/4] block: support polling through blk_execute_rq
Date:   Fri, 21 May 2021 13:21:42 -0700
Message-Id: <20210521202145.3674904-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210521202145.3674904-1-kbusch@kernel.org>
References: <20210521202145.3674904-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Poll for completions if the request's hctx is a polling type.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Moved blk_execute_rq's poll handling into a small helper function

 block/blk-exec.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index beae70a0e5e5..38f88552aa31 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -63,6 +63,19 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
+static bool blk_rq_is_poll(struct request *rq)
+{
+	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
+}
+
+static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
+{
+	do {
+		blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
+		cond_resched();
+	} while (!completion_done(wait));
+}
+
 /**
  * blk_execute_rq - insert a request into queue for execution
  * @bd_disk:	matching gendisk
@@ -83,7 +96,10 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
-	if (hang_check)
+
+	if (blk_rq_is_poll(rq))
+		blk_rq_poll_completion(rq, &wait);
+	else if (hang_check)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
-- 
2.25.4

