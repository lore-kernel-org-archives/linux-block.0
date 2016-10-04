Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35981 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbcJDU15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 16:27:57 -0400
Date: Tue, 4 Oct 2016 16:27:54 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Shaohua Li <shli@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
Message-ID: <20161004202754.GJ4205@htj.duckdns.org>
References: <20161004155616.GB4205@htj.duckdns.org>
 <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it>
 <20161004162759.GD4205@htj.duckdns.org>
 <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
 <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
 <20161004191427.GG4205@htj.duckdns.org>
 <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B8B66027-D652-46E2-A0C6-81F227817571@unimore.it>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Paolo.

On Tue, Oct 04, 2016 at 09:29:48PM +0200, Paolo Valente wrote:
> > Hmm... I think we already discussed this but here's a really simple
> > case.  There are three unknown workloads A, B and C and we want to
> > give A certain best-effort guarantees (let's say around 80% of the
> > underlying device) whether A is sharing the device with B or C.
> 
> That's the same example that you proposed me in our previous
> discussion.  For this example I showed you, with many boring numbers,
> that with BFQ you get the most accurate distribution of the resource.

Yes, it is about the same example and what I understood was that
"accurate distribution of the resources" holds as long as the
randomness is incidental (ie. due to layout on the filesystem and so
on) with the slice expiration mechanism offsetting the actually random
workloads.

> If you have enough stamina, I can repeat them again.  To save your

I'll go back to the thread and re-read them.

> patience, here is a very brief summary.  In a concrete use case, the
> unknown workloads turn into something like this: there will be a first
> time interval during which A happens to be, say, sequential, B happens
> to be, say, random and C happens to be, say, quasi-sequential.  Then
> there will be a next time interval during which their characteristics
> change, and so on.  It is easy (but boring, I acknowledge it) to show
> that, for each of these time intervals BFQ provides the best possible
> service in terms of fairness, bandwidth distribution, stability and so
> on.  Why?  Because of the elastic bandwidth-time scheduling of BFQ
> that we already discussed, and because BFQ is naturally accurate in
> redistributing aggregate throughput proportionally, when needed.

Yeah, that's what I remember and for workload above certain level of
randomness its time consumption is mapped to bw, right?

> > I get that bfq can be a good compromise on most desktop workloads and
> > behave reasonably well for some server workloads with the slice
> > expiration mechanism but it really isn't an IO resource partitioning
> > mechanism.
> 
> Right.  My argument is that BFQ enables you to give to each client the
> bandwidth and low-latency guarantees you want.  And this IMO is way
> better than partitioning a resource and then getting unavoidable
> unfairness and high latency.

But that statement only holds while bw is the main thing to guarantee,
no?  The level of isolation that we're looking for here is fairly
strict adherence to sub/few-milliseconds in terms of high percentile
scheduling latency while within the configured bw/iops limits, not
"overall this device is being used pretty well".

Thanks.

-- 
tejun
