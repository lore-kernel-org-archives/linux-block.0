Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E929CC7618B
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 16:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD8F21871
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 16:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DEJmM/V9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfGXQ1E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:27:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGXQ1D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 12:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yNhGV6A1IPVP4ZHdx1ozA8WOlPpuWHgtt88D569y5bM=; b=DEJmM/V9hVWzSJqf25q7KhQxP
        Pee1MY0G7u9uHIQHf5iyK6QOyVcmz8IOxGCO07KMTpYF7rMymimxwAF8pCd2F2TfjJUY/Yi000Tsq
        D6C9l/Tu0iDaJijOsx6OYTdsGSKiSxmBSbc1YQmxnSo1Ppt1XyzqInUvKi0yJBrW9/yrbCRaGnf5X
        eYShlyPQgZ6/lzk4vS1ytGE0W4BEOUUzN0V8bvhRvWQLbutyWkqjwVOoUVjMBp8C6t4n4gOsRs9t3
        gSB8w0D+ynQmHtNJYayRusbUwiHCgeM905OyIKoGcfqjmpT6olHq9t9DrLSbdQ7xjHJQoDOJ+Wr10
        aPWA2tZLg==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqK6W-00015Z-B0; Wed, 24 Jul 2019 16:27:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux@roeck-us.net, James.Bottomley@HansenPartnership.com,
        linux-block@vger.kernel.org
Subject: [PATCH] block: fix max segment size handling in blk_queue_virt_boundary
Date:   Wed, 24 Jul 2019 18:26:56 +0200
Message-Id: <20190724162656.3967-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We should only set the max segment size to unlimited if we actually
have a virt boundary.  Otherwise we accidentally clear that limit
when called from the SCSI midlayer, which always calls
blk_queue_virt_boundary, even if that mask is 0.

Fixes: 7ad388d8e4c7 ("scsi: core: add a host / host template field for the virt boundary")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 2ae348c101a0..2c1831207a8f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -752,7 +752,8 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
 	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
 	 * of that they are not limited by our notion of "segment size".
 	 */
-	q->limits.max_segment_size = UINT_MAX;
+	if (mask)
+		q->limits.max_segment_size = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_queue_virt_boundary);
 
-- 
2.20.1

