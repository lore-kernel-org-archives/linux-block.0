Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36174 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933554AbcJ2IMz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:12:55 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Joern Engel <joern@logfs.org>,
        Prasad Joshi <prasadjoshi.linux@gmail.com>,
        logfs@logfs.org (open list:LogFS)
Subject: [PATCH 13/60] fs: logfs: remove unnecesary check
Date: Sat, 29 Oct 2016 16:08:12 +0800
Message-Id: <1477728600-12938-14-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The check on bio->bi_vcnt doesn't make sense in erase_end_io().

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/logfs/dev_bdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/logfs/dev_bdev.c b/fs/logfs/dev_bdev.c
index ff5e3e31bca3..f05a02ff43e6 100644
--- a/fs/logfs/dev_bdev.c
+++ b/fs/logfs/dev_bdev.c
@@ -144,7 +144,6 @@ static void erase_end_io(struct bio *bio)
 	struct logfs_super *super = logfs_super(sb); 
 
 	BUG_ON(bio->bi_error); /* FIXME: Retry io or write elsewhere */ 
-	BUG_ON(bio->bi_vcnt == 0); 
 	bio_put(bio); 
 	if (atomic_dec_and_test(&super->s_pending_writes))
 		wake_up(&wq); 
-- 
2.7.4

