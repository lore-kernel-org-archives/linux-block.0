Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7ABC77B7C
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 12:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbjEKMWP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjEKMWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 08:22:14 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAA83ABE
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 05:22:11 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230511121548euoutp01af04e7a926dcff189d9739b2c150c3e8~eFdy3a-sJ3172631726euoutp01Z
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 12:15:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230511121548euoutp01af04e7a926dcff189d9739b2c150c3e8~eFdy3a-sJ3172631726euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683807348;
        bh=uA2KruwDO60X+BPGYxqFAOrfIAP6vOFftHyeUGgcSls=;
        h=From:To:CC:Subject:Date:References:From;
        b=DcsM8byUOT4yBe5/Qx3No/CSOmEjaXQjiYXb7Bb/4fe1e4h4FqC5RjQTSk5za6VCu
         cBRfCFaQ9u1oa4SKpixXbweJ4c5b0OgAVGQkNo1n0Rbw8A2GE+IELECAPEpErSfJij
         CtenPiPsDPbv2/BOf7XbNRalq9X/HcFY6oN3vVvs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511121548eucas1p20367c5efe320138d3500ee1cfdf9696c~eFdyu0KI91565315653eucas1p2d;
        Thu, 11 May 2023 12:15:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E6.28.42423.47CDC546; Thu, 11
        May 2023 13:15:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1~eFdyZzirk1440714407eucas1p1S;
        Thu, 11 May 2023 12:15:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230511121547eusmtrp29c988864312913a580e79453f8b1bb88~eFdyZRhgV2339523395eusmtrp2i;
        Thu, 11 May 2023 12:15:47 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-47-645cdc74d114
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.3B.10549.37CDC546; Thu, 11
        May 2023 13:15:47 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230511121547eusmtip23cff362ade41808ef1d1947a184df102~eFdyQNdV22565925659eusmtip2Q;
        Thu, 11 May 2023 12:15:47 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 11 May 2023 13:15:45 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <axboe@kernel.dk>
CC:     <gost.dev@samsung.com>, <linux-block@vger.kernel.org>,
        <hch@lst.de>, <willy@infradead.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
Date:   Thu, 11 May 2023 14:15:44 +0200
Message-ID: <20230511121544.111648-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7djPc7old2JSDFZt5bZYfbefzWLl6qNM
        FntvaVv8/jGHzYHFY/MKLY/LZ0s9dt9sYPP4vEkugCWKyyYlNSezLLVI3y6BK6NtymHGgr0m
        FUtuajUwLlTpYuTkkBAwkVg5qYuli5GLQ0hgBaPE3VU9TBDOF0aJNVevs0I4nxklNh36xQjT
        0tl7GKplOaPEm4/NTHBV8/+vZ4dwtjBKfD0+lbmLkYODTUBLorGTHcQUERCVmLOoEqSEWaCN
        UWL6/3vMIFOFBfwlWpq3sYLYLAKqEmvXvmMCsXkFrCQ2bOllBemVEJCXWPxAAiIsKHFy5hMW
        EJsZKNy8dTYzhC0hcfDFC2aIQ5UkGjafYYGwayX2Nh8AO01CYAuHxPZ3T6GKXCS+/VnNBmEL
        S7w6voUdwpaR+L9zPhOEXS3x9MZvZojmFkaJ/p3r2SAOspboO5MDUeMocX3jC3aIMJ/EjbeC
        EPfwSUzaNp0ZIswr0dEmBFGtJrH63huWCYzKs5B8MwvJN7OQfLOAkXkVo3hqaXFuemqxYV5q
        uV5xYm5xaV66XnJ+7iZGYPI4/e/4px2Mc1991DvEyMTBeIhRgoNZSYT37ZLoFCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1MjYyHNr6e/GbxCYfFrD4v
        3Wv2P3swk/uBn8KjDzuXrX/+/UzzktTotydquVr5rGw2iWsKT5/cz/qsasUPS9a0RXMCpDZ9
        iQrasqLDz/mzWOHHrNKeJSHyEbnm++ZW706vX/dtr7byRG/Obeum5QQkXsvcnnLjp82L7gUB
        Z8u6VTZXH3snoW/2/vOiR7qmJZfrYvcIHzCe5yX4/6I23/bysq3P6yvlROxvr3UMtFtdttkq
        v+/WjaVHFbbER3j1/djZ9kYousyzJ/1b7ZLPrzJarjVfL5JuyFzePcFq6+vph7bymbLPSlQo
        L3v4sVuXKyT0jKfYDROFfMao5TlZort1NiX29jg4P3p9eMeklqvFSizFGYmGWsxFxYkAG5P+
        ZI0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Pd3iOzEpBpunGFusvtvPZrFy9VEm
        i723tC1+/5jD5sDisXmFlsfls6Ueu282sHl83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hp
        oWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9E25TBjwV6TiiU3tRoYF6p0MXJySAiYSHT2
        HmbpYuTiEBJYyigx7/J0FoiEjMTGL1dZIWxhiT/Xutggij4ySqyY+I4ZwtnCKPFo2QSgDAcH
        m4CWRGMnO4gpIiAqMWdRJUgJs0Abo8T0//eYQQYJC/hK3FkzgwnEZhFQlVi79h2YzStgJbFh
        Sy8rSK+EgLzE4gcSEGFBiZMzn4DdwwwUbt46mxnClpA4+OIFM8RtShINm89A3Vwr0fnqNNsE
        RqFZSNpnIWmfhaR9ASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBY2Xbs5+YdjPNefdQ7
        xMjEwXiIUYKDWUmE9+2S6BQh3pTEyqrUovz4otKc1OJDjKZA70xklhJNzgdGa15JvKGZgamh
        iZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1PU1J9/TjyPOrrs8IcgzwbOp092
        xRtynLj3oz8/q7mGbabZNJm+1WETLdr/sj8ynDNJPebwzYCyf4FGqVVinxIf+b3ZcMVlo2dZ
        ZYDOQzEG+xMtc+ZwbPjKK+V34njbK0NG038198ul6rSTudTLtm5fHTCl717W0qRt63XFnvVa
        cfM+mviA+wXb4VNrc2YpH/auSprTWRW6ik08R0/sW8+Sk+cMlpScFrhVuzT59NKdcXsqHfpD
        hbXZD0dwfvu7QHTqpTcf9nK6HS582LZI2MotJCzdesmk76nCOiw3hf3ULWP7tsjsZaoUYDng
        smBCSsz09XbPt99prTj41ZRjWbfZmdJNGVruxmvqLln+WKHEUpyRaKjFXFScCADdJuFTHgMA
        AA==
X-CMS-MailID: 20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1
X-Msg-Generator: CA
X-RootMTR: 20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1
References: <CGME20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

XArray was introduced to hold large array of pointers with a simple API.
XArray API also provides array semantics which simplifies the way we store
and access the backing pages, and the code becomes significantly easier
to understand.

No performance difference was noticed between the two implementation
using fio with direct=1 [1].

[1] Performance in KIOPS:

          |  radix-tree |    XArray  |   Diff
          |             |            |
write     |    315      |     313    |   -0.6%
randwrite |    286      |     290    |   +1.3%
read      |    330      |     335    |   +1.5%
randread  |    309      |     312    |   +0.9%

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
@willy: I noticed later that you sent a similar patch in 2019[1]. Let me                                                                                                                                                                                                               
know if you need your signoff in the patch as well.                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                       
[1] https://lore.kernel.org/linux-block/20190318194821.3470-9-willy@infradead.org/

 drivers/block/brd.c | 93 ++++++++++++---------------------------------
 1 file changed, 24 insertions(+), 69 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index bcad9b926b0c..2f71376afc71 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -19,7 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
-#include <linux/radix-tree.h>
+#include <linux/xarray.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
@@ -28,7 +28,7 @@
 #include <linux/uaccess.h>
 
 /*
- * Each block ramdisk device has a radix_tree brd_pages of pages that stores
+ * Each block ramdisk device has a xarray brd_pages of pages that stores
  * the pages containing the block device's contents. A brd page's ->index is
  * its offset in PAGE_SIZE units. This is similar to, but in no way connected
  * with, the kernel's pagecache or buffer cache (which sit above our block
@@ -40,11 +40,9 @@ struct brd_device {
 	struct list_head	brd_list;
 
 	/*
-	 * Backing store of pages and lock to protect it. This is the contents
-	 * of the block device.
+	 * Backing store of pages. This is the contents of the block device.
 	 */
-	spinlock_t		brd_lock;
-	struct radix_tree_root	brd_pages;
+	struct xarray	        brd_pages;
 	u64			brd_nr_pages;
 };
 
@@ -56,21 +54,8 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 	pgoff_t idx;
 	struct page *page;
 
-	/*
-	 * The page lifetime is protected by the fact that we have opened the
-	 * device node -- brd pages will never be deleted under us, so we
-	 * don't need any further locking or refcounting.
-	 *
-	 * This is strictly true for the radix-tree nodes as well (ie. we
-	 * don't actually need the rcu_read_lock()), however that is not a
-	 * documented feature of the radix-tree API so it is better to be
-	 * safe here (we don't have total exclusion from radix tree updates
-	 * here, only deletes).
-	 */
-	rcu_read_lock();
 	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
-	page = radix_tree_lookup(&brd->brd_pages, idx);
-	rcu_read_unlock();
+	page = xa_load(&brd->brd_pages, idx);
 
 	BUG_ON(page && page->index != idx);
 
@@ -83,7 +68,7 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
 	pgoff_t idx;
-	struct page *page;
+	struct page *page, *cur;
 	int ret = 0;
 
 	page = brd_lookup_page(brd, sector);
@@ -94,71 +79,42 @@ static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 	if (!page)
 		return -ENOMEM;
 
-	if (radix_tree_maybe_preload(gfp)) {
-		__free_page(page);
-		return -ENOMEM;
-	}
+	xa_lock(&brd->brd_pages);
 
-	spin_lock(&brd->brd_lock);
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	page->index = idx;
-	if (radix_tree_insert(&brd->brd_pages, idx, page)) {
+
+	cur = __xa_cmpxchg(&brd->brd_pages, idx, NULL, page, gfp);
+
+	if (unlikely(cur)) {
 		__free_page(page);
-		page = radix_tree_lookup(&brd->brd_pages, idx);
-		if (!page)
-			ret = -ENOMEM;
-		else if (page->index != idx)
+		ret = xa_err(cur);
+		if (!ret && (cur->index != idx))
 			ret = -EIO;
 	} else {
 		brd->brd_nr_pages++;
 	}
-	spin_unlock(&brd->brd_lock);
 
-	radix_tree_preload_end();
+	xa_unlock(&brd->brd_pages);
+
 	return ret;
 }
 
 /*
- * Free all backing store pages and radix tree. This must only be called when
+ * Free all backing store pages and xarray. This must only be called when
  * there are no other users of the device.
  */
-#define FREE_BATCH 16
 static void brd_free_pages(struct brd_device *brd)
 {
-	unsigned long pos = 0;
-	struct page *pages[FREE_BATCH];
-	int nr_pages;
+	struct page *page;
+	pgoff_t idx;
 
-	do {
-		int i;
+	xa_for_each(&brd->brd_pages, idx, page) {
+		__free_page(page);
+		cond_resched_rcu();
+	}
 
-		nr_pages = radix_tree_gang_lookup(&brd->brd_pages,
-				(void **)pages, pos, FREE_BATCH);
-
-		for (i = 0; i < nr_pages; i++) {
-			void *ret;
-
-			BUG_ON(pages[i]->index < pos);
-			pos = pages[i]->index;
-			ret = radix_tree_delete(&brd->brd_pages, pos);
-			BUG_ON(!ret || ret != pages[i]);
-			__free_page(pages[i]);
-		}
-
-		pos++;
-
-		/*
-		 * It takes 3.4 seconds to remove 80GiB ramdisk.
-		 * So, we need cond_resched to avoid stalling the CPU.
-		 */
-		cond_resched();
-
-		/*
-		 * This assumes radix_tree_gang_lookup always returns as
-		 * many pages as possible. If the radix-tree code changes,
-		 * so will this have to.
-		 */
-	} while (nr_pages == FREE_BATCH);
+	xa_destroy(&brd->brd_pages);
 }
 
 /*
@@ -372,8 +328,7 @@ static int brd_alloc(int i)
 	brd->brd_number		= i;
 	list_add_tail(&brd->brd_list, &brd_devices);
 
-	spin_lock_init(&brd->brd_lock);
-	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
+	xa_init(&brd->brd_pages);
 
 	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
 	if (!IS_ERR_OR_NULL(brd_debugfs_dir))
-- 
2.39.2

