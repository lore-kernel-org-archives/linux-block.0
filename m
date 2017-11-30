Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44941 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752599AbdK3OJQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Nov 2017 09:09:16 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: neilb@suse.com, axboe@fb.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] block: Set BIO_TRACE_COMPLETION on new bio during split
Date: Thu, 30 Nov 2017 08:08:14 -0600
Message-Id: <20171130140814.25871-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Fixes: fbbaf700e7b1 ("block: trace completion of all bios.")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 228229f3bb76..3f4940dd00da 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1836,7 +1836,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	bio_advance(bio, split->bi_iter.bi_size);
 
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
-		bio_set_flag(bio, BIO_TRACE_COMPLETION);
+		bio_set_flag(split, BIO_TRACE_COMPLETION);
 
 	return split;
 }
-- 
2.14.2
