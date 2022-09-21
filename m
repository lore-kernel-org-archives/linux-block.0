Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4670ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIUSFu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIUSFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D585181B13
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=c/oYbdpDHJldsOvPDT6O3MgxnDn9hwNYDWixStZw2TQ=; b=X2fJsBAnwEeaDwOMJWvuoo+QI1
        KoSOfSFpOx5ibjq5z71vEQGzKxr3TJnIimVfshPpPqbp5qF8NMpAaOQBZPvekTJ45YXmaoIy6zYDh
        JZBOyr0ewNVjka3ZU2UA930nKt5sHddI3XlX8lKfgDXxOGf6JiJ/QcQ9uz8kVHkZ9a7eissx9CQ8q
        OG7JNRyI17IVgn23gxDMFw+XONEsYizhLSSTIvmRCgQiLUL7YfXyhqxEX4Lm8WGJx5FjNrmzo5TT2
        EA0O+PYcYzEPtyxLAlv/ZelmmJMW9Sc2AiGkVi3Kkc/KHjn5IEuAhRLLPJiBEOiOYIfbQdQcj4Nyx
        lqrFgJ6A==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob46N-00CGcr-DE; Wed, 21 Sep 2022 18:05:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 13/17] blk-throttle: pass a gendisk to blk_throtl_register_queue
Date:   Wed, 21 Sep 2022 20:04:57 +0200
Message-Id: <20220921180501.1539876-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the gendisk to blk_throtl_register_queue as part of moving the
blk-cgroup infrastructure to be gendisk based.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c    | 2 +-
 block/blk-throttle.c | 3 ++-
 block/blk-throttle.h | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e1f009aba6fd2..e71b3b43927c0 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -844,7 +844,7 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	wbt_enable_default(q);
-	blk_throtl_register_queue(q);
+	blk_throtl_register(disk);
 
 	/* Now everything is ready and send out KOBJ_ADD uevent */
 	kobject_uevent(&q->kobj, KOBJ_ADD);
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 9ca8ae0ae6683..a9709d4af6f39 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2415,8 +2415,9 @@ void blk_throtl_exit(struct gendisk *disk)
 	kfree(q->td);
 }
 
-void blk_throtl_register_queue(struct request_queue *q)
+void blk_throtl_register(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct throtl_data *td;
 	int i;
 
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index f75852a4e5337..7e217e613aee2 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -170,13 +170,13 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
 #ifndef CONFIG_BLK_DEV_THROTTLING
 static inline int blk_throtl_init(struct gendisk *disk) { return 0; }
 static inline void blk_throtl_exit(struct gendisk *disk) { }
-static inline void blk_throtl_register_queue(struct request_queue *q) { }
+static inline void blk_throtl_register(struct gendisk *disk) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
 static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
 #else /* CONFIG_BLK_DEV_THROTTLING */
 int blk_throtl_init(struct gendisk *disk);
 void blk_throtl_exit(struct gendisk *disk);
-void blk_throtl_register_queue(struct request_queue *q);
+void blk_throtl_register(struct gendisk *disk);
 bool __blk_throtl_bio(struct bio *bio);
 void blk_throtl_cancel_bios(struct request_queue *q);
 static inline bool blk_throtl_bio(struct bio *bio)
-- 
2.30.2

