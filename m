Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EE7C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C1A2133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ntf5EC8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbeLQLQd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:16:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeLQLQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 06:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DjgPUGw6L1U2kT0wxEColPW3ZBHLqtxDVkBnVt1Wnc8=; b=Ntf5EC8Aof0xvp+xVyCcLfDLC
        USRQabJbmus1XgURWd5K0J3+ITN9zeI2RTF1tZDfUjFpfGKKGzZWAt87U0CZXsDyHoD+NGaj+yN+N
        o/yj5Vy/7LNwYOpl/pEtWaDDuSzvSoxF1DMSNVG19ShjTOLxfcyV25ouAnRXpgA4bhhuBTOp+hfwg
        snhG5vyi7x12PrgPvGZsqEBfB/ogvSjJgXo52muZZzXE6fsf7P50zRknR0lNkiriB+DRZ9uJYt3pj
        ywPS4+E4aTJggOa50VPFSfT6/dWL9b1NX/J6Nf3IO4g3n3WsJzuAesKL4Ad/vioLgOnpwwr+vR1kd
        3m8RKL8tw==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYqsw-0000st-KO; Mon, 17 Dec 2018 11:16:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] blk-mq: only dispatch to non-defauly queue maps if they have queues
Date:   Mon, 17 Dec 2018 12:16:26 +0100
Message-Id: <20181217111627.22635-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We should check if a given queue map actually has queues enabled before
dispatching to it.  This allows drivers to not initialize optional but
not used map types, which subsequently will allow fixing problems with
queue map rebuilds for that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index b63a0de8a07a..d1ed096723fb 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -105,14 +105,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
-	if (q->tag_set->nr_maps > HCTX_TYPE_POLL &&
-	    ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags)))
+	if ((flags & REQ_HIPRI) &&
+	    q->tag_set->nr_maps > HCTX_TYPE_POLL && 
+	    q->tag_set->map[HCTX_TYPE_POLL].nr_queues &&
+	    test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		type = HCTX_TYPE_POLL;
 
-	else if (q->tag_set->nr_maps > HCTX_TYPE_READ &&
-		 ((flags & REQ_OP_MASK) == REQ_OP_READ))
+	else if (((flags & REQ_OP_MASK) == REQ_OP_READ) &&
+	         q->tag_set->nr_maps > HCTX_TYPE_READ &&
+		 q->tag_set->map[HCTX_TYPE_READ].nr_queues)
 		type = HCTX_TYPE_READ;
-
+	
 	return blk_mq_map_queue_type(q, type, cpu);
 }
 
-- 
2.19.2

