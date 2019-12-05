Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168F0C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA41324657
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OW9Yn/Za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfLEPKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:10:20 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:3944 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEPKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 10:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575558619; x=1607094619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SrfasP8IAPqd8vrwXng/eZJeZ7Albzeeh72IDkV4jQI=;
  b=OW9Yn/ZaWJ//CBZeq8rGeDvcuJIk918UrrPch8wATbipy3qQVv6yuHor
   oQBLoPu9CAF6fms32pZB2riXH5OPO6W/fEWKnGS7USneM5hAWewSv1hpF
   wGxcfyel2/oFm7ytwq4hIe+4BD2cadgXIoBj2Jowd0JGtKm83bW0oPLHZ
   4=;
IronPort-SDR: 6VkidmQTW/ue9jNioio6TGxd5tu1XHQKcxD/T+VEDx8tDzmBagjTN63qVU/t5lYWXCLkKtZIph
 1/OCyc1d8QPg==
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="11821889"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Dec 2019 15:10:02 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 93E92A201D;
        Thu,  5 Dec 2019 15:10:00 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 15:09:59 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.171) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 15:09:55 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <roger.pau@citrix.com>
CC:     <sjpark@amazon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 1/1] xen/blkback: Aggressively shrink page pools if a memory pressure is detected
Date:   Thu, 5 Dec 2019 16:09:32 +0100
Message-ID: <20191205150932.3793-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205150932.3793-1-sjpark@amazon.com>
References: <20191205150932.3793-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.171]
X-ClientProxiedBy: EX13D12UWA004.ant.amazon.com (10.43.160.168) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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
`blkback` running guest by attaching a large number of block devices and
inducing I/O.  System administrators can avoid such problematic
situations by limiting the maximum number of devices each guest can
attach.  However, finding the optimal limit is not so easy.  Improper
set of the limit can result in the memory pressure or a resource
underutilization.  This commit avoids such problematic situations by
shrinking the pools aggressively (further the limit) for a while (users
can set this duration via a module parameter) if a memory pressure is
detected.

Discussions
===========

The `blkback`'s original shrinking mechanism returns only pages in the
pool which are not currently be used by `blkback`.  In other words, the
pages that will be shrunk are not mapped with foreign pages.  Because
this commit is changing only the shrink limit but uses the shrinking
mechanism as is, this commit does not introduce improper mappings
related security issues.

Once a memory pressure is detected, this commit keeps the aggressive
shrinking limit for a user-specified time duration.  The duration should
be neither too long nor too short.  If it is too long, free pages pool
shrinking overhead can reduce the I/O performance.  If it is too short,
`blkback` will not free enough pages to reduce the memory pressure.
This commit sets the value as `10 milliseconds` by default because it is
a short time in terms of I/O while it is a long time in terms of memory
operations.  Also, as the original shrinking mechanism works for at
least every 100 milliseconds, this could be a somewhat reasonable
choice.  I also tested other durations (refer to the below section for
more details) and confirmed that 10 milliseconds is the one that works
best.  That said, the proper duration depends on actual configurations
and workloads.  That's why this commit is allowing users to set it as
their optimal value via the module parameter.

Memory Pressure Test
====================

To show how this commit fixes the above mentioned memory pressure
situation well, I configured a test environment on a xen-running system.
On the `blkfront` running guest instances, I attach a large number of
network-backed volume devices and induce I/O to those.  Meanwhile, I
measure the number of pages that swapped in and out on the `blkback`
running guest.  The test ran twice, once for the `blkback` before this
commit and once for that after this commit.  As shown below, this commit
has dramatically reduced the memory pressure:

                pswpin  pswpout
    before      76,672  185,799
    after          212    3,325

Optimal Aggressive Shrinking Duration
-------------------------------------

To find a best aggressive shrinking duration, I repeated the test with
three different durations (1ms, 10ms, and 100ms).  The results are as
below:

    duration    pswpin  pswpout
    1           852     6,424
    10          212     3,325
    100         203     3,340

As expected, the numbers have further decreased by increasing the
duration, but the reduction stopped from the `10ms`.  Based on this
results, I chose the default duration as 10ms.

Performance Overhead Test
=========================

This commit could incur I/O performance degradation under severe memory
pressure because the aggressive shrinking will require more page
allocations per I/O.  To show the overhead, I artificially made an
aggressive pages pool shrinking situation and measured the I/O
performance of a `blkfront` running guest.

For the artificial shrinking, I set the `blkback.max_buffer_pages` using
the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
the value to `1024` and `0`.  The `1024` is the default value.  Setting
the value as `0` is same to a situation doing the aggressive shrinking
always (worst-case).

For the I/O performance measurement, I use a simple `dd` command.

Default Performance
-------------------

    [dom0]# echo 1024 >
/sys/module/xen_blkback/parameters/max_buffer_pages
    [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k
count=$((256*512)); sync; done
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

    [dom0]# echo 0 >
/sys/module/xen_blkback/parameters/max_buffer_pages
    [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k
count=$((256*512)); sync; done
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

In short, even worst case aggressive shrinking makes no visible
performance degradation.  I think this is due to the slow speed of the
I/O.  In other words, the additional page allocation overhead is hidden
under the much slower I/O latency.

Nevertheless, pleaset note that this is just a very simple and minimal
test.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/blkback.c | 35 +++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 3666afa639d1..72d068328ef1 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -135,6 +135,31 @@ module_param(log_stats, int, 0644);
 /* Number of free pages to remove on each call to gnttab_free_pages */
 #define NUM_BATCH_FREE_PAGES 10
 
+/*
+ * Once a memory pressure is detected, keep aggressive shrinking of the free
+ * page pools for this time (milliseconds)
+ */
+static int xen_blkif_aggressive_shrinking_duration = 10;
+module_param_named(aggressive_shrinking_duration,
+		xen_blkif_aggressive_shrinking_duration, int, 0644);
+MODULE_PARM_DESC(aggressive_shrinking_duration,
+"Duration in ms to do aggressive shrinking when a memory pressure is detected");
+
+static unsigned long xen_blk_mem_pressure_end;
+
+static unsigned long blkif_shrink_count(struct shrinker *shrinker,
+				struct shrink_control *sc)
+{
+	xen_blk_mem_pressure_end = jiffies +
+		msecs_to_jiffies(xen_blkif_aggressive_shrinking_duration);
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
@@ -656,8 +681,11 @@ int xen_blkif_schedule(void *arg)
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
@@ -1500,6 +1528,9 @@ static int __init xen_blkif_init(void)
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

