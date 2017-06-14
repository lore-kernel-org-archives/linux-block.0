Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752445AbdFNQM1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2017 12:12:27 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V2 10/12] block: call __bio_free in bio_endio
Date: Wed, 14 Jun 2017 09:12:08 -0700
Message-Id: <6019e3e30918ea37c262d6dcdc89ee5edf2c84ed.1497455937.git.shli@fb.com>
In-Reply-To: <cover.1497455937.git.shli@fb.com>
References: <cover.1497455937.git.shli@fb.com>
In-Reply-To: <cover.1497455937.git.shli@fb.com>
References: <cover.1497455937.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

bio_free isn't a good place to free cgroup/integrity info. There are a
lot of cases bio is allocated in special way (for example, in stack) and
never gets called by bio_put hence bio_free, we are leaking memory. This
patch moves the free to bio endio, which should be called anyway. The
__bio_free call in bio_free is kept, in case the bio never gets called
bio endio.

This assumes ->bi_end_io() doesn't access cgroup/integrity info, which
seems true in my audit. Otherwise, we probably must add a flag to
distinguish if bio will be called by bio_put.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio-integrity.c | 1 +
 block/bio.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index b5009a8..869ac7a 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -120,6 +120,7 @@ void bio_integrity_free(struct bio *bio)
 	}
 
 	bio->bi_integrity = NULL;
+	bio->bi_opf &= ~REQ_INTEGRITY;
 }
 EXPORT_SYMBOL(bio_integrity_free);
 
diff --git a/block/bio.c b/block/bio.c
index 888e780..9bfd8d4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1823,6 +1823,8 @@ void bio_endio(struct bio *bio)
 	}
 
 	blk_throtl_bio_endio(bio);
+	/* release cgroup/integrity info */
+	__bio_free(bio);
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
-- 
2.9.3
