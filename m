Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C5CECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIUSFd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiIUSFa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570857B1E3
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=m84afpL5prFOgaNXA7vh6+aTkXGzVZ6kkXcHwhvJMEQ=; b=36vSP5rVqaLffVLnTpkCj4l3wY
        fvyHqoDF6ZnT78jJA8VVdOzfRUK3OvRXL/+q0/dB3ca6O3t1y5oFoLikx9ODBT92vpMPW3oArnK/f
        cfNIcv+3xtDK7Kte6iSN5JGE/Aru89rfh4LLG0Wqt6dQjBA+FpHje3kApNec4V3hLWGLvKzJnoX35
        egbnBsSRxN6pk80NdNdFnDrRfoPGA5+8L1RKwI0hZuiuV+ot7s+L62NVttliYUBwAjeRip5HZ/TgP
        +Gzu2XEqe6AQl5xqDCWNqmm+BufQtRvZskQCSd/F4foTT3DC6R3jgv2GYGEPz0q8LUkcXxGxvWbEm
        5F0sAWWA==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob46A-00CGaE-T6; Wed, 21 Sep 2022 18:05:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 10/17] blk-iocost: pass a gendisk to blk_iocost_init
Date:   Wed, 21 Sep 2022 20:04:54 +0200
Message-Id: <20220921180501.1539876-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the gendisk to blk_iocost_init as part of moving the blk-cgroup
infrastructure to be gendisk based.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-iocost.c | 7 ++++---
 block/blk.h        | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index cba9d3ad58e16..1e7bf0d353227 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2828,8 +2828,9 @@ static struct rq_qos_ops ioc_rqos_ops = {
 	.exit = ioc_rqos_exit,
 };
 
-static int blk_iocost_init(struct request_queue *q)
+static int blk_iocost_init(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct ioc *ioc;
 	struct rq_qos *rqos;
 	int i, cpu, ret;
@@ -3178,7 +3179,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	ioc = q_to_ioc(bdev_get_queue(bdev));
 	if (!ioc) {
-		ret = blk_iocost_init(bdev_get_queue(bdev));
+		ret = blk_iocost_init(bdev->bd_disk);
 		if (ret)
 			goto err;
 		ioc = q_to_ioc(bdev_get_queue(bdev));
@@ -3345,7 +3346,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 
 	ioc = q_to_ioc(bdev_get_queue(bdev));
 	if (!ioc) {
-		ret = blk_iocost_init(bdev_get_queue(bdev));
+		ret = blk_iocost_init(bdev->bd_disk);
 		if (ret)
 			goto err;
 		ioc = q_to_ioc(bdev_get_queue(bdev));
diff --git a/block/blk.h b/block/blk.h
index 361db83147c6f..8d5c7a6f52a66 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -391,7 +391,7 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 #ifdef CONFIG_BLK_CGROUP_IOLATENCY
 int blk_iolatency_init(struct gendisk *disk);
 #else
-static int blk_iolatency_init(struct gendisk *disk) { return 0 };
+static int blk_iolatency_init(struct gendisk *disk) { return 0; }
 #endif
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.30.2

