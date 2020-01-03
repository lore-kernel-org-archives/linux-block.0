Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146EAC00523
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 07:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0138821D7D
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 07:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a4p9aCO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgACHz2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:55:28 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:36750 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACHz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 02:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578038127; x=1609574127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=BNj2ZpEqscC16GT1ujYI1MhyWZyxnccFrqY6TpA1/wU=;
  b=a4p9aCO18n0D9tWTRIkfJhUEzU3WBiJlxiGQAfRG7FydhrohcEa8Tio1
   zm7f4Whv7K4kWp3BtWwYoWZfXxmti+pylCMktT4ANEVZgFn26uu8qbqoi
   1e69hYBISrDC64hcnasUkh5EV4gF5rAWdXd3BtFKW0uNrKyBdLCa96h6u
   M=;
IronPort-SDR: QwSJXMSAWI5rBa/AVXZwfYid/EHff+9L/s8IDNWg6pTX+v8EnMtlCqIc9bOvfc1hEdMe38punz
 qQ2Ta0LX70cg==
X-IronPort-AV: E=Sophos;i="5.69,389,1571702400"; 
   d="scan'208";a="10782255"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Jan 2020 07:55:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 5FEC8A2575;
        Fri,  3 Jan 2020 07:55:22 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 Jan 2020 07:55:21 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 3 Jan 2020 07:55:16 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <roger.pau@citrix.com>, SeongJae Park <sjpark@amazon.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <pdurrant@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v13 3/5] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Fri, 3 Jan 2020 08:54:48 +0100
Message-ID: <20200103075448.12994-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218183718.31719-4-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.109]
X-ClientProxiedBy: EX13d09UWC003.ant.amazon.com (10.43.162.113) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Roger,

Sorry if I'm disturbing your vacation.  If you are already came back to work,
may I ask your opinion about this patch?

On Wed, 18 Dec 2019 19:37:16 +0100 SeongJae Park <sjpark@amazon.com> wrote:

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
>     after          867    3,967
> 
> Optimal Aggressive Shrinking Duration
> -------------------------------------
> 
> To find a best squeezing duration, I repeated the test with three
> different durations (1ms, 10ms, and 100ms).  The results are as below:
> 
>     duration    pswpin  pswpout
>     1           707     5,095
>     10          867     3,967
>     100         362     3,348
> 
> As expected, the memory pressure decreases as the duration increases,
> but the reduction become slow from the `10ms`.  Based on this results, I
> chose the default duration as 10ms.
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
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  .../ABI/testing/sysfs-driver-xen-blkback      | 10 ++++++++
>  drivers/block/xen-blkback/blkback.c           |  7 ++++--
>  drivers/block/xen-blkback/common.h            |  1 +
>  drivers/block/xen-blkback/xenbus.c            | 23 ++++++++++++++++++-
>  4 files changed, 38 insertions(+), 3 deletions(-)
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
> index b90dbcd99c03..24172c180f5f 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -824,6 +824,26 @@ static void frontend_changed(struct xenbus_device *dev,
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
> +	if (!be)
> +		return;

This null check is the only one change from the version
(https://lore.kernel.org/xen-devel/20191216093755.GJ11756@Air-de-Roger/)
you gave me the 'Reviewed-by' before.  This check is necessary because
'reclaim_memory()' can be called before 'probe' or after 'remove' callback.


Thanks,
SeongJae Park

> +	be->blkif->buffer_squeeze_end = jiffies +
> +		msecs_to_jiffies(buffer_squeeze_duration_ms);
> +}
> +
>  /* ** Connection ** */
>  
>  
> @@ -1115,7 +1135,8 @@ static struct xenbus_driver xen_blkbk_driver = {
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
