Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: use blk_mq_timeout_work to limit the max timeout
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391610-1654-1-git-send-email-jianchao.w.wang@oracle.com>
 <884a5cbb5622ca5c890585a8d5dff0e3a1d60cfe.camel@wdc.com>
 <dd0484f6-ad41-5607-107f-4c487a739478@oracle.com>
 <08b5a3e94f2265815a98abae7a8dde0894512d4e.camel@wdc.com>
 <e75238d6-aefb-3673-1ce8-991f7fedfea6@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e00d7ac7-642e-da56-d8b6-28b9b379f638@oracle.com>
Date: Wed, 20 Jun 2018 09:45:26 +0800
MIME-Version: 1.0
In-Reply-To: <e75238d6-aefb-3673-1ce8-991f7fedfea6@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 06/20/2018 09:37 AM, jianchao.wang wrote:
> 
> 
> On 06/20/2018 09:35 AM, Bart Van Assche wrote:
>> On Wed, 2018-06-20 at 09:28 +0800, jianchao.wang wrote:
>>> Hi Bart
>>>
>>> Thanks for your kindly response.
>>>
>>> On 06/19/2018 11:18 PM, Bart Van Assche wrote:
>>>> On Tue, 2018-06-19 at 15:00 +0800, Jianchao Wang wrote:
>>>>> blk_rq_timeout is needed to limit the max timeout value, otherwise,
>>>>> a idle hctx cannot be deactivated timely in shared-tag case.
>>>>>
>>>>> Fixes: 12f5b931 (blk-mq: Remove generation seqeunce)
>>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>>> ---
>>>>>  block/blk-mq.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index 70c65bb..ccebe7b 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -868,7 +868,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
>>>>>  	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
>>>>>  
>>>>>  	if (next != 0) {
>>>>> -		mod_timer(&q->timeout, next);
>>>>> +		mod_timer(&q->timeout, blk_rq_timeout(round_jiffies_up(next)));
>>>>>  	} else {
>>>>>  		/*
>>>>>  		 * Request timeouts are handled as a forward rolling timer. If
>>>>
>>>> Hello Jianchao,
>>>>
>>>> What makes you think that it would be necessary to call blk_rq_timeout() from
>>>> blk_mq_timeout_work()? Have you noticed that blk_add_timer() already calls that
>>>> function? I think it is not necessary to call blk_rq_timeout() from
>>>> blk_mq_timeout_work() because it is guaranteed in that function that the next
>>>> timeout is less than BLK_MAX_TIMEOUT jiffies in the future.
>>>>
>>>
>>> blk_add_timer will not re-arm the timer if the timer's expire value is before the new rq's expire value.
>>>
>>> Let's look at the following scenario.
>>>
>>> 0                    +30s
>>>> __________________|___|
>>>
>>> T0                T1   T2
>>>
>>> T1 = T2 - 1 jiffies 
>>>
>>> T0:  rq_a is issued and q->timer is armed and will expire at T2
>>>      then rq_a is completed.
>>> T1:  rq_b is issued and q->timer is not re-armed, because its next expire time is T2 < (T1 + 30s)
>>>
>>> T2:  if rq_b have not been completed when timer expires at T2, timer would be re-armed based on the rq_b 
>>>      If we don't have blk_rq_timeout here, the next expire time is about T2 + 30s.
>>
>> Hello Jianchao,
>>
>> I disagree with the last sentence above. I think for your example blk_mq_req_expired()
>> will set next to T1 + 30s instead of T2 + 30s.
>>
> 
> Would you please explain the reason ?
> 

Oops, yes, it is T1. I thought you were saying T0. :)

In this scenario, I have said, the T1 = T2 - 1 jiifies, it is very closed to T2.
So I said "the next expire time is about T2 + 30s"
It's my bad description.

The next time is T1 + 30s, but it is also not a good value

> Thanks
> Jianchao
> 
>> Bart.
>>
>>
> 
