Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8059EC35244
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53482473C
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp+aEwOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfLMPgL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:36:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40815 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfLMPgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 10:36:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1381521plp.7;
        Fri, 13 Dec 2019 07:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TMzbAvFP3yWT6YAfy9bgu7F+ker5oB+nrGJ42qyGAXA=;
        b=Qp+aEwOGyOZbqJRFS0g2YNqq/vGtD86zDnL9veckvgQbfMeyHYCtLk5T4tugaTMvO3
         WLqKda2xqpV803MmsBSd4k+i3mwCscmJjmere0orczPqXD5hPpm++QxlnFSOEWktxEAZ
         DRxGQz6ca0TGrEfrYq+zw4Pv4RRuFdzc7wN6eKDX8m+lMqAuxhmO2WhAv8Cd2w+S47rg
         izwTVFYZuT1Kc8oJ1Z5dGTq+Ki0uSezlcmWs7VuiRf25gY5EHphnSsOdtitR4Ti4bRu2
         mmK0d1Xc8PJ//z7A26bX/Sh4CEfVYiWsDcFg2s8AV+Q8c6EAxephCiGsSvdzKnwLtjeh
         YyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TMzbAvFP3yWT6YAfy9bgu7F+ker5oB+nrGJ42qyGAXA=;
        b=K8ifTsNvUeL+RmdDwePuy5bZVUGPAoOf8CSl50/SNQeL2rD1IesFEBamdTYDbahJrc
         pk/9nAVU093/gLOyYlnuuR25OgZyyCACRMsxg2ad4B+ksY+fivsY9VSUsPqvm9JSQM6w
         JRiMrSM9SF20nqoSf0m7FfjDSnKBHtOm0HuYqTOrx24/H5ejEY85OeLb1XBSuCUYfN7Y
         b3kpp5ECTpDgYjYv8zocpYVsm32VxXP8pFTQJWzWNnttwT0hH8UPJK7UI1L6qO/F7B9J
         OUi9uJHSwjaIatRP+qwFMekECGCQSZjupm1nuzU7f7Rl7H1G/uZfm00mh/awHq+FGe18
         1zSA==
X-Gm-Message-State: APjAAAWHlc0l2KEy3yhSoLr9EpSQmA8IJOdUEY7b0crlHiVT4cuM53y0
        RMXYJMWqWKB67BlWF+4oNzc=
X-Google-Smtp-Source: APXvYqx/tTThM4N8APNQHLuc1ZTNOdmNUUvYzcgT2iO5rANQjtbhDryyAcZQW3n5eq1V6wjE4DENeg==
X-Received: by 2002:a17:90a:e4f:: with SMTP id p15mr16868630pja.90.1576251370516;
        Fri, 13 Dec 2019 07:36:10 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id w131sm12039217pfc.16.2019.12.13.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 07:36:09 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/4] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Fri, 13 Dec 2019 15:35:44 +0000
Message-Id: <20191213153546.17425-3-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213153546.17425-1-sjpark@amazon.de>
References: <20191213153546.17425-1-sjpark@amazon.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Each `blkif` has a free pages pool for the grant mapping.  The size of
the pool starts from zero and is increased on demand while processing
the I/O requests.  If current I/O requests handling is finished or 100
milliseconds has passed since last I/O requests handling, it checks and
shrinks the pool to not exceed the size limit, `max_buffer_pages`.

Therefore, host administrators can cause memory pressure in blkback by
attaching a large number of block devices and inducing I/O.  Such
problematic situations can be avoided by limiting the maximum number of
devices that can be attached, but finding the optimal limit is not so
easy.  Improper set of the limit can results in memory pressure or a
resource underutilization.  This commit avoids such problematic
situations by squeezing the pools (returns every free page in the pool
to the system) for a while (users can set this duration via a module
parameter) if memory pressure is detected.

Discussions
===========

The `blkback`'s original shrinking mechanism returns only pages in the
pool which are not currently be used by `blkback` to the system.  In
other words, the pages that are not mapped with granted pages.  Because
this commit is changing only the shrink limit but still uses the same
freeing mechanism it does not touch pages which are currently mapping
grants.

Once memory pressure is detected, this commit keeps the squeezing limit
for a user-specified time duration.  The duration should be neither too
long nor too short.  If it is too long, the squeezing incurring overhead
can reduce the I/O performance.  If it is too short, `blkback` will not
free enough pages to reduce the memory pressure.  This commit sets the
value as `10 milliseconds` by default because it is a short time in
terms of I/O while it is a long time in terms of memory operations.
Also, as the original shrinking mechanism works for at least every 100
milliseconds, this could be a somewhat reasonable choice.  I also tested
other durations (refer to the below section for more details) and
confirmed that 10 milliseconds is the one that works best with the test.
That said, the proper duration depends on actual configurations and
workloads.  That's why this commit allows users to set the duration as a
module parameter.

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
you have any doubt, test on your machine with your workload to find the
optimal squeezing duration for you.

[1] https://aws.amazon.com/ebs/
[2] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/ramdisk.html

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 .../ABI/testing/sysfs-driver-xen-blkback      | 10 +++++++++
 drivers/block/xen-blkback/blkback.c           |  7 +++++--
 drivers/block/xen-blkback/common.h            |  1 +
 drivers/block/xen-blkback/xenbus.c            | 21 ++++++++++++++++++-
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
index 4e7babb3ba1f..f01224231f3f 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
@@ -25,3 +25,13 @@ Description:
                 allocated without being in use. The time is in
                 seconds, 0 means indefinitely long.
                 The default is 60 seconds.
+
+What:           /sys/module/xen_blkback/parameters/buffer_squeeze_duration_ms
+Date:           December 2019
+KernelVersion:  5.5
+Contact:        SeongJae Park <sjpark@amazon.de>
+Description:
+                When memory pressure is reported to blkback this option
+                controls the duration in milliseconds that blkback will not
+                cache any page not backed by a grant mapping.
+                The default is 10ms.
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..79f677aeb5cc 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -656,8 +656,11 @@ int xen_blkif_schedule(void *arg)
 			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
 		}
 
-		/* Shrink if we have more than xen_blkif_max_buffer_pages */
-		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
+		/* Shrink the free pages pool if it is too large. */
+		if (time_before(jiffies, blkif->buffer_squeeze_end))
+			shrink_free_pagepool(ring, 0);
+		else
+			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
 
 		if (log_stats && time_after(jiffies, ring->st_print))
 			print_stats(ring);
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..536c84f61fed 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -319,6 +319,7 @@ struct xen_blkif {
 	/* All rings for this device. */
 	struct xen_blkif_ring	*rings;
 	unsigned int		nr_rings;
+	unsigned long		buffer_squeeze_end;
 };
 
 struct seg_buf {
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b90dbcd99c03..4f6ea4feca79 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
 }
 
 
+/* Once a memory pressure is detected, squeeze free page pools for a while. */
+static unsigned int buffer_squeeze_duration_ms = 10;
+module_param_named(buffer_squeeze_duration_ms,
+		buffer_squeeze_duration_ms, int, 0644);
+MODULE_PARM_DESC(buffer_squeeze_duration_ms,
+"Duration in ms to squeeze pages buffer when a memory pressure is detected");
+
+/*
+ * Callback received when the memory pressure is detected.
+ */
+static void reclaim_memory(struct xenbus_device *dev)
+{
+	struct backend_info *be = dev_get_drvdata(&dev->dev);
+
+	be->blkif->buffer_squeeze_end = jiffies +
+		msecs_to_jiffies(buffer_squeeze_duration_ms);
+}
+
 /* ** Connection ** */
 
 
@@ -1115,7 +1133,8 @@ static struct xenbus_driver xen_blkbk_driver = {
 	.ids  = xen_blkbk_ids,
 	.probe = xen_blkbk_probe,
 	.remove = xen_blkbk_remove,
-	.otherend_changed = frontend_changed
+	.otherend_changed = frontend_changed,
+	.reclaim_memory = reclaim_memory,
 };
 
 int xen_blkif_xenbus_init(void)
-- 
2.17.1

