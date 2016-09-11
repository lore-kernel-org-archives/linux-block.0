Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49945 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755780AbcIKODP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Sep 2016 10:03:15 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: remove IOPRIO_BITS
Date: Sun, 11 Sep 2016 16:03:04 +0200
Message-Id: <1473602584-11744-4-git-send-email-hch@lst.de>
In-Reply-To: <1473602584-11744-1-git-send-email-hch@lst.de>
References: <1473602584-11744-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/ioprio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index beb9ce1..8c12390 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -7,7 +7,6 @@
 /*
  * Gives us 8 prio classes with 13-bits of data for each class
  */
-#define IOPRIO_BITS		(16)
 #define IOPRIO_CLASS_SHIFT	(13)
 #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
 
-- 
2.1.4

