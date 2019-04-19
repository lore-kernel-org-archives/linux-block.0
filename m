Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D89CC282E4
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052CB2183F
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QmJ5U1jH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfDSWy1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:54:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfDSWy1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 18:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KvveXM5hRaTNv44WTwKUaFnUt1t2zM3DQyWqxIqL0to=; b=QmJ5U1jHLTUMWGuNfurmKpGw7
        mL69o9jvts4VBddKSH5YXG36KFSXoIkFgj8WWAiP26WXPYia65K3VOMK237qKA8YaZ4Oe9RSE+MJV
        u6DxLBa4rO1H58eRSMkiILFu3eEpUOXI171yC82QwH7Vt0J7+M6r6ep4wnDa70gTZFDLmRnFgZ3jc
        Ys9PU97CaIWw2jZfVLaqlSO70F9K8n9KGdvs7vTw6LyNvVhrcI5j7/W6Qfwgz7aTP6TZmyoZX3tGQ
        tQMbTEBhe/q24per2p//MmhXNOkg/RKk8qwhDDkHonQ9TzGyrao0mmLhf7bv78kPl1yznftTRfWwN
        YfbBOQhCQ==;
Received: from x5f74192b.dyn.telefonica.de ([95.116.25.43] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHNS6-0006LO-L1; Fri, 19 Apr 2019 06:56:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux@roeck-us.net, linux-block@vger.kernel.org
Subject: [PATCH] block: avoid scatterlist offsets > PAGE_SIZE
Date:   Fri, 19 Apr 2019 08:56:24 +0200
Message-Id: <20190419065624.25583-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While we generally allow scatterlists to have offsets larger than page
size for an entry, and other subsystems like the crypto code make use of
that, the block layer isn't quite ready for that.  Flip the switch back
to avoid them for now, and revisit that decision early in a merge window
once the known offenders are fixed.

Fixes: 8a96a0e40810 ("block: rewrite blk_bvec_map_sg to avoid a nth_page call")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 247b17f2a0f6..21e87a714a73 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -474,9 +474,21 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 	while (nbytes > 0) {
 		unsigned offset = bvec->bv_offset + total;
 		unsigned len = min(get_max_segment_size(q, offset), nbytes);
+		struct page *page = bvec->bv_page;
+
+		/*
+		 * Unfortunately a fair number of drivers barf on scatterlists
+		 * that have an offset larger than PAGE_SIZE, despite other
+		 * subsystems dealing with that invariant just fine.  For now
+		 * stick to the legacy format where we never present those from
+		 * the block layer, but the code below should be removed once
+		 * these offenders (mostly MMC/SD drivers) are fixed.
+		 */
+		page += (offset >> PAGE_SHIFT);
+		offset &= ~PAGE_MASK;
 
 		*sg = blk_next_sg(sg, sglist);
-		sg_set_page(*sg, bvec->bv_page, len, offset);
+		sg_set_page(*sg, page, len, offset);
 
 		total += len;
 		nbytes -= len;
-- 
2.20.1

