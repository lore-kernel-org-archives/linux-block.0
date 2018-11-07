Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH] block: Clear kernel memory before copying to user
Date: Wed,  7 Nov 2018 07:37:45 -0700
Message-Id: <20181107143745.11845-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

If the kernel allocates a bounce buffer for user read data, this memory
needs to be cleared before copying it to the user, otherwise it may leak
kernel memory to user space.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index d5368a445561..a50d59236b19 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1260,6 +1260,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
 		if (ret)
 			goto cleanup;
 	} else {
+		zero_fill_bio(bio);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 	}
 
-- 
2.14.4
