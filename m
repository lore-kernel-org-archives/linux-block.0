Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EB2C04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B60205C9
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KewKyXge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEPIlw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:41:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfEPIlw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9MBm8Dx7H4f4/dBkNEoL58Y8FDBs1jzesgN8w8Rt7Fg=; b=KewKyXge4kFPPPVH8sComPOOG0
        738xKAIZ8cnKSVoqqcx32Z+ez0kAU+btGSHbfGz2Afjt1xNbc6AG2Tz5UtF/pXeoQwaKIz5u88EIe
        PEGTmGUf9L0mN7gis52mbKr187yXGnaoMA9jcfp3/2617KfXnQ8x5OD1JlnoN0ADFTiyTJUzbXjT8
        OMtxG1EP3bHH/juE3+Rim4CXwcaN8sQOmd2pzSPev2s48lfSQ5mHU0WNQcTDnpvzY/f94bXBbS5Qz
        9xBLLJ6ZPNmQUzVg7pJOqoU0gNidLJ+uCFnxyouX1SMjkOJTBBktW39B6UoU3XbwWYzyaNMTFtqCh
        GaQk3qHA==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRBxW-0005P4-VV; Thu, 16 May 2019 08:41:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: force an unlimited segment size on queues with a virt boundary
Date:   Thu, 16 May 2019 10:40:56 +0200
Message-Id: <20190516084058.20678-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516084058.20678-1-hch@lst.de>
References: <20190516084058.20678-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently fail to update the front/back segment size in the bio when
deciding to allow an otherwise gappy segement to a device with a
virt boundary.  The reason why this did not cause problems is that
devices with a virt boundary fundamentally don't use segments as we
know it and thus don't care.  Make that assumption formal by forcing
an unlimited segement size in this case.

Fixes: f6970f83ef79 ("block: don't check if adjacent bvecs in one bio can be mergeable")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-settings.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 3facc41476be..2ae348c101a0 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -310,6 +310,9 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 		       __func__, max_size);
 	}
 
+	/* see blk_queue_virt_boundary() for the explanation */
+	WARN_ON_ONCE(q->limits.virt_boundary_mask);
+
 	q->limits.max_segment_size = max_size;
 }
 EXPORT_SYMBOL(blk_queue_max_segment_size);
@@ -742,6 +745,14 @@ EXPORT_SYMBOL(blk_queue_segment_boundary);
 void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
 {
 	q->limits.virt_boundary_mask = mask;
+
+	/*
+	 * Devices that require a virtual boundary do not support scatter/gather
+	 * I/O natively, but instead require a descriptor list entry for each
+	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
+	 * of that they are not limited by our notion of "segment size".
+	 */
+	q->limits.max_segment_size = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_queue_virt_boundary);
 
-- 
2.20.1

