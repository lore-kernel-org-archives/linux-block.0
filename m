Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B9AC282E3
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5E21738
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfDWM37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727225AbfDWM37 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 08:29:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6083AE1D;
        Tue, 23 Apr 2019 12:29:57 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 4/5] blk-mq: Set hctx pointer to NULL in blk_mq_exit_hw_queues()
Date:   Tue, 23 Apr 2019 14:29:50 +0200
Message-Id: <20190423122951.134531-5-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190423122951.134531-1-hare@suse.de>
References: <20190423122951.134531-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When clearing the hardware context we should be setting the pointer
to NULL, too, to avoid accesses to invalid hctx entries.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3da453b11deb..f620462dc4d1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2275,6 +2275,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
+		q->queue_hw_ctx[i] = NULL;
 	}
 }
 
-- 
2.16.4

