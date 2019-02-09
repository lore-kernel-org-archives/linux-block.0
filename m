Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D43EC282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2451921903
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBIEyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:54:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:57968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfBIEyX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:54:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1EA0EABA1;
        Sat,  9 Feb 2019 04:54:22 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, stable@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 19/19] bcache: use (REQ_META|REQ_PRIO) to indicate bio for metadata
Date:   Sat,  9 Feb 2019 12:53:11 +0800
Message-Id: <20190209045311.15677-20-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
References: <20190209045311.15677-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In 'commit 752f66a75aba ("bcache: use REQ_PRIO to indicate bio for
metadata")' REQ_META is replaced by REQ_PRIO to indicate metadata bio.
This assumption is not always correct, e.g. XFS uses REQ_META to mark
metadata bio other than REQ_PRIO. This is why Nix noticed that bcache
does not cache metadata for XFS after the above commit.

Thanks to Dave Chinner, he explains the difference between REQ_META and
REQ_PRIO from view of file system developer. Here I quote part of his
explanation from mailing list,
   REQ_META is used for metadata. REQ_PRIO is used to communicate to
   the lower layers that the submitter considers this IO to be more
   important that non REQ_PRIO IO and so dispatch should be expedited.

   IOWs, if the filesystem considers metadata IO to be more important
   that user data IO, then it will use REQ_PRIO | REQ_META rather than
   just REQ_META.

Then it seems bios with REQ_META or REQ_PRIO should both be cached for
performance optimation, because they are all probably low I/O latency
demand by upper layer (e.g. file system).

So in this patch, when we want to decide whether to bypass the cache,
REQ_META and REQ_PRIO are both checked. Then both metadata and
high priority I/O requests will be handled properly.

Reported-by: Nix <nix@esperi.org.uk>
Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Andre Noll <maan@tuebingen.mpg.de>
Tested-by: Nix <nix@esperi.org.uk>
Cc: stable@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/request.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 15070412a32e..f101bfe8657a 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -392,10 +392,11 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 
 	/*
 	 * Flag for bypass if the IO is for read-ahead or background,
-	 * unless the read-ahead request is for metadata (eg, for gfs2).
+	 * unless the read-ahead request is for metadata
+	 * (eg, for gfs2 or xfs).
 	 */
 	if (bio->bi_opf & (REQ_RAHEAD|REQ_BACKGROUND) &&
-	    !(bio->bi_opf & REQ_PRIO))
+	    !(bio->bi_opf & (REQ_META|REQ_PRIO)))
 		goto skip;
 
 	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
@@ -877,7 +878,7 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 	}
 
 	if (!(bio->bi_opf & REQ_RAHEAD) &&
-	    !(bio->bi_opf & REQ_PRIO) &&
+	    !(bio->bi_opf & (REQ_META|REQ_PRIO)) &&
 	    s->iop.c->gc_stats.in_use < CUTOFF_CACHE_READA)
 		reada = min_t(sector_t, dc->readahead >> 9,
 			      get_capacity(bio->bi_disk) - bio_end_sector(bio));
-- 
2.16.4

