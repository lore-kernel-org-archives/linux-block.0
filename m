Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33448C433F5
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 06:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350186AbiELGOP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 02:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350185AbiELGOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 02:14:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5690312FECD
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=g2MObSKFFbr1G5Nu/cSUEGmefkxDWOMY5qxXXlBtGJk=; b=qnHNf4j9XdwyQToMdZ2r2i+KIr
        gE/cAleAvOlFVzfWdScJdhWP8i5JXfwIrwiaqcrWkvQWFJgxoZeNulKhEOBL0gmizoQd87zfc1j1O
        uBaXDu1WpESP2szbKxWwbmwwSkubDd7CShKlMJoHpX0kucnYak3bS6WDB0WC/zuOv6GNPGhb+3AIb
        ndHv7K3bSzz7+jRgHA96DU3pv7YTYvSW38gHXFW7tO0MDiTR3VlGvkeFpvH5G9dxjIMlJF7WQZe+t
        1Znzi9mpFgXMtV5pioAlcN5CZRJBKmiiNslpIvUsAP86/oM7qN/Po00RT2IMbGXUdGix4ax9F8pl4
        Nh0yGhcA==;
Received: from [2001:4bb8:184:7881:71e:a8b6:a4d4:1744] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np25T-00AMTU-DH; Thu, 12 May 2022 06:14:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2] block: reorder the REQ_ flags
Date:   Thu, 12 May 2022 08:14:08 +0200
Message-Id: <20220512061408.1826595-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Keep the op-specific flag last so that they are clearly separate from
the generic flags.  Various recent commits just kept adding new flags
at the end.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c62274466e726..9601164ff1caa 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -408,16 +408,17 @@ enum req_flag_bits {
 	 * work item to avoid such priority inversions.
 	 */
 	__REQ_CGROUP_PUNT,
-
-	/* command specific flags for REQ_OP_WRITE_ZEROES: */
-	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
-
 	__REQ_POLLED,		/* caller polls for completion using bio_poll */
 	__REQ_ALLOC_CACHE,	/* allocate IO from cache if available */
+	__REQ_SWAP,		/* swap I/O */
+	__REQ_DRV,		/* for driver use */
+
+	/*
+	 * Command specific flags, keep last:
+	 */
+	/* for REQ_OP_WRITE_ZEROES: */
+	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	/* for driver use */
-	__REQ_DRV,
-	__REQ_SWAP,		/* swapping request. */
 	__REQ_NR_BITS,		/* stops here */
 };
 
-- 
2.30.2

