Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE05C43603
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0BD20637
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bVSC40PZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLDLew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:34:52 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:1302 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDLew (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 06:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575459291; x=1606995291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=l9KPO+RfCo20qWXXb2Nj9NKT03YEvDC09jO2n9eHTpU=;
  b=bVSC40PZzS1pbsGSnYSn797HiGF6KsKsr7dnSXhoaK0cm6AVmTi9+UTK
   LLoLYG3encITk/W/XCNo3nCrRCzrDxWdPTi5/YxK4KE6mnLvWkiOhxV9F
   cAR0k2RNKRaqsI2+P+h3QStYjFvIwY//z+AHi/Ne+/GxcZj4loHOH7+1r
   I=;
IronPort-SDR: viKll6ecnooPrmUshSbgKArxk+zTotTLwmPFV/Wv/PkUGPV6L9xCUelo4wLNJXlMTz/omLid4V
 /zTdHD3WM+lw==
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="7009075"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 04 Dec 2019 11:34:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 18111C0C8E;
        Wed,  4 Dec 2019 11:34:42 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 11:34:42 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.249) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Dec 2019 11:34:38 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <axboe@kernel.dk>
CC:     <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 1/2] xen/blkback: Aggressively shrink page pools if a memory pressure is detected
Date:   Wed, 4 Dec 2019 12:34:18 +0100
Message-ID: <20191204113419.2298-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204113419.2298-1-sjpark@amazon.com>
References: <20191204113419.2298-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.249]
X-ClientProxiedBy: EX13D21UWB003.ant.amazon.com (10.43.161.212) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Each `blkif` has a free pages pool for the grant mapping.  The size of
the pool starts from zero and be increased on demand while processing
the I/O requests.  If current I/O requests handling is finished or 100
milliseconds has passed since last I/O requests handling, it checks and
shrinks the pool to not exceed the size limit, `max_buffer_pages`.

Therefore, `blkfront` running guests can cause a memory pressure in the
`blkback` running guest by attaching arbitrarily large number of block
devices and inducing I/O.  This commit avoids such problematic
situations by shrinking the pools aggressively (further the limit) for a
while (one millisecond) if a memory pressure is detected.

Discussions
===========

The shrinking mechanism returns only pages in the pool which are not
currently be used by blkback.  In other words, the pages that will be
shrunk are not mapped with foreign pages.  Because this commit is
changing only the shrink limit but uses the shrinking mechanism as is,
this commit does not introduce security issues such as improper
unmappings.

This commit keeps the aggressive shrinking limit for one milisecond from
last memory pressure detected time.  The duration should be neither too
short nor too long.  If it is too long, free pages pool shrinking
overhead can reduce the I/O performance.  If it is too short, blkback
will not free enough pages to reduce the memory pressure.  I believe
that one millisecond is a short duration in terms of I/O while it is a
long duration in terms of memory operations.  Also, as the original
shrinking mechanism works for every 100 milliseconds, this 1 millisecond
could be a somewhat reasonable choice.  Also, this duration worked well
for our testing environment simulating the memory pressure situation
(will be described in detail below).

Memory Pressure Test
====================

To show whether this commit fixes the above mentioned memory pressure
situation well, I configured a test environment.  On the `blkfront`
running guest instances of a virtualized environment, I attach
arbitrarily large number of network-backed volume devices and induce I/O
to those.  Meanwhile, I measure the number of pages that swapped in and
out on the `blkback` running guest.  The test ran twice, once for the
`blkback` before this commit and once for that after this commit.

Roughly speaking, this commit has reduced those numbers 130x (pswpin)
and 34x (pswpout) as below:

    		pswpin	pswpout
    before	76,672	185,799
    after	   587	  5,402

Performance Overhead Test
=========================

This commit could incur I/O performance degradation under memory
pressure because the aggressive shrinking will require more page
allocations.  To show the overhead, I artificially made an aggressive
pages pool shrinking situation and measured the I/O performance of a
`blkfront` running guest.

For the artificial shrinking, I set the `blkback.max_buffer_pages` using
the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
the value to `1024` and `0`.  The `1024` is the default value.  Setting
the value as `0` incurs the worst-case aggressive shrinking stress.

For the I/O performance measurement, I use a simple `dd` command.

Default Performance
-------------------

    [dom0]# echo 1024 >  /sys/module/xen_blkback/parameters/max_buffer_pages
    [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8827 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8781 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8737 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8702 s, 38.7 MB/s

Worst-case Performance
----------------------

    [dom0]# echo 0 >  /sys/module/xen_blkback/parameters/max_buffer_pages
    [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.878 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8746 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8786 s, 38.7 MB/s
    131072+0 records in
    131072+0 records out
    536870912 bytes (537 MB) copied, 13.8749 s, 38.7 MB/s

In short, even worst case aggressive pools shrinking makes no visible
performance degradation.  I think this is due to the slow speed of the
I/O.  In other words, the additional page allocation overhead is hidden
under the much slower I/O time.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/blkback.c | 31 +++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 3666afa639d1..aa1a127093e5 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -135,6 +135,27 @@ module_param(log_stats, int, 0644);
 /* Number of free pages to remove on each call to gnttab_free_pages */
 #define NUM_BATCH_FREE_PAGES 10
 
+/*
+ * Once a memory pressure is detected, keep aggressive shrinking of the free
+ * page pools for this time (msec)
+ */
+#define AGGRESSIVE_SHRINKING_DURATION	1
+
+static unsigned long xen_blk_mem_pressure_end;
+
+static unsigned long blkif_shrink_count(struct shrinker *shrinker,
+				struct shrink_control *sc)
+{
+	xen_blk_mem_pressure_end = jiffies +
+		msecs_to_jiffies(AGGRESSIVE_SHRINKING_DURATION);
+	return 0;
+}
+
+static struct shrinker blkif_shrinker = {
+	.count_objects = blkif_shrink_count,
+	.seeks = DEFAULT_SEEKS,
+};
+
 static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
 {
 	return xen_blkif_pgrant_timeout &&
@@ -656,8 +677,11 @@ int xen_blkif_schedule(void *arg)
 			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
 		}
 
-		/* Shrink if we have more than xen_blkif_max_buffer_pages */
-		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
+		/* Shrink the free pages pool if it is too large. */
+		if (time_before(jiffies, xen_blk_mem_pressure_end))
+			shrink_free_pagepool(ring, 0);
+		else
+			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
 
 		if (log_stats && time_after(jiffies, ring->st_print))
 			print_stats(ring);
@@ -1500,6 +1524,9 @@ static int __init xen_blkif_init(void)
 	if (rc)
 		goto failed_init;
 
+	if (register_shrinker(&blkif_shrinker))
+		pr_warn("shrinker registration failed\n");
+
  failed_init:
 	return rc;
 }
-- 
2.17.1

