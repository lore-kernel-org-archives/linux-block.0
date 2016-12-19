Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58571 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755108AbcLSPdL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2016 10:33:11 -0500
Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <7A8A5078-E9B8-4EBF-BAB1-9E8EEBF3A043@linaro.org>
 <dd9501e9-5fc2-66d3-5c62-f8b727a6b6c9@fb.com>
CC: <linux-block@vger.kernel.org>,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <c8fadbaa-5eda-18d0-ea2a-b13f6cfb034b@fb.com>
Date: Mon, 19 Dec 2016 08:33:01 -0700
MIME-Version: 1.0
In-Reply-To: <dd9501e9-5fc2-66d3-5c62-f8b727a6b6c9@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/19/2016 08:20 AM, Jens Axboe wrote:
> On 12/19/2016 04:32 AM, Paolo Valente wrote:
>>
>>> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha scritto:
>>>
>>> This is version 4 of this patchset, version 3 was posted here:
>>>
>>> https://marc.info/?l=linux-block&m=148178513407631&w=2
>>>
>>> From the discussion last time, I looked into the feasibility of having
>>> two sets of tags for the same request pool, to avoid having to copy
>>> some of the request fields at dispatch and completion time. To do that,
>>> we'd have to replace the driver tag map(s) with our own, and augment
>>> that with tag map(s) on the side representing the device queue depth.
>>> Queuing IO with the scheduler would allocate from the new map, and
>>> dispatching would acquire the "real" tag. We would need to change
>>> drivers to do this, or add an extra indirection table to map a real
>>> tag to the scheduler tag. We would also need a 1:1 mapping between
>>> scheduler and hardware tag pools, or additional info to track it.
>>> Unless someone can convince me otherwise, I think the current approach
>>> is cleaner.
>>>
>>> I wasn't going to post v4 so soon, but I discovered a bug that led
>>> to drastically decreased merging. Especially on rotating storage,
>>> this release should be fast, and on par with the merging that we
>>> get through the legacy schedulers.
>>>
>>
>> I'm to modifying bfq.  You mentioned other missing pieces to come.  Do
>> you already have an idea of what they are, so that I am somehow
>> prepared to what won't work even if my changes are right?
> 
> I'm mostly talking about elevator ops hooks that aren't there in the new
> framework, but exist in the old one. There should be no hidden
> surprises, if that's what you are worried about.
> 
> On the ops side, the only ones I can think of are the activate and
> deactivate, and those can be done in the dispatch_request hook for
> activate, and put/requeue for deactivate.
> 
> Outside of that, some of them have been renamed, and some have been
> collapsed (like activate/deactivate), and yet others again work a little
> differently (like merging). See the mq-deadline conversion, and just
> work through them one at the time.

Some more details...

Outside of the differences outlined above, a major one is that the old
scheduler interfaces invoked almost all of the hooks with the device
queue lock held. That's no longer the case on the new framework, you
have to setup your own lock(s) for what you need. That's a lot saner.
One example is the attempt to merge a bio to an existing request, that
would be the ->bio_merge() hook. If you look at mq-deadline, the hook
merely grabs its per-queue lock (dd->lock) and calls a blk-mq-sched
helper to do the merging. That, in turn, will call ->request_merge(), so
that is called with the lock that ->bio_merge() grabs.

-- 
Jens Axboe


-- 
Jens Axboe

