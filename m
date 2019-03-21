Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F97FC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2005E218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbGHNS+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfCUXLF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:11:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfCUXLF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ITh0PDuKsVjOyyeeRtjz3UzTqbLdss+dT8xckm/7GTE=; b=MbGHNS+Z4cCqM00ucn37teidnr
        hJv9qD3truODyS5q5wNSxxy1LgAbOoptJjp1xaWekM+JvhUL/HiGUA+amOwSqkNmY3q41Edk8HHIm
        aOTqZrk3MdwDfjoupRLEOp1BVSekppKzVkaDKC5MOtbGiglkhH4uk8qaroWee5BZaYQ9J8lazyHAt
        G/yJ+lViyyBWyoXKmic9ve3/lgShtR89HjxyJG3o1d8fzga26mP5oOhTN0Jm+Wn2oBV/9nGjl2XeQ
        RRP++jZUKwRH2QuGOb/KiWbk43UBdX7/SqNIN5KLyMkJCBfC+aZ0igGXk15GoBbBqnoYEw2rJ/0fI
        grF4Ik7Q==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76pw-0002Lt-Gc; Thu, 21 Mar 2019 23:11:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 01/15] block: add a req_bvec helper
Date:   Thu, 21 Mar 2019 16:10:23 -0700
Message-Id: <20190321231037.25104-2-hch@lst.de>
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

Return the currently active bvec segment, potentially spanning multiple
pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0de92b29f589..255e20313cde 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -929,6 +929,13 @@ static inline unsigned int blk_rq_payload_bytes(struct request *rq)
 	return blk_rq_bytes(rq);
 }
 
+static inline struct bio_vec req_bvec(struct request *rq)
+{
+	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
+		return rq->special_vec;
+	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
+}
+
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     int op)
 {
-- 
2.20.1

