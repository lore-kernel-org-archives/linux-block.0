Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F70C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7002243E
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 17:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7002243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeKOD5O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:57:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbeKOD5N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 22:57:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9232C7F3E7;
        Wed, 14 Nov 2018 17:53:03 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 413715DD64;
        Wed, 14 Nov 2018 17:52:54 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id wAEHqrhr022066;
        Wed, 14 Nov 2018 12:52:53 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id wAEHqqBi022062;
        Wed, 14 Nov 2018 12:52:52 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 14 Nov 2018 12:52:52 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>
cc:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH] fix infinite loop in __blkdev_issue_discard
Message-ID: <alpine.LRH.2.02.1811141240050.18040@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 14 Nov 2018 17:53:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The "min_t(unsigned int" macro truncates both arguments to unsigned int. 
So, if we are running discard on a very big device with 2^32 or more 
sectors, the truncation may produce zero, resulting in infinite loop.

This patch fixes the infinite loop in the lvm test lvcreate-large-raid.sh

BTW. the patch 744889b7cbb56a64f957e65ade7cb65fe3f35714 that was committed 
between v4.19-rc8 and v4.19 also breaks discard by truncating sector_t to 
unsigned int (but it won't result in an infinite loop, it will result in 
an error instead). Should it be pulled out from the 4.19 long term branch? 
Or should we backport all the subsequent patches on the top of it?

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Zdenek Kabelac <zkabelac@redhat.com>
Fixes: ba5d73851e71 ("block: cleanup __blkdev_issue_discard()")
Fixes: 744889b7cbb5 ("block: don't deal with discard limit in blkdev_issue_discard()")
Cc: stable@vger.kernel.org	# v4.19

---
 block/blk-lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/block/blk-lib.c
===================================================================
--- linux-2.6.orig/block/blk-lib.c	2018-11-14 18:25:28.000000000 +0100
+++ linux-2.6/block/blk-lib.c	2018-11-14 18:33:04.000000000 +0100
@@ -55,7 +55,7 @@ int __blkdev_issue_discard(struct block_
 		return -EINVAL;
 
 	while (nr_sects) {
-		unsigned int req_sects = min_t(unsigned int, nr_sects,
+		unsigned int req_sects = min_t(sector_t, nr_sects,
 				bio_allowed_max_sectors(q));
 
 		bio = blk_next_bio(bio, 0, gfp_mask);
