Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89320C43610
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 16:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479B321479
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ekVcuHan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479B321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbeKVC7m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:59:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbeKVC7m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 21:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0Sc/7JZrLZH3MB9AKrNIk+mOyLv5fjOlTXwM2E67fJg=; b=ekVcuHanRtS/lVNHopuYSDWeTT
        CKTXSbPTG8kfXd4M523sGUZdEqvNpICgI2qjDmir9EJhTQ7YCBV+crAxt9pH14j7DfJIAtjs9RyPq
        X5rlDR7VqzutwMWKM1kHgFnhxytGNxn4DTsh+OnSVk6HLDhELE5O8JoY8CEUhMcAPv9jw8vICenll
        0HGE237UO+YK17x0lXFsREDDEwOO3ggYAV53BRve+gt/Uqvdsr2IJhrxFo8Ju8AJXhwF3jt04RMMb
        BGEgIK3PA6k9rMD7/2UPvq+I8sfpuX0vN3kEVD0alpnK79LxRaIdqm07ntTysgq6/8FqXFN5rSy5/
        0AR36TdA==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPVIh-0003ZL-1X; Wed, 21 Nov 2018 16:24:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 13/13] block: enable polling by default if a poll map is initalized
Date:   Wed, 21 Nov 2018 17:23:47 +0100
Message-Id: <20181121162347.17430-14-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the user did setup polling in the driver we should not require
another know in the block layer to enable it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32e43bea36e3..9847e9d2fa7b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2782,6 +2782,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
+	if (set->nr_maps > HCTX_TYPE_POLL)
+		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
 		blk_queue_flag_set(QUEUE_FLAG_NO_SG_MERGE, q);
-- 
2.19.1

