Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3BAC433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 18:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D834920727
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 18:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LK/audsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgEPS2M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 14:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgEPS2L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 14:28:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D316CC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/jtsWDPPIl1mgWNNtduCV79R7IS+Ivt3UeZn6zBeLzM=; b=LK/audszNQMMxkwx7htWxHJwr5
        5FYYOR9PMhN4UfBAtfnAk5Gxoz9xhVPga25ehk05djgGy9fUuYRQnFRRnz8x0zw7j56lCwspBf7Gw
        Jdxj4bNrKoOaftnd5KLnFwkGHsyVpBS5aeahqEfKF6cBfaz84S0bBtz1tEOwOl0Y9kN/rjiRcQb3Y
        H1jnScSMQNPyCcaWmdqQXSj1BY2DINnXE8UvbfV+0Cv/UBD7besDLaFJUOrDI5U+wbx+My29uXvP5
        d9ekxRPdXwToEKl8DPXNLjOPNYHGL8tPJv/agw8tDmMf1VF+t5DDEVT3bn16b+SlTwfbFsncTp0/1
        DaAwNyzQ==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ja1Xf-0007o8-Co; Sat, 16 May 2020 18:28:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/4] blk-mq: remove a pointless queue enter pair in blk_mq_alloc_request_hctx
Date:   Sat, 16 May 2020 20:28:00 +0200
Message-Id: <20200516182801.482930-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516182801.482930-1-hch@lst.de>
References: <20200516182801.482930-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need for two queue references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e62b97dceb48..b1c12de8926e3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -455,10 +455,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	ret = -EWOULDBLOCK;
-	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
-	blk_queue_exit(q);
-
 	if (!rq)
 		goto out_queue_exit;
 	return rq;
-- 
2.26.2

