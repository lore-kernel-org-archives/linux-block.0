Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34738 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcJIBQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Oct 2016 21:16:03 -0400
MIME-Version: 1.0
In-Reply-To: <CACsaVZ+AqSXHTRdpdrQQp6PuynEPeB-5YOyweWsenjvuKsD12w@mail.gmail.com>
References: <20161004155616.GB4205@htj.duckdns.org> <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it>
 <20161004162759.GD4205@htj.duckdns.org> <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it> <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it> <20161004191427.GG4205@htj.duckdns.org>
 <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it> <20161004202754.GJ4205@htj.duckdns.org>
 <CACsaVZ+AqSXHTRdpdrQQp6PuynEPeB-5YOyweWsenjvuKsD12w@mail.gmail.com>
From: Kyle Sanderson <kyle.leet@gmail.com>
Date: Sat, 8 Oct 2016 18:15:14 -0700
Message-ID: <CACsaVZ+azEP+fH5Dg-8soH8QjWBRnL-2B4Uuj4YF2hUnoyvzgA@mail.gmail.com>
Subject: Fwd: [PATCH V3 00/11] block-throttle: add .high limit
To: Tejun Heo <tj@kernel.org>
Cc: jmoyer@redhat.com, Paolo Valente <paolo.valente@unimore.it>,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-block@vger.kernel.org,
        Shaohua Li <shli@fb.com>, Jens Axboe <axboe@fb.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>, Kernel-team@fb.com,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Re-sending as plain-text as the Gmail Android App is still
historically broken...

---------- Forwarded message ----------
From: Kyle Sanderson <kyle.leet@gmail.com>
Date: Wed, Oct 5, 2016 at 7:09 AM
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
To: Tejun Heo <tj@kernel.org>
Cc: jmoyer@redhat.com, Paolo Valente <paolo.valente@unimore.it>,
linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
linux-block@vger.kernel.org, Shaohua Li <shli@fb.com>, Jens Axboe
<axboe@fb.com>, Linus Walleij <linus.walleij@linaro.org>, Vivek Goyal
<vgoyal@redhat.com>, Kernel-team@fb.com, Ulf Hansson
<ulf.hansson@linaro.org>


Obviously not to compound against this, however it has been proven for
years that CFQ will lock significantly under contention, and other
schedulers, such as BFQ attempt to provide fairness which is
absolutely the desired  outcome from using a machine. The networking
space is a little wrecked in the sense there's a plethora of qdiscs
that don't necessarily need to exist; but are legacy. This limitation
does not exist in this realm as there are no specific tunables.

There is no reason that in 2016 a user-space application can steal all
of the I/O from a disk, completely locking the machine when BFQ has
essentially solved this years ago. I've been a moderately happy user
of BFQ for quite sometime now. There aren't tens, or hundreds of us,
but thousands through the custom kernels that are spun, and the
distros that helped support BFQ.

How is this even a discussion when hard numbers, and trying any
reproduction case easily reproduce the issues that CFQ causes. Reading
this thread, and many others only grows not only my disappointment,
but whenever someone launches kterm or scrot and their machine
freezes, leaves a selective few individuals completely responsible for
this. Help those users, help yourself, help Linux.


On 4 Oct 2016 1:29 pm, "Tejun Heo" <tj@kernel.org> wrote:
>
> Hello, Paolo.
>
> On Tue, Oct 04, 2016 at 09:29:48PM +0200, Paolo Valente wrote:
> > > Hmm... I think we already discussed this but here's a really simple
> > > case.  There are three unknown workloads A, B and C and we want to
> > > give A certain best-effort guarantees (let's say around 80% of the
> > > underlying device) whether A is sharing the device with B or C.
> >
> > That's the same example that you proposed me in our previous
> > discussion.  For this example I showed you, with many boring numbers,
> > that with BFQ you get the most accurate distribution of the resource.
>
> Yes, it is about the same example and what I understood was that
> "accurate distribution of the resources" holds as long as the
> randomness is incidental (ie. due to layout on the filesystem and so
> on) with the slice expiration mechanism offsetting the actually random
> workloads.
>
> > If you have enough stamina, I can repeat them again.  To save your
>
> I'll go back to the thread and re-read them.
>
> > patience, here is a very brief summary.  In a concrete use case, the
> > unknown workloads turn into something like this: there will be a first
> > time interval during which A happens to be, say, sequential, B happens
> > to be, say, random and C happens to be, say, quasi-sequential.  Then
> > there will be a next time interval during which their characteristics
> > change, and so on.  It is easy (but boring, I acknowledge it) to show
> > that, for each of these time intervals BFQ provides the best possible
> > service in terms of fairness, bandwidth distribution, stability and so
> > on.  Why?  Because of the elastic bandwidth-time scheduling of BFQ
> > that we already discussed, and because BFQ is naturally accurate in
> > redistributing aggregate throughput proportionally, when needed.
>
> Yeah, that's what I remember and for workload above certain level of
> randomness its time consumption is mapped to bw, right?
>
> > > I get that bfq can be a good compromise on most desktop workloads and
> > > behave reasonably well for some server workloads with the slice
> > > expiration mechanism but it really isn't an IO resource partitioning
> > > mechanism.
> >
> > Right.  My argument is that BFQ enables you to give to each client the
> > bandwidth and low-latency guarantees you want.  And this IMO is way
> > better than partitioning a resource and then getting unavoidable
> > unfairness and high latency.
>
> But that statement only holds while bw is the main thing to guarantee,
> no?  The level of isolation that we're looking for here is fairly
> strict adherence to sub/few-milliseconds in terms of high percentile
> scheduling latency while within the configured bw/iops limits, not
> "overall this device is being used pretty well".
>
> Thanks.
>
> --
> tejun
