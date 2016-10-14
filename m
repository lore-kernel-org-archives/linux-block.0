Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33897 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbcJNSfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Oct 2016 14:35:20 -0400
Date: Fri, 14 Oct 2016 14:35:17 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Kyle Sanderson <kyle.leet@gmail.com>, jmoyer@redhat.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-block@vger.kernel.org,
        Shaohua Li <shli@fb.com>, Jens Axboe <axboe@fb.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>, Kernel-team@fb.com,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161014183517.GB6320@mtj.duckdns.org>
References: <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
 <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
 <20161004191427.GG4205@htj.duckdns.org>
 <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it>
 <20161004202754.GJ4205@htj.duckdns.org>
 <CACsaVZ+AqSXHTRdpdrQQp6PuynEPeB-5YOyweWsenjvuKsD12w@mail.gmail.com>
 <CACsaVZ+azEP+fH5Dg-8soH8QjWBRnL-2B4Uuj4YF2hUnoyvzgA@mail.gmail.com>
 <20161014164036.GA6320@mtj.duckdns.org>
 <6B4FE5ED-75BD-4AD8-B0FA-B452FB631BE8@unimore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6B4FE5ED-75BD-4AD8-B0FA-B452FB631BE8@unimore.it>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Paolo.

On Fri, Oct 14, 2016 at 07:13:41PM +0200, Paolo Valente wrote:
> That said, your 'thus' seems a little too strong: "bfq does not yet
> handle fast SSDs, thus we need something else".  What about the
> millions of devices (and people) still within 10-20 K IOPS, and
> experiencing awful latencies and lack of bandwidth guarantees?

I'm not objecting to any of that.  My point just is that bfq, at least
as currently implemented, is unfit for certain classes of use cases.

> > FWIW, it looks like the only way we can implement proportional control
> > on highspeed ssds with acceptable overhead
> 
> Maybe not: as I wrote to Viveck in a previous reply, containing
> pointers to documentation, we have already achieved twenty millions
> of decisions per second with a prototype driving existing
> proportional-share packet schedulers (essentially without
> modifications).

And that doesn't require idling and thus doesn't severely impact
utilization?

> > is somehow finding a way to
> > calculate the cost of each IO and throttle IOs according to that while
> > controlling for latency as necessary.  Slice scheduling with idling
> > seems too expensive with highspeed devices with high io depth.
> 
> Yes, that's absolutely true.  I'm already thinking about an idleless
> solution.  As I already wrote, I'm willing to help with scheduling in
> blk-mq.  I hope there will be the opportunity to find some way to go
> at KS.

It'd be great to have a proportional control mechanism whose overhead
is acceptable.  Unfortunately, we don't have one now and nothing seems
right around the corner.  (Mostly) work-conserving throttling would be
fiddlier to use but is something which is useful regardless of such
proportional control mechanism and can be obtained relatively easily.

I don't see why the two approaches would be mutually exclusive.

Thanks.

-- 
tejun
