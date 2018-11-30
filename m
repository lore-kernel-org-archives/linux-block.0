Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD068C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBFA20863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBFA20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeK3Tqu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:46:50 -0500
Received: from verein.lst.de ([213.95.11.211]:48868 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3Tqu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 14:46:50 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2600968BDF; Fri, 30 Nov 2018 09:38:16 +0100 (CET)
Date:   Fri, 30 Nov 2018 09:38:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: avoid extra bio reference for async O_DIRECT
Message-ID: <20181130083815.GE18936@lst.de>
References: <b890e540-fc63-13c1-bef0-1e6a39d1850e@kernel.dk> <e834208c-bb4b-820a-28c9-918e92afa295@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e834208c-bb4b-820a-28c9-918e92afa295@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I like the idea, but I don't think it is correct as-is.  We can't just
move the blkdev_bio_dirty_release for the last bio into the caller, as
the completion order that decrements the refcount might have different
ordering.

Something like the simpler patch below might archive your goal, though:

---
From 923ee8e2358de04037ba6f7269aaf321f7b2e173 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 30 Nov 2018 09:23:48 +0100
Subject: block: avoid extra bio reference for async O_DIRECT

The bio referencing has a trick that doesn't do any actual atomic
inc/dec on the reference count until we have to elevator to > 1. For the
async IO O_DIRECT case, we can't use the simple DIO variants, so we use
__blkdev_direct_IO(). It always grabs an extra reference to the bio
after allocation, which means we then enter the slower path of actually
having to do atomic_inc/dec on the count.

We don't need to do that for the async case, unless we end up going
multi-bio, in which case we're already doing huge amounts of IO. For the
smaller IO case (< BIO_MAX_PAGES), we can do without the extra ref.

Based on an earlier patch (and commit log) from Jens Axboe.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d233a59ea364..e1886cc7048f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -302,7 +302,8 @@ static void blkdev_bio_end_io(struct bio *bio)
 			}
 
 			dio->iocb->ki_complete(iocb, ret, 0);
-			bio_put(&dio->bio);
+			if (dio->multi_bio)
+				bio_put(&dio->bio);
 		} else {
 			struct task_struct *waiter = dio->waiter;
 
@@ -343,14 +344,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		return -EINVAL;
 
 	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
-	bio_get(bio); /* extra ref for the completion handler */
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
-	if (dio->is_sync)
+	if (dio->is_sync) {
 		dio->waiter = current;
-	else
+		bio_get(bio);
+	} else {
 		dio->iocb = iocb;
+	}
 
 	dio->size = 0;
 	dio->multi_bio = false;
@@ -400,6 +402,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		}
 
 		if (!dio->multi_bio) {
+			/*
+			 * AIO needs an extra reference to ensure the dio
+			 * structure which is embedded into the first bio
+			 * stays around.
+			 */
+			if (!is_sync)
+				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
 		} else {
-- 
2.19.1

