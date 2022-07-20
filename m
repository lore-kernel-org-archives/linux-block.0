Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C28C43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 13:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiGTNFs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 09:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiGTNFr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 09:05:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171BC13CF8
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vix19VrwCIHN0eigioAKgAgnGNGZBJFPLp0LOK/gSUo=; b=inMbf21SAKExWurbfwom39n/iV
        AqLuZevSIapL7m7vAsme/JbvUcXjWShgg96ObnwkdAtSB9aLC/W5ZyEkb9aLvCOH6oonWc/IdUpb/
        cRtXA4L6d3KbJ442DIGcxmEDLw4XdCrFzYyI3lLl7vXZ9rouCX98qdAP7VW8RY2oOOpBW2N9NZgKd
        ic2l8wEKrwwU+TpWXtszD8ZRrDo6FzIliZYyCpzKs9P7mIFxH7i+b7Jd+EXNkJOHVSsQiJYKj0r/5
        KsG8jXbDqn1/LV+muO7eTYY0VaBQ4++WpSjH+GBSmNawZfdEmqUh8GRzRGgn/4crJMm1BChT4lm7q
        3N7Nsiug==;
Received: from 089144204193.atnat0013.highway.webapn.at ([89.144.204.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE9Oa-005iSn-Im; Wed, 20 Jul 2022 13:05:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: fix error handling in __blk_mq_alloc_disk
Date:   Wed, 20 Jul 2022 15:05:40 +0200
Message-Id: <20220720130541.1323531-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To fully clean up the queue if the disk allocation fails we need to
call blk_mq_destroy_queue and not just blk_put_queue.

Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d716b7f3763f3..70177ee74295b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3960,7 +3960,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 
 	disk = __alloc_disk_node(q, set->numa_node, lkclass);
 	if (!disk) {
-		blk_put_queue(q);
+		blk_mq_destroy_queue(q);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(GD_OWNS_QUEUE, &disk->state);
-- 
2.30.2

