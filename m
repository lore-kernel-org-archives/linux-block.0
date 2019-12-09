Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D5C04E30
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D510B2073D
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EHbSl6BO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLITns (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:43:48 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:7718 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLITns (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 14:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575920627; x=1607456627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mFjg3O0wfH0ZG+pcKsCZbVXZVnhM0nmqdVzE5AyatYA=;
  b=EHbSl6BOX9hCfF4rXzziG3dArCpJWazDPil3g0U8rk7FoXHgPGsq33bv
   IqO03WTcDRrdXiGYa8smFbXd9IFKzGwQe3Qj1n67P6JoIbvCbhlX6QPL7
   6T6tGipDhJjtUueRXuO0v+LT11Sc59cT7S7uABIdu/dtyVfzSJ+DbSgIH
   I=;
IronPort-SDR: RchwsZR167DBXMCJHQBM4rQG+QF9IhOzAxobDuWOM/UovEl2WC77jy6Jv4DD0kKeCH7IZX8OWU
 s9pW/5Y9JCYQ==
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="7798331"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Dec 2019 19:43:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 5A423A23B7;
        Mon,  9 Dec 2019 19:43:45 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 19:43:44 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 19:43:38 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <sjpark@amazon.com>
CC:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <roger.pau@citrix.com>,
        <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v4 2/2] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Mon, 9 Dec 2019 20:43:05 +0100
Message-ID: <20191209194305.20828-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209194305.20828-1-sjpark@amazon.com>
References: <20191209194305.20828-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D30UWC003.ant.amazon.com (10.43.162.122) To
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
 drivers/block/xen-blkback/blkback.c | 23 +++++++++++++++++++++--
 drivers/block/xen-blkback/common.h  |  1 +
 drivers/block/xen-blkback/xenbus.c  |  3 ++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..7e3994c20843 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -142,6 +142,22 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
 		HZ * xen_blkif_pgrant_timeout);
 }
 
+/* Once a memory pressure is detected, squeeze free page pools for a while. */
+static int xen_blkif_buffer_squeeze_duration_ms = 10;
+module_param_named(buffer_squeeze_duration_ms,
+		xen_blkif_buffer_squeeze_duration_ms, int, 0644);
+MODULE_PARM_DESC(buffer_squeeze_duration_ms,
+"Duration in ms to squeeze pages buffer when a memory pressure is detected");
+
+static unsigned long xen_blk_buffer_squeeze_end;
+
+unsigned xen_blkbk_reclaim(struct xenbus_device *dev, domid_t domid)
+{
+	xen_blk_buffer_squeeze_end = jiffies +
+		msecs_to_jiffies(xen_blkif_buffer_squeeze_duration_ms);
+	return 0;
+}
+
 static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
 {
 	unsigned long flags;
@@ -656,8 +672,11 @@ int xen_blkif_schedule(void *arg)
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
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..de5c6a301f44 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -383,6 +383,7 @@ irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
 int xen_blkif_schedule(void *arg);
 int xen_blkif_purge_persistent(void *arg);
 void xen_blkbk_free_caches(struct xen_blkif_ring *ring);
+unsigned xen_blkbk_reclaim(struct xenbus_device *dev, domid_t domid);
 
 int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
 			      struct backend_info *be, int state);
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b90dbcd99c03..de49a09e6933 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -1115,7 +1115,8 @@ static struct xenbus_driver xen_blkbk_driver = {
 	.ids  = xen_blkbk_ids,
 	.probe = xen_blkbk_probe,
 	.remove = xen_blkbk_remove,
-	.otherend_changed = frontend_changed
+	.otherend_changed = frontend_changed,
+	.reclaim = xen_blkbk_reclaim
 };
 
 int xen_blkif_xenbus_init(void)
-- 
2.17.1

