Return-Path: <prvs=547e67762=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH] block: Fix __bio_integrity_endio() documentation
Date: Tue, 16 Jan 2018 10:31:39 -0800
Message-Id: <20180116183139.29777-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Fixes: 4246a0b63bd8 ("block: add a bi_error field to struct bio")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 block/bio-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 23b42e8aa03e..9cfdd6c83b5b 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -374,7 +374,6 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 /**
  * __bio_integrity_endio - Integrity I/O completion function
  * @bio:	Protected bio
- * @error:	Pointer to errno
  *
  * Description: Completion for integrity I/O
  *
-- 
2.15.1
