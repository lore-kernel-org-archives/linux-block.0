Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A5C77B61
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 07:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDPHf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDPHf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 03:35:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE719AE
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OZwo1ZpM4yYcLMphoE1u2iirqt7c0SIC/ViSQ2GRcV4=; b=ocbxuRvxZqehasEVPuwqh0MGky
        lmSjoNzm1+WQVPupX4Tnd/W/8U9nGHWQyWfdNDTVs3sRr+DTOQDak8k3uFKsyeCaYjEjf7qo+Pd+w
        2NlVubNL5ovdUKmPn1fa5J7lZIgRGea+e50hcZBBf3i4D1KFRi4d2glqKYeSX5PqI8J5xLT6rLZpv
        r3gYz8rJten9HSBbJaDNa/I9Sb6jQYySiE+AyFq84nG9qf4ilmAfxpjNlEIEz268lvB1C8VfDBtwo
        pZWtm8M6hGRsjOWkBJ0Li0qPvRxt2qo9EnYrFOpfEUopEaRvwhTw8qusyimRrPARM6draPIm2eOj6
        o9/DrPRg==;
Received: from [2001:4bb8:192:2d6c:1ebd:68b7:179c:f32a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnwvT-00DJRQ-1N;
        Sun, 16 Apr 2023 07:35:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: fix the blk_mq_add_to_requeue_list call in blk_kick_flush
Date:   Sun, 16 Apr 2023 09:35:53 +0200
Message-Id: <20230416073553.966161-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit b12e5c6c755a accidentally changes blk_kick_flush to do a head
insert into the requeue list, fix this up.

Fixes: b12e5c6c755a ("blk-mq: pass a flags argument to blk_mq_add_to_requeue_list")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 00dd2f61312d89..04698ed9bcd4a9 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -346,7 +346,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	smp_wmb();
 	req_ref_set(flush_rq, 1);
 
-	blk_mq_add_to_requeue_list(flush_rq, BLK_MQ_INSERT_AT_HEAD);
+	blk_mq_add_to_requeue_list(flush_rq, 0);
 	blk_mq_kick_requeue_list(q);
 }
 
-- 
2.39.2

