Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2D4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 05:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiGUFQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiGUFQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:16:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080279ECA
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DvETBB5agZp7ygVb4rCORiayjfYhnL2Zion3w5qgXrs=; b=nbVk0ULGKH3faDzm5CPvQ3I0PP
        6Y7UUB9dsaCEeGMIc1XfRtd7xfte/TrDH7L8CHL8fOtAbshHhaBV3/F0rUZi7bR9H1EnZqR3+tPfl
        FgzcN5fL3ZrdecH1+YXxrd+8l5v/VH/QsripNxWcXD1faiggZ4hzMVz6ReyxdTJIVfQdXQ/H96yO9
        /zul3SgtPUrKLOoQnWHni9EYnJlQ+Ak/PEoEVctFc9LcTSJ+y1ydN2rBbttpF73n/krEZqBDAmB/K
        ANBlYIYvE4tZh8QZtHiktpxo1dp/FI3mkg4u1HTjgnnVY+RqGZ7SjypyBxHTsb7ZvZREOkwmPDX3e
        aX8sHKfQ==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEOYI-00HDWp-B2; Thu, 21 Jul 2022 05:16:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/8] ublk: remove the empty open and release block device operations
Date:   Thu, 21 Jul 2022 07:16:27 +0200
Message-Id: <20220721051632.1676890-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721051632.1676890-1-hch@lst.de>
References: <20220721051632.1676890-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need to define empty versions, they can just be left out.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ublk_drv.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 07913b5bccd90..deabcb23ae2af 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -208,19 +208,8 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
-static int ublk_open(struct block_device *bdev, fmode_t mode)
-{
-	return 0;
-}
-
-static void ublk_release(struct gendisk *disk, fmode_t mode)
-{
-}
-
 static const struct block_device_operations ub_fops = {
 	.owner =	THIS_MODULE,
-	.open =		ublk_open,
-	.release =	ublk_release,
 };
 
 #define UBLK_MAX_PIN_PAGES	32
-- 
2.30.2

