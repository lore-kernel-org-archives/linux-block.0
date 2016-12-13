Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49639 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932771AbcLMQ2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 11:28:16 -0500
Subject: Re: [PATCHSET/RFC v2] blk-mq scheduling framework
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <9D1F7CB5-4043-448B-A553-D6A9804D5089@linaro.org>
 <20161213151739.GA32618@kernel.dk>
 <DB8071E8-E3C2-4DA1-9716-987D84C078C3@linaro.org>
CC: <linux-block@vger.kernel.org>,
        Linux-Kernal <linux-kernel@vger.kernel.org>, <osandov@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <a4a9d8fb-9239-da76-946c-4361785889ad@fb.com>
Date: Tue, 13 Dec 2016 09:28:02 -0700
MIME-Version: 1.0
In-Reply-To: <DB8071E8-E3C2-4DA1-9716-987D84C078C3@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/13/2016 09:15 AM, Paolo Valente wrote:
> 
>> Il giorno 13 dic 2016, alle ore 16:17, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> On Tue, Dec 13 2016, Paolo Valente wrote:
>>>
>>>> Il giorno 08 dic 2016, alle ore 21:13, Jens Axboe <axboe@fb.com> ha scritto:
>>>>
>>>> As a followup to this posting from yesterday:
>>>>
>>>> https://marc.info/?l=linux-block&m=148115232806065&w=2
>>>>
>>>> this is version 2. I wanted to post a new one fairly quickly, as there
>>>> ended up being a number of potential crashes in v1. This one should be
>>>> solid, I've run mq-deadline on both NVMe and regular rotating storage,
>>>> and we handle the various merging cases correctly.
>>>>
>>>> You can download it from git as well:
>>>>
>>>> git://git.kernel.dk/linux-block blk-mq-sched.2
>>>>
>>>> Note that this is based on for-4.10/block, which is in turn based on
>>>> v4.9-rc1. I suggest pulling it into my for-next branch, which would
>>>> then merge nicely with 'master' as well.
>>>>
>>>
>>> Hi Jens,
>>> this is just to tell you that I have finished running some extensive
>>> tests on this patch series (throughput, responsiveness, low latency
>>> for soft real time).  No regression w.r.t. blk detected, and no
>>> crashes or other anomalies.
>>>
>>> Starting to work on BFQ port.  Please be patient with my little
>>> expertise on mq environment, and with my next silly questions!
>>
>> No worries, ask away if you have questions. As you might have seen, it's
>> still a little bit of a moving target, but it's getting closer every
>> day. I'll post a v3 later today hopefully that will be a good fix point
>> for you. I'll need to add the io context setup etc, that's not there
>> yet, as only cfq/bfq uses that.
>>
> 
> You anticipated the question that was worrying me more, how to handle
> iocontexts :) I'll go on studying your patches while waiting for this
> (last, right?) missing piece for bfq.

It's the last missing larger piece. We probably have a few hooks that
BFQ/CFQ currently uses that aren't wired up yet in the elevator_ops for
mq, so you'll probably have to do those as you go. I can take a look,
but I would prefer if they be done one a as-needed basis. Perhaps we can
get rid of some of them.

> Should you implement a modified version of cfq, to test your last
> extensions, I would of course appreciate very much to have a look at
> it (if you are willing to share it, of course).

I most likely won't do that, as it would be a waste of time on my end.
If you need help with the BFQ parts, I'll help you out.

-- 
Jens Axboe

