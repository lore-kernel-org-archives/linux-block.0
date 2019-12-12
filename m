Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3953C2D0C8
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 11:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD9320663
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 11:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ASvuXtM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfLLLm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:42:58 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:53836 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLLLm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 06:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576150977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U3WcJ8IapAMs/XVPwPZMnZcUn2qsD3OYhJj84xe86X8=;
  b=ASvuXtM06MA5JCvvFaUQbEGgrdUJxBaxu53QD7gznKfO5dAS617hzyhV
   DM8xtljIy90MrgSX0y0wqSALMHtHIPij47TQI//KriBLS/Q6gaerXK4UB
   PwxkvifE5ulRcwg60xCTg13hIf+GBxvAPuxET79DhE7ogtdtGvqZ+r5jJ
   8=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: xLeaKZ9GS66BgkUjAJCuWNJfGpwZGqU5SIN8rNSqddyRh2q1Vlo6ofhfhgAmn2x6ciFqvvS8sd
 BJ3YZRtTzmdmilsP6p6u97ePm16TbJsalqWT6NJZYxWKyHrNpRWawQUX0OBFyiXHMUUQjMXcRI
 e/1kI+XokoIjvWWl70PxVycJJDff3FQoJNpryqZh1roPp91Nctx9X/ovzP0MOkmr+1zi7cL4tt
 YVKX+89EtxcrNulkCoZ4EzJqo7VMmsT6r7pAbHBNV3npo0gP0A0lanqFMuJswt3J+cDEHVI47G
 vBI=
X-SBRS: 2.7
X-MesageID: 9573089
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,305,1571716800"; 
   d="scan'208";a="9573089"
Date:   Thu, 12 Dec 2019 12:42:47 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <sjpark@amazon.com>,
        <pdurrant@amazon.com>, SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v7 2/3] xen/blkback: Squeeze page pools if a
 memory pressure is detected
Message-ID: <20191212114247.GB11756@Air-de-Roger>
References: <20191211181016.14366-1-sjpark@amazon.de>
 <20191211181016.14366-3-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191211181016.14366-3-sjpark@amazon.de>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Please make sure you Cc me in blkback related patches.

On Wed, Dec 11, 2019 at 06:10:15PM +0000, SeongJae Park wrote:
> Each `blkif` has a free pages pool for the grant mapping.  The size of
> the pool starts from zero and be increased on demand while processing
                                ^ is
> the I/O requests.  If current I/O requests handling is finished or 100
> milliseconds has passed since last I/O requests handling, it checks and
> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
> 
> Therefore, host administrators can cause memory pressure in blkback by
> attaching a large number of block devices and inducing I/O.  Such
> problematic situations can be avoided by limiting the maximum number of
> devices that can be attached, but finding the optimal limit is not so
> easy.  Improper set of the limit can results in the memory pressure or a
                                                  ^ s/the//
> resource underutilization.  This commit avoids such problematic
> situations by squeezing the pools (returns every free page in the pool
> to the system) for a while (users can set this duration via a module
> parameter) if a memory pressure is detected.
                ^ s/a//
> 
> Discussions
> ===========
> 
> The `blkback`'s original shrinking mechanism returns only pages in the
> pool, which are not currently be used by `blkback`, to the system.  In

I think you can remove both comas in the above sentence.

> other words, the pages that are not mapped with granted pages.  Because
> this commit is changing only the shrink limit but still uses the same
> freeing mechanism it does not touch pages which are currently mapping
> grants.
> 
> Once a memory pressure is detected, this commit keeps the squeezing
       ^ s/a//
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
> configurations and workloads.  That's why this commit allows users to
> set the duration as a module parameter.
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
> For the I/O performance measurement, I run a simple `dd` command 5 times
> as below and collect the 'MB/s' results.
> 
>     $ for i in {1..5}; do dd if=/dev/zero of=file \
>                              bs=4k count=$((256*512)); sync; done

I think it would be better if you could skip the filesystem overhead
by writing directly to a block device, ie:

Attach a null_blk based block device to the guest (on dom0):
# xl block-attach guest phy:/dev/null_blk0 xvdb w

Run a workload against the device (inside the guest):
# fio --filename=/dev/xvdb --direct=1 --rw=randrw --bs=4k --ioengine=libaio \
      --iodepth=64 --runtime=120 --numjobs=4 --time_based --group_reporting \
      --name=throughput-test-job --eta-newline=1

You should run this on a multi-vcpu guest so that multiple queues are
used, and adjust the numjobs to (at least) match the number of queues.

> 
> If the underlying block device is slow enough, the squeezing overhead
> could be hidden.  For the reason, I do this test for both a slow block
> device and a fast block device.  I use a popular cloud block storage
> service, ebs[1] as a slow device and the ramdisk block device[2] for the
> fast device.
> 
> The results are as below.  'max_pgs' represents the value of the
> `blkback.max_buffer_pages` parameter.
> 
> On the slow block device
> ------------------------
> 
>     max_pgs   Min       Max       Median     Avg    Stddev
>     0         38.7      45.8      38.7       40.12  3.1752165
>     1024      38.7      45.8      38.7       40.12  3.1752165
>     No difference proven at 95.0% confidence
> 
> On the fast block device
> ------------------------
> 
>     max_pgs   Min       Max       Median     Avg    Stddev
>     0         417       423       420        419.4  2.5099801
>     1024      414       425       416        417.8  4.4384682
>     No difference proven at 95.0% confidence

This is intriguing, as it seems to prove that the usage of a cache of
free pages is irrelevant performance wise.

The pool of free pages was introduced long ago, and it's possible that
recent improvements to the balloon driver had made such pool useless,
at which point it could be removed instead of worked around.

Do you think you could perform some more tests (as pointed out above
against the block device to skip the fs overhead) and report back the
results?

> 
> In short, even worst case squeezing on ramdisk based fast block device
> makes no visible performance degradation.  Please note that this is just
> a very simple and minimal test.  On systems using super-fast block
> devices and a special I/O workload, the results might be different.  If
> you have any doubt, test on your machine for your workload to find the
> optimal squeezing duration for you.
> 
> [1] https://aws.amazon.com/ebs/
> [2] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/ramdisk.html
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  drivers/block/xen-blkback/blkback.c | 22 ++++++++++++++++++++--
>  drivers/block/xen-blkback/common.h  |  1 +
>  drivers/block/xen-blkback/xenbus.c  |  3 ++-
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index fd1e19f1a49f..98823d150905 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -142,6 +142,21 @@ static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
>  		HZ * xen_blkif_pgrant_timeout);
>  }
>  
> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> +static unsigned int buffer_squeeze_duration_ms = 10;
> +module_param_named(buffer_squeeze_duration_ms,
> +		buffer_squeeze_duration_ms, int, 0644);
> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");

You should add a description about this parameter to
Documentation/ABI/testing/sysfs-driver-xen-blkback

Thanks, Roger.
