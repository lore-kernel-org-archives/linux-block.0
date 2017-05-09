Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:45155 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752403AbdF3KVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:21:20 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id C22053E567F
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:21:08 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id 0946AB40084
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:21:08 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Tang Junhui <tang.junhui@zte.com.cn>
Date: Tue, 9 May 2017 12:05:08 -0700
Subject: [PATCH 02/19] bcache: fix sequential large write IO bypass
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-block@vger.kernel.org
Message-Id: <20170629222107.D41A5100128@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Sequential write IOs were tested with bs=1M by FIO in writeback cache
mode, these IOs were expected to be bypassed, but actually they did not.
We debug the code, and find in check_should_bypass():
    if (!congested &&
        mode == CACHE_MODE_WRITEBACK &&
        op_is_write(bio_op(bio)) &&
        (bio-＞bi_opf & REQ_SYNC))
        goto rescale
that means, If in writeback mode, a write IO with REQ_SYNC flag will not
be bypassed though it is a sequential large IO, It's not a correct thing
to do actually, so this patch remove these codes.

Signed-off-by: tang.junhui <tang.junhui@zte.com.cn>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Eric Wheeler <bcache@linux.ewheeler.net>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/request.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 019b3df..958072a 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -400,12 +400,6 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 	if (!congested && !dc->sequential_cutoff)
 		goto rescale;
 
-	if (!congested &&
-	    mode == CACHE_MODE_WRITEBACK &&
-	    op_is_write(bio->bi_opf) &&
-	    op_is_sync(bio->bi_opf))
-		goto rescale;
-
 	spin_lock(&dc->io_lock);
 
 	hlist_for_each_entry(i, iohash(dc, bio->bi_iter.bi_sector), hash)
-- 
1.8.3.1
