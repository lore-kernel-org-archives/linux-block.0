Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721B2C433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 06:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiFSGGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiFSGGH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 02:06:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4CEEE31
        for <linux-block@vger.kernel.org>; Sat, 18 Jun 2022 23:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4XIFl+GSr1Z70cDCATlroa1XJidJO0+DPGUNsyOtRtI=; b=nDBFrUcDtKKimzNhMbtEimuqnE
        Z+Yu6T58CKMQbeJq93nhIp9XPUc/QuH8U0gTd3eB88D/Xnpo+7Je3uq7l19ATD0+CnGAQgW5jaKWr
        GPS+Dop9f5UmNtvb9FAj0K4U7Wl9ZXXL1+NOLbVcPop3S6hzJPyLoaV9bPDL/P08uDCQsI6GgtOS3
        CuzFJ9uW0Ath5uF/EkBz5uUvxhMMO5lZiP3oFZefI4Y5ndVpPyIvArpgROU33YDnQoB/sOzRzYX+X
        QhjSxYVZ8zr9LXAhBR8r2hCV2Z02zO1Blno54BIlLDRNoXcj//ToQHx27Rfqh18URpUmIv+0qPgkQ
        DQ0i+wTw==;
Received: from [2001:4bb8:189:7251:513c:d533:c6f1:1e56] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2o4T-00DJnF-Bk; Sun, 19 Jun 2022 06:06:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 4/6] block: stop setting the nomerges flags in blk_cleanup_queue
Date:   Sun, 19 Jun 2022 08:05:50 +0200
Message-Id: <20220619060552.1850436-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220619060552.1850436-1-hch@lst.de>
References: <20220619060552.1850436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These flags only apply to file system I/O, and all file system I/O is
already drained by del_gendisk and thus can't be in progress when
blk_cleanup_queue is called.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 088332984cd1b..2f418606e3bd3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -304,9 +304,6 @@ void blk_cleanup_queue(struct request_queue *q)
 	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 	blk_queue_start_drain(q);
 
-	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
-	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
-
 	/*
 	 * Drain all requests queued before DYING marking. Set DEAD flag to
 	 * prevent that blk_mq_run_hw_queues() accesses the hardware queues
-- 
2.30.2

