Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF12ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIUSFM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIUSFL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FD03A4BE
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bTfM3bNRIg/e7R4RrMzFmzwCVdFY/XV/QvD+iCF4hQI=; b=B5zSS7itGb+cf1UpnJh33snzdo
        RnpLKEAdVbwuz0GbKOjki8dBrVdY6i5PlgTSlVz6HEAcOmjbryKbFaIInydRG4Yq8PCj5KmtNWCUC
        vLbhrY/J7HYP7YqDaihkZVypjCWkKY/JcydYlvRc3DRGPTdP4RygZjj5UpMDVlMT1KSoIAAQ1SrX8
        qS6CW2H13dCKXtzC5HeHTf+3ZqYP9nL1ZlAUJ06lx9yZIawxYsvgcMqGHGNHY4ebwc1ugJ2i0C6ly
        rIC9i1zKIbBqPhbzI5yIvCMVfTAiY4hHDRCy6av1IHRnbn3SLhrQgNI07zd73KOJBbTQrqIgeFpFl
        ZnGSG+8A==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob45t-00CGWH-6S; Wed, 21 Sep 2022 18:05:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 02/17] blk-cgroup: remove blk_queue_root_blkg
Date:   Wed, 21 Sep 2022 20:04:46 +0200
Message-Id: <20220921180501.1539876-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just open code it in the only caller and drop the unused !BLK_CGROUP
stub.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c |  3 +--
 block/blk-cgroup.h | 13 -------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3a88f8c011d27..4180de4cbb3e1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -915,8 +915,7 @@ static void blkcg_fill_root_iostats(void)
 	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
 	while ((dev = class_dev_iter_next(&iter))) {
 		struct block_device *bdev = dev_to_bdev(dev);
-		struct blkcg_gq *blkg =
-			blk_queue_root_blkg(bdev_get_queue(bdev));
+		struct blkcg_gq *blkg = bdev->bd_disk->queue->root_blkg;
 		struct blkg_iostat tmp;
 		int cpu;
 		unsigned long flags;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index d2724d1dd7c9b..c1fb00a1dfc03 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -268,17 +268,6 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 	return __blkg_lookup(blkcg, q, false);
 }
 
-/**
- * blk_queue_root_blkg - return blkg for the (blkcg_root, @q) pair
- * @q: request_queue of interest
- *
- * Lookup blkg for @q at the root level. See also blkg_lookup().
- */
-static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
-{
-	return q->root_blkg;
-}
-
 /**
  * blkg_to_pdata - get policy private data
  * @blkg: blkg of interest
@@ -507,8 +496,6 @@ struct blkcg {
 };
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
-static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
-{ return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_exit_queue(struct request_queue *q) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
-- 
2.30.2

