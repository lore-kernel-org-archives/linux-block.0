Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7124BC433ED
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEE46113E
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhDBRRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 13:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhDBRRu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 13:17:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37EC0613E6
        for <linux-block@vger.kernel.org>; Fri,  2 Apr 2021 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o2BpwR/eizg1eK4+coshSWM00a/Ku/FDcZLD2TpCmAA=; b=uPA6qQxVOJWLVGUja8yI31BOyk
        HecgNYiyr3nIcU8XDOH9AZ9et1SKVWLySV3ADLZJJoJfhItvYBAlQtkGkny0T/6PlUfu2mFlQzkSx
        H8hvpC7EQB4/fcu8CHh+mGw/1ZaDpwQVgRsiXgbw1RO8DBtbtDpsQeAbVBqEAyGJqzaDHupSed7tH
        O1tx3NIgtjQdDgWrG8wp5h+dvxce4f7ard8pSQf/G/OOgX0RGmLJ8uTf/ovCNFHKhHCkFkDNLeylH
        //ZR4bBDjBxuvQ6cP52G6H28qk42RoDo3Fm6ZY4G6TTWiIXmIRal9OKINLuImp5587IBXI4MBcvBG
        CsFzT3Ww==;
Received: from [2001:4bb8:180:7517:6acc:e698:6fa4:15da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lSNQa-00FVAI-N0; Fri, 02 Apr 2021 17:17:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: remove the unused RQF_ALLOCED flag
Date:   Fri,  2 Apr 2021 19:17:46 +0200
Message-Id: <20210402171746.389793-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c | 1 -
 include/linux/blkdev.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9ebb344e25850a..271f6596435ba2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -302,7 +302,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(QUIET),
 	RQF_NAME(ELVPRIV),
 	RQF_NAME(IO_STAT),
-	RQF_NAME(ALLOCED),
 	RQF_NAME(PM),
 	RQF_NAME(HASHED),
 	RQF_NAME(STATS),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b4241f73f7a89c..4a285e920dfa63 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -85,8 +85,6 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
 /* account into disk and partition IO statistics */
 #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
-/* request came from our alloc pool */
-#define RQF_ALLOCED		((__force req_flags_t)(1 << 14))
 /* runtime pm request */
 #define RQF_PM			((__force req_flags_t)(1 << 15))
 /* on IO scheduler merge hash */
-- 
2.30.1

