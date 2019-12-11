Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27508C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 11:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D974F214AF
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 11:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="KN/NdJZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKLOy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:14:54 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:22399 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfLKLOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 06:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576062892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Js+KXVZu0C18q/pPZwN6y53cJHe5c921qavIhxSbNr0=;
  b=KN/NdJZBHKvsOTj9enYihaSSbrUQ9P9/oxUxur35BCT1RgBWyRFgMyrD
   9pUWeUNfAvKIJ0es99iT30FYNb+6Ym0nY4JtPMi5OOX+/kEv774IEqt88
   8MU4hKzLFtvKzP7SrtJH4cSlqMmW6mtfvtFPpZSDGjg05iwREqOic2WId
   w=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: E1SgW5d/JwjFrVJ4rG46aG2mxrt+Z9vE+P4acKp8Lh42xK/bQFGNRypqf2fT9YkW7PLI8xIBPz
 z6po0exRV2hbTI43CIoh3Xbdrez9/AzsmRjlJfcTkOrpPKfGFP3ky389luPc0n7G8uNTntQ9Ip
 GacmHMNpXXX62Bt7DAY0JO9WxnexhCc+njV5MJVGPHVxk7dqfky2jd8JKpQbrjATP5MrrgqkXO
 Jnl2i9FjGa4XBtpxyBP0e2uCc3U1U10bMTk0rj2/Ja9WIiWfZ2KLEvnBtf02J0itS4853l2/Ob
 iok=
X-SBRS: 2.7
X-MesageID: 9645192
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,301,1571716800"; 
   d="scan'208";a="9645192"
Date:   Wed, 11 Dec 2019 12:14:44 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <sjpark@amazon.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <xen-devel@lists.xenproject.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: [PATCH v5 2/2] xen/blkback: Squeeze page pools if a memory
 pressure is detected
Message-ID: <20191211111444.GL980@Air-de-Roger>
References: <20191210110432.GG980@Air-de-Roger>
 <20191211040812.12354-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211040812.12354-1-sj38.park@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I see that you have already sent v6, for future iterations can you
please wait until the conversation on the previous version has been
settled?

I'm still replying to your replies to v5, and hence you should hold off
sending v6 until we get some kind of conclusion/agreement.

On Wed, Dec 11, 2019 at 05:08:12AM +0100, SeongJae Park wrote:
> On Tue, 10 Dec 2019 12:04:32 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> 
> > > Each `blkif` has a free pages pool for the grant mapping.  The size of
> > > the pool starts from zero and be increased on demand while processing
> > > the I/O requests.  If current I/O requests handling is finished or 100
> > > milliseconds has passed since last I/O requests handling, it checks and
> > > shrinks the pool to not exceed the size limit, `max_buffer_pages`.
> > > 
> > > Therefore, `blkfront` running guests can cause a memory pressure in the
> > > `blkback` running guest by attaching a large number of block devices and
> > > inducing I/O.
> > 
> > Hm, I don't think this is actually true. blkfront cannot attach an
> > arbitrary number of devices, blkfront is just a frontend for a device
> > that's instantiated by the Xen toolstack, so it's the toolstack the one
> > that controls the amount of PV block devices.
> 
> Right, the problem can occur only if it is mis-configured so that the frontend
> running guests can attach a large number of devices which is enough to cause
> the memory pressure.  I tried to explain it in below paragraph, but seems above
> paragraph is a little bit confusing.  I will wordsmith the sentence in the next
> version.

I would word it along these lines:

"Host administrators can cause memory pressure in blkback by attaching
a large number of block devices and inducing I/O."

> > 
> > > System administrators can avoid such problematic
> > > situations by limiting the maximum number of devices each guest can
> > > attach.  However, finding the optimal limit is not so easy.  Improper
> > > set of the limit can results in the memory pressure or a resource
> > > underutilization.  This commit avoids such problematic situations by
> > > squeezing the pools (returns every free page in the pool to the system)
> > > for a while (users can set this duration via a module parameter) if a
> > > memory pressure is detected.
> > > 
> > > Discussions
> > > ===========
> > > 
> > > The `blkback`'s original shrinking mechanism returns only pages in the
> > > pool, which are not currently be used by `blkback`, to the system.  In
> > > other words, the pages are not mapped with foreign pages.  Because this
> >                         ^ that               ^ granted
> > > commit is changing only the shrink limit but uses the mechanism as is,
> > > this commit does not introduce improper mappings related security
> > > issues.
> > 
> > That last sentence is hard to parse. I think something like:
> > 
> > "Because this commit is changing only the shrink limit but still uses the
> > same freeing mechanism it does not touch pages which are currently
> > mapping grants."
> > 
> > > 
> > > Once a memory pressure is detected, this commit keeps the squeezing
> > > limit for a user-specified time duration.  The duration should be
> > > neither too long nor too short.  If it is too long, the squeezing
> > > incurring overhead can reduce the I/O performance.  If it is too short,
> > > `blkback` will not free enough pages to reduce the memory pressure.
> > > This commit sets the value as `10 milliseconds` by default because it is
> > > a short time in terms of I/O while it is a long time in terms of memory
> > > operations.  Also, as the original shrinking mechanism works for at
> > > least every 100 milliseconds, this could be a somewhat reasonable
> > > choice.  I also tested other durations (refer to the below section for
> > > more details) and confirmed that 10 milliseconds is the one that works
> > > best with the test.  That said, the proper duration depends on actual
> > > configurations and workloads.  That's why this commit is allowing users
> >                                                         ^ allows
> > > to set it as their optimal value via the module parameter.
> > 
> > ... to set the duration as a module parameter.
> 
> Thank you for great suggestions, I will apply those.
> 
> > 
> > > 
> > > Memory Pressure Test
> > > ====================
> > > 
> > > To show how this commit fixes the memory pressure situation well, I
> > > configured a test environment on a xen-running virtualization system.
> > > On the `blkfront` running guest instances, I attach a large number of
> > > network-backed volume devices and induce I/O to those.  Meanwhile, I
> > > measure the number of pages that swapped in and out on the `blkback`
> > > running guest.  The test ran twice, once for the `blkback` before this
> > > commit and once for that after this commit.  As shown below, this commit
> > > has dramatically reduced the memory pressure:
> > > 
> > >                 pswpin  pswpout
> > 
> > I assume pswpin means 'pages swapped in' and pswpout 'pages swapped
> > out'. Might be good to add a note to that effect.
> 
> Good point!  I will add the note.
> 
> > 
> > >     before      76,672  185,799
> > >     after          212    3,325
> > > 
> > > Optimal Aggressive Shrinking Duration
> > > -------------------------------------
> > > 
> > > To find a best squeezing duration, I repeated the test with three
> > > different durations (1ms, 10ms, and 100ms).  The results are as below:
> > > 
> > >     duration    pswpin  pswpout
> > >     1           852     6,424
> > >     10          212     3,325
> > >     100         203     3,340
> > > 
> > > As expected, the memory pressure has decreased as the duration is
> > > increased, but the reduction stopped from the `10ms`.  Based on this
> > > results, I chose the default duration as 10ms.
> > > 
> > > Performance Overhead Test
> > > =========================
> > > 
> > > This commit could incur I/O performance degradation under severe memory
> > > pressure because the squeezing will require more page allocations per
> > > I/O.  To show the overhead, I artificially made a worst-case squeezing
> > > situation and measured the I/O performance of a `blkfront` running
> > > guest.
> > > 
> > > For the artificial squeezing, I set the `blkback.max_buffer_pages` using
> > > the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  We set
> > > the value to `1024` and `0`.  The `1024` is the default value.  Setting
> > > the value as `0` is same to a situation doing the squeezing always
> > > (worst-case).
> > > 
> > > For the I/O performance measurement, I use a simple `dd` command.
> > > 
> > > Default Performance
> > > -------------------
> > > 
> > >     [dom0]# echo 1024 > /sys/module/xen_blkback/parameters/max_buffer_pages
> > >     [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 13.8827 s, 38.7 MB/s
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 13.8781 s, 38.7 MB/s
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 13.8737 s, 38.7 MB/s
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 13.8702 s, 38.7 MB/s

While this is useful, it's kind of too verbose IMO. If you need to do
this kind of performance comparisons I would recommend using ministat
(available at least on Debian and FreeBSD) in order to plot the
results and give the std deviation and statistical difference given a
confidence level.

The output of ministat can be pasted in the commit message, since it's
a text based tool.

> > > 
> > > Worst-case Performance
> > > ----------------------
> > > 
> > >     [dom0]# echo 0 > /sys/module/xen_blkback/parameters/max_buffer_pages
> > >     [instance]$ for i in {1..5}; do dd if=/dev/zero of=file bs=4k count=$((256*512)); sync; done
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 11.7257 s, 45.8 MB/s
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 13.878 s, 38.7 MB/s
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 13.8746 s, 38.7 MB/s
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 13.8786 s, 38.7 MB/s
> > >     131072+0 records in
> > >     131072+0 records out
> > >     536870912 bytes (537 MB) copied, 13.8749 s, 38.7 MB/s
> > > 
> > > In short, even worst case squeezing makes no visible performance
> > > degradation.
> > 
> > I would argue that with a ~40MB/s throughput you won't see any
> > performance difference at all regardless of the size of the pool of
> > free pages or the amount of persistent grants because the bottleneck is
> > on the storage performance itself.
> > 
> > You need to test this using nullblk or some kind of fast storage, or
> > else the above figures are not going to reflect any changes you make
> > because they are hidden by the poor performance of the underlying
> > storage.
> 
> Yes, agree that.  My test is just a minimal check for my environment.  I will
> note the points and concerns in the commit message.

I'm afraid that just adding a note about this concerns is not enough.

We should make sure that this change doesn't regress the current
performance of fast storage backends, and hence I have to ask you to
test with null_blk or a fast storage and provide the figures.

> > 
> > > I think this is due to the slow speed of the I/O.  In
> > > other words, the additional page allocation overhead is hidden under the
> > > much slower I/O latency.
> > > 
> > > Nevertheless, pleaset note that this is just a very simple and minimal
> > > test.
> > 
> > I would like to add that IMO this is papering over an existing issue,
> > which is how pages to be used to map grants are allocated. Grant
> > mappings _shouldn't_ consume RAM pages in the first place, and IIRC
> > the fact that they do is because Linux balloons out memory in order to
> > re-use those pages to map grants and have a valid page struct.
> > 
> > A way to solve this would be to hotplug a fake memory region and use
> > it in order to map grant pages, without having to balloon out RAM
> > regions. At the end of day on a PV domain mapping a grant should just
> > require virtual address space.
> > 
> > This is going to get even worse for PVH that requires a physical memory
> > address in order to map a grant, but that's another story.
> 
> Yes, as Paul also pointed out and suggested, we should consider a structural
> solution in a big picture.  Until the big change is ready, this simple solution
> would work as a point fix.

Getting a proper solution would be my preference, in the mean time I
guess it's fine to accept such a bodge, as it's pretty small and
non-intrusive.

Thanks, Roger.
