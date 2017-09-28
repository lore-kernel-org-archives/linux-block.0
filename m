Return-Path: <jiangqi903@gmail.com>
Return-Path: <jiangqi903@gmail.com>
Subject: Re: [PATCH] blk-throttle: fix possible io stall when doing upgrade
To: Shaohua Li <shli@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>, boyu.mt@taobao.com, wenqing.lz@taobao.com,
 qijiang.qj@alibaba-inc.com
References: <5b918e35-7072-ba9a-92cc-726d02777b4f@gmail.com>
 <20170925172228.n2soitn5vj53ln36@kernel.org>
 <5216fe6f-deb2-8db3-a241-46f95c999a7e@gmail.com>
 <20170926024820.2kxmluua6abvno4j@kernel.org>
 <4881c35d-6dde-ba81-2771-798d5701c245@gmail.com>
 <20170927213819.cnunjtmndq4nk5hv@kernel.org>
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <e0efa2c6-10d1-e239-ec1a-a64320fa3a5e@gmail.com>
Date: Thu, 28 Sep 2017 11:48:20 +0800
MIME-Version: 1.0
In-Reply-To: <20170927213819.cnunjtmndq4nk5hv@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Shahua,

On 17/9/28 05:38, Shaohua Li wrote:
> On Tue, Sep 26, 2017 at 11:16:05AM +0800, Joseph Qi wrote:
>>
>>
>> On 17/9/26 10:48, Shaohua Li wrote:
>>> On Tue, Sep 26, 2017 at 09:06:57AM +0800, Joseph Qi wrote:
>>>> Hi Shaohua,
>>>>
>>>> On 17/9/26 01:22, Shaohua Li wrote:
>>>>> On Mon, Sep 25, 2017 at 06:46:42PM +0800, Joseph Qi wrote:
>>>>>> From: Joseph Qi <qijiang.qj@alibaba-inc.com>
>>>>>>
>>>>>> Currently it will try to dispatch bio in throtl_upgrade_state. This may
>>>>>> lead to io stall in the following case.
>>>>>> Say the hierarchy is like:
>>>>>> /-test1
>>>>>>   |-subtest1
>>>>>> and subtest1 has 32 queued bios now.
>>>>>>
>>>>>> throtl_pending_timer_fn            throtl_upgrade_state
>>>>>> ------------------------------------------------------------------------
>>>>>>                                    upgrade to max
>>>>>>                                    throtl_select_dispatch
>>>>>>                                    throtl_schedule_next_dispatch
>>>>>> throtl_select_dispatch
>>>>>> throtl_schedule_next_dispatch
>>>>>>
>>>>>> Since throtl_select_dispatch will move queued bios from subtest1 to
>>>>>> test1 in throtl_upgrade_state, it will then just do nothing in
>>>>>> throtl_pending_timer_fn. As a result, queued bios won't be dispatched
>>>>>> any more if no proper timer scheduled.
>>>>>
>>>>> Sorry, didn't get it. If throtl_pending_timer_fn does nothing (because
>>>>> throtl_upgrade_state already moves bios to parent), there is no pending
>>>>> blkcg/bio, not rearming the timer wouldn't lose anything. Am I missing
>>>>> anything? could you please describe the failure in details?
>>>>>
>>>>> Thanks,
>>>>> Shaohua
>>>>> In normal case, throtl_pending_timer_fn tries to move bios from
>>>> subtest1 to test1, and finally do the real issueing work when reach
>>>> the top-level.
>>>> But int the case above, throtl_select_dispatch in
>>>> throtl_pending_timer_fn returns 0, because the work is done by
>>>> throtl_upgrade_state. Then throtl_pending_timer_fn *thinks* there is
>>>> nothing to do, but the queued bios are still in service queue of
>>>> test1.
>>>
>>> Still didn't get, sorry. If there are pending bios in test1, why
>>> throtl_schedule_next_dispatch in throtl_pending_timer_fn doesn't setup the
>>> timer?
>>>
>>
>> throtl_schedule_next_dispatch doesn't setup timer because there is no
>> pending children left, all the queued bios are moved to parent test1
>> now. IMO, this is used in case that it cannot dispatch all queued bios
>> in one round.
>> And if the select dispatch is done by timer, it will then do propagate
>> dispatch in parent till reach the top-level.
>> But in the case above, it breaks this logic.
>> Please point out if I am understanding wrong.
> 
> I read your reply again. So if the bios are move to test1, why don't we
> dispatch bios of test1? throtl_upgrade_state does a post-order traversal, so it
> handles subtest1 and then test1. Anything I missed? Please describe in details,
> thanks! Did you see a real stall or is this based on code analysis?
> 
> Thanks,
> Shaohua
> 

Sorry for the unclear description and the misunderstanding brought in.
I backported your patches to my kernel 3.10 and did the test. I tested
with libaio and iodepth 32. Most time it worked well, but occasionally
it would stall io, and the blktrace showed the following:

252,0   26        0    19.884802028     0  m   N throtl upgrade to max
252,0   13        0    19.884820336     0  m   N throtl /test1 dispatch nr_queued=32 read=0 write=32

>From my analysis, it was because upgrade had moved the queued bios from
subtest1 to test1, but not continued to move them to parent and did the
real issuing. Then timer fn saw there were still 32 queued bios, but
since select dispatch returned 0, it wouldn't try more. As a result,
the corresponding fio stalled.
I've looked at the code again and found that the behavior of
blkg_for_each_descendant_post changes between 3.10 and 4.12. In 3.10 it
doesn't include root while in 4.12 it does. That's why the above case
happens.
So upstream don't have this problem, sorry again for the noise.

Thanks,
Joseph
