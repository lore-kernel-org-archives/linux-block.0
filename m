Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33547 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755733AbcJFL5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2016 07:57:47 -0400
Subject: Re: [PATCH V3 00/11] block-throttle: add .high limit
To: Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20161004155616.GB4205@htj.duckdns.org>
 <A5525664-DF90-4604-B64A-E793BBC0CB6A@unimore.it>
 <20161004162759.GD4205@htj.duckdns.org>
 <278BCC7B-ED58-4FDF-9243-FAFC3F862E4D@unimore.it>
 <20161004172852.GB73678@anikkar-mbp.local.dhcp.thefacebook.com>
 <EE90477C-FD56-48C1-8A45-97AF39A8BB0C@unimore.it>
 <20161004185413.GF4205@htj.duckdns.org>
 <F9A2F063-F5A2-49A6-8DFE-91ACDE380645@unimore.it>
 <20161004191427.GG4205@htj.duckdns.org>
 <CACRpkdavM0ZGdDjXAsEG1MMy4WuAnudNw9KL8eFJFsfm_ptEBg@mail.gmail.com>
 <20161006110342.gyyiwaqw4ivzdaww@sirena.org.uk>
Cc: Tejun Heo <tj@kernel.org>,
        Paolo Valente <paolo.valente@unimore.it>,
        Shaohua Li <shli@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Kernel-team@fb.com,
        jmoyer@redhat.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Hannes Reinecke <hare@suse.com>
From: "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <439e8a13-cb14-c955-ae98-30ed5490739b@gmail.com>
Date: Thu, 6 Oct 2016 07:57:37 -0400
MIME-Version: 1.0
In-Reply-To: <20161006110342.gyyiwaqw4ivzdaww@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2016-10-06 07:03, Mark Brown wrote:
> On Thu, Oct 06, 2016 at 10:04:41AM +0200, Linus Walleij wrote:
>> On Tue, Oct 4, 2016 at 9:14 PM, Tejun Heo <tj@kernel.org> wrote:
>
>>> I get that bfq can be a good compromise on most desktop workloads and
>>> behave reasonably well for some server workloads with the slice
>>> expiration mechanism but it really isn't an IO resource partitioning
>>> mechanism.
>
>> Not just desktops, also Android phones.
>
>> So why not have BFQ as a separate scheduling policy upstream,
>> alongside CFQ, deadline and noop?
>
> Right.
>
>> We're already doing the per-usecase Kconfig thing for preemption.
>> But maybe somebody already hates that and want to get rid of it,
>> I don't know.
>
> Hannes also suggested going back to making BFQ a separate scheduler
> rather than replacing CFQ earlier, pointing out that it mitigates
> against the risks of changing CFQ substantially at this point (which
> seems to be the biggest issue here).
>
ISTR that the original argument for this approach essentially amounted 
to: 'If it's so much better, why do we need both?'.

Such an argument is valid only if the new design is better in all 
respects (which there isn't sufficient information to decide in this 
case), or the negative aspects are worth the improvements (which is too 
workload specific to decide for something like this).
