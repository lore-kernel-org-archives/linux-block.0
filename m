Return-Path: <BATV+afefc9c3360d6e01bea6+5510+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/10] block: don't include io.h from bio.h
Date: Mon, 24 Sep 2018 09:43:54 +0200
Message-Id: <20180924074355.2802-10-hch@lst.de>
In-Reply-To: <20180924074355.2802-1-hch@lst.de>
References: <20180924074355.2802-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Now that we don't need an override for BIOVEC_PHYS_MERGEABLE there is
no need to drag this header in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9ad4b0a487a4..b3d47862b1b4 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -24,9 +24,6 @@
 #include <linux/bug.h>
 
 #ifdef CONFIG_BLOCK
-
-#include <asm/io.h>
-
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
 
-- 
2.19.0
