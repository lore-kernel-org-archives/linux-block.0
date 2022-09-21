Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BA2ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiIUSFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiIUSFs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5B79A6BE
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mTO2xyShL8zgP6UvfFBZpZO4j+pjtCEHQisdr1z3Mq4=; b=i9pXFyF5w8J7CM2a1b8grfKVw6
        GgFjP1BdXLNzAnihFAhBRnUsfYMdH0Z9968UuBTQcyESy4YADhbrtdNZ+Ufst9R8oEIg+a4+CMZ6A
        dOkhgSD+0xWCs4FRnY5up5d7za3zY64bnjXNyuEiQBoSV04Pd4OijziVW8Cks2pBgGdq5p08bYiSC
        vwyi61KrJcAGefw7I2x9y72x0EmSPWju8TcW9xHe+3ruJGRgeXIjFSfYkBWhcmKDq/6xovT/zXEKN
        /7HBXu7HMx2GUSJqPoNACZDrYTHiPMnktXziByMSHMCOKN56XDw6YGnwdeJhAxSH4s41o648Hu8wl
        kSXodCLA==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob46R-00CGdV-Nm; Wed, 21 Sep 2022 18:05:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 15/17] blk-cgroup: pass a gendisk to blkg_destroy_all
Date:   Wed, 21 Sep 2022 20:04:59 +0200
Message-Id: <20220921180501.1539876-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the gendisk to blkg_destroy_all as part of moving the blk-cgroup
infrastructure to be gendisk based.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3dfd78f1312db..c2d5ca2eb92e5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -462,14 +462,9 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	percpu_ref_kill(&blkg->refcnt);
 }
 
-/**
- * blkg_destroy_all - destroy all blkgs associated with a request_queue
- * @q: request_queue of interest
- *
- * Destroy all blkgs associated with @q.
- */
-static void blkg_destroy_all(struct request_queue *q)
+static void blkg_destroy_all(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg, *n;
 	int count = BLKG_DESTROY_BATCH_SIZE;
 
@@ -1276,7 +1271,7 @@ int blkcg_init_disk(struct gendisk *disk)
 err_ioprio_exit:
 	blk_ioprio_exit(disk);
 err_destroy_all:
-	blkg_destroy_all(q);
+	blkg_destroy_all(disk);
 	return ret;
 err_unlock:
 	spin_unlock_irq(&q->queue_lock);
@@ -1287,7 +1282,7 @@ int blkcg_init_disk(struct gendisk *disk)
 
 void blkcg_exit_disk(struct gendisk *disk)
 {
-	blkg_destroy_all(disk->queue);
+	blkg_destroy_all(disk);
 	blk_throtl_exit(disk);
 }
 
-- 
2.30.2

