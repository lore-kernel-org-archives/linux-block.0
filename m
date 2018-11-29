Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3B8C04EBA
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ED221104
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+lx4dYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7ED221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeK3GU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:20:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeK3GU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ykAaLZV2iF6SPE0j2qoE/d4tLRBOGBVmZGLykGCOQU4=; b=j+lx4dYoz3vF1ggP+ienmidiTS
        NE9gKFvd5A6B7rVOUTK5E5hq1tM/tBNHVP9yhgxdnt9VzA+Me3jRMQGMbtoa2WEY+J8hkVC/H3Cs5
        T9KCriF5JnYlPvGP3MAPU4w6YWsLNr0S4BDErUeSSdJo+qPwlbB2ByrcVnalZeT5gPyFFLwrLYGVy
        DHq0wjqBrPAIs1IQgDnr3xpX5oCg380njpP7zT4NKZxh3XOSoaAL9YLA8jATz0um6/tj4vOA/KPVZ
        mTpxotx9vskHGD+vd2TFpGk4YgZCKOFd4Zr3sul1yyAJv5NGptD5hF+thsEDhjrIH6VHlY8nv/sId
        llVeRneA==;
Received: from 213-225-33-236.nat.highway.a1.net ([213.225.33.236] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSRl6-000432-RA; Thu, 29 Nov 2018 19:13:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 13/13] block: enable polling by default if a poll map is initalized
Date:   Thu, 29 Nov 2018 20:13:10 +0100
Message-Id: <20181129191310.9795-14-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129191310.9795-1-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
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
index 9c90c5038d07..a550a00ac00c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2811,6 +2811,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->tag_set = set;
 
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
+	if (set->nr_maps > HCTX_TYPE_POLL)
+		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
 		blk_queue_flag_set(QUEUE_FLAG_NO_SG_MERGE, q);
-- 
2.19.1

