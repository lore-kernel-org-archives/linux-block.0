Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C6C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789462077B
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 18:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMz7hqKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfLKSKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:10:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43753 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKSKy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 13:10:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so2175651pfe.10;
        Wed, 11 Dec 2019 10:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H8zS3WPczvmZQ0VfAWj0iPbsB+8YM/87wWFzDicbOGs=;
        b=dMz7hqKiU8gYER0U8PXmUZ+3tdJyKMAUlKZIlDlNTOxSH/MHEODnPGGJZVVBrJ9bOf
         2S9VjLhBusfcUJkwMaRRi1+DYmto4D26INRvuKtb7BzRbTv115+lMiktdtm/lFuGs+vm
         A5NI5Ja7Dd048lW/6qUilWWwLfi4p3yvHuTplKZgIB2B9DUfYVWDVg9g+J9SHomr8oum
         fAfx5PWjKPO+ForIWgEseQNwPlqf061VdaG6SOlKsqiybJ8hzXFdML2CXyl/HnVkmiyl
         f4jpSfBZ/3IIPDaO2H3dNi+KEPlaJdsNlQCa1zGhrCBaA8FB9KVz1JL4lmV2MvDhmhKw
         DSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H8zS3WPczvmZQ0VfAWj0iPbsB+8YM/87wWFzDicbOGs=;
        b=n0RTlCx7cCdI09X5klaaaQogs7wrxJdGSr/kwv4BOBb6N0s6/FbE2QEMTYkni51Ndp
         AeLsYIgCPeQtdtpzAigZq0PAA3z5iSzmVXVUu4T+HZaZ4pvzr6t0NBM9nofTOjTq6ymI
         hkjbxgJniUoxD/VAo59pefcWpSlwH84vKsAABW8Hkedwo9QHsR+UqGwE7i3ZNHZOroxb
         jMv3oLRImYWJJ0AtzfYtcJ04tXS13wLcUIBHr/jTX1xntGNtgsfe3d/sFgofwI/KCGuH
         6neQX+RIV4l4Y+itd/C1seXXqZrCcj65NDVRV4m3uH1s3YkuRqltADm+FBCiId4gCOD3
         LMJg==
X-Gm-Message-State: APjAAAX6b+fg1W0YQFfcp54bSOGoJY2NyL854FkwlIr/V3E22vFEXbkQ
        xU8Td+zXZ5sBYhXmMGWyWh4=
X-Google-Smtp-Source: APXvYqwe8fg/JTOI34kRlAHKKKdNqz921JndK7Jp8Z9L6EAFy1lgAjHinYZEqa+2WDp73V9YqtO0xQ==
X-Received: by 2002:a63:ed4a:: with SMTP id m10mr4979110pgk.99.1576087853596;
        Wed, 11 Dec 2019 10:10:53 -0800 (PST)
Received: from localhost.localdomain (campus-094-212.ucdavis.edu. [168.150.94.212])
        by smtp.gmail.com with ESMTPSA id x33sm3552651pga.86.2019.12.11.10.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 10:10:52 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Wed, 11 Dec 2019 18:10:15 +0000
Message-Id: <20191211181016.14366-3-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211181016.14366-1-sjpark@amazon.de>
References: <20191211181016.14366-1-sjpark@amazon.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each `blkif` has a free pages pool for the grant mapping.  The size of
the pool starts from zero and be increased on demand while processing
the I/O requests.  If current I/O requests handling is finished or 100
milliseconds has passed since last I/O requests handling, it checks and
shrinks the pool to not exceed the size limit, `max_buffer_pages`.

Therefore, host administrators can cause memory pressure in blkback by
attaching a large number of block devices and inducing I/O.  Such
problematic situations can be avoided by limiting the maximum number of
devices that can be attached, but finding the optimal limit is not so
easy.  Improper set of the limit can results in the memory pressure or a
resource underutilization.  This commit avoids such problematic
situations by squeezing the pools (returns every free page in the pool
to the system) for a while (users can set this duration via a module
parameter) if a memory pressure is detected.

Discussions
===========

The `blkback`'s original shrinking mechanism returns only pages in the
pool, which are not currently be used by `blkback`, to the system.  In
other words, the pages that are not mapped with granted pages.  Because
this commit is changing only the shrink limit but still uses the same
freeing mechanism it does not touch pages which are currently mapping
grants.

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
configurations and workloads.  That's why this commit allows users to
set the duration as a module parameter.

Memory Pressure Test
====================

To show how this commit fixes the memory pressure situation well, I
configured a test environment on a xen-running virtualization system.
On the `blkfront` running guest instances, I attach a large number of
network-backed volume devices and induce I/O to those.  Meanwhile, I
measure the number of pages that swapped in (pswpin) and out (pswpout)
on the `blkback` running guest.  The test ran twice, once for the
`blkback` before this commit and once for that after this commit.  As
shown below, this commit has dramatically reduced the memory pressure:

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
the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  In this
test, I set the value to `1024` and `0`.  The `1024` is the default
value.  Setting the value as `0` is same to a situation doing the
squeezing always (worst-case).

For the I/O performance measurement, I run a simple `dd` command 5 times
as below and collect the 'MB/s' results.

    $ for i in {1..5}; do dd if=/dev/zero of=file \
                             bs=4k count=$((256*512)); sync; done

If the underlying block device is slow enough, the squeezing overhead
could be hidden.  For the reason, I do this test for both a slow block
device and a fast block device.  I use a popular cloud block storage
service, ebs[1] as a slow device and the ramdisk block device[2] for the
fast device.

The results are as below.  'max_pgs' represents the value of the
`blkback.max_buffer_pages` parameter.

On the slow block device
------------------------

    max_pgs   Min       Max       Median     Avg    Stddev
    0         38.7      45.8      38.7       40.12  3.1752165
    1024      38.7      45.8      38.7       40.12  3.1752165
    No difference proven at 95.0% confidence

On the fast block device
------------------------

    max_pgs   Min       Max       Median     Avg    Stddev
    0         417       423       420        419.4  2.5099801
    1024      414       425       416        417.8  4.4384682
    No difference proven at 95.0% confidence

In short, even worst case squeezing on ramdisk based fast block device
makes no visible performance degradation.  Please note that this is just
a very simple and minimal test.  On systems using super-fast block
devices and a special I/O workload, the results might be different.  If
you have any doubt, test on your machine for your workload to find the
optimal squeezing duration for you.

[1] https://aws.amazon.com/ebs/
[2] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/ramdisk.html

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/blkback.c | 22 ++++++++++++++++++++--
 drivers/block/xen-blkback/common.h  |  1 +
 drivers/block/xen-blkback/xenbus.c  |  3 ++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..98823d150905 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -142,6 +142,21 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
 		HZ * xen_blkif_pgrant_timeout);
 }
 
+/* Once a memory pressure is detected, squeeze free page pools for a while. */
+static unsigned int buffer_squeeze_duration_ms = 10;
+module_param_named(buffer_squeeze_duration_ms,
+		buffer_squeeze_duration_ms, int, 0644);
+MODULE_PARM_DESC(buffer_squeeze_duration_ms,
+"Duration in ms to squeeze pages buffer when a memory pressure is detected");
+
+static unsigned long buffer_squeeze_end;
+
+void xen_blkbk_reclaim_memory(struct xenbus_device *dev)
+{
+	buffer_squeeze_end = jiffies +
+		msecs_to_jiffies(buffer_squeeze_duration_ms);
+}
+
 static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
 {
 	unsigned long flags;
@@ -656,8 +671,11 @@ int xen_blkif_schedule(void *arg)
 			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
 		}
 
-		/* Shrink if we have more than xen_blkif_max_buffer_pages */
-		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
+		/* Shrink the free pages pool if it is too large. */
+		if (time_before(jiffies, buffer_squeeze_end))
+			shrink_free_pagepool(ring, 0);
+		else
+			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
 
 		if (log_stats && time_after(jiffies, ring->st_print))
 			print_stats(ring);
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..1e0df86cb941 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -383,6 +383,7 @@ irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
 int xen_blkif_schedule(void *arg);
 int xen_blkif_purge_persistent(void *arg);
 void xen_blkbk_free_caches(struct xen_blkif_ring *ring);
+void xen_blkbk_reclaim_memory(struct xenbus_device *dev);
 
 int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
 			      struct backend_info *be, int state);
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b90dbcd99c03..0477f910b018 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -1115,7 +1115,8 @@ static struct xenbus_driver xen_blkbk_driver = {
 	.ids  = xen_blkbk_ids,
 	.probe = xen_blkbk_probe,
 	.remove = xen_blkbk_remove,
-	.otherend_changed = frontend_changed
+	.otherend_changed = frontend_changed,
+	.reclaim_memory = xen_blkbk_reclaim_memory,
 };
 
 int xen_blkif_xenbus_init(void)
-- 
2.17.1

