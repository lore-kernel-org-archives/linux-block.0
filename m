Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA4CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 13:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiEJNFH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 May 2022 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbiEJNFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 09:05:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D82F68B6
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MNNgEU8YbRvaYjqmZ5ubrsPvBmUpKeG94J5Uy5ZJh5o=; b=p/fl44+56h/rtm1F3cKnKggAds
        J1pzhJpKD2a4QOSbE4cv8ohgcqiTEM93PaRxYT4gBNEKvHCE+fBlPuK814E9zinvnEm/EK+7zV/dd
        WJZaalrVUKzr8P9dKRq79HNMpw1i51+MIc0riVQtGphXFrYKUJfDjFgM80lTJTSI3CdxQ27GZrf1K
        srY9GKeFb5S8zsEN45u6JIG1j9qFsG5G527RIOGR6MWCq6sYgjpbihHeKT25OcWDYfxqjwXsrmpmv
        CRKalHHY7NvAY6VbkyG6b0qTk1tL2bJp0Jk0TbxrS+DxCoQC6CPOOcawafh3i+Xvy6HqS+GfgeI7B
        POhwwq1Q==;
Received: from [2001:4bb8:184:7881:fd5:7227:dfd7:f2c7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noPU6-00255p-Nw; Tue, 10 May 2022 13:01:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: reorder the REQ_ flags
Date:   Tue, 10 May 2022 15:00:58 +0200
Message-Id: <20220510130058.1315400-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Keep the op-specific flag last.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c62274466e726..9be1225ebe682 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -408,16 +408,14 @@ enum req_flag_bits {
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
+	/* command specific flag for REQ_OP_WRITE_ZEROES: */
+	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	/* for driver use */
-	__REQ_DRV,
-	__REQ_SWAP,		/* swapping request. */
 	__REQ_NR_BITS,		/* stops here */
 };
 
-- 
2.30.2

