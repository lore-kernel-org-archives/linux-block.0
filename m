Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729051AbeIYWUf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Sep 2018 18:20:35 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH] bcache: use REQ_PRIO to indicate bio for metadata
Date: Wed, 26 Sep 2018 00:12:13 +0800
Message-Id: <20180925161213.15923-1-colyli@suse.de>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In cached_dev_cache_miss() and check_should_bypass(), REQ_META is used
to check whether a bio is for metadata request. REQ_META is used for
blktrace, the correct REQ_ flag should be REQ_PRIO. This flag means the
bio should be prior to other bio, and frequently be used to indicate
metadata io in file system code.

This patch replaces REQ_META with correct flag REQ_PRIO.

CC Adam Manzanares because he explains to me what REQ_PRIO is for.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Adam Manzanares <adam.manzanares@wdc.com>
---
 drivers/md/bcache/request.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 51be355a3309..13d3355a90c0 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -395,7 +395,7 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 	 * unless the read-ahead request is for metadata (eg, for gfs2).
 	 */
 	if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND) &&
-	    !(bio->bi_opf & REQ_META))
+	    !(bio->bi_opf & REQ_PRIO))
 		goto skip;
 
 	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
@@ -877,7 +877,7 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 	}
 
 	if (!(bio->bi_opf & REQ_RAHEAD) &&
-	    !(bio->bi_opf & REQ_META) &&
+	    !(bio->bi_opf & REQ_PRIO) &&
 	    s->iop.c->gc_stats.in_use < CUTOFF_CACHE_READA)
 		reada = min_t(sector_t, dc->readahead >> 9,
 			      get_capacity(bio->bi_disk) - bio_end_sector(bio));
-- 
2.19.0
