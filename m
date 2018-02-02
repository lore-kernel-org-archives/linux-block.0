Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/2] block: Fix a race between the throttling code and
 request queue initialization
To: Joseph Qi <jiangqi903@gmail.com>, Bart Van Assche
 <Bart.VanAssche@wdc.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
Cc: "hch@lst.de" <hch@lst.de>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
References: <20180131235300.12773-1-bart.vanassche@wdc.com>
 <20180131235300.12773-3-bart.vanassche@wdc.com>
 <1ff1b2fa-ffe1-20f4-6be9-919c6a5b8227@linux.alibaba.com>
 <1517501761.2746.21.camel@wdc.com>
 <26f758cf-430c-aa7f-0d21-75fbad6db260@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0a0a7da3-5005-b97e-493b-77bd9ee63fcc@kernel.dk>
Date: Fri, 2 Feb 2018 07:52:31 -0700
MIME-Version: 1.0
In-Reply-To: <26f758cf-430c-aa7f-0d21-75fbad6db260@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/1/18 6:02 PM, Joseph Qi wrote:
> Hi Bart,
> 
> On 18/2/2 00:16, Bart Van Assche wrote:
>> On Thu, 2018-02-01 at 09:53 +0800, Joseph Qi wrote:
>>> I'm afraid the risk may also exist in blk_cleanup_queue, which will
>>> set queue_lock to to the default internal lock.
>>>
>>> spin_lock_irq(lock);
>>> if (q->queue_lock != &q->__queue_lock)
>>> 	q->queue_lock = &q->__queue_lock;
>>> spin_unlock_irq(lock);
>>>
>>> I'm thinking of getting blkg->q->queue_lock to local first, but this
>>> will result in still using driver lock even the queue_lock has already
>>> been set to the default internal lock.
>>
>> Hello Joseph,
>>
>> I think the race between the queue_lock assignment in blk_cleanup_queue()
>> and the use of that pointer by cgroup attributes could be solved by
>> removing the visibility of these attributes from blk_cleanup_queue() instead
>> of __blk_release_queue(). However, last time I proposed to move code from
>> __blk_release_queue() into blk_cleanup_queue() I received the feedback that
>> from some kernel developers that they didn't like this.
>>
>> Is the block driver that triggered the race on the q->queue_lock assignment
>> using legacy (single queue) or multiqueue (blk-mq) mode? If that driver is
>> using legacy mode, are you aware that there are plans to remove legacy mode
>> from the upstream kernel? And if your driver is using multiqueue mode, how
>> about the following change instead of the two patches in this patch series:
>>
> We triggered this race when using single queue. I'm not sure if it
> exists in multi-queue.
> Do you mean upstream won't fix bugs any more in single queue?

No, we'll still fix bugs in the legacy path, we just won't introduce
any new features of accept any new drivers that use that path.
Ultimately that path will go away once there are no more users,
but until then it is maintained.

-- 
Jens Axboe
