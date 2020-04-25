Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E276C55191
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF53206B6
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q/KQ1+Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgDYRKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYRKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:10:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A302AC09B04D
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Hc6E0OdOnGTicQJSOqDTI3VlToLxubDcP2v4Ef4g7Ns=; b=q/KQ1+QcAsjO/Q4l6Y1TXBRxsH
        QPuQn8Q/1HooYDD3e4VD043QkJ8ss6lfGwg+UhRg4XTtDB8x8MNOBf9d9glW9Lhmofwxt+lszoila
        9KzyhEBmiJvb7XUkBVhDa7kLME2ghKq0Mfc3uWSnxu4FvNeAeo0FEm4DnWMmoG3CQUPGSAcg+jJeG
        GUz4zn68lV1RG184IMJRief1m5sx7yvf6gwrVEdETpypuqK2gtHzjdc2xE3Zt9EMRwF8xjgnQKYyI
        Jgr05xa1iHYKqhhaDCMMNj8YSQauwNwGULw1Wkfp/dwP1QXQ+iXiQAW3hz0SfcpcGMxjSsoDG/Enz
        UUngbJyg==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJZ-0001zn-48; Sat, 25 Apr 2020 17:10:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 07/11] block: optimize do_make_request for direct to blk-mq issue
Date:   Sat, 25 Apr 2020 19:09:40 +0200
Message-Id: <20200425170944.968861-8-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425170944.968861-1-hch@lst.de>
References: <20200425170944.968861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't bother with reshuffling the on-stack bio list if we know that we
directly issue to a request based driver that can't re-inject bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e8c48203b2c55..d196799e68881 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1035,10 +1035,7 @@ static blk_qc_t do_make_request(struct bio *bio,
 
 	if (unlikely(bio_queue_enter(bio) != 0))
 		return BLK_QC_T_NONE;
-	if (q->make_request_fn)
-		ret = q->make_request_fn(q, bio);
-	else
-		ret = blk_mq_make_request(q, bio);
+	ret = q->make_request_fn(q, bio);
 	blk_queue_exit(q);
 
 	/*
@@ -1092,7 +1089,10 @@ static blk_qc_t __generic_make_request(struct bio *bio)
 
 	current->bio_list = bio_list_on_stack;
 	do {
-		ret = do_make_request(bio, bio_list_on_stack);
+		if (bio->bi_disk->queue->make_request_fn)
+			ret = do_make_request(bio, bio_list_on_stack);
+		else
+			ret = __direct_make_request(bio);
 	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
 	current->bio_list = NULL; /* deactivate */
 
-- 
2.26.1

