Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: "van der Linden, Frank" <fllinden@amazon.com>,
 "jianchao.wang" <jianchao.w.wang@oracle.com>,
 Anchal Agarwal <anchalag@amzn.com>
Cc: "mlinux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <969389e7-b1bc-0559-6cc9-9461b034a24f@kernel.dk>
 <8af76974-08b2-f4ef-91b9-7bd42291b8d9@oracle.com>
 <347a7a07dc5f4122a37afd703ef2a3d0@EX13D13UWB002.ant.amazon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c2e96743-11a1-3e7e-0563-9789c5443f41@kernel.dk>
Date: Fri, 24 Aug 2018 10:44:22 -0600
MIME-Version: 1.0
In-Reply-To: <347a7a07dc5f4122a37afd703ef2a3d0@EX13D13UWB002.ant.amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/24/18 10:40 AM, van der Linden, Frank wrote:
> On 8/23/18 10:56 PM, jianchao.wang wrote:
>>
>> On 08/24/2018 07:14 AM, Jens Axboe wrote:
>>> On 8/23/18 5:03 PM, Jens Axboe wrote:
>>>>> Hi Jens, This patch looks much cleaner for sure as Frank pointed out
>>>>> too. Basically this looks similar to wake_up_nr only making sure that
>>>>> those woken up requests won't get reordered. This does solves the
>>>>> thundering herd issue. However, I tested the patch against my
>>>>> application and lock contention numbers rose to around 10 times from
>>>>> what I had from your last 3 patches.  Again this did add to drop in
>>>>> of total files read by 0.12% and rate at which they were read by
>>>>> 0.02% but this is not a very significant drop. Is lock contention
>>>>> worth the tradeoff?  I also added missing
>>>>> __set_current_state(TASK_RUNNING) to the patch for testing.
>>>> Can you try this variant? I don't think we need a
>>>> __set_current_state() after io_schedule(), should be fine as-is.
>>>>
>>>> I'm not surprised this will raise contention a bit, since we're now
>>>> waking N tasks potentially, if N can queue. With the initial change,
>>>> we'd always just wake one.  That is arguably incorrect. You say it's
>>>> 10 times higher contention, how does that compare to before your
>>>> patch?
>>>>
>>>> Is it possible to run something that looks like your workload?
>>> Additionally, is the contention you are seeing the wait queue, or the
>>> atomic counter? When you say lock contention, I'm inclined to think it's
>>> the rqw->wait.lock.
>>>
>> I guess the increased lock contend is due to:
>> when the wake up is ongoing with wait head lock is held, there is still waiter
>> on wait queue, and __wbt_wait will go to wait and try to require the wait head lock.
>> This is necessary to keep the order on the rqw->wait queue.
>>
>> The attachment does following thing to try to avoid the scenario above.
>> "
>> Introduce wait queue rqw->delayed. Try to lock rqw->wait.lock firstly, if fails, add
>> the waiter on rqw->delayed. __wbt_done will pick the waiters on rqw->delayed up and
>> queue them on the tail of rqw->wait before it do wake up operation.
>> "
>>
> Hmm, I am not sure about this one. Sure, it will reduce lock contention
> for the waitq lock, but it also introduces more complexity.
> 
> It's expected that there will be more contention if the waitq lock is
> held longer. That's the tradeoff for waking up more throttled tasks and
> making progress faster. Is this added complexity worth the gains? My
> first inclination would be to say no.
> 
> If lock contention on a wait queue is an issue, then either the wait
> queue mechanism itself should be improved, or the code that uses the
> wait queue should be fixed. Also, the contention is still a lot lower
> than it used to be.

Hard to disagree with that. If you look at the blk-mq tagging code, it
spreads out the wait queues exactly because of this.

-- 
Jens Axboe
