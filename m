Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp26.sms.unimo.it ([155.185.44.26]:51533 "EHLO
        smtp26.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbcJPTCt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2016 15:02:49 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <20161014183517.GB6320@mtj.duckdns.org>
Date: Sun, 16 Oct 2016 21:02:39 +0200
Cc: Kyle Sanderson <kyle.leet@gmail.com>, jmoyer@redhat.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-block@vger.kernel.org,
        Shaohua Li <shli@fb.com>, Jens Axboe <axboe@fb.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>, Kernel-team@fb.com,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <7980A2DC-3701-4A3D-9253-2E047A0144AE@unimore.it>
References: <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it> <20161004185413.GF4205@htj.duckdns.org> <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it> <20161004191427.GG4205@htj.duckdns.org> <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it> <20161004202754.GJ4205@htj.duckdns.org> <CACsaVZ+AqSXHTRdpdrQQp6PuynEPeB-5YOyweWsenjvuKsD12w@mail.gmail.com> <CACsaVZ+azEP+fH5Dg-8soH8QjWBRnL-2B4Uuj4YF2hUnoyvzgA@mail.gmail.com> <20161014164036.GA6320@mtj.duckdns.org> <6B4FE5ED-75BD-4AD8-B0FA-B452FB631BE8@unimore.it> <20161014183517.GB6320@mtj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 14 ott 2016, alle ore 20:35, Tejun Heo <tj@kernel.org> ha scritto:
> 
> Hello, Paolo.
> 
> On Fri, Oct 14, 2016 at 07:13:41PM +0200, Paolo Valente wrote:
>> That said, your 'thus' seems a little too strong: "bfq does not yet
>> handle fast SSDs, thus we need something else".  What about the
>> millions of devices (and people) still within 10-20 K IOPS, and
>> experiencing awful latencies and lack of bandwidth guarantees?
> 
> I'm not objecting to any of that.

Ok, sorry for misunderstanding.  I'm just more and more confused about
why a readily available, and not proven wrong solution has not yet
been accepted, if everybody apparently acknowledges the problem.

>  My point just is that bfq, at least
> as currently implemented, is unfit for certain classes of use cases.
> 

Absolutely correct.

>>> FWIW, it looks like the only way we can implement proportional control
>>> on highspeed ssds with acceptable overhead
>> 
>> Maybe not: as I wrote to Viveck in a previous reply, containing
>> pointers to documentation, we have already achieved twenty millions
>> of decisions per second with a prototype driving existing
>> proportional-share packet schedulers (essentially without
>> modifications).
> 
> And that doesn't require idling and thus doesn't severely impact
> utilization?
> 

Nope.  Packets are commonly assumed to be sent asynchronously.
I guess that discussing the validity of this assumption is out of the
scope of this thread.

Thanks,
Paolo

>>> is somehow finding a way to
>>> calculate the cost of each IO and throttle IOs according to that while
>>> controlling for latency as necessary.  Slice scheduling with idling
>>> seems too expensive with highspeed devices with high io depth.
>> 
>> Yes, that's absolutely true.  I'm already thinking about an idleless
>> solution.  As I already wrote, I'm willing to help with scheduling in
>> blk-mq.  I hope there will be the opportunity to find some way to go
>> at KS.
> 
> It'd be great to have a proportional control mechanism whose overhead
> is acceptable.  Unfortunately, we don't have one now and nothing seems
> right around the corner.  (Mostly) work-conserving throttling would be
> fiddlier to use but is something which is useful regardless of such
> proportional control mechanism and can be obtained relatively easily.
> 
> I don't see why the two approaches would be mutually exclusive.
> 
> Thanks.
> 
> -- 
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
Paolo Valente
Algogroup
Dipartimento di Scienze Fisiche, Informatiche e Matematiche
Via Campi 213/B
41125 Modena - Italy
http://algogroup.unimore.it/people/paolo/





