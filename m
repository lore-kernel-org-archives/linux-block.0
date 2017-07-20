Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:51612 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933965AbdGTIxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2017 04:53:07 -0400
Date: Thu, 20 Jul 2017 09:52:56 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Benoit Depail <benoit.depail@nbs-system.com>
CC: <xen-users@lists.xen.org>, WebDawg <webdawg@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        <linux-block@vger.kernel.org>
Subject: Re: [Xen-users] File-based domU - Slow storage write since xen 4.8
Message-ID: <20170720085256.e3m35aalg6jn7qrh@dhcp-3-128.uk.xensource.com>
References: <5554bd39-6e0a-5c17-2b64-bb80d4a6502b@nbs-system.com>
 <CAKdd5H9f_=NCYMmhLcvHKFw7m_sKvygSVqz3+Z0YPAGiPMxKxQ@mail.gmail.com>
 <5b562ef2-36e2-a08e-1683-6ffc7cfa54de@nbs-system.com>
 <20170717124931.rsiqxkzzkmvfofd7@MacBook-Pro-de-Roger.local>
 <5dd18982-cbcf-a675-1e07-5b4c4e4da50e@nbs-system.com>
 <20170717164658.drliebetcnil3wjb@dhcp-3-128.uk.xensource.com>
 <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <bba4e389-b975-fbb8-b680-c9c4039617ca@nbs-system.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I'm afraid I'm also not that knowledgeable, so I'm adding the author
and the Linux block ml.

On Wed, Jul 19, 2017 at 04:25:02PM +0200, Benoit Depail wrote:
> Hello,
> 
> On 07/17/17 18:46, Roger Pau Monn� wrote:
> > There are not a huge amount of changes to blkback, so it would be
> > helpful if you could pinpoint the change that introduced this
> > regression for you, or if you can get a kernel version that introduced
> > the regression that would also be helpful.
> 
> I used git bisect on the linux-stable source tree to build (a lot of)
> tests kernels, and was able to find this commit as the first one
> introducing the regression :
> 
> d2081cfe624b5decaaf68088ca256ed1b140672c is the first bad commit
> commit d2081cfe624b5decaaf68088ca256ed1b140672c
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Tue Jan 12 15:08:39 2016 -0700
> 
>     block: split bios to max possible length
> 
> In term of kernel version, the first one showing bad performances in my
> case is 4.4.2 (with, obviously, 4.4.1 working as expected).
> 
> Interestingly, this commit is an improvement of
> d3805611130af9b911e908af9f67a3f64f4f0914, which is present in 4.4-rc8
> but do not show any performance issue in our case.
> 
> I can also confirm that this issue is still present in the latest
> unstable kernel (we tested 4.13-rc1).
> 
> I think I have reached a point where more competent people should
> investigate, but I'll be glad to help if needed.

For the sake of the people that I've added, would you mind describing
the issues you are seeing and the tests that you performed?

Thanks, Roger.
