Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A428FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 21:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiEWVuG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 17:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiEWVuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 17:50:05 -0400
X-Greylist: delayed 5425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 14:50:01 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE0526C1
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XGWyS9M4v/8rYbPomtgL43gdQZPyiCqFsQGUPRBoEE8=; b=jNJY8+U4ieTF5pw5yCPUYrQQeJ
        eAMrGcxb8toU27SrvnmOckiH2cW5J3IbdrTHEVBhFqcikl3MlZsyS6tR7cLki+4Gelg+bdRF+mKFd
        icOXGQlihA0qFmnNRTH+QA/NRc4V62c74evkbg9IRBzAPnEhgA0wJlQDDe/w0p7RTHG7bfo+mMOo7
        zu1b7ndtsmvkItGFlj5+v5SiRb4xw5OZZP6VpZtwtxPGg6yS6K651JQk5Xim5R8415uFb7GYH1DQh
        9GGbwlG6azepMd8cfZhAQ/mlW3cUFBEmPik5KaUG2/t0wGPOCsWPs8+o4lDkQ2jwFgJq0Ext4sboh
        aBLvia6Q==;
Received: from [2001:4bb8:18c:7298:c299:b72c:6660:451c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nt7Or-004Fq2-5z; Mon, 23 May 2022 12:43:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: use bio_queue_enter instead of blk_queue_enter in bio_poll
Date:   Mon, 23 May 2022 14:43:02 +0200
Message-Id: <20220523124302.526186-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We want to have a valid live gendisk to call ->poll and not just a
request_queue, so call the right helper.

Fixes: 3e08773c3841 ("block: switch polling to be bio based")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 80fa73c419a99..06ff5bbfe8f66 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -939,7 +939,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 
 	blk_flush_plug(current->plug, false);
 
-	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
+	if (bio_queue_enter(bio))
 		return 0;
 	if (queue_is_mq(q)) {
 		ret = blk_mq_poll(q, cookie, iob, flags);
-- 
2.30.2

