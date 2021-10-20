Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154A4C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3326135F
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJTOnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJTOnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:43:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87748C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KpJbjTlCJOZkqUQcPgI4Ykyfjw6kkbFP/II0aGgvmxw=; b=pKSuK709rcYGCvJN5LCIILEJ9a
        lQW80ipiw0I2kdGr7459A8s4mpG6SDyNWCU10QMXo3JLKacsFjnH9dk42KwAnQUz7SCmCDyAJqfUV
        HS3sBGrxpuSDhnv33/rzF451fIEruS5HpsxgW3mndT3atUh90FCcSkr3g9pdpTO3znT122aJQ1qMO
        3fWcBTNIE5KCtNJoeO2CXf+eTojcoTDjp3CtyQaPu223RpQ9S3Hi1/EvAIRcEI8DJkPynq+gdwj6l
        i9hvaANF7R5XNYcC8k6PYqAQ5Wfd+rTMW/6pEnUUBy3MPAgOqvpDs152qgV2ghpRB0I4DTE9Am7WY
        r1hOkTwA==;
Received: from [2001:4bb8:180:8777:a130:d02a:a9b5:7d80] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdCmU-004oFb-KE; Wed, 20 Oct 2021 14:41:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/4] blk-mq: only flush requests from the plug in blk_mq_submit_bio
Date:   Wed, 20 Oct 2021 16:41:16 +0200
Message-Id: <20211020144119.142582-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020144119.142582-1-hch@lst.de>
References: <20211020144119.142582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the call to blk_flush_plug_list in blk_mq_submit_bio with a
direct call to blk_mq_flush_plug_list.  This means we do not flush
plug callback from stackable devices, which doesn't really help with
the accumulated requests anyway, and it also means the cached requests
aren't freed here as they can still be used later on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 31d9e612d2360..9bb6ece419a5b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2571,7 +2571,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		}
 
 		if (request_count >= blk_plug_max_rq_count(plug) || last) {
-			blk_flush_plug_list(plug, false);
+			blk_mq_flush_plug_list(plug, false);
 			trace_block_plug(q);
 		}
 
-- 
2.30.2

