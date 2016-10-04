Return-Path: <linux-block-owner@vger.kernel.org>
Received: from spostino.sms.unimo.it ([155.185.44.3]:52139 "EHLO
        spostino.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbcJDRoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2016 13:44:00 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
Date: Tue, 4 Oct 2016 19:43:48 +0200
Cc: Tejun Heo <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
References: <cover.1475529372.git.shli@fb.com> <20161004132805.GB28808@redhat.com> <20161004155616.GB4205@htj.duckdns.org> <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it> <20161004162759.GD4205@htj.duckdns.org> <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it> <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
To: Shaohua Li <shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 04 ott 2016, alle ore 19:28, Shaohua Li <shli@fb.com> ha scritto:
> 
> On Tue, Oct 04, 2016 at 07:01:39PM +0200, Paolo Valente wrote:
>> 
>>> Il giorno 04 ott 2016, alle ore 18:27, Tejun Heo <tj@kernel.org> ha scritto:
>>> 
>>> Hello,
>>> 
>>> On Tue, Oct 04, 2016 at 06:22:28PM +0200, Paolo Valente wrote:
>>>> Could you please elaborate more on this point?  BFQ uses sectors
>>>> served to measure service, and, on the all the fast devices on which
>>>> we have tested it, it accurately distributes
>>>> bandwidth as desired, redistributes excess bandwidth with any issue,
>>>> and guarantees high responsiveness and low latency at application and
>>>> system level (e.g., ~0 drop rate in video playback, with any background
>>>> workload tested).
>>> 
>>> The same argument as before.  Bandwidth is a very bad measure of IO
>>> resources spent.  For specific use cases (like desktop or whatever),
>>> this can work but not generally.
>>> 
>> 
>> Actually, we have already discussed this point, and IMHO the arguments
>> that (apparently) convinced you that bandwidth is the most relevant
>> service guarantee for I/O in desktops and the like, prove that
>> bandwidth is the most important service guarantee in servers too.
>> 
>> Again, all the examples I can think of seem to confirm it:
>> . file hosting: a good service must guarantee reasonable read/write,
>> i.e., download/upload, speeds to users
>> . file streaming: a good service must guarantee low drop rates, and
>> this can be guaranteed only by guaranteeing bandwidth and latency
>> . web hosting: high bandwidth and low latency needed here too
>> . clouds: high bw and low latency needed to let, e.g., users of VMs
>> enjoy high responsiveness and, for example, reasonable file-copy
>> time
>> ...
>> 
>> To put in yet another way, with packet I/O in, e.g., clouds, there are
>> basically the same issues, and the main goal is again guaranteeing
>> bandwidth and low latency among nodes.
>> 
>> Could you please provide a concrete server example (assuming we still
>> agree about desktops), where I/O bandwidth does not matter while time
>> does?
> 
> I don't think IO bandwidth does not matter. The problem is bandwidth can't
> measure IO cost. For example, you can't say 8k IO costs 2x IO resource than 4k
> IO.
> 

For what goal do you need to be able to say this, once you succeeded
in guaranteeing bandwidth and low latency to each
process/client/group/node/user?

>>>> Could you please suggest me some test to show how sector-based
>>>> guarantees fails?
>>> 
>>> Well, mix 4k random and sequential workloads and try to distribute the
>>> acteual IO resources.
>>> 
>> 
>> 
>> If I'm not mistaken, we have already gone through this example too,
>> and I thought we agreed on what service scheme worked best, again
>> focusing only on desktops.  To make a long story short(er), here is a
>> snippet from one of our last exchanges.
>> 
>> ----------
>> 
>> On Sat, Apr 16, 2016 at 12:08:44AM +0200, Paolo Valente wrote:
>>> Maybe the source of confusion is the fact that a simple sector-based,
>>> proportional share scheduler always distributes total bandwidth
>>> according to weights. The catch is the additional BFQ rule: random
>>> workloads get only time isolation, and are charged for full budgets,
>>> so as to not affect the schedule of quasi-sequential workloads. So,
>>> the correct claim for BFQ is that it distributes total bandwidth
>>> according to weights (only) when all competing workloads are
>>> quasi-sequential. If some workloads are random, then these workloads
>>> are just time scheduled. This does break proportional-share bandwidth
>>> distribution with mixed workloads, but, much more importantly, saves
>>> both total throughput and individual bandwidths of quasi-sequential
>>> workloads.
>>> 
>>> We could then check whether I did succeed in tuning timeouts and
>>> budgets so as to achieve the best tradeoffs. But this is probably a
>>> second-order problem as of now.
> 
> I don't see why random/sequential matters for SSD. what really matters is
> request size and IO depth. Time scheduling is skeptical too, as workloads can
> dispatch all IO within almost 0 time in high queue depth disks.
> 

That's an orthogonal issue.  If what matter is, e.g., size, then it is
enough to replace "sequential I/O" with "large-request I/O".  In case
I have been too vague, here is an example: I mean that, e.g, in an I/O
scheduler you replace the function that computes whether a queue is
seeky based on request distance, with a function based on
request size.  And this is exactly what has been already done, for
example, in CFQ:

	if (blk_queue_nonrot(cfqd->queue))
		cfqq->seek_history |= (n_sec < CFQQ_SECT_THR_NONROT);
	else
		cfqq->seek_history |= (sdist > CFQQ_SEEK_THR);

Thanks,
Paolo

> Thanks,
> Shaohua


--
Paolo Valente
Algogroup
Dipartimento di Scienze Fisiche, Informatiche e Matematiche
Via Campi 213/B
41125 Modena - Italy
http://algogroup.unimore.it/people/paolo/





