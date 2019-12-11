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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B7C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 04:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6022073B
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 04:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLwWW9+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLKE12 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 23:27:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40014 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfLKE12 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 23:27:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so879951plp.7;
        Tue, 10 Dec 2019 20:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gHSB8JjTfrVa+2rnf6DBh2FVjHPHYrux3hW9l4ue23E=;
        b=LLwWW9+atm4yq8czOoNnegigQXlKjPxM5zcG1K667YPGhnXmyYIY3mDof7HhDeXskK
         XtJeViRpZfA/hFcqlvWWfSOp73jGUmQ89qvP3PfD73Eb98wvRbr1irnc364RYDC6OK3K
         ACXHNrFzxP++QOoE+vcZ0i+vHM1zjSY0t1cO6mxiaYdluG2e1uJMAxbnRgB2+lcXPM0X
         vfl2aciNj10eWqQpn/0g+94hSgeZ1CWh6DhhmEaPEdAb7GjZKMDGNlw7by1sEwD1nDcF
         JHO7HV+RQnTghtAVRDCdKehaA/eV/upbf4V4QGDKmuEMaQ6AKXO7LVD3Vgo1Nh0yNiNg
         LqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gHSB8JjTfrVa+2rnf6DBh2FVjHPHYrux3hW9l4ue23E=;
        b=Mr1xDUkqB4iTQtceynAZIIeanU9i9Hm4R8abMMIyxlBwSK3/YUz1D69nACdGOWV7tW
         MGbppDWw1qV1+HKNCLNQZ1paKO6HBlIUJLCPojKTGXlH1n1KNvejtNm36l44e9oFxHmg
         2xULE183x2OkQzoaC6yAoO5a6m7csrB9w3tCQydQvFygIirKdXyDq0OvkcSAH42UAMgB
         6qkwWCf4bTzKtOh+j4uLdJWmjTqF5UQ6PwjJJ80ZGaKvhzmV/X/HJ55uNGpS62Cs4th0
         yeIL1i3FRvIn4IuojPvfNH9unnU96OW627cq583RqMsU+jdeMW44phjUJk8tAfQxgPyA
         74yQ==
X-Gm-Message-State: APjAAAXjbMhB8nGOE5z54hMvxtRxXu1a5IjS4OrW3WiEz7WVj/hEDbTQ
        CIAh6avC/arLX56bfgALMp0=
X-Google-Smtp-Source: APXvYqz78yFKteR4nCz5+N9t6t8Ay+iS2x0/OVGDpwF3Lf3uinkm8v3lH7hD4cBH/h0h8wj9awnvlA==
X-Received: by 2002:a17:902:43:: with SMTP id 61mr1169630pla.88.1576038447420;
        Tue, 10 Dec 2019 20:27:27 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id b16sm675558pfo.64.2019.12.10.20.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 20:27:26 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Wed, 11 Dec 2019 04:27:17 +0000
Message-Id: <20191211042717.6090-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211042428.5961-1-sjpark@amazon.de>
References: <20191211042428.5961-1-sjpark@amazon.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each `blkif` has a free pages pool for the grant mapping.  The size of
the pool starts from zero and be increased on demand while processing
the I/O requests.  If current I/O requests handling is finished or 100
milliseconds has passed since last I/O requests handling, it checks and
shrinks the pool to not exceed the size limit, `max_buffer_pages`.

Therefore, if a system (maybe mistakenly) allows `blkfront` running
guests to attach a large number of devices, the guests could cause a
memory pressure in the `blkback` running guest by attaching a large
number of block devices and inducing I/O.  System administrators can
avoid such problematic situations by limiting the maximum number of
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
the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
the value to `1024` and `0`.  The `1024` is the default value.  Setting
the value as `0` is same to a situation doing the squeezing always
(worst-case).

For the I/O performance measurement, I use a simple `dd` command.

Default Performance
-------------------

    [dom0]# echo 1024 > /sys/module/xen_blkback/parameters/max_buffer_pages
    [instance]$ for i in {1..5}; do dd if=/dev/zero of=file \
                                       bs=4k count=$((256*512)); sync; done
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
    [instance]$ for i in {1..5}; do dd if=/dev/zero of=file \
                                       bs=4k count=$((256*512)); sync; done
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
degradation on this test machine.  I think this is due to the slow speed
of the I/O devices I used.  In other words, the additional page
allocation overhead is hidden under the much slower I/O latency.
Nevertheless, pleaset note that this is just a very simple and minimal
test using a slow block device.  On systems using fast block devices
such as ramdisks or NVMe SSDs, the results could be very different.  If
you are in such cases, you should control the squeezing duration via the
module parameter.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/blkback.c | 22 ++++++++++++++++++++--
 drivers/block/xen-blkback/common.h  |  1 +
 drivers/block/xen-blkback/xenbus.c  |  3 ++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..b493c306e84f 100644
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
+void xen_blkbk_reclaim(struct xenbus_device *dev)
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
index 1d3002d773f7..8a3195d2dca7 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -383,6 +383,7 @@ irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
 int xen_blkif_schedule(void *arg);
 int xen_blkif_purge_persistent(void *arg);
 void xen_blkbk_free_caches(struct xen_blkif_ring *ring);
+void xen_blkbk_reclaim(struct xenbus_device *dev);
 
 int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
 			      struct backend_info *be, int state);
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b90dbcd99c03..b596c6e8b006 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -1115,7 +1115,8 @@ static struct xenbus_driver xen_blkbk_driver = {
 	.ids  = xen_blkbk_ids,
 	.probe = xen_blkbk_probe,
 	.remove = xen_blkbk_remove,
-	.otherend_changed = frontend_changed
+	.otherend_changed = frontend_changed,
+	.reclaim = xen_blkbk_reclaim,
 };
 
 int xen_blkif_xenbus_init(void)
-- 
2.17.1

