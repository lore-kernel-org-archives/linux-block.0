Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp1.sms.unimo.it ([155.185.44.147]:33746 "EHLO
        smtp1.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754587AbcJFPFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 11:05:51 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <05107cf1-3010-9361-c006-f05a16529774@gmail.com>
Date: Thu, 6 Oct 2016 17:05:36 +0200
Cc: Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Message-Id: <60D2D707-4266-4600-BBD9-D67B61BF5EF4@unimore.it>
References: <20161004155616.GB4205@htj.duckdns.org> <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it> <20161004162759.GD4205@htj.duckdns.org> <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it> <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com> <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it> <20161004185413.GF4205@htj.duckdns.org> <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it> <20161004191427.GG4205@htj.duckdns.org> <CACRpkdavM0ZGdDjXAsEG1MMy4WuAnudNw9KL8eFJFsfm_ptEBg@mail.gmail.com> <20161006110342.gyyiwaqw4ivzdaww@sirena.org.uk> <439e8a13-cb14-c955-ae98-30ed5490739b@gmail.com> <0BBC988E-9331-4565-B4EA-BDCAE2D1E134@unimore.it> <05107cf1-3010-9361-c006-f05a16529774@gmail.com>
To: "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 06 ott 2016, alle ore 15:52, Austin S. Hemmelgarn <ahferroin7@gmail.com> ha scritto:
> 
> On 2016-10-06 08:50, Paolo Valente wrote:
>> 
>>> Il giorno 06 ott 2016, alle ore 13:57, Austin S. Hemmelgarn <ahferroin7@gmail.com> ha scritto:
>>> 
>>> On 2016-10-06 07:03, Mark Brown wrote:
>>>> On Thu, Oct 06, 2016 at 10:04:41AM +0200, Linus Walleij wrote:
>>>>> On Tue, Oct 4, 2016 at 9:14 PM, Tejun Heo <tj@kernel.org> wrote:
>>>> 
>>>>>> I get that bfq can be a good compromise on most desktop workloads and
>>>>>> behave reasonably well for some server workloads with the slice
>>>>>> expiration mechanism but it really isn't an IO resource partitioning
>>>>>> mechanism.
>>>> 
>>>>> Not just desktops, also Android phones.
>>>> 
>>>>> So why not have BFQ as a separate scheduling policy upstream,
>>>>> alongside CFQ, deadline and noop?
>>>> 
>>>> Right.
>>>> 
>>>>> We're already doing the per-usecase Kconfig thing for preemption.
>>>>> But maybe somebody already hates that and want to get rid of it,
>>>>> I don't know.
>>>> 
>>>> Hannes also suggested going back to making BFQ a separate scheduler
>>>> rather than replacing CFQ earlier, pointing out that it mitigates
>>>> against the risks of changing CFQ substantially at this point (which
>>>> seems to be the biggest issue here).
>>>> 
>>> ISTR that the original argument for this approach essentially amounted to: 'If it's so much better, why do we need both?'.
>>> 
>>> Such an argument is valid only if the new design is better in all respects (which there isn't sufficient information to decide in this case), or the negative aspects are worth the improvements (which is too workload specific to decide for something like this).
>> 
>> All correct, apart from the workload-specific issue, which is not very clear to me. Over the last five years I have not found a single workload for which CFQ is better than BFQ, and none has been suggested.
> My point is that whether or not BFQ is better depends on the workload. You can't test for every workload, so you can't say definitively that BFQ is better for every workload.

Yes

>  At a minimum, there are workloads where the deadline and noop schedulers are better, but they're very domain specific workloads.

Definitely

>  Based on the numbers from Shaohua, it looks like CFQ has better throughput than BFQ, and that will affect some workloads (for most, the improved fairness is worth the reduced throughput, but there probably are some cases where it isn't).

Well, no fairness as deadline and noop, but with much less throughput
than deadline and noop, doesn't sound much like the best scheduler for
those workloads.  With BFQ you have service guarantees, with noop or
deadline you have maximum throughput.

>> 
>> Anyway, leaving aside this fact, IMO the real problem here is that we are in a catch-22: "we want BFQ to replace CFQ, but, since CFQ is legacy code, then you cannot change, and thus replace, CFQ"
> I agree that that's part of the issue, but I also don't entirely agree with the reasoning on it.  Until blk-mq has proper I/O scheduling, people will continue to use CFQ, and based on the way things are going, it will be multiple months before that happens, whereas BFQ exists and is working now.

Exactly!

Thanks,
Paolo

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





