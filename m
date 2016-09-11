Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755780AbcIKODK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Sep 2016 10:03:10 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: remove bio_destructor_t
Date: Sun, 11 Sep 2016 16:03:02 +0200
Message-Id: <1473602584-11744-2-git-send-email-hch@lst.de>
In-Reply-To: <1473602584-11744-1-git-send-email-hch@lst.de>
References: <1473602584-11744-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 436f43f..a2f4add 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -16,7 +16,6 @@ struct block_device;
 struct io_context;
 struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
-typedef void (bio_destructor_t) (struct bio *);
 
 #ifdef CONFIG_BLOCK
 /*
-- 
2.1.4

