Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A5C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B4E21917
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u+pA6Dm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCUXLW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:11:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXLW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kt0DZcnyRt74tBre9oFhmfIpxTow89gYpEuO5lvOwn0=; b=u+pA6Dm0y+be/Jy7hAbs3fIQX3
        WifdY0OOgbubbspIpYUUT0u2S9oauqZkY9kx1TRO2He7wWeYpxY9RLZ/9vuzr71AwjxA8+YZBruWg
        EKK+YCPxKzhTE5mPFwaF7BT3ub6jJRiZKDZVQ8fUHIPHdtRQHL0YdfJ7XOfPSiHF9LLtbCJk50tAe
        RUAkezYNS/u9PDbEN55VpEqpq3xCXXwwY8h5KY9Z9BDbjfRYbKRSp0iHqKIpL6LSb34cMYlS/CaWq
        tu21QXlpIVvnljOdR9oqAoKuu8H96mZk/JlzQCxVOXa9SW9n38d6On9LyL19GQ0XaPzgX0YAjq9kQ
        QVhoLpGQ==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76qC-0002lk-S3; Thu, 21 Mar 2019 23:11:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 04/15] block: add dma_map_bvec helper
Date:   Thu, 21 Mar 2019 16:10:26 -0700
Message-Id: <20190321231037.25104-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Provide a nice little shortcut for mapping a single bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5279104527ad..322ff969659c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -641,6 +641,10 @@ static inline bool blk_account_rq(struct request *rq)
 #define rq_dma_dir(rq) \
 	(op_is_write(req_op(rq)) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
 
+#define dma_map_bvec(dev, bv, dir, attrs) \
+	dma_map_page_attrs(dev, (bv)->bv_page, (bv)->bv_offset, (bv)->bv_len, \
+	(dir), (attrs))
+
 static inline bool queue_is_mq(struct request_queue *q)
 {
 	return q->mq_ops;
-- 
2.20.1

