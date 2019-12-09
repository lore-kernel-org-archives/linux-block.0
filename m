Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEFDC2BD09
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2907C2077B
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 08:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eGh7M3ZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfLII7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:59:36 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:43623 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLII7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 03:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575881974; x=1607417974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8olk0hAHmu26Td53ApyhVwpVYzt4H81HIr7areIZQ94=;
  b=eGh7M3ZO3ctYAt+tLlAiraYtG7gbyY/kVnaEC8HIAyQMQno5MT0L0SCm
   l44Zmq9YBIOXrPN1QAE67d728A+yCLqWXjAMGNJIudE1De/1n19x/ttE5
   dopt4/UP5SbCNrraxzLAEMCaBuEVZdE6HuQU/JJ/NE9GG1I3N5LunmfC9
   Y=;
IronPort-SDR: 2E9jejrhM12/0sKKegU0IeHe4R1Ct1JOv1Q2r/RNov9eLHxqrZ8GYit34xcatQRjIMaxkpUJWl
 Jb8HSG+ob2xg==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="3968734"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 09 Dec 2019 08:59:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 3B5E8A22CA;
        Mon,  9 Dec 2019 08:59:17 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 08:59:17 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.249) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 08:59:12 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>, <roger.pau@citrix.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 1/1] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Mon, 9 Dec 2019 09:58:39 +0100
Message-ID: <20191209085839.21215-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209085839.21215-1-sjpark@amazon.com>
References: <20191209085839.21215-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.249]
X-ClientProxiedBy: EX13D29UWA001.ant.amazon.com (10.43.160.187) To
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
set of the limit can results in the memory pressure or a resource
underutilization.  This commit avoids such problematic situations by
squeezing the pools (returns every free page in the pool to the system)
for a while (users can set this duration via a module parameter) if a
memory pressure is detected.

Discussions
===========

The `blkback`'s original shrinking mechanism returns only pages in the
pool, which are not currently be used by `blkback`, to the system.  In
other words, the pages are not mapped with foreign pages.  Because this
commit is changing only the shrink limit but uses the mechanism as is,
this commit does not introduce improper mappings related security
issues.

Once a memory pressure is detected, this commit keeps the squeezing
limit for a user-specified time duration.  The duration should be
neither too long nor too short.  If it is too long, the squeezing
incurring overhead can reduce the I/O performance.  If it is too short,
`blkback` will not free enough pages to reduce the memory pressure.
This commit sets the value as `10 milliseconds` by default because it is
a short time in terms of I/O while it is a long time in terms of memory
operations.  Also, as the original shrinking mechanism works for at
least every 100 milliseconds, this could be a somewhat reasonable
choice.  I also tested other durations (refer to the below section for
more details) and confirmed that 10 milliseconds is the one that works
best with the test.  That said, the proper duration depends on actual
configurations and workloads.  That's why this commit is allowing users
to set it as their optimal value via the module parameter.

Memory Pressure Test
====================

To show how this commit fixes the memory pressure situation well, I
configured a test environment on a xen-running virtualization system.
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

To find a best squeezing duration, I repeated the test with three
different durations (1ms, 10ms, and 100ms).  The results are as below:

    duration    pswpin  pswpout
    1           852     6,424
    10          212     3,325
    100         203     3,340

As expected, the memory pressure has decreased as the duration is
increased, but the reduction stopped from the `10ms`.  Based on this
results, I chose the default duration as 10ms.

Performance Overhead Test
=========================

This commit could incur I/O performance degradation under severe memory
pressure because the squeezing will require more page allocations per
I/O.  To show the overhead, I artificially made a worst-case squeezing
situation and measured the I/O performance of a `blkfront` running
guest.

For the artificial squeezing, I set the `blkback.max_buffer_pages` using
the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
the value to `1024` and `0`.  The `1024` is the default value.  Setting
the value as `0` is same to a situation doing the squeezing always
(worst-case).

For the I/O performance measurement, I use a simple `dd` command.

Default Performance
-------------------

    [dom0]# echo 1024 > /sys/module/xen_blkback/parameters/max_buffer_pages
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

    [dom0]# echo 0 > /sys/module/xen_blkback/parameters/max_buffer_pages
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

In short, even worst case squeezing makes no visible performance
degradation.  I think this is due to the slow speed of the I/O.  In
other words, the additional page allocation overhead is hidden under the
much slower I/O latency.

Nevertheless, pleaset note that this is just a very simple and minimal
test.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/blkback.c | 35 +++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..587061fd06fc 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -142,6 +142,31 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
 		HZ * xen_blkif_pgrant_timeout);
 }
 
+/*
+ * Once a memory pressure is detected, squeeze free page pools
+ * this time (milliseconds)
+ */
+static int xen_blkif_buffer_squeeze_duration = 10;
+module_param_named(buffer_squeeze_duration,
+		xen_blkif_buffer_squeeze_duration, int, 0644);
+MODULE_PARM_DESC(buffer_squeeze_duration,
+"Duration in ms to squeeze pages buffer when a memory pressure is detected");
+
+static unsigned long xen_blk_buffer_squeeze_end;
+
+static unsigned long blkif_shrink_count(struct shrinker *shrinker,
+				struct shrink_control *sc)
+{
+	xen_blk_buffer_squeeze_end = jiffies +
+		msecs_to_jiffies(xen_blkif_buffer_squeeze_duration);
+	return 0;
+}
+
+static struct shrinker blkif_shrinker = {
+	.count_objects = blkif_shrink_count,
+	.seeks = DEFAULT_SEEKS,
+};
+
 static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
 {
 	unsigned long flags;
@@ -656,8 +681,11 @@ int xen_blkif_schedule(void *arg)
 			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
 		}
 
-		/* Shrink if we have more than xen_blkif_max_buffer_pages */
-		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
+		/* Shrink the free pages pool if it is too large. */
+		if (time_before(jiffies, xen_blk_buffer_squeeze_end))
+			shrink_free_pagepool(ring, 0);
+		else
+			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
 
 		if (log_stats && time_after(jiffies, ring->st_print))
 			print_stats(ring);
@@ -1498,6 +1526,9 @@ static int __init xen_blkif_init(void)
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

