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
From: Joseph Qi <jiangqi903@gmail.com>
Message-ID: <4881c35d-6dde-ba81-2771-798d5701c245@gmail.com>
Date: Tue, 26 Sep 2017 11:16:05 +0800
MIME-Version: 1.0
In-Reply-To: <20170926024820.2kxmluua6abvno4j@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 17/9/26 10:48, Shaohua Li wrote:
> On Tue, Sep 26, 2017 at 09:06:57AM +0800, Joseph Qi wrote:
>> Hi Shaohua,
>>
>> On 17/9/26 01:22, Shaohua Li wrote:
>>> On Mon, Sep 25, 2017 at 06:46:42PM +0800, Joseph Qi wrote:
>>>> From: Joseph Qi <qijiang.qj@alibaba-inc.com>
>>>>
>>>> Currently it will try to dispatch bio in throtl_upgrade_state. This may
>>>> lead to io stall in the following case.
>>>> Say the hierarchy is like:
>>>> /-test1
>>>>   |-subtest1
>>>> and subtest1 has 32 queued bios now.
>>>>
>>>> throtl_pending_timer_fn            throtl_upgrade_state
>>>> ------------------------------------------------------------------------
>>>>                                    upgrade to max
>>>>                                    throtl_select_dispatch
>>>>                                    throtl_schedule_next_dispatch
>>>> throtl_select_dispatch
>>>> throtl_schedule_next_dispatch
>>>>
>>>> Since throtl_select_dispatch will move queued bios from subtest1 to
>>>> test1 in throtl_upgrade_state, it will then just do nothing in
>>>> throtl_pending_timer_fn. As a result, queued bios won't be dispatched
>>>> any more if no proper timer scheduled.
>>>
>>> Sorry, didn't get it. If throtl_pending_timer_fn does nothing (because
>>> throtl_upgrade_state already moves bios to parent), there is no pending
>>> blkcg/bio, not rearming the timer wouldn't lose anything. Am I missing
>>> anything? could you please describe the failure in details?
>>>
>>> Thanks,
>>> Shaohua
>>> In normal case, throtl_pending_timer_fn tries to move bios from
>> subtest1 to test1, and finally do the real issueing work when reach
>> the top-level.
>> But int the case above, throtl_select_dispatch in
>> throtl_pending_timer_fn returns 0, because the work is done by
>> throtl_upgrade_state. Then throtl_pending_timer_fn *thinks* there is
>> nothing to do, but the queued bios are still in service queue of
>> test1.
> 
> Still didn't get, sorry. If there are pending bios in test1, why
> throtl_schedule_next_dispatch in throtl_pending_timer_fn doesn't setup the
> timer?
> 

throtl_schedule_next_dispatch doesn't setup timer because there is no
pending children left, all the queued bios are moved to parent test1
now. IMO, this is used in case that it cannot dispatch all queued bios
in one round.
And if the select dispatch is done by timer, it will then do propagate
dispatch in parent till reach the top-level.
But in the case above, it breaks this logic.
Please point out if I am understanding wrong.

Thanks,
Joseph
