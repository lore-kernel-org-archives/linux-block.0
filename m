Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C197BC43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF612067C
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="I2+up6ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfLLPXZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:23:25 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:58028 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfLLPXZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 10:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576164204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gYDKEote6nZzfFtY/B3Bt+4wk/QQ/K5SQUNQRMsAuMQ=;
  b=I2+up6IDHnfKidG9nsR6b5dRrDM0jH4efQSp6odHSEYKuzGU2e7i+kHl
   kCchBslIAwegbFf2CwxtihbE2Nz2ox6RGfWj+uu73zvi2IJFe40YMhpKd
   m2gAjdP/XT6PdCB9HvoygvZfexUoN+2oVqqGhW0C8jGK81XNmYn5ie8LR
   k=;
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
IronPort-SDR: ZNyWCsM6N4/1gv+dV4ixDqV1rHhYuMm/H7nbvJT3hnqx/dL+UwTZMgz7Ce5hwJL4RZX2UnyI+y
 SJITAIwvJR3i/CjdodxZ49Lh4pWTcQC/SGRwMz8Hxd+u0bGCIvvI2am3YIGJyp4Ljcjb23n5yT
 +LblLtgyjvnRbFs8q21cjJ4jiMwTJ2Nm+Xvh6drEkrXUQTeUlBlHd1FrD6TqklMibsZSFzCUDw
 bqu8OPqOH0iwIlOZhbggjEEYDXU9oK0IUN5TH+exjyJ1PMOipAwy8PjM58PrtyJERFue9+SH8W
 teA=
X-SBRS: 2.7
X-MesageID: 10008666
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,306,1571716800"; 
   d="scan'208";a="10008666"
Date:   Thu, 12 Dec 2019 16:23:17 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <sjpark@amazon.com>,
        <konrad.wilk@oracle.com>, <pdurrant@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: Re: Re: [Xen-devel] [PATCH v7 2/3] xen/blkback: Squeeze page pools
 if a memory pressure is detected
Message-ID: <20191212152317.GE11756@Air-de-Roger>
References: <20191212114247.GB11756@Air-de-Roger>
 <20191212133905.462-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191212133905.462-1-sj38.park@gmail.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 12, 2019 at 02:39:05PM +0100, SeongJae Park wrote:
> On Thu, 12 Dec 2019 12:42:47 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> > > On the slow block device
> > > ------------------------
> > > 
> > >     max_pgs   Min       Max       Median     Avg    Stddev
> > >     0         38.7      45.8      38.7       40.12  3.1752165
> > >     1024      38.7      45.8      38.7       40.12  3.1752165
> > >     No difference proven at 95.0% confidence
> > > 
> > > On the fast block device
> > > ------------------------
> > > 
> > >     max_pgs   Min       Max       Median     Avg    Stddev
> > >     0         417       423       420        419.4  2.5099801
> > >     1024      414       425       416        417.8  4.4384682
> > >     No difference proven at 95.0% confidence
> > 
> > This is intriguing, as it seems to prove that the usage of a cache of
> > free pages is irrelevant performance wise.
> > 
> > The pool of free pages was introduced long ago, and it's possible that
> > recent improvements to the balloon driver had made such pool useless,
> > at which point it could be removed instead of worked around.
> 
> I guess the grant page allocation overhead in this test scenario is really
> small.  In an absence of memory pressure, fragmentation, and NUMA imbalance,
> the latency of the page allocation ('get_page()') is very short, as it will
> success in the fast path.

The allocation of the pool of free pages involves more than get_page,
it uses gnttab_alloc_pages which in the worse case will allocate a
page and balloon it out issuing one hypercall.

> Few years ago, I once measured the page allocation latency on my machine.
> Roughly speaking, it was about 1us in best case, 100us in worst case, and 5us
> in average.  Please keep in mind that the measurement was not designed and
> performed in serious way.  Thus the results could have profile overhead in it,
> though.  While keeping that in mind, let's simply believe the number and ignore
> the latency of the block layer, blkback itself (including the grant
> mapping), and anything else including context switch, cache miss, but the
> allocation.  In other words, suppose that the grant page allocation is only one
> source of the overhead.  It will be able to achieve 1 million IOPS (4KB *
> 1MIOPS = 4 GB/s) in the best case, 200 thousand IOPS (800 MB/s) in average, and
> 10 thousand IOPS (40 MB/s) in worst case.  Based on this coarse calculation, I
> think the test results is reasonable.
> 
> This also means that the effect of the blkback's free pages pool might be
> visible under page allocation fast path failure situation.  Nevertheless, it
> would be also hard to measure that in micro level unless the measurement is
> well designed and controlled.
> 
> > 
> > Do you think you could perform some more tests (as pointed out above
> > against the block device to skip the fs overhead) and report back the
> > results?
> 
> To be honest, I'm not sure whether additional tests are really necessary,
> because I think the `dd` test and the results explanation already makes some
> sense and provide the minimal proof of the concept.  Also, this change is a
> fallback for the memory pressure situation, which is an error path in some
> point of view.  Such errorneous situation might not happen frequently and if
> the situation is not solved in short time, something much worse (e.g., OOM kill
> of the user space xen control processes) than temporal I/O performance
> degradation could happen.  Thus, I'm not sure whether such detailed performance
> measurement is necessary for this rare error handling change.

Right, my main concern is that we seem to be adding duck tape so
things don't fall apart, but if such cache is really not beneficial
from a performance PoV I would rather see it go away than adding more
stuff to it in order to workaround corner cases like memory
starvation.

Anyway, I guess we can take such change, but long term we need to look
into fixing grants to not use ballooned pages, and figure out if the
blkback free page cache is really useful or not.

Thanks, Roger.
