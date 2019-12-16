Return-Path: <SRS0=l7do=2G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7EBC43603
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3D32067C
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rWHOM0GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfLPOiH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:38:07 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:49901 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfLPOiH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Dec 2019 09:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576507087; x=1608043087;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=fpyDnJNaFzRDmUSFRzaiXpmn9Vgqu2xuPDGzAJ/00tw=;
  b=rWHOM0GOrRG3UTLFIc0GgGexngofUao6cf5/bD5F692LukoFNHTD5bQe
   +wCRZYm5d28iMlJKPUYxze7ARvRSSozQuW9rUcQTkS+DdK7APEyoqrZXS
   EarVZQc5mToBldpkdAI+dP6W+hyQSrOBnSWsl22gzECZsL76N9vNGcxiG
   8=;
IronPort-SDR: gyTBQ26kzEFlZzatjQPVeRxSOVFM73lsdOjEVmCMNqDY8YWQ/fuSZDkO7X/j9YiTDszvRV884y
 wf+rkayRnxAQ==
X-IronPort-AV: E=Sophos;i="5.69,321,1571702400"; 
   d="scan'208";a="13780196"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 16 Dec 2019 14:37:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 23D07A249F;
        Mon, 16 Dec 2019 14:37:52 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 14:37:51 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 14:37:46 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     <linux-block@vger.kernel.org>, <sjpark@amazon.com>,
        <pdurrant@amazon.com>, SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Mon, 16 Dec 2019 15:37:20 +0100
Message-ID: <20191216143720.23268-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20191216124527.30306-3-sjpark@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D29UWC001.ant.amazon.com (10.43.162.143) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 16 Dec 2019 13:45:25 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Each `blkif` has a free pages pool for the grant mapping.  The size of
> the pool starts from zero and is increased on demand while processing
> the I/O requests.  If current I/O requests handling is finished or 100
> milliseconds has passed since last I/O requests handling, it checks and
> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
> 
> Therefore, host administrators can cause memory pressure in blkback by
> attaching a large number of block devices and inducing I/O.  Such
> problematic situations can be avoided by limiting the maximum number of
> devices that can be attached, but finding the optimal limit is not so
> easy.  Improper set of the limit can results in memory pressure or a
> resource underutilization.  This commit avoids such problematic
> situations by squeezing the pools (returns every free page in the pool
> to the system) for a while (users can set this duration via a module
> parameter) if memory pressure is detected.
> 
> Discussions
> ===========
> 
> The `blkback`'s original shrinking mechanism returns only pages in the
> pool which are not currently be used by `blkback` to the system.  In
> other words, the pages that are not mapped with granted pages.  Because
> this commit is changing only the shrink limit but still uses the same
> freeing mechanism it does not touch pages which are currently mapping
> grants.
> 
> Once memory pressure is detected, this commit keeps the squeezing limit
> for a user-specified time duration.  The duration should be neither too
> long nor too short.  If it is too long, the squeezing incurring overhead
> can reduce the I/O performance.  If it is too short, `blkback` will not
> free enough pages to reduce the memory pressure.  This commit sets the
> value as `10 milliseconds` by default because it is a short time in
> terms of I/O while it is a long time in terms of memory operations.
> Also, as the original shrinking mechanism works for at least every 100
> milliseconds, this could be a somewhat reasonable choice.  I also tested
> other durations (refer to the below section for more details) and
> confirmed that 10 milliseconds is the one that works best with the test.
> That said, the proper duration depends on actual configurations and
> workloads.  That's why this commit allows users to set the duration as a
> module parameter.
> 
> Memory Pressure Test
> ====================
> 
> To show how this commit fixes the memory pressure situation well, I
> configured a test environment on a xen-running virtualization system.
> On the `blkfront` running guest instances, I attach a large number of
> network-backed volume devices and induce I/O to those.  Meanwhile, I
> measure the number of pages that swapped in (pswpin) and out (pswpout)
> on the `blkback` running guest.  The test ran twice, once for the
> `blkback` before this commit and once for that after this commit.  As
> shown below, this commit has dramatically reduced the memory pressure:
> 
>                 pswpin  pswpout
>     before      76,672  185,799
>     after          212    3,325
> 
> Optimal Aggressive Shrinking Duration
> -------------------------------------
> 
> To find a best squeezing duration, I repeated the test with three
> different durations (1ms, 10ms, and 100ms).  The results are as below:
> 
>     duration    pswpin  pswpout
>     1           852     6,424
>     10          212     3,325
>     100         203     3,340
> 
> As expected, the memory pressure has decreased as the duration is
> increased, but the reduction stopped from the `10ms`.  Based on this
> results, I chose the default duration as 10ms.
> 
> Performance Overhead Test
> =========================
> 
> This commit could incur I/O performance degradation under severe memory
> pressure because the squeezing will require more page allocations per
> I/O.  To show the overhead, I artificially made a worst-case squeezing
> situation and measured the I/O performance of a `blkfront` running
> guest.
> 
> For the artificial squeezing, I set the `blkback.max_buffer_pages` using
> the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  In this
> test, I set the value to `1024` and `0`.  The `1024` is the default
> value.  Setting the value as `0` is same to a situation doing the
> squeezing always (worst-case).
> 
> If the underlying block device is slow enough, the squeezing overhead
> could be hidden.  For the reason, I use a fast block device, namely the
> rbd[1]:
> 
>     # xl block-attach guest phy:/dev/ram0 xvdb w
> 
> For the I/O performance measurement, I run a simple `dd` command 5 times
> directly to the device as below and collect the 'MB/s' results.
> 
>     $ for i in {1..5}; do dd if=/dev/zero of=/dev/xvdb \
>                              bs=4k count=$((256*512)); sync; done
> 
> The results are as below.  'max_pgs' represents the value of the
> `blkback.max_buffer_pages` parameter.
> 
>     max_pgs   Min       Max       Median     Avg    Stddev
>     0         417       423       420        419.4  2.5099801
>     1024      414       425       416        417.8  4.4384682
>     No difference proven at 95.0% confidence
> 
> In short, even worst case squeezing on ramdisk based fast block device
> makes no visible performance degradation.  Please note that this is just
> a very simple and minimal test.  On systems using super-fast block
> devices and a special I/O workload, the results might be different.  If
> you have any doubt, test on your machine with your workload to find the
> optimal squeezing duration for you.
> 
> [1] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/ramdisk.html
> 
> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  .../ABI/testing/sysfs-driver-xen-blkback      | 10 +++++++++
>  drivers/block/xen-blkback/blkback.c           |  7 +++++--
>  drivers/block/xen-blkback/common.h            |  1 +
>  drivers/block/xen-blkback/xenbus.c            | 21 ++++++++++++++++++-
>  4 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> index 4e7babb3ba1f..f01224231f3f 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> @@ -25,3 +25,13 @@ Description:
>                  allocated without being in use. The time is in
>                  seconds, 0 means indefinitely long.
>                  The default is 60 seconds.
> +
> +What:           /sys/module/xen_blkback/parameters/buffer_squeeze_duration_ms
> +Date:           December 2019
> +KernelVersion:  5.5
> +Contact:        SeongJae Park <sjpark@amazon.de>
> +Description:
> +                When memory pressure is reported to blkback this option
> +                controls the duration in milliseconds that blkback will not
> +                cache any page not backed by a grant mapping.
> +                The default is 10ms.
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index fd1e19f1a49f..79f677aeb5cc 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -656,8 +656,11 @@ int xen_blkif_schedule(void *arg)
>  			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
>  		}
>  
> -		/* Shrink if we have more than xen_blkif_max_buffer_pages */
> -		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
> +		/* Shrink the free pages pool if it is too large. */
> +		if (time_before(jiffies, blkif->buffer_squeeze_end))
> +			shrink_free_pagepool(ring, 0);
> +		else
> +			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
>  
>  		if (log_stats && time_after(jiffies, ring->st_print))
>  			print_stats(ring);
> diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
> index 1d3002d773f7..536c84f61fed 100644
> --- a/drivers/block/xen-blkback/common.h
> +++ b/drivers/block/xen-blkback/common.h
> @@ -319,6 +319,7 @@ struct xen_blkif {
>  	/* All rings for this device. */
>  	struct xen_blkif_ring	*rings;
>  	unsigned int		nr_rings;
> +	unsigned long		buffer_squeeze_end;
>  };
>  
>  struct seg_buf {
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index b90dbcd99c03..4f6ea4feca79 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
>  }
>  
>  
> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> +static unsigned int buffer_squeeze_duration_ms = 10;
> +module_param_named(buffer_squeeze_duration_ms,
> +		buffer_squeeze_duration_ms, int, 0644);
> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> +
> +/*
> + * Callback received when the memory pressure is detected.
> + */
> +static void reclaim_memory(struct xenbus_device *dev)
> +{
> +	struct backend_info *be = dev_get_drvdata(&dev->dev);
> +
> +	be->blkif->buffer_squeeze_end = jiffies +
> +		msecs_to_jiffies(buffer_squeeze_duration_ms);

This callback might race with 'xen_blkbk_probe()'.  The race could result in
__NULL dereferencing__, as 'xen_blkbk_probe()' sets '->blkif' after it links
'be' to the 'dev'.  Please _don't merge_ this patch now!

I will do more test and share results.  Meanwhile, if you have any opinion,
please let me know.


Thanks,
SeongJae Park

> +}
> +
>  /* ** Connection ** */
>  
>  
> @@ -1115,7 +1133,8 @@ static struct xenbus_driver xen_blkbk_driver = {
>  	.ids  = xen_blkbk_ids,
>  	.probe = xen_blkbk_probe,
>  	.remove = xen_blkbk_remove,
> -	.otherend_changed = frontend_changed
> +	.otherend_changed = frontend_changed,
> +	.reclaim_memory = reclaim_memory,
>  };
>  
>  int xen_blkif_xenbus_init(void)
> -- 
> 2.17.1
> 
