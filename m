Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DFBC433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 07:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiKVH2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 02:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiKVH2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 02:28:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C267BC91
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 23:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XsksVogVfSuMgS02JTH2wmmAM1tAmfxE2mNkOwQ/JxQ=; b=fHSxHkbSG7f3ny3kSj3qUYWzRJ
        jhuIyOY6Uyk84Q58PrEQxO6QXNmvW3O+UK4/2P/K8MHG/sNG9GiNkXAixHwLp+ScilM6FntCwix3a
        xAhgZ5QN9l+gue55n+RpSAcG4o58xOE+swqdSgH3KCaC2qQJTY8YVlEcT9yGuAaVXboffAxe43eyA
        /h3rTjjGoA/ZqyjLaGqmA3kr87XrDTZeT7YcjS5F8b6NuL+Q2M5MrvzOjcn+d/ZSy6/uVuG3Ax+1y
        3Dn8V7jBLuKBTi8Ozl5xURU5PVqW/nY2Fnd5tHLti2xvrylk0wmybz2S8kv0vJyTM/wVHET5CJGLk
        QtUrnc6Q==;
Received: from [2001:4bb8:199:6d04:dcd2:c84e:1bc9:2053] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxNhD-005adr-BZ; Tue, 22 Nov 2022 07:27:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] blk-mq: fix queue reference leak on blk_mq_alloc_disk_for_queue failure
Date:   Tue, 22 Nov 2022 08:27:53 +0100
Message-Id: <20221122072753.426077-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop the disk reference just acquired when __alloc_disk_node failed.

Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a3a5fb4d4ef667..02a1f6e501ea8d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4108,9 +4108,14 @@ EXPORT_SYMBOL(__blk_mq_alloc_disk);
 struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
 		struct lock_class_key *lkclass)
 {
+	struct gendisk *disk;
+
 	if (!blk_get_queue(q))
 		return NULL;
-	return __alloc_disk_node(q, NUMA_NO_NODE, lkclass);
+	disk = __alloc_disk_node(q, NUMA_NO_NODE, lkclass);
+	if (!disk)
+		blk_put_queue(q);
+	return disk;
 }
 EXPORT_SYMBOL(blk_mq_alloc_disk_for_queue);
 
-- 
2.30.2

