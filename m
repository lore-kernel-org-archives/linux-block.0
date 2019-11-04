Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70047CA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4180D20869
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 18:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tQ6m7FUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfKDSFq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:05:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfKDSFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 13:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gl9OD8N/vzZCZwIDUWRQmBpbqhHaLlmVwIO5ueiska0=; b=tQ6m7FUBmPJAoJIwVmlHQmiEw
        cXMzXuO+gcu9KOyb3l86M9Ar0ZVvdWi/cJTecta9nHnFKsAVbVotFb4fJVOHi76essm6c5y+T3oTg
        MkfiqW6WdjQtsCepWCZBTIxEsSku91wKLIPXlEh7lBBkvScqJLHkyG3LxBpFAQY0uiBc/09vhDycx
        BWTuGqM1oyRAbd7j1lBECgFZK1rFKBJ17eP5X1gGEDFP15ZwRvOE4XOZ04cfiw31U08FfXjGX9WMJ
        /u5qpWxZE2eKrDggoxkeKtjKqzSVFDHnsYVwasj2N1KkPWjvKIZXFUsAgCPDPAFVbgIeOSE6xD3xQ
        dwZSUt17w==;
Received: from [216.240.19.104] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRgjZ-0004VH-Es; Mon, 04 Nov 2019 18:05:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH] block: avoid blk_bio_segment_split for small I/O operations
Date:   Mon,  4 Nov 2019 10:05:43 -0800
Message-Id: <20191104180543.23123-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blk_queue_split() adds significant overhead for small I/O operations.
Add a shortcut to avoid it for cases where we know we never need to
split.

Based on a patch from Ming Lei.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 48e6725b32ee..06eb38357b41 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -293,7 +293,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		unsigned int *nr_segs)
 {
-	struct bio *split;
+	struct bio *split = NULL;
 
 	switch (bio_op(*bio)) {
 	case REQ_OP_DISCARD:
@@ -309,6 +309,19 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 				nr_segs);
 		break;
 	default:
+		/*
+		 * All drivers must accept single-segments bios that are <=
+		 * PAGE_SIZE.  This is a quick and dirty check that relies on
+		 * the fact that bi_io_vec[0] is always valid if a bio has data.
+		 * The check might lead to occasional false negatives when bios
+		 * are cloned, but compared to the performance impact of cloned
+		 * bios themselves the loop below doesn't matter anyway.
+		 */
+		if ((*bio)->bi_vcnt == 1 &&
+		    (*bio)->bi_io_vec[0].bv_len <= PAGE_SIZE) {
+			*nr_segs = 1;
+			break;
+		}
 		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
 		break;
 	}
-- 
2.20.1

