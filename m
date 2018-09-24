Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeIXNpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Sep 2018 09:45:32 -0400
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/10] block: don't include bug.h from bio.h
Date: Mon, 24 Sep 2018 09:43:55 +0200
Message-Id: <20180924074355.2802-11-hch@lst.de>
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

No need to pull in the BUG() defintion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index b3d47862b1b4..f447b0ebb288 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -21,7 +21,6 @@
 #include <linux/highmem.h>
 #include <linux/mempool.h>
 #include <linux/ioprio.h>
-#include <linux/bug.h>
 
 #ifdef CONFIG_BLOCK
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
-- 
2.19.0
