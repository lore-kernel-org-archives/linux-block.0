Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E04C6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiIUSFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiIUSFs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC077560
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wQ9tdr8wVaRfEFDMhvcBgpLqBIwQryTcTsHMB5YwlXw=; b=Fck2WLFmyjHmS6wL/YCRh6T8MD
        CGhwO+SMz2oivsSSC8ww0Eu2ph00dr3xW7QqfR0RKTik4H9f8brdeJMeYWmnaMSWFpqnsoznek2mP
        /nE/pgqGVf8K3RxYd8qUxCtKFRGwV3RrXnuIP0Ms2395CZTcTgTTX9X/cmB6EHbAvPr/kjLNtBX6u
        7+QQU307KKItw389GAK9uTd2PK7GjjYV340QchZ19mQjJ0OIX4aXDgEjS2Z5q4ophjtFauClxGBwP
        r6BZPzkCdlqzdekm2Ut5w1ub7QC7hrJz8yBvCaNnA7RMX30oEp0ACkWDnceQ2Eyy9gAyXMtA5VoI+
        nCtjmLJg==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob46P-00CGd4-I4; Wed, 21 Sep 2022 18:05:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 14/17] blk-throttle: pass a gendisk to blk_throtl_cancel_bios
Date:   Wed, 21 Sep 2022 20:04:58 +0200
Message-Id: <20220921180501.1539876-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the gendisk to blk_throtl_cancel_bios as part of moving the
blk-cgroup infrastructure to be gendisk based.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-throttle.c | 3 ++-
 block/blk-throttle.h | 4 ++--
 block/genhd.c        | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a9709d4af6f39..8c683d5050483 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1723,8 +1723,9 @@ struct blkcg_policy blkcg_policy_throtl = {
 	.pd_free_fn		= throtl_pd_free,
 };
 
-void blk_throtl_cancel_bios(struct request_queue *q)
+void blk_throtl_cancel_bios(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct cgroup_subsys_state *pos_css;
 	struct blkcg_gq *blkg;
 
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 7e217e613aee2..143991fd13228 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -172,13 +172,13 @@ static inline int blk_throtl_init(struct gendisk *disk) { return 0; }
 static inline void blk_throtl_exit(struct gendisk *disk) { }
 static inline void blk_throtl_register(struct gendisk *disk) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
-static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
+static inline void blk_throtl_cancel_bios(struct gendisk *disk) { }
 #else /* CONFIG_BLK_DEV_THROTTLING */
 int blk_throtl_init(struct gendisk *disk);
 void blk_throtl_exit(struct gendisk *disk);
 void blk_throtl_register(struct gendisk *disk);
 bool __blk_throtl_bio(struct bio *bio);
-void blk_throtl_cancel_bios(struct request_queue *q);
+void blk_throtl_cancel_bios(struct gendisk *disk);
 static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
diff --git a/block/genhd.c b/block/genhd.c
index f1af045fac2fe..d6a21803a57e2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -626,7 +626,7 @@ void del_gendisk(struct gendisk *disk)
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
 	device_del(disk_to_dev(disk));
 
-	blk_throtl_cancel_bios(disk->queue);
+	blk_throtl_cancel_bios(disk);
 
 	blk_sync_queue(q);
 	blk_flush_integrity();
-- 
2.30.2

