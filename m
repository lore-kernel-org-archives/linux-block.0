Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39488C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B34261D0D
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 10:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhF3KGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 06:06:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41776 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbhF3KGQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 06:06:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 271F71FE60;
        Wed, 30 Jun 2021 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625047424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zQqwP8nQ9d/PpMi6FRBTsc/6S3sreiYX/DtOcbYh7So=;
        b=1Qv+plawI6gHA/gkH2yy+x+RSWnJYGsaPBJFRacFNtEH9RYcWDPcSKuKNI/9OoGw7OeOYn
        GR73x9aZyQ8cFlXgnFkFNDyOpUv11hLwurma37KFyeQlI7GDPLZYydx9rMU5u0wqS++Kiy
        mN08WoekrqS19pF/K1CKxhFS8Pp3LG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625047424;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zQqwP8nQ9d/PpMi6FRBTsc/6S3sreiYX/DtOcbYh7So=;
        b=qINXigZFKCVBy5ViSPop96bcBkwjydKqZZuYYsQFWHXVkOP0Mx2z0uMCfkXIM5yFaX/wgP
        CZiVkCxrCdBIvJBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1D322A3B9B;
        Wed, 30 Jun 2021 10:03:44 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0E5B15170CC2; Wed, 30 Jun 2021 12:03:44 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH] blk-mq: don't allocate requests when all cpus in a hctx are offline
Date:   Wed, 30 Jun 2021 12:03:42 +0200
Message-Id: <20210630100342.1100-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When all CPUs in a hctx are offline in blk_mq_alloc_request_hctx() we should
not try to allocate the request, as we'll fail later on in blk_mq_get_tag() anyway.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f11d4018ce2e..1622d0cabe3a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -468,13 +468,16 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
+	ret = -EWOULDBLOCK;
+	/* all cpus in the hctx are offline, don't try to allocate a tag */
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+	if (unlikely(cpu >= nr_cpu_ids))
+		goto out_queue_exit;
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
 		blk_mq_tag_busy(data.hctx);
 
-	ret = -EWOULDBLOCK;
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-- 
2.29.2

