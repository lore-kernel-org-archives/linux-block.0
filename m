Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:29942 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935646AbdGTRaD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2017 13:30:03 -0400
Date: Thu, 20 Jul 2017 13:36:06 -0400
From: Keith Busch <keith.busch@intel.com>
To: Benoit Depail <benoit.depail@nbs-system.com>
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        xen-users@lists.xen.org, WebDawg <webdawg@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
Message-ID: <20170720173606.GD1202@localhost.localdomain>
References: <5554bd39-6e0a-5c17-2b64-bb80d4a6502b@nbs-system.com>
 <CAKdd5H9f_=NCYMmhLcvHKFw7m_sKvygSVqz3+Z0YPAGiPMxKxQ@mail.gmail.com>
 <5b562ef2-36e2-a08e-1683-6ffc7cfa54de@nbs-system.com>
 <20170717124931.rsiqxkzzkmvfofd7@MacBook-Pro-de-Roger.local>
 <5dd18982-cbcf-a675-1e07-5b4c4e4da50e@nbs-system.com>
 <20170717164658.drliebetcnil3wjb@dhcp-3-128.uk.xensource.com>
 <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
 <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
 <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7205d904-44a3-631f-fbd8-8b62d43ca4e0@nbs-system.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 20, 2017 at 05:12:33PM +0200, Benoit Depail wrote:
> ##### Dom0 with a kernel >= 4.4.2, or a custom 4.4.1 including commit
> d2081cfe624b5decaaf68088ca256ed1b140672c
> 
> On the dom0:
> # dd if=/dev/zero of=/mnt/d-anb-nab2.img bs=4M count=1280
> 1280+0 records in
> 1280+0 records out
> 5368709120 bytes (5.4 GB) copied, 46.3234 s, 116 MB/s
> 
> # dd if=/dev/zero of=/dev/loop1 bs=4M count=1280
> 1280+0 records in
> 1280+0 records out
> 5368709120 bytes (5.4 GB) copied, 44.948 s, 119 MB/s
> 
> On the domU:
> # dd if=/dev/zero of=/dev/xvdb bs=4M count=1280
> 1280+0 records in
> 1280+0 records out
> 5368709120 bytes (5.4 GB) copied, 102.943 s, 52.2 MB/s
> 
> 
> For completeness sake, I'll put my findings below:
> 
> > I used git bisect on the linux-stable source tree to build (a lot of)
> > tests kernels, and was able to find this commit as the first one
> > introducing the regression :
> >
> > d2081cfe624b5decaaf68088ca256ed1b140672c is the first bad commit
> > commit d2081cfe624b5decaaf68088ca256ed1b140672c
> > Author: Keith Busch <keith.busch@intel.com>
> > Date:   Tue Jan 12 15:08:39 2016 -0700
> >
> >     block: split bios to max possible length
> >
> > In term of kernel version, the first one showing bad performances in my
> > case is 4.4.2 (with, obviously, 4.4.1 working as expected).
> >
> > Interestingly, this commit is an improvement of
> > d3805611130af9b911e908af9f67a3f64f4f0914, which is present in 4.4-rc8
> > but do not show any performance issue in our case.
> >
> > I can also confirm that this issue is still present in the latest
> > unstable kernel (we tested 4.13-rc1).

I admit I don't have a good working knowledge of xen block. I've spent a
few minutes looking over the code, and the best I can tell is that this
patch will build requests up to 88 blocks ((11 segments * 4k) / 512)
that would have been fewer blocks without this patch. The resulting bio
vectors may also have offsets that weren't there before.

I'm not sure what the significance is. Perhaps it's causing the number
of grants to exceed BLKIF_MAX_SEGMENTS_PER_REQUEST, which appears to take
a less optimal path in the code, but I'm not sure why that would only
harm writes.

As a test, could you throttle the xvdb queue's max_sectors_kb? If I
followed xen-blkfront correctly, the default should have it set to 44.
Try setting it to 40.

  echo 40 > /sys/block/xvdb/queue/max_sectors_kb
