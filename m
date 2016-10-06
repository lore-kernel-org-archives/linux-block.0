Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp26.sms.unimo.it ([155.185.44.26]:41943 "EHLO
        smtp26.sms.unimo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754307AbcJFMuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 08:50:24 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
From: Paolo Valente <paolo.valente@unimore.it>
In-Reply-To: <439e8a13-cb14-c955-ae98-30ed5490739b@gmail.com>
Date: Thu, 6 Oct 2016 14:50:11 +0200
Cc: Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Hannes Reinecke <hare@suse.com>
Message-Id: <0BBC988E-9331-4565-B4EA-BDCAE2D1E134@unimore.it>
References: <20161004155616.GB4205@htj.duckdns.org> <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it> <20161004162759.GD4205@htj.duckdns.org> <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it> <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com> <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it> <20161004185413.GF4205@htj.duckdns.org> <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it> <20161004191427.GG4205@htj.duckdns.org> <CACRpkdavM0ZGdDjXAsEG1MMy4WuAnudNw9KL8eFJFsfm_ptEBg@mail.gmail.com> <20161006110342.gyyiwaqw4ivzdaww@sirena.org.uk> <439e8a13-cb14-c955-ae98-30ed5490739b@gmail.com>
To: "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 06 ott 2016, alle ore 13:57, Austin S. Hemmelgarn <ahferroin7@gmail.com> ha scritto:
> 
> On 2016-10-06 07:03, Mark Brown wrote:
>> On Thu, Oct 06, 2016 at 10:04:41AM +0200, Linus Walleij wrote:
>>> On Tue, Oct 4, 2016 at 9:14 PM, Tejun Heo <tj@kernel.org> wrote:
>> 
>>>> I get that bfq can be a good compromise on most desktop workloads and
>>>> behave reasonably well for some server workloads with the slice
>>>> expiration mechanism but it really isn't an IO resource partitioning
>>>> mechanism.
>> 
>>> Not just desktops, also Android phones.
>> 
>>> So why not have BFQ as a separate scheduling policy upstream,
>>> alongside CFQ, deadline and noop?
>> 
>> Right.
>> 
>>> We're already doing the per-usecase Kconfig thing for preemption.
>>> But maybe somebody already hates that and want to get rid of it,
>>> I don't know.
>> 
>> Hannes also suggested going back to making BFQ a separate scheduler
>> rather than replacing CFQ earlier, pointing out that it mitigates
>> against the risks of changing CFQ substantially at this point (which
>> seems to be the biggest issue here).
>> 
> ISTR that the original argument for this approach essentially amounted to: 'If it's so much better, why do we need both?'.
> 
> Such an argument is valid only if the new design is better in all respects (which there isn't sufficient information to decide in this case), or the negative aspects are worth the improvements (which is too workload specific to decide for something like this).

All correct, apart from the workload-specific issue, which is not very clear to me. Over the last five years I have not found a single workload for which CFQ is better than BFQ, and none has been suggested.

Anyway, leaving aside this fact, IMO the real problem here is that we are in a catch-22: "we want BFQ to replace CFQ, but, since CFQ is legacy code, then you cannot change, and thus replace, CFQ"

Thanks,
Paolo

--
Paolo Valente
Algogroup
Dipartimento di Scienze Fisiche, Informatiche e Matematiche
Via Campi 213/B
41125 Modena - Italy
http://algogroup.unimore.it/people/paolo/





