Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B77C2D0BF
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 11:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E2C2073D
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 11:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="hFd/VNWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfLJLEm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:04:42 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:6084 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfLJLEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 06:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575975881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eM9GJhYmgntlMtTD+75XtmeukkZf/oCk8wIREKff2H4=;
  b=hFd/VNWPMglqcJwQCqIkmnms0+ybC3sDqi9PYkT2Y8Z5UfynNO0FSHhs
   ULL3sbsMSFqM/g6NwoWQuNCEY21gHZ1od85HONNRy4Ew9TFOmiCnB8Zyt
   CwdS2hr/Rdpk6aLOATaAvtaapeYFfPPpPNSEt+lOZt+nP8dW36JRDjf8Y
   8=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 9NmFtmBaQa/YevSgNyWFN4SYb4s0qJ0+o7kXfLOEohSi05nK3qKNNI6cWkOmOBP3WoxXRl6CUR
 hTdhntcws6D0XdAcAaFBbIhPChSmidxXRRyR0d+ecQQtbrYBf79ZGRD2y/p9TP+WdAolc7jCk/
 ob6+XUtrnHaWmWbjSUt4GaNZMUuOJoFfebUSLOn689ywemALYsGuGxnRLoiQYnf2+r+uuRBeIe
 FCdz7/CA231Fn4ymQRJDuV7H62knKYw9L4N/Eqxsd/E3dpQR/ZD7uO4uBuxjBYJkZWZk2BrVEh
 wxE=
X-SBRS: 2.7
X-MesageID: 9859319
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,299,1571716800"; 
   d="scan'208";a="9859319"
Date:   Tue, 10 Dec 2019 12:04:32 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <sjpark@amazon.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <xen-devel@lists.xenproject.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v5 2/2] xen/blkback: Squeeze page pools if a memory
 pressure is detected
Message-ID: <20191210110432.GG980@Air-de-Roger>
References: <20191210080628.5264-1-sjpark@amazon.de>
 <20191210080628.5264-3-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191210080628.5264-3-sjpark@amazon.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 10, 2019 at 08:06:28AM +0000, SeongJae Park wrote:
> Each `blkif` has a free pages pool for the grant mapping.  The size of
> the pool starts from zero and be increased on demand while processing
> the I/O requests.  If current I/O requests handling is finished or 100
> milliseconds has passed since last I/O requests handling, it checks and
> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
> 
> Therefore, `blkfront` running guests can cause a memory pressure in the
> `blkback` running guest by attaching a large number of block devices and
> inducing I/O.

Hm, I don't think this is actually true. blkfront cannot attach an
arbitrary number of devices, blkfront is just a frontend for a device
that's instantiated by the Xen toolstack, so it's the toolstack the one
that controls the amount of PV block devices.

> System administrators can avoid such problematic
> situations by limiting the maximum number of devices each guest can
> attach.  However, finding the optimal limit is not so easy.  Improper
> set of the limit can results in the memory pressure or a resource
> underutilization.  This commit avoids such problematic situations by
> squeezing the pools (returns every free page in the pool to the system)
> for a while (users can set this duration via a module parameter) if a
> memory pressure is detected.
> 
> Discussions
> ===========
> 
> The `blkback`'s original shrinking mechanism returns only pages in the
> pool, which are not currently be used by `blkback`, to the system.  In
> other words, the pages are not mapped with foreign pages.  Because this
                        ^ that               ^ granted
> commit is changing only the shrink limit but uses the mechanism as is,
> this commit does not introduce improper mappings related security
> issues.

That last sentence is hard to parse. I think something like:

"Because this commit is changing only the shrink limit but still uses the
same freeing mechanism it does not touch pages which are currently
mapping grants."

> 
> Once a memory pressure is detected, this commit keeps the squeezing
> limit for a user-specified time duration.  The duration should be
> neither too long nor too short.  If it is too long, the squeezing
> incurring overhead can reduce the I/O performance.  If it is too short,
> `blkback` will not free enough pages to reduce the memory pressure.
> This commit sets the value as `10 milliseconds` by default because it is
> a short time in terms of I/O while it is a long time in terms of memory
> operations.  Also, as the original shrinking mechanism works for at
> least every 100 milliseconds, this could be a somewhat reasonable
> choice.  I also tested other durations (refer to the below section for
> more details) and confirmed that 10 milliseconds is the one that works
> best with the test.  That said, the proper duration depends on actual
> configurations and workloads.  That's why this commit is allowing users
                                                        ^ allows
> to set it as their optimal value via the module parameter.

... to set the duration as a module parameter.

> 
> Memory Pressure Test
> ====================
> 
> To show how this commit fixes the memory pressure situation well, I
> configured a test environment on a xen-running virtualization system.
> On the `blkfront` running guest instances, I attach a large number of
> network-backed volume devices and induce I/O to those.  Meanwhile, I
> measure the number of pages that swapped in and out on the `blkback`
> running guest.  The test ran twice, once for the `blkback` before this
> commit and once for that after this commit.  As shown below, this commit
> has dramatically reduced the memory pressure:
> 
>                 pswpin  pswpout

I assume pswpin means 'pages swapped in' and pswpout 'pages swapped
out'. Might be good to add a note to that effect.

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
> the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
> the value to `1024` and `0`.  The `1024` is the default value.  Setting
> the value as `0` is same to a situation doing the squeezing always
> (worst-case).
> 
> For the I/O performance measurement, I use a simple `dd` command.
> 
> Default Performance
> -------------------
> 
>     [dom0]# echo 1024 > /sys/module/xen_blkback/parameters/max_buffer_pages
>     [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8827 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8781 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8737 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8702 s, 38.7 MB/s
> 
> Worst-case Performance
> ----------------------
> 
>     [dom0]# echo 0 > /sys/module/xen_blkback/parameters/max_buffer_pages
>     [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.878 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8746 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8786 s, 38.7 MB/s
>     131072+0 records in
>     131072+0 records out
>     536870912 bytes (537 MB) copied, 13.8749 s, 38.7 MB/s
> 
> In short, even worst case squeezing makes no visible performance
> degradation.

I would argue that with a ~40MB/s throughput you won't see any
performance difference at all regardless of the size of the pool of
free pages or the amount of persistent grants because the bottleneck is
on the storage performance itself.

You need to test this using nullblk or some kind of fast storage, or
else the above figures are not going to reflect any changes you make
because they are hidden by the poor performance of the underlying
storage.

> I think this is due to the slow speed of the I/O.  In
> other words, the additional page allocation overhead is hidden under the
> much slower I/O latency.
> 
> Nevertheless, pleaset note that this is just a very simple and minimal
> test.

I would like to add that IMO this is papering over an existing issue,
which is how pages to be used to map grants are allocated. Grant
mappings _shouldn't_ consume RAM pages in the first place, and IIRC
the fact that they do is because Linux balloons out memory in order to
re-use those pages to map grants and have a valid page struct.

A way to solve this would be to hotplug a fake memory region and use
it in order to map grant pages, without having to balloon out RAM
regions. At the end of day on a PV domain mapping a grant should just
require virtual address space.

This is going to get even worse for PVH that requires a physical memory
address in order to map a grant, but that's another story.

> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  drivers/block/xen-blkback/blkback.c | 23 +++++++++++++++++++++--
>  drivers/block/xen-blkback/common.h  |  1 +
>  drivers/block/xen-blkback/xenbus.c  |  3 ++-
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index fd1e19f1a49f..4d4dba7ea721 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -142,6 +142,22 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
>  		HZ * xen_blkif_pgrant_timeout);
>  }
>  
> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> +static int xen_blkif_buffer_squeeze_duration_ms = 10;

unsigned?

You can likely drop the xen_blkif prefix since this is a static
variable.

> +module_param_named(buffer_squeeze_duration_ms,
> +		xen_blkif_buffer_squeeze_duration_ms, int, 0644);
> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> +
> +static unsigned long xen_blk_buffer_squeeze_end;
> +
> +unsigned xen_blkbk_reclaim(struct xenbus_device *dev)
> +{
> +	xen_blk_buffer_squeeze_end = jiffies +
> +		msecs_to_jiffies(xen_blkif_buffer_squeeze_duration_ms);
> +	return 0;
> +}
> +
>  static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
>  {
>  	unsigned long flags;
> @@ -656,8 +672,11 @@ int xen_blkif_schedule(void *arg)
>  			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
>  		}
>  
> -		/* Shrink if we have more than xen_blkif_max_buffer_pages */
> -		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
> +		/* Shrink the free pages pool if it is too large. */
> +		if (time_before(jiffies, xen_blk_buffer_squeeze_end))
> +			shrink_free_pagepool(ring, 0);
> +		else
> +			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
>  
>  		if (log_stats && time_after(jiffies, ring->st_print))
>  			print_stats(ring);
> diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
> index 1d3002d773f7..c0334cda79fe 100644
> --- a/drivers/block/xen-blkback/common.h
> +++ b/drivers/block/xen-blkback/common.h
> @@ -383,6 +383,7 @@ irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
>  int xen_blkif_schedule(void *arg);
>  int xen_blkif_purge_persistent(void *arg);
>  void xen_blkbk_free_caches(struct xen_blkif_ring *ring);
> +unsigned xen_blkbk_reclaim(struct xenbus_device *dev);
>  
>  int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
>  			      struct backend_info *be, int state);
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index b90dbcd99c03..de49a09e6933 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -1115,7 +1115,8 @@ static struct xenbus_driver xen_blkbk_driver = {
>  	.ids  = xen_blkbk_ids,
>  	.probe = xen_blkbk_probe,
>  	.remove = xen_blkbk_remove,
> -	.otherend_changed = frontend_changed
> +	.otherend_changed = frontend_changed,
> +	.reclaim = xen_blkbk_reclaim

While at it please add the ending comma so that new addition don't
have to modify the previous line.

Thanks, Roger.
