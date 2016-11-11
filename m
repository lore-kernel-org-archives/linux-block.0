Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Joern Engel <joern@logfs.org>,
        Prasad Joshi <prasadjoshi.linux@gmail.com>,
        logfs@logfs.org (open list:LogFS)
Subject: [PATCH 12/12] fs: logfs: remove unnecesary check
Date: Fri, 11 Nov 2016 20:05:40 +0800
Message-Id: <1478865957-25252-13-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
References: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

The check on bio->bi_vcnt doesn't make sense in erase_end_io().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/logfs/dev_bdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/logfs/dev_bdev.c b/fs/logfs/dev_bdev.c
index b9188be0bf83..9bfa0151d7c9 100644
--- a/fs/logfs/dev_bdev.c
+++ b/fs/logfs/dev_bdev.c
@@ -143,7 +143,6 @@ static void erase_end_io(struct bio *bio)
 	struct logfs_super *super = logfs_super(sb); 
 
 	BUG_ON(bio->bi_error); /* FIXME: Retry io or write elsewhere */ 
-	BUG_ON(bio->bi_vcnt == 0); 
 	bio_put(bio); 
 	if (atomic_dec_and_test(&super->s_pending_writes))
 		wake_up(&wq); 
-- 
2.7.4

