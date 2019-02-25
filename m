Return-Path: <SRS0=QdhR=RA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42387C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Feb 2019 04:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BDB2084D
	for <linux-block@archiver.kernel.org>; Mon, 25 Feb 2019 04:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfBYEJQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Feb 2019 23:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfBYEJQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Feb 2019 23:09:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8540F3680A;
        Mon, 25 Feb 2019 04:09:15 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0FDD19C7B;
        Mon, 25 Feb 2019 04:09:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: [PATCH] xfs: allocate sector sized IO buffer via page_frag_alloc
Date:   Mon, 25 Feb 2019 12:09:04 +0800
Message-Id: <20190225040904.5557-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 25 Feb 2019 04:09:15 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

XFS uses kmalloc() to allocate sector sized IO buffer.

Turns out buffer allocated via kmalloc(sector sized) can't
be guaranteed to be 512 byte aligned, and actually slab only provides
ARCH_KMALLOC_MINALIGN alignment, even though it is observed
that the sector size allocation is often 512 byte aligned. When
KASAN or other memory debug options are enabled, the allocated
buffer becomes not aliged with 512 byte any more.

This unalgined IO buffer causes at least two issues:

1) some storage controller requires IO buffer to be 512 byte aligned,
and data corruption is observed

2) loop/dio requires the IO buffer to be logical block size aligned,
and loop's default logcial block size is 512 byte, then one xfs image
can't be mounted via loop/dio any more.

Use page_frag_alloc() to allocate the sector sized buffer, then the
above issue can be fixed because offset_in_page of allocated buffer
is always sector aligned.

Not see any regression with this patch on xfstests.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Christopher Lameter <cl@linux.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-block@vger.kernel.org
Link: https://marc.info/?t=153734857500004&r=1&w=2
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/xfs/xfs_buf.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 4f5f2ff3f70f..92b8cdf5e51c 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -340,12 +340,27 @@ xfs_buf_free(
 			__free_page(page);
 		}
 	} else if (bp->b_flags & _XBF_KMEM)
-		kmem_free(bp->b_addr);
+		page_frag_free(bp->b_addr);
 	_xfs_buf_free_pages(bp);
 	xfs_buf_free_maps(bp);
 	kmem_zone_free(xfs_buf_zone, bp);
 }
 
+static DEFINE_PER_CPU(struct page_frag_cache, xfs_frag_cache);
+
+static void *xfs_alloc_frag(int size)
+{
+	struct page_frag_cache *nc;
+	void *data;
+
+	preempt_disable();
+	nc = this_cpu_ptr(&xfs_frag_cache);
+	data = page_frag_alloc(nc, size, GFP_ATOMIC);
+	preempt_enable();
+
+	return data;
+}
+
 /*
  * Allocates all the pages for buffer in question and builds it's page list.
  */
@@ -368,7 +383,7 @@ xfs_buf_allocate_memory(
 	 */
 	size = BBTOB(bp->b_length);
 	if (size < PAGE_SIZE) {
-		bp->b_addr = kmem_alloc(size, KM_NOFS);
+		bp->b_addr = xfs_alloc_frag(size);
 		if (!bp->b_addr) {
 			/* low memory - use alloc_page loop instead */
 			goto use_alloc_page;
@@ -377,7 +392,7 @@ xfs_buf_allocate_memory(
 		if (((unsigned long)(bp->b_addr + size - 1) & PAGE_MASK) !=
 		    ((unsigned long)bp->b_addr & PAGE_MASK)) {
 			/* b_addr spans two pages - use alloc_page instead */
-			kmem_free(bp->b_addr);
+			page_frag_free(bp->b_addr);
 			bp->b_addr = NULL;
 			goto use_alloc_page;
 		}
-- 
2.9.5

