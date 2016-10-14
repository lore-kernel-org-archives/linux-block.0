Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp26.sms.unimo.it ([155.185.44.26]:47308 "EHLO
        smtp26.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbcJNRNw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Oct 2016 13:13:52 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <20161014164036.GA6320@mtj.duckdns.org>
Date: Fri, 14 Oct 2016 19:13:41 +0200
Cc: Kyle Sanderson <kyle.leet@gmail.com>, jmoyer@redhat.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-block@vger.kernel.org,
        Shaohua Li <shli@fb.com>, Jens Axboe <axboe@fb.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>, Kernel-team@fb.com,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <6B4FE5ED-75BD-4AD8-B0FA-B452FB631BE8@unimore.it>
References: <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it> <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com> <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it> <20161004185413.GF4205@htj.duckdns.org> <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it> <20161004191427.GG4205@htj.duckdns.org> <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it> <20161004202754.GJ4205@htj.duckdns.org> <CACsaVZ+AqSXHTRdpdrQQp6PuynEPeB-5YOyweWsenjvuKsD12w@mail.gmail.com> <CACsaVZ+azEP+fH5Dg-8soH8QjWBRnL-2B4Uuj4YF2hUnoyvzgA@mail.gmail.com> <20161014164036.GA6320@mtj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 14 ott 2016, alle ore 18:40, Tejun Heo <tj@kernel.org> ha scritto:
> 
> Hello, Kyle.
> 
> On Sat, Oct 08, 2016 at 06:15:14PM -0700, Kyle Sanderson wrote:
>> How is this even a discussion when hard numbers, and trying any
>> reproduction case easily reproduce the issues that CFQ causes. Reading
>> this thread, and many others only grows not only my disappointment,
>> but whenever someone launches kterm or scrot and their machine
>> freezes, leaves a selective few individuals completely responsible for
>> this. Help those users, help yourself, help Linux.
> 
> So, just to be clear.  I wasn't arguing against bfq replacing cfq (or
> anything along that line) but that proportional control, as
> implemented, would be too costly for many use cases and thus we need
> something along the line of what Shaohua is proposing.
> 

Sorry for dropping in all the times, but the vision that you and some
other guys propose seems to miss some important piece (unless, now or
then, you will patiently prove me wrong, or I will finally understand
on my own why I'm wrong).

You are of course right: bfq, as a component of blk, and above all, as
a sort of derivative of CFQ (and of its overhead), has currently too
high a overhead to handle more than 10-20K IOPS.

That said, your 'thus' seems a little too strong: "bfq does not yet
handle fast SSDs, thus we need something else".  What about the
millions of devices (and people) still within 10-20 K IOPS, and
experiencing awful latencies and lack of bandwidth guarantees?

For certain systems or applications, it isn't even just a "buy a fast
SSD" matter, but a technological constraint.

> FWIW, it looks like the only way we can implement proportional control
> on highspeed ssds with acceptable overhead

Maybe not: as I wrote to Viveck in a previous reply, containing
pointers to documentation, we have already achieved twenty millions
of decisions per second with a prototype driving existing
proportional-share packet schedulers (essentially without
modifications).

> is somehow finding a way to
> calculate the cost of each IO and throttle IOs according to that while
> controlling for latency as necessary.  Slice scheduling with idling
> seems too expensive with highspeed devices with high io depth.
> 

Yes, that's absolutely true.  I'm already thinking about an idleless
solution.  As I already wrote, I'm willing to help with scheduling in
blk-mq.  I hope there will be the opportunity to find some way to go
at KS.

Thanks,
Paolo

> Thanks.
> 
> -- 
> tejun


--
Paolo Valente
Algogroup
Dipartimento di Scienze Fisiche, Informatiche e Matematiche
Via Campi 213/B
41125 Modena - Italy
http://algogroup.unimore.it/people/paolo/





