Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7507AC282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 12:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3BE2070E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 12:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Fc7Imd7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgAHMlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:41:31 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:13760 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHMlb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 07:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1578487291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kKzckFXtd4QCltPF91w9MDyi+uT80gIXF5vn2oy5HgE=;
  b=Fc7Imd7JKm1UvCVlARDbWFxXt4HngPFAYsQy5QEtN6q2780GVlX1Qk6z
   vWDy49kCavjP7hZEqYnRznz1ZD4+x/gimR6MEFkQNEsJesR6w/6bj1JPS
   +gKGE63rtb6fxW/wj5hptd85cfDFuPqN4olDc2tkaz7rwFbvnkZDNGWQq
   o=;
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
IronPort-SDR: /gIoRj6HHUkZXOqLm5gucpQE7SqaVHIUDpCxc5YQw3CQFxfGAHwWPxaOZt3QxuBf2lpYm47rOP
 r9kFNIrnVTds4ZCwZ2qnKoTPkemuaTAiiR9bdVoYGTr9186U0zLx+7X5eX5IoGpNcvxHpOvt4u
 vjJl7UWecuhD5DLRitGStmjA5YJC7XpL1aLFKS4EpJtPH/PbUvxuJSQJMNNeLHC6etw/Rm8lOt
 SO9ENyx8MPxCQHQMn2aMuy6VDYXe8Sn+aVAXKRUQnCx+6UPJs6WySlrPn/yoS0KQ2vnfnb92EQ
 CNM=
X-SBRS: 2.7
X-MesageID: 10607407
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,410,1571716800"; 
   d="scan'208";a="10607407"
Date:   Wed, 8 Jan 2020 13:40:57 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        "SeongJae Park" <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 3/5] xen/blkback: Squeeze page pools if a memory
 pressure is detected
Message-ID: <20200108124057.GN11756@Air-de-Roger>
References: <20191218183718.31719-1-sjpark@amazon.com>
 <20191218183718.31719-4-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218183718.31719-4-sjpark@amazon.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 18, 2019 at 07:37:16PM +0100, SeongJae Park wrote:
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

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, and sorry for the delay!

Roger.
